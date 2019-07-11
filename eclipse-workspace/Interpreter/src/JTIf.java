
public class JTIf extends JTCode {
	private JTCode cond;
	private JTCode then_body;
	private JTCode else_body;
	
	public JTIf(JTCode code, JTCode code2, JTCode code3) {
		cond = code;
		then_body = code2;
		else_body = code3;
	}
	
	public JTCode run() throws Exception {
		JTCode c;
		JTCode p = cond.run();
		
		if (p != JTBool.False) {
			c = then_body;
		} else {
			c = else_body;
		}
		if (c != null) {
			c = c.run();
		}
		return c;
	}
}
