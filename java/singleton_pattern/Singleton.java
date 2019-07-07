public class Singleton {
    private static Singleton singleton = new Singleton();

    private Singleton(){
        System.out.println("シングルトンのインスタンスを生成しました");
    }

    public static Singleton getInstance(){
        return singleton;
    }
}
