
public class JTDefVar extends JTCode {
	private JTSymbol symbol;
	private JTCode code;
	
	public JTDefVar(JTSymbol sym, JTCode c) {
		symbol = sym;
		code = c;
	}
	
	public JTCode run() throws Exception {
		if (Interpreter.hasSymbol(symbol)) {
			throw new Exception("変数" + symbol.toString() + "は定義済みです");
		}
		JTCode val = null;
		if (code != null) {
			val = code.run();
		}
		Interpreter.def(symbol, val);
		return val;
	}
}
