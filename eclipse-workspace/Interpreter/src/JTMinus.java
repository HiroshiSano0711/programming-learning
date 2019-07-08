
public class JTMinus extends JTCode {
	private JTCode code;
	
	public JTMinus(JTCode c) {
		code = c;
	}
	
	public JTCode run() throws Exception {
		JTCode c = code.run();
		if (c.getClass() != JTInt.class) {
			throw new Exception("数値以外のものに単項演算子を適用しようとしています");
		}
		JTInt int1 = (JTInt)c;
		return new JTInt(-int1.getValue());
	}
}
