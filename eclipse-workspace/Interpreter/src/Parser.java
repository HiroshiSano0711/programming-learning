
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
		JTCode code = expr();
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
	
	private JTCode expr() throws Exception {
		JTCode code = term();
		switch (advanced_token) {
		case '+':
		case '-':
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
			code = term2(code);
			break;
		}
		return code;
	}
	
	private JTBinExpr expr2(JTCode code) throws Exception {
		JTBinExpr result = null;
		while ((advanced_token == '+') || (advanced_token == '-') ) {
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


















