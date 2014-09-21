package util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jdbc.Conn;

public class CsProfessorSpider {

	static String txt = "src/py/professorInfo.txt";

	public static void getProfessorURL() throws SQLException,
			ClassNotFoundException, IOException {
		Connection con = null;
		try {
			con = Conn.getConn();
			BufferedReader br = new BufferedReader(new InputStreamReader(
					new FileInputStream(txt)));
			String str;
			while ((str = (br.readLine())) != null) {
				try {
					String[] strs = str.split("#\\$%");
					PreparedStatement st = con
							.prepareStatement("insert into professorInfo(name, image, detail)"
									+ " values(?,?,?)");

					System.out.println(str + " " + strs.length);
					st.setString(1, strs[1]);
					st.setString(2, strs[2]);
					st.setString(3, strs[3]);
					st.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		} finally {
			con.close();
		}
	}

	public static void main(String args[]) throws ClassNotFoundException,
			IOException, SQLException {
		getProfessorURL();
	}
}
