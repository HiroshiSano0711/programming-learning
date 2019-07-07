// メソッドdisplayだけが実装されている抽象クラス。
// テンプレートメソッド（display）を実装する。
// テンプレートメソッドで使っている抽象メソッドをサブクラスで実装する。

public abstract class AbstractDisplay {
    protected abstract void open();
    protected abstract void print();
    protected abstract void close();

    public final void display(){
        open();
        for(int i = 0; i < 5; i++){
            print();
        }
        close();
    }
}
