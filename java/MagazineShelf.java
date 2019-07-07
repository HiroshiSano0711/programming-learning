// 雑誌棚を表すクラス。このクラスを集合体として扱う。
import java.util.ArrayList;

public class MagazineShelf implements Aggregate {
    private ArrayList magazines;

    public MagazineShelf(int initialsize) {
        this.magazines = new ArrayList(initialsize);
    }

    public Magazine getMagazineAt(int index) {
        return (Magazine)magazines.get(index);
    }

    public void appendMagazine(Magazine magazine) {
        magazines.add(magazine);
    }

    public int getSize() {
        return magazines.size();
    }

    public Iterator iterator() {
        return new MagazineShelfIterator(this);
    }
}
