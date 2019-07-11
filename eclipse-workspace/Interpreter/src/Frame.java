import java.util.Hashtable;
import java.util.Stack;

public class Frame {
	private Stack locals = new Stack();
	
	public int size() {
		return locals.size();
	}
	
	public void pushLocals(Hashtable table) {
		locals.push(table);
	}
	
	public void popLocals() {
		locals.pop();
	}
	
	public boolean hasSymbol(JTSymbol sym) {
		if (locals.size() != 0) {
			Hashtable table = (Hashtable)locals.peek();
			if (table.containsKey(sym)) {
				return true;
			}
		}
		return false;
	}
	
	public JTCode getSymbolValue(JTSymbol sym) {
		if (locals.size() != 0) {
			Hashtable table = (Hashtable)locals.peek();
			if (table.containsKey(sym)) {
				return (JTCode)table.get(sym);
			}
		}
		return null;
	}
	
	public void set(JTSymbol sym, JTCode c) {
		Hashtable table = (Hashtable)locals.peek();
		if (locals.size() != 0) {
			if (table.containsKey(sym)) {
				table.put(sym, c);
				return;
			}
		}
	}
	
	public void def(JTSymbol sym, JTCode c) {
		Hashtable table = (Hashtable)locals.peek();
		table.put(sym, c);
	}
}
