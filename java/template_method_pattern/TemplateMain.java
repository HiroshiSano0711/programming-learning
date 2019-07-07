// 動作確認用のクラス

public class TemplateMain {
    public static void main(String[] args) {
        displayDriver(new ChartDisplay('H'));
        displayDriver(new StringDisplay("Hello, world"));
        displayDriver(new StringDisplay("こんにちは"));
    }

    public static void displayDriver(AbstractDisplay obj){
        obj.display();
    }
}
