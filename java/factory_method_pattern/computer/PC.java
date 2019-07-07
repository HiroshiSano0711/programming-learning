package computer;
import framework.*;

public class PC extends Product {
    private String owner;

    PC(String owner) {
        System.out.println(owner + "のコンピューターを作成します。");
        this.owner = owner;
    }

    public void use(){
        System.out.println(owner + "のコンピューターを使います。");
    }

    public String getOwner(){
        return owner;
    }
}
