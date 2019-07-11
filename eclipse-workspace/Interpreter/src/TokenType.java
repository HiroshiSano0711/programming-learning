public class TokenType {
	public static final int EOS = -1; // 文の終わりを表す
	public static final int INT = 257; // 1バイトの0 ~ 255までの文字コード。256はエラー用に空けている。
	public static final int SYMBOL = 258;
	public static final int STRING = 259;
	
	// 真偽値
	public static final int TRUE = 260;
	public static final int FALSE = 261;
	public static final int EQUAL = 262; // '=='
	public static final int NOT_EQUAL = 263; // '!='
	public static final int LESS_THAN = 264; // '<='
	public static final int GREATER_THAN = 265; // '>='
	public static final int AND = 266; // '&&'
	public static final int OR = 267; // '||'
	
	// statement
	public static final int IF = 268;
	public static final int ELSE = 269;
    public static final int WHILE = 270;
}
