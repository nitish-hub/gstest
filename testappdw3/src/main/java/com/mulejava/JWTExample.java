package com.mulejava;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FilenameUtils;
import java.io.*; 
import java.security.*; 
import java.text.MessageFormat;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption; 

public class JWTExample {
	
	public static String getJWTToken(String client_id,String username,String url,String kspass,String pkpass,String pkalias) {
	  
	//String result = null; 
    String header = "{\"alg\":\"RS256\"}";
    String claimTemplate = "'{'\"iss\": \"{0}\", \"sub\": \"{1}\", \"aud\": \"{2}\", \"exp\": \"{3}\"'}'";

    String result = null;
    //String dirName = "/src/main/resources";
    //String downloadURL ="https://github.com/ashunist/ProjectRssFeed/blob/master/projectrss/test.txt";
         
	try {
      StringBuffer token = new StringBuffer();

      //Encode the JWT Header and add it to our string to sign
      token.append(Base64.encodeBase64URLSafeString(header.getBytes("UTF-8")));

      //Separate with a period
      token.append(".");

      //Create the JWT Claims Object
      String[] claimArray = new String[4];
      claimArray[0] =client_id;// "3MVG9qwrtt_SGpCsDte.DPxai.lxd.Tep2pXntyKbvM9uNp5cX3iaPDYf.Jvqlf29_I63ITpkBiBigYIYkpWe";
      claimArray[1] =username;// "muleintdev@gsusa.com";
      claimArray[2] =url;    // "https://test.salesforce.com";
      claimArray[3] = Long.toString( ( System.currentTimeMillis()/1000 ) + 300);
   //   claimArray[4] = "JTI";
      MessageFormat claims;
      claims = new MessageFormat(claimTemplate);
      String payload = claims.format(claimArray);

      //Add the encoded claims object
      token.append(Base64.encodeBase64URLSafeString(payload.getBytes("UTF-8")));

      //Load the private key from a keystore
      KeyStore keystore = KeyStore.getInstance("JKS");
      
    //  String certURL="C:\\MuleSoft\\Mule4\\EnterpriseWorkSpaces\\testappdw3\\src\\main\\resources\\MuleSoftToSalesforce.jks";
    //  InputStream jksStream=new URL(certURL).openStream();      
   //   FileUtils.copyURLToFile(new URL("https://github.com/gsusa/mulesoft/blob/development/tmp/Code/test/MuleSoftToSalesforce.jks?raw=true"), new File("C:\\AnypointStudio7EnterpriseEdition\\plugins\\org.mule.tooling.server.4.2.0.ee_7.3.3.201904292040\\mule\\apps\\MuleSoftToSalesforce1.jks"));
   //   FileUtils.copyFileToDirectory(new File("https://github.com/gsusa/mulesoft/tree/development/tmp/Code/test/MuleSoftToSalesforce.jks"),new File("/src/main/resources"));
      
      InputStream is = JWTExample.class.getResourceAsStream("/MuleSoftToSalesforce.jks");
  //    keystore.load(new FileInputStream("MuleSoftToSalesforce.jks"),"24M7!q".toCharArray());
   //   keystore.load(is,"24M7!q".toCharArray());  
      keystore.load(is,kspass.toCharArray());
   //   keystore.load(new FileInputStream("file://src/main/resources/MuleSoftToSalesforce.jks"), "24M7!q".toCharArray());
   //   PrivateKey privateKey = (PrivateKey) keystore.getKey("mulesofttosalesforce", "24M7!p".toCharArray()); 
      PrivateKey privateKey = (PrivateKey) keystore.getKey(pkalias, pkpass.toCharArray());
  
  //    System.out.println(privateKey);
  //    System.out.println("Key" + keystore.getKey("mulesofttosalesforce", "24M7!p".toCharArray()));

      //Sign the JWT Header + "." + JWT Claims Object
      Signature signature = Signature.getInstance("SHA256withRSA");
      signature.initSign(privateKey);
      signature.update(token.toString().getBytes("UTF-8"));
      String signedPayload = Base64.encodeBase64URLSafeString(signature.sign());

      //Separate with a period
      token.append(".");

      //Add the encoded signature
      token.append(signedPayload);

      System.out.println(token.toString());
      
      result =token.toString();
      
    } catch (Exception e) {
        e.printStackTrace();
    }
	return result;
  }
    public static void download(String downloadURL) throws IOException
	{
	    URL website = new URL(downloadURL);
	    String fileName = getFileName(downloadURL);
	    System.out.println(fileName);
	    InputStream inputStream = website.openStream();
        Files.copy(inputStream, Paths.get(fileName), StandardCopyOption.REPLACE_EXISTING);
	   
	}
	
	public static String getFileName(String downloadURL) throws UnsupportedEncodingException
	{
	    String baseName = FilenameUtils.getBaseName(downloadURL);
	    String extension = FilenameUtils.getExtension(downloadURL);
	    String fileName = baseName + "." + extension;

	    int questionMarkIndex = fileName.indexOf("?");
	    if (questionMarkIndex != -1)
	    {
	        fileName = fileName.substring(0, questionMarkIndex);
	    }

	    fileName = fileName.replaceAll("-", "");
	    
	    return URLDecoder.decode(fileName, "UTF-8");
	    
	}	
}