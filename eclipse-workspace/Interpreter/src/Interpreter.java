import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.Hashtable;

public class Interpreter {
	public static Hashtable<JTSymbol, JTCode> Globals = new Hashtable<JTSymbol, JTCode>();
	public static Frame frame = new Frame();
	
	public static boolean hasSymbol(JTSymbol sym) {
		if (frame.hasSymbol(sym)) {
			return true;
		}
		return Globals.contains(sym);
	}
	
	public static JTCode getSymbolValue(JTSymbol sym) {
		if (frame.hasSymbol(sym)) {
			return frame.getSymbolValue(sym);
		}
		return (JTCode)Globals.get(sym);
	}
	
	public static void set(JTSymbol sym, JTCode code) {
		if (frame.hasSymbol(sym)) {
			frame.set(sym, code);
			return;
		}
		Globals.put(sym, code);
	}
	
	public static void def(JTSymbol sym, JTCode code) {
		if (frame.size() != 0) {
			frame.def(sym, code);
			return;
		}
		Globals.put(sym, code);
	}
	
	public static void pushLocals(Hashtable table) {
		frame.pushLocals(table);
	}
	
	public static void popLocals( ) {
		frame.popLocals();
	}

	static void usage() {
		System.out.println("Usage: java Interpreter [source_file_name]");
	}
	
	static {
		Globals.put(JTSymbol.intern("puts"), new JTPrimPrint());
		Globals.put(JTSymbol.intern("max"), new JTPrimMax());
	}

	public static void main(String[] args) {
		boolean interactive = false;
		
		// 標準入力の引数が2個以上あったら使い方を示す出力をだして処理を終える。
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
				code.run();				
			}
			in.close();
		} catch (FileNotFoundException e) {
			System.out.println("can't open file");				
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
