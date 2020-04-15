package com.mulejava;

import java.util.Random;

import java.lang.String;

public class StringManipulation {
  
  public String result;
  
  public StringManipulation() {
    // TODO Auto-generated constructor stub
  }
  public void ConcatAB(String value1, String value2) {
    result = value1 + value2;	
  }
  public static String staticFunctionTest(String bas) {
    return bas + new Random().nextInt();	
  }
  
  public static String appendRandom(String base) {
		return base + new Random().nextInt();
	}

}
