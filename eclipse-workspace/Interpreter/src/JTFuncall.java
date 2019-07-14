import java.util.ArrayList;

public class JTFuncall extends JTCode {
	private JTSymbol symbol;
	private ArrayList<JTCode> list;
	
	public JTFuncall(JTSymbol sym, ArrayList<JTCode> l) {
		symbol = sym;
		list = l;
	}
	
	public JTCode run() throws Exception {
		JTCode c = Interpreter.getSymbolValue(symbol);
		if(c == null) {
			throw new Exception("関数" + symbol.toString() + "は存在しません");
		}
		if (!(c instanceof JTFun)) {
			throw new Exception("関数" + symbol.toString() + "は関数ではないです");
		}
		
		JTFun func = (JTFun)c;
		ArrayList<JTCode> list2 = new ArrayList<JTCode>();
		for (int i = 0; i < list.size(); i++) {
			JTCode c2 = ((JTCode)list.get(i)).run();
			list2.add(c2);
		}
		return func.call(list2);
	}
}
