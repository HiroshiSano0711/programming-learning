import java.io.*;

public class PracticeMain {
    public static void main(String[] args) {
        FileIO f = new FileProperties();
        try {
            // TODO: ファイルが読み込めないのを修正する
            f.readFromFile("file.txt");
            f.setValue("year", "2004");
            f.setValue("month", "4");
            f.setValue("day", "21");
            f.writeToFile("newFile.txt");
        } catch(IOException e) {
            e.printStackTrace();
        }
    }
}
