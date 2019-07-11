import java.util.ArrayList;

public class Parser {
	private Lexer lex;
	private int advanced_token; // 先読みしたトークンを保存する
	
	public JTCode parse(Lexer lexer) {
		JTCode code = null;
		lex = lexer;
		getToken(); // パース前に1つトークンを先読みしておく
		try {
			code = program();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return code;
	}

	// トークンを1つ先読みする
	private void getToken() {
		if (lex.advance()) {
			advanced_token = (Integer)lex.token();
		} else {
			advanced_token = TokenType.EOS;
		}
	}
	
	private JTCode program() throws Exception {
		JTCode code = statement();
		if (code != null) {
			switch (advanced_token) {
			case ';':
				break;
			default:
				throw new Exception("文法エラー");
			}
		}
		return code;
	}
	
	private JTCode statement() throws Exception {
		JTCode code = null;
		switch (advanced_token) {
		case TokenType.IF:
			code = if_statement();
			break;
		case TokenType.WHILE:
			code = while_statement();
			break;
		case '{':
			code = block();
			break;
		default:
			code = expr();
		}
		return code;
	}
	
	private JTCode if_statement() throws Exception {
		getToken();
		if(advanced_token != '('){
			throw new Exception("文法エラーです。");
		}
		getToken();
		JTCode cond = expr();
		if (advanced_token != ')') {
			throw new Exception("文法エラーです。");
		}
		getToken();
		JTCode st1 = statement();
		JTCode st2 = null;
		if (advanced_token == TokenType.ELSE) {
			getToken();
			st2 = statement();
		}
		return new JTIf(cond, st1, st2);
	}
	
	private JTCode while_statement() throws Exception {
		getToken();
		if (advanced_token != '(') {
			throw new Exception("文法エラーです。");
		}
		getToken();
		JTCode cond = expr();
		if(advanced_token != ')') {
			throw new Exception("文法エラーです。");
		}
		getToken();
		JTCode st = statement();
		return new JTWhile(cond, st);
	}
	
	private JTCode block() throws Exception {
		ArrayList list = null;
		getToken();
		while(advanced_token != '}') {
			JTCode c = statement();
			if(advanced_token != ';') {
				throw new Exception("文法エラーです");
			}
			getToken();
			if (list == null) {
				list = new ArrayList();
			}
			list.add(c);
		}
		getToken();
		return new JTBlock(list);
	}
	
	private JTCode expr() throws Exception {
		JTCode code = simpleExpr();
		switch (advanced_token) {
		case '<':
		case '>':
		case TokenType.EQUAL:
		case TokenType.NOT_EQUAL:
		case TokenType.LESS_THAN:
		case TokenType.GREATER_THAN:
			code = expr2(code);
			break;
		}
		return code;
	}
	
	private JTCode term() throws Exception {
		JTCode code = factor();
		switch (advanced_token) {
		case '*':
		case '/':
		case TokenType.AND:
			code = term2(code);
			break;
		}
		return code;
	}
	
	private JTBinExpr expr2(JTCode code) throws Exception {
		JTBinExpr result = null;
		while ((advanced_token == '<') ||
			   (advanced_token == '>') || 
			   (advanced_token == TokenType.EQUAL) ||
			   (advanced_token == TokenType.NOT_EQUAL) ||
			   (advanced_token == TokenType.LESS_THAN) ||
			   (advanced_token == TokenType.GREATER_THAN))
		{
			int op = advanced_token;
			getToken();
			JTCode code2 = simpleExpr();
			if (result == null) {
				result = new JTBinExpr(op, code, code2);
			} else {
				result = new JTBinExpr(op, result, code2);
			}
		}
		return result;
	}
	
	private JTCode term2(JTCode code) throws Exception {
		JTBinExpr result = null;
		while ((advanced_token == '*') || (advanced_token == '/') ) {
			int op = advanced_token;
			getToken();
			JTCode code2 = term();
			if (result == null) {
				result = new JTBinExpr(op, code, code2);
			} else {
				result = new JTBinExpr(op, result, code2);
			}
		}
		return result;
	}
	
	private JTCode simpleExpr() throws Exception {
		JTCode code = term();
		switch (advanced_token) {
		case '+':
		case '-':
		case TokenType.OR:
			code = simpleExpr2(code);
			break;
		}
		return code;
	}
	
	private JTCode simpleExpr2(JTCode code) throws Exception {
		JTBinExpr result = null;
		while ((advanced_token == '+') || (advanced_token == '-') || (advanced_token == TokenType.OR)) {
			int op = advanced_token;
			getToken();
			JTCode code2 = term();
			if (result == null) {
				result = new JTBinExpr(op, code, code2);
			} else {
				result = new JTBinExpr(op, result, code2);
			}
		}
		return result;
	}
	
	private JTCode factor() throws Exception {
		JTCode code = null;
		switch (advanced_token) {
		case TokenType.EOS:
			break;
		case TokenType.INT:
			code = new JTInt((Integer)lex.value());
			getToken();
			break;
		case TokenType.SYMBOL:
			JTSymbol sym = (JTSymbol)lex.value();
			getToken();
			if (advanced_token == '=') {
				getToken();
				code = new JTAssign(sym, expr());
			} else {
				code = sym; 
			}
			break;
		case TokenType.STRING:
			code = new JTString((String)lex.value());
			getToken();
			break;
		case TokenType.TRUE:
			code = JTBool.True;
			getToken();
			break;
		case TokenType.FALSE:
			code = JTBool.False;
			getToken();
			break;
		case '!':
			getToken();
			code = new JTNot(factor());
			break;
		case '-':
			getToken();
			code = new JTMinus(factor());
			break;
		case '(':
			getToken();
			code = expr();
			if (advanced_token != ')') {
				throw new Exception("文法エラー：対応するかっこがありません");
			}
			getToken();
			break;
		default:
			throw new Exception("文法エラー");
		}
		return code;
	}
}


















