public class Movie {
    public static final int CHILDRENDS = 2;
    public static final int REGULAR = 0;
    public static final int NEW_RELEASE = 1;

    private String _title;
    private Price _price;

    public Movie(String title, int priceCode){
        _title = title;
        setPriceCode(priceCode);
    }

    public int getTitle(){
        return _title;
    }

    public int getPriceCode(){
        return _price.getPriceCode();
    }

    public void setPriceCode(int arg){
        switch (arg) {
            case REGULAR:
                _price = new RegularPrice();
                break;
            case CHILDRENDS:
                _price = new ChildlrensPrice();
                break;
            case NEW_RELEASE:
                _price = new NewReleasePrice();
                break;
            default:
                throw new IllegalArgumentException("不正な料金コードです。");
        }
    }

    double getCharge(int daysRented) {
        return _price.getCharge(daysRented);
    }

    int getFrequentRenterPoints(int daysRented){
        return _price.getFrequentRenterPoints(daysRented);
    }
}
