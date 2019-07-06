// スキャンを行うインターフェース。

public interface Iterator {
    public abstract boolean hasNext(); // ループの終了条件に使うためのメソッド
    public abstract Object next(); // 集合体の要素を一個返すメソッド。内部状態を次に進めておく
}
