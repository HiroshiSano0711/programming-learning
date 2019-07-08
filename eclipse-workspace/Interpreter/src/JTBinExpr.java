
public class JTBinExpr extends JTCode {
	private int op;
	protected JTCode code1;
	protected JTCode code2;
	
	public JTBinExpr(int operator, JTCode c1, JTCode c2) {
		op = operator;
		code1 = c1;
		code2 = c2;
	}

	public JTCode run() throws Exception {
		JTCode c1 = code1.run();
		JTCode c2 = code2.run();
		JTCode result = null;
		switch (op) {
		case '+':
			result = c1.add(c2);
			break;
		case '-':
			result = c1.sub(c2);
			break;
		case '*':
			result = c1.multiply(c2);
			break;
		case '/':
			result = c1.devide(c2);
			break;
		}
		return result;
	}
}
