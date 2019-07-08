import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStreamReader;

import javax.print.attribute.standard.PagesPerMinute;

public class Interpreter {
	static void usage() {
		System.out.println("Usage: java Interpreter [source_file_name]");
	}

	public static void main(String[] args) {
		boolean interactive = false;
		
		if (args.length >= 2) {
			usage();
			return;
		}
		
		try {
			BufferedReader in;
			
			if (args.length == 0) {
				in = new BufferedReader(new InputStreamReader(System.in));
				interactive = true;
			} else {
				in = new BufferedReader(new FileReader(args[0]));
			}
			
			Lexer lexer = new Lexer(in);
			Parser parser = new Parser();
			
			while(true) {
				if (interactive) {
					System.out.print("Interpreter: ");
				}
				JTCode code = (JTCode) parser.parse(lexer);
				if (code == null) { break; }	
				System.out.println("result= " + code.run().toString());
			}
			in.close();
		} catch (FileNotFoundException e) {
			System.out.println("can't open file");				
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
