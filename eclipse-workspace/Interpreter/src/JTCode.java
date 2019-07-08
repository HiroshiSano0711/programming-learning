
public abstract class JTCode {
	public JTCode run() throws Exception {
		return this;
	}
	
	public JTCode add(JTCode code) throws Exception {
		throw new Exception("このオブジェクトに演算子「+」は使用できません");
	}

	public JTCode sub(JTCode code) throws Exception {
		throw new Exception("このオブジェクトに演算子「-」は使用できません");
	}
	
	public JTCode multiply(JTCode code) throws Exception {
		throw new Exception("このオブジェクトに演算子「*」は使用できません");
	}
	
	public JTCode devide(JTCode code) throws Exception {
		throw new Exception("このオブジェクトに演算子「/」は使用できません");
	}
}
