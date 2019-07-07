public class TicketMain {
    public static void main(String[] args) {
        Ticket ticket = Ticket.getInstance();

        for (int i = 0; i < 10; i++) {
            System.out.println(ticket.getNextNumber());   
        }
    }
}
