import java.io.*;
import java.util.*;
import java.lang.*;
import java.lang.reflect.*;
public class start
{
public static void main(String[] args)
	{
		int flag = 0;
		if(args.length==0)
		{
			try {
				runProcess("rm -rf Yylex.class");
				flag = runProcess("jflex lex.jflex");
    } catch (Exception e) {
      e.printStackTrace();
    }
		}
		else
		{
			String command = "jflex "+args[0];
			try
			{
			runProcess("rm -rf Yylex.class");
			flag = runProcess(command);
			}
			 catch (Exception e)
			 {
				  e.printStackTrace();
			 }
		}	
	
	
	if(flag==0)
	{
	FileReader fr =null;
	try
	{
		runProcess("javac Yylex.java");
		Class.forName("Yylex");
		fr = new FileReader(new File("test.txt"));
	}catch(FileNotFoundException e)
	{
		e.printStackTrace();
	}
	catch (Exception e)
			 {
				  e.printStackTrace();
			 }
	
	try
	{
		clearScreen();
		Yylex lex = new Yylex(fr);
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
	else
	{
		System.out.println("JFlex has some error Sorry :(");
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

private static int runProcess(String command) throws Exception {
    Process pro = Runtime.getRuntime().exec(command);
    printLines(command + " stdout:", pro.getInputStream());
    printLines(command + " stderr:", pro.getErrorStream());
    pro.waitFor();
   return pro.exitValue();
}
}
