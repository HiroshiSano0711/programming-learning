import framework.*;
import idcard.*;
import computer.*;

public class FactoryMain {
    public static void main(String[] args) {
        Factory factory = new IDCardFactory();
        Product card1 = factory.create("田中");
        Product card2 = factory.create("鈴木");
        Product card3 = factory.create("高橋");

        card1.use();
        card2.use();
        card3.use();

        // Factory factory2 = new PCFactory();
        // Product pc = factory2.create("Apple");
        // pc.use();
    }
}
