import java.util.Hashtable;
import java.util.Stack;

public class Frame {
	private Stack<Hashtable<JTSymbol, JTCode>> locals = new Stack<Hashtable<JTSymbol, JTCode>>();
	
	public int size() {
		return locals.size();
	}
	
	public void pushLocals(Hashtable<JTSymbol, JTCode> table) {
		locals.push(table);
	}
	
	public void popLocals() {
		locals.pop();
	}
	
	public boolean hasSymbol(JTSymbol sym) {
		if (locals.size() != 0) {
			Hashtable<JTSymbol, JTCode> table = (Hashtable<JTSymbol, JTCode>)locals.peek();
			if (table.containsKey(sym)) {
				return true;
			}
		}
		return false;
	}
	
	public JTCode getSymbolValue(JTSymbol sym) {
		if (locals.size() != 0) {
			Hashtable<JTSymbol, JTCode> table = (Hashtable<JTSymbol, JTCode>)locals.peek();
			if (table.containsKey(sym)) {
				return (JTCode)table.get(sym);
			}
		}
		return null;
	}
	
	public void set(JTSymbol sym, JTCode c) {
		Hashtable<JTSymbol, JTCode> table = (Hashtable<JTSymbol, JTCode>)locals.peek();
		if (locals.size() != 0) {
			if (table.containsKey(sym)) {
				table.put(sym, c);
				return;
			}
		}
	}
	
	public void def(JTSymbol sym, JTCode c) {
		Hashtable<JTSymbol, JTCode> table = (Hashtable<JTSymbol, JTCode>)locals.peek();
		table.put(sym, c);
	}
}
