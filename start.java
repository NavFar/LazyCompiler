import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Constructor;

import Parser.YYParser;


public class Main {
	public static void main(String[] args) throws IOException {
		FileReader fr = null;
		
		try {
			//fr = new FileReader(new File("E:\\JavaProjects\\LazyCompiler\\test.txt"));
			fr = new FileReader(new File("test.txt"));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		YYParser parser = new YYParser(new Yylex(fr));
		parser.parse();
//		try {
//			lex.yylex();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}

}
