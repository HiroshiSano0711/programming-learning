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
			case '/':
			case '(':
			case ')':
			case '=':
				tok = ch;
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
		StringBuffer buffer = new StringBuffer();
		while (true) {
			int c = reader.read();
			if (c < 0) {
				throw new Exception("ファイルの終わりに到達しました");
			}
			if (!Character.isJavaIdentifierStart((char)c)) {
				reader.unread(c);
				break;
			}
			buffer.append((char)c);
		}
		String s = buffer.toString();
		val = JTSymbol.intern(s);
	}
	
	private void skipWhiteSpace() throws Exception {
		int ch = reader.read();
		while((ch != -1) && Character.isWhitespace(ch)) {
			ch = reader.read();
		}
		reader.unread(ch);
	}
}
