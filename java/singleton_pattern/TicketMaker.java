import sun.security.jca.GetInstance;

public class TicketMaker {
    private static TicketMaker ticketMaker = new TicketMaker();
    private int ticketNumber = 100;

    private TicketMaker(){
    }

    public static TicketMaker getInstance() {
        return ticketMaker;
    }

    public synchronized int getNextTicketNumber(){
        return ticketNumber++;
    }
    
}