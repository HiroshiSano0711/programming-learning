
public class JTString extends JTCode {
	private String str;

	public JTString(String string) {
		str = string;
	}

	public String getStr() {
		return str;
	}

	public String toString() {
		return '"' + str + '"';
	}

	public JTCode add(JTCode c2) throws Exception {
		if (c2.getClass() != JTString.class) {
			throw new Exception("not string");
		}
		JTString s2 = (JTString)c2;
		return new JTString(str + s2.str);
	}
}
