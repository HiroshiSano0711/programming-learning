// あらかじめ提供されているクラス。このクラスとの差異を埋めたい

public class Banner {
    private String string;

    public Banner(String string) {
        this.string = string;
    }
    public void showWithParen() {
        System.out.println("(" + string + ")");
    }
    public void showWithAster() {
        System.out.println("*" + string + "*");
    }
}
