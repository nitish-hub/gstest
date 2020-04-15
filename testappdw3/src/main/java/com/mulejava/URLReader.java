package com.mulejava;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

public class URLReader {

	public static void copyURLToFile(URL url, File file) {
		
		try {
			InputStream input = url.openStream();
			if (file.exists()) {
				if (file.isDirectory())
					throw new IOException("File '" + file + "' is a directory");
				
				if (!file.canWrite())
					throw new IOException("File '" + file + "' cannot be written");
			} else {
				File parent = file.getParentFile();
				if ((parent != null) && (!parent.exists()) && (!parent.mkdirs())) {
					throw new IOException("File '" + file + "' could not be created");
				}
			}

			FileOutputStream output = new FileOutputStream(file);

			byte[] buffer = new byte[4096];
			int n = 0;
			while (-1 != (n = input.read(buffer))) {
				output.write(buffer, 0, n);
			}

			input.close();
			output.close();
			
			System.out.println("File '" + file + "' downloaded successfully!");
		}
		catch(IOException ioEx) {
			ioEx.printStackTrace();
		}
	}

	public static int mainRead() throws IOException {
		
		//URL pointing to the file
		String sUrl = "https://github.com/ashunist/ProjectRssFeed/blob/master/projectrss/test.txt";
		
		URL url = new URL(sUrl);
		
		//File where to be downloaded
		File file = new File("C:\\AnypointStudio7EnterpriseEdition\\plugins\\org.mule.tooling.server.4.2.0.ee_7.3.3.201904292040\\mule\\apps\\testappdw3\\test.txt");
		
		URLReader.copyURLToFile(url, file);
		return 0;
	}

}