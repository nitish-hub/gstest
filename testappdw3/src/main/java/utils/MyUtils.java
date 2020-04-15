package utils;

import java.util.Random;
import java.lang.String;

public class MyUtils {

	public MyUtils() {
		    // TODO Auto-generated constructor stub
		  }
	public static String appendRandom(String str) {
		return str + new Random().nextInt();
	}
	
	public static String ConcatAB(String value1, String value2) {
		    return value1 + value2;	
		  }
}