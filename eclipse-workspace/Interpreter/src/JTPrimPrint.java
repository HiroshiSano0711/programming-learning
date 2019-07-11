import java.util.ArrayList;

public class JTPrimPrint extends JTPrim{
	public JTPrimPrint() {
		super(1);
	}
	
	public JTCode exec(ArrayList params) throws Exception {
		JTCode code = (JTCode)params.get(0);
		System.out.println(code.run().toString());
		return null;
	}
}
