public class Main {
    public static void main(String[] args) {
        MagazineShelf magazineShelf = new MagazineShelf(4);
        magazineShelf.appendMagazine(new Magazine("Javaで学ぶデザインパターン1"));
        magazineShelf.appendMagazine(new Magazine("Javaで学ぶデザインパターン2"));
        magazineShelf.appendMagazine(new Magazine("Javaで学ぶデザインパターン3"));
        magazineShelf.appendMagazine(new Magazine("Javaで学ぶデザインパターン4"));
        Iterator it = magazineShelf.iterator();

        while(it.hasNext()) {
            Magazine magazine = (Magazine)it.next();
            System.out.println(magazine.getName());
        }
    }   
}
