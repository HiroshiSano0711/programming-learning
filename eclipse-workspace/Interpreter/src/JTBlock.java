import java.util.ArrayList;
import java.util.Iterator;

public class JTBlock extends JTCode {
	ArrayList list;

	public JTBlock(ArrayList l) {
		list = l;
	}

	public JTCode run() throws Exception {
		JTCode code = JTBool.True;
		if (list != null) {
			Iterator iterator = list.iterator();
			while (iterator.hasNext()) {
				JTCode c = (JTCode)iterator.next();
				code = c.run();
			}
		}
		return code;
	}
}
