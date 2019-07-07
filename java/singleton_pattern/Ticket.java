public class Ticket {
    private static Ticket ticket = new Ticket();
    private int number = 100;

    private Ticket(){}

    public static Ticket getInstance() {
        return ticket;
    }

    public synchronized int getNextNumber(){
        return number++;
    }
}
