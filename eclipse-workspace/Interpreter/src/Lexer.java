/*
	手順１：1文字読み込んでみる
	手順２：テキストの終端だったらえエラー
	手順３：読み込んだ文字が数字であるかどうかを判定する
	手順４a：数字であれば、数字が続く限り読み込む
	手順４b：数字出ないときは、別のもの（予約語や文字列など）であるかどうかをチェックして読み込む
*/

import java.io.Reader;

public class Lexer {
	private int tok;
	private Object val;
	private LexerReader reader;
	
	// readerはトークンの読込先
	public Lexer(Reader r) {
		reader = new LexerReader(r);
	}
	
	// 戻り値：次のトークンがあればtrue、なければfalse
	public boolean advance() {
		try {
			skipWhiteSpace(); // スペースを排除する
			int ch = reader.read();
			if (ch < 0) { return false;	}
			
			switch (ch) {
			case ';':
			case '+':
			case '-':
			case '*':
			case '(':
			case ')':
			case '=':
				tok = ch;
				break;
			case '/':
				ch = reader.read();
				if (ch == '/') {
					skipLineComment();
					return advance();
				} else if (ch == '*') {
					skipComment();
					return advance();
				} else {
					reader.unread(ch);
					tok = '/';
				}
				break;
			case '"':
				lexString();
				tok = TokenType.STRING;
				break;
			default:
				if (Character.isDigit((char)ch)) {
					reader.unread(ch);
					lexDigit();
					tok = TokenType.INT;
				} else if (Character.isJavaIdentifierStart((char)ch)) {
					reader.unread(ch);
					lexSymbol();
				}else{
					throw new Exception("Not a number");
				}
				break;
			}
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true; // トークンが存在したのでtrueを返す
	}

	// 現在のトークンの種類を返す
	public Object token() {
		return tok;
	}
	
	// 現在のトークンの値を返す
	public Object value() {
		return val;
	}

	// 文字を1文字ずつ読み込んでいって数値に変換する
	private void lexDigit() throws Exception {
		int num = 0;
		while(true){
			int ch = reader.read();
			if (ch < 0) {
				break;
			}
			if (!Character.isDigit((char)ch)) {
				reader.unread(ch);
				break;
			}
			num = (num * 10) + (ch - '0');
		}
		val = new Integer(num);
	}
	
	private void lexSymbol() throws Exception {
		tok = TokenType.SYMBOL;
		StringBuffer buf = new StringBuffer();
		while (true) {
			int c = reader.read();
			if (c < 0) {
				throw new Exception("ファイルの終わりに到達しました");
			}
			if (!Character.isJavaIdentifierStart((char)c)) {
				reader.unread(c);
				break;
			}
			buf.append((char)c);
		}
		String s = buf.toString();
		val = JTSymbol.intern(s);
	}
	
	private void lexString() throws Exception {
		StringBuffer buf = new StringBuffer();
		while(true) {
			int c = reader.read();
			if (c < 0) {
				throw new Exception("文字列中でファイルの終わりに到達しました");
			}
			if (c == '"') {
				break;
			} else if (c == '\\') {
				c = reader.read();
				if (c < 0) {
					throw new Exception("文字列中でファイルの終わりに到達しました");
				}
			}
			buf.append((char)c);
		}
		val = buf.toString();
	}

	private void skipWhiteSpace() throws Exception {
		int ch = reader.read();
		while((ch != -1) && Character.isWhitespace(ch)) {
			ch = reader.read();
		}
		reader.unread(ch);
	}

	private void skipLineComment() throws Exception {
		int c;
		while((c = reader.read()) != '\n') {
			if (c < 0) {
				throw new Exception("コメント中にファイルの終端に到達しました。");
			}
		}
		reader.unread(c);
	}

	private void skipComment() throws Exception {
		int c = '\0';
		while(true) {
			c = reader.read();
			if (c < 0) {
				throw new Exception("コメント中にファイルの終端に到達しました。");
			}
			if (c == '*') {
				c = reader.read();
				if (c == '/') {
					break;
				}
			}
		}
	}
}
