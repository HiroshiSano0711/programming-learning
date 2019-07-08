
public class JTAssign extends JTBinExpr {
	public JTAssign(JTSymbol symbol, JTCode code) {
		super('=', symbol, code);
	}
	
	public JTCode run() throws Exception {
		JTSymbol sym = (JTSymbol)code1;
		JTCode c = code2.run();
		Interpreter.set(sym, c);
		return c;
	}
}
