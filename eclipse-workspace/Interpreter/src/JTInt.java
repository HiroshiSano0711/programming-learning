
public class JTInt extends JTCode {
	private int value;
	
	public JTInt(Integer integer) {
		value = integer.intValue();
	}
	
	public JTInt(int i) {
		value = i;
	}
	
	public int getValue() {
		return value;
	}
	
	public String toString() {
		return Integer.toString(value);
	}
	
	public JTCode add(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを足そうとしました");
		}
		JTInt i = (JTInt)code;
		result = new JTInt(value + i.getValue());
		return result;
	}
	
	public JTCode sub(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを引こうとしました");
		}
		JTInt i = (JTInt)code;
		result = new JTInt(value - i.getValue());
		return result;
	}
	
	public JTCode multiply(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものをかけようとしました");
		}
		JTInt i = (JTInt)code;
		result = new JTInt(value * i.getValue());
		return result;
	}
	
	public JTCode devide(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを割ろうとしました");
		}
		JTInt i = (JTInt)code;
		result = new JTInt(value / i.getValue());
		return result;
	}
	
	public JTCode less(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを比較しようとしました");
		}
		JTInt i = (JTInt)code;
		if (value < i.getValue()) {
			result = JTBool.True;
		} else {
			result = JTBool.False;
		}
		return result;
	}
	
	public JTCode less_than(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを比較しようとしました");
		}
		JTInt i = (JTInt)code;
		if (value <= i.getValue()) {
			result = JTBool.True;
		} else {
			result = JTBool.False;
		}
		return result;
	}
	
	public JTCode greater(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを比較しようとしました");
		}
		JTInt i = (JTInt)code;
		if (value > i.getValue()) {
			result = JTBool.True;
		} else {
			result = JTBool.False;
		}
		return result;
	}
	
	public JTCode greater_than(JTCode code) throws Exception {
		JTCode result = null;
		if (code.getClass() != JTInt.class) {
			throw new Exception("数値以外のものを比較しようとしました");
		}
		JTInt i = (JTInt)code;
		if (value <= i.getValue()) {
			result = JTBool.True;
		} else {
			result = JTBool.False;
		}
		return result;
	}
	
	public boolean equals(Object code) {
		if (code.getClass() != JTInt.class) {
			return false;
		}
		JTInt i = (JTInt)code;
		return value == i.getValue();
	}
}
