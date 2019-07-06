// 雑誌棚を表すクラス。このクラスを集合体として扱う。

public class MagazineShelf implements Aggregate {
    private Magazine[] magazines;
    private int last = 0;

    public MagazineShelf(int maxsize) {
        this.magazines = new Magazine[maxsize];
    }

    public Magazine getMagazineAt(int index) {
        return magazines[index];
    }

    public void appendMagazine(Magazine magazine) {
        this.magazines[last] = magazine;
        last++;
    }

    public int getSize() {
        return last;
    }

    public Iterator iterator() {
        return new MagazineShelfIterator(this);
    }
}
