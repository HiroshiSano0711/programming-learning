package computer;
import framework.*;
import java.util.*;

public class PCFactory extends Factory {
    private List owners = new ArrayList();

    protected Product createProduct(String owner){
        return new PC(owner);
    }

    protected void registerProduct(Product product){
        owners.add(((PC)product).getOwner());
    }

    public List getOwner(){
        return owners;
    }
}
