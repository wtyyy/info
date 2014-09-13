package util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.regex.Pattern;

import jdbc.Conn;

public class CsProfessorSpider {
	
	static String txt = "src/py/professorInfo.txt";
	
	public static void getProfessorURL() throws SQLException, ClassNotFoundException, IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(txt)));
		String str;
		while ((str=(br.readLine()))!=null) {
			try {
			String[] strs = str.split("#\\$%");
			PreparedStatement st = Conn.getConn().prepareStatement(
					"insert into professorInfo(name, image, detail)"
							+ " values(?,?,?)");
			
			System.out.println(str+" "+strs.length);
			st.setString(1, strs[1]);
			st.setString(2, strs[2]);
			st.setString(3, strs[3]);
			st.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				
		}
	}
	
	public static void main(String args[]) throws ClassNotFoundException, IOException, SQLException {
		getProfessorURL();
	}
}
