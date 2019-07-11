import java.util.Enumeration;
import java.util.Vector;

public class Customer {
    private Strig _name;
    private Vector _rentals = new Vector();
    
    public Customer(String name){
        _name = name;
    }

    public void addRental(Rental arg){
        _rentals.addElement(arg);
    }
    
    public String getName(){
        return _name;
    }

    public String statement(){
        double totalAmount = 0;
        int frequentRenterPoints = 0;
        Enumeration rentals = _rentals.elements();
        String result = "Rental Record for" + getName() + "\n";
        while(rentals.hasMoreElements()){
            Rental each = (Rental)rentals.nextElement();
            frequentRenterPoints += each.getFrequentRenterPoints();

            result += "Amount owed is " + String.valueOf(totalAmount) + "\n" + String.valueOf(each.getCharge()) + "\n";
            totalAmount += each.getCharge();
        }

        result += "Amount owed is " + String.valueOf(getTotalCharge()) + "\n";
        result += "Yout earned " + String.valueOf(getFrequentRenterPoints()) + "frequent renter points";
        return result;
    }

    private double getTotalCharge(){
        double result = 0;
        Enumeration rentals = _rentals.elements();
        while(rentals.hasMoreElements()){
            Rental each = (Rental)rentals.nextElement();
            result += each.getCharge();
        }
        return result;
    }

    private int getFrequentRenterPoints(){
        double result = 0;
        Enumeration rentals = _rentals.elements();
        while(rentals.hasMoreElements()){
            Rental each = (Rental)rentals.nextElement();
            result += each.getFrequentRenterPoints();
        }
        return result;
    }
}
