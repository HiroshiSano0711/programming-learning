// 集合体を表すインターフェース。集合体に対応するIteratorを一個作成する

public interface Aggregate {
    public abstract Iterator iterator();
}
