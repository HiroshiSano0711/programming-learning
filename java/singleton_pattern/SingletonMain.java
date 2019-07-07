public class SingletonMain {
    public static void main(String[] args) {
        System.out.println("Start");

        Singleton obj1 = Singleton.getInstance();
        Singleton obj2 = Singleton.getInstance();

        if (obj1 == obj2) {
            System.out.println("同じインスタンスです");
        } else {
            System.out.println("違うインスタンスです");
        }

        System.out.println("End");
    }
}
