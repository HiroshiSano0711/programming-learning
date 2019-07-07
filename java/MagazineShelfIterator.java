// 雑誌棚のスキャンを行うクラス。
import java.util.ArrayList;

public class MagazineShelfIterator implements Iterator {
    private MagazineShelf magazineShelf;
    private int index;

    public MagazineShelfIterator(MagazineShelf magazineShelf) {
        this.magazineShelf = magazineShelf;
        this.index = 0;
    }

    public boolean hasNext() {
        if(index < magazineShelf.getSize()) {
            return true;
        } else {
            return false;
        }
    }

    public Object next() {
        Magazine magazine = magazineShelf.getMagazineAt(index);
        index++;
        return magazine;
    }
}
