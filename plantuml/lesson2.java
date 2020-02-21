public class lesson2 {
	public static void main(String[] args) {
		lesson2_3();
	}
  public static void lesson2_3() {
    System.out.println("占いの館へようこそ"+"\n"+"あなたの名前を入力してください");
    String name = new java.util.Scanner(System.in).nextLine();
    System.out.println("あなたの年齢を入力してください");
    String ageString = new java.util.Scanner(System.in).nextLine();
    int age =Integer.parseInt(ageString);
    int fortune = new java.util.Random().nextInt(4);
    fortune++;
    System.out.println(age+"歳の"+name+"さん、"+"あなたの運気番号は"+fortune+"です");
    System.out.println("1:大吉　2：中吉　3：吉　4：凶");
  }
}
