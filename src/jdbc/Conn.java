package jdbc;

import java.sql.DriverManager;
import java.sql.SQLException;

public class Conn {
	public static java.sql.Connection getConn() {
		try {
			return DriverManager.getConnection("jdbc:mysql://59.66.133.34:3306/wtyInfo",
			    "scyue", "");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}