import java.util.ArrayList;

public class JTPrimMax extends JTPrim {
	public JTPrimMax() {
		super(2);
	}

	public JTCode exec(ArrayList params) throws Exception {
		JTCode code1 = (JTCode)params.get(0);
		JTCode code2 = (JTCode)params.get(1);
		if (code1.getClass() != JTInt.class) {
			throw new Exception("max関数の引数は数値でなければいません。");
		}
		if (code2.getClass() != JTInt.class) {
			throw new Exception("max関数の引数は数値でなければいません。");
		}

		JTInt int1 = (JTInt)code1;
		JTInt int2 = (JTInt)code2;
		return new JTInt(Math.max(int1.getValue(), int2.getValue()));
	}
}
