public class SingletonMain {
    public static void main(String[] args) {
        System.out.println("Start");

        Singleton obj1 = Singleton.getInstance();
        Singleton obj2 = Singleton.getInstance();
        Singleton obj3 = Singleton.getInstance();
        Singleton obj4 = Singleton.getInstance();

        // 何回読んでも同じインスタンスが返される
        if (obj1 == obj2 && obj2 == obj3 && obj3 == obj4) {
            System.out.println("どれも同じインスタンス");
        }

        System.out.println("End");
    }
}
