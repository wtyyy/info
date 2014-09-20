package file;

import java.sql.SQLException;

import jdbc.Conn;
import util.UserInfo;

/**
 * Simple checker that validates an upload attempt
 * 
 * @author 天一
 *
 */
public class UploadCheck {
	public static String check(UserInfo user) throws ClassNotFoundException,
			SQLException {
		if (user == null) {
			return "你没有登录";
		}
		if ("student".equals(user.getPrivilege())) {
			Conn.getConn()
					.prepareStatement(
							"delete from files where uploaderId="
									+ user.getId()).executeUpdate();
		}
		return null;
	}
}