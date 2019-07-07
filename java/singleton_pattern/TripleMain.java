// インスタンスを3つだけ作成するクラス。Singletonの演習問題。

public class Triple {
    private static Triple[] triple = new Triple[] {
        new Triple(0),
        new Triple(1),
        new Triple(2)
    };
    private int id;

    private Triple(int id){
        this.id = id;
    }

    public static Triple getInstance(int id) {
        return triple[id];
    }

    public String toString(){
        return id;
    }
}
