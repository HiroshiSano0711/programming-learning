import java.util.*;

public class Lesson2 {
	public static void main(String[] args) {
		fortuneTelling();
	}
	public static void fortuneTelling() {
    String name = scanName();
    Integer age = age();
    Integer fortune = fortune();
    printResult(name, age, fortune);
  }

	public static String scanName() {
    System.out.println("占いの館へようこそ"+"\n"+"あなたの名前を入力してください");
    String name = new java.util.Scanner(System.in).nextLine();
    return name;
  }

	public static int age() {
    System.out.println("あなたの年齢を入力してください");
    String age = new java.util.Scanner(System.in).nextLine();
		return Integer.parseInt(age);
  }

  private static int fortune() {
    int fortune = new java.util.Random().nextInt(4);
    return fortune++;
  }

  private static void printResult(String name, Integer age, Integer fortune) {
    System.out.println(age+"歳の"+name+"さん、"+"あなたの運気番号は"+fortune+"です");
    System.out.println("1:大吉　2：中吉　3：吉　4：凶");
  }
}
