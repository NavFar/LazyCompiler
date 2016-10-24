import java.io.*;
import java.util.*;
import java.util.*;
public class start
{
public static void main(String[] args)
	{
		if(args.length==0)
		{
			try {
				runProcess("rm -rf Yylex.java~");
				runProcess("jflex lex.jflex");
    } catch (Exception e) {
      e.printStackTrace();
    }
		}
		else
		{
			String command = "jflex "+args[0];
			try
			{
			runProcess(command);
			}
			 catch (Exception e)
			 {
				  e.printStackTrace();
			 }
		}	
		
	
	FileReader fr =null;
	try
	{
		fr = new FileReader(new File("test.txt"));
	}catch(FileNotFoundException e)
	{
		e.printStackTrace();
	}
	Yylex lex = new Yylex(fr);
	try
	{
		clearScreen();
		lex.yylex();
	}
	catch (IOException e)
	{
		e.printStackTrace();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	
	}
private static void clearScreen() throws Exception
{
	final String operatingSystem = System.getProperty("os.name");
if (operatingSystem .contains("Windows")) {
    runProcess("cls");
}
else {
    runProcess("clear");
}
}
private static void printLines(String name, InputStream ins) throws Exception {
    String line = null;
    BufferedReader in = new BufferedReader(
        new InputStreamReader(ins));
    while ((line = in.readLine()) != null) {
        System.out.println(name + " " + line);
    }
  }

private static void runProcess(String command) throws Exception {
    Process pro = Runtime.getRuntime().exec(command);
    printLines(command + " stdout:", pro.getInputStream());
    printLines(command + " stderr:", pro.getErrorStream());
    pro.waitFor();
    System.out.println(command + " exitValue() " + pro.exitValue());
}
}
