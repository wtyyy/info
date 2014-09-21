package jdbc;

import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * The sql connector.
 * 
 * @author 天一
 *
 */
public class Conn {
	/**
	 * Connect to the predefined Mysql database
	 * 
	 * @return the java.sql.Connection instance
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public static java.sql.Connection getConn() throws SQLException,
			ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager
				.getConnection(
						"jdbc:mysql://localhost:3306/wtyInfo?useUnicode=true&characterEncoding=UTF-8",
						"scyue", "");
	}
}