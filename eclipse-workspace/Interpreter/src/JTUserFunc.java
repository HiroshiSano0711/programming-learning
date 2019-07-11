import java.util.ArrayList;
import java.util.Hashtable;

public class JTUserFunc extends JTFun {
	JTSymbol symbol = null;
	private ArrayList params;
	private JTCode body;
	
	public JTUserFunc(JTSymbol sym, ArrayList l, JTCode code) {
		symbol = sym;
		params = l;
		body = code;
		if (params != null) {
			arg_count = params.size();
		}
	}
	
	public String toString() {
		return "<fun>";
	}
	
	public JTCode run() throws Exception {
		if (symbol != null) {
			Interpreter.set(symbol, this);
		}
		return this;
	}
	
	public JTCode exec(ArrayList params) throws Exception {
		JTCode c = null;
		setArgs(params);
		if (body != null) {
			c = body.run();
		}
		removeArgs();
		return c;
	}
	
	public void setArgs(ArrayList args) throws Exception {
		if ((params == null) && (args == null)) {
			Interpreter.pushLocals(new Hashtable());
			return;
		}
		
		Hashtable table = new Hashtable();
		Interpreter.pushLocals(table);
		
		for (int i = 0; i < args.size(); i++) {
			JTSymbol sym = (JTSymbol)params.get(i);
			JTCode c = (JTCode)args.get(i);
			table.put(sym, c);
		}
	}
	
	public void removeArgs() {
		Interpreter.popLocals();
	}
}
