import java.util.Hashtable;;

public class JTSymbol extends JTCode {
	private static Hashtable<String, JTSymbol> table = new Hashtable<String, JTSymbol>();
	private String name;
	
	private JTSymbol(String s) {
		name = s;
		table.put(s, this);
	}
	
	public static JTSymbol intern(String s) {
		if (table.containsKey(s)) {
			return (JTSymbol)table.get(s);
		} else {
			return new JTSymbol(s);
		}
	}
	
	public JTCode run() throws Exception {
		JTCode c = Interpreter.getSymbolValue(this);
		if (c == null) {
			throw new Exception("シンボル" + name + "は定義されていません。");
		}
		return c;
	}
	
	public String tpString() {
		return name;
	}
}
