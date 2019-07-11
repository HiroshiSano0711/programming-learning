
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

	public JTCode less(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「<」は使用できません");
	}

	public JTCode greater(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「>」は使用できません");
	}

	public JTCode less_than(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「<=」は使用できません");
	}

	public JTCode greater_than(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「>=」は使用できません");
	}

	public JTCode and(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「&&」は使用できません");
	}

	public JTCode or(JTCode c2) throws Exception {
		throw new Exception("このオブジェクトに演算子「||」は使用できません");
	}
}
