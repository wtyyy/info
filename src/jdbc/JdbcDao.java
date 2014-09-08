package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JdbcDao {

	public String TAG = this.getClass().getName();
	public static String URL = "jdbc:mysql://localhost:3306/";
	public static String DATABASENAME = "info";
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		System.out.println("getConn start");
		try {
			return DriverManager.getConnection(URL + DATABASENAME, "root",
					"root");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void release(ResultSet rs, Statement ps, Connection conn) {
		try {
			if (null != rs) {

				rs.close();
			}
			if (null != ps) {
				ps.close();
			}
			if (null != conn) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<String> getUserList() {
		List<String> list = new ArrayList<String>();
		try {
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from user");
			while (rs.next()) {
				list.add(rs.getString("name"));
				System.out.println(rs.getString("id"));
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;

	}

}
