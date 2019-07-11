
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
		JTCode result = null;
		JTCode c1 = code1.run();

		if (op == TokenType.AND) {
			result = c1.and(code2);
		} else if (op == TokenType.OR) {
			result = c1.or(code2);
		} else {
			JTCode c2 = code2.run();

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
			case '<':
				result = c1.less(c2);
				break;
			case '>':
				result = c1.greater(c2);
				break;
			case TokenType.LESS_THAN:
				result = c1.less_than(c2);
				break;
			case TokenType.GREATER_THAN:
				result = c1.greater_than(c2);
				break;
			case TokenType.EQUAL:
				if (c1.equals(c2)) {
					result = JTBool.True;
				} else {
					result = JTBool.False;
				}
				break;
			case TokenType.NOT_EQUAL:
				if (c1.equals(c2)) {
					result = JTBool.False;
				} else {
					result = JTBool.True;
				}
				break;
			}
		}
		return result;
	}
}
