package jdbc;

import java.sql.DriverManager;
import java.sql.SQLException;

public class Conn {
	public static java.sql.Connection getConn() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(
				"jdbc:mysql://59.66.133.34:3306/wtyInfo?useUnicode=true&characterEncoding=UTF-8", "scyue", "");
	}
}