package util;

import java.util.*;
import java.io.IOException;
import java.sql.*;

import jdbc.Conn;
/**
 * Course Selection class.
 * Use Select to force a user to select a class 
 * @author 天一
 *
 */
public class CourseSelect {
	/**
	 * let a student to select a course
	 * @param studentId
	 * @param courseId
	 * @return	null if succeeds, or error message
	 * @throws SQLException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public static String select(int studentId, int courseId)
			throws SQLException, IOException, ClassNotFoundException {
		

		
		Connection con = Conn.getConn();
		try {
			con.setAutoCommit(false);

			ResultSet myCourses = con.prepareStatement(
					"select * from studentChooseCourse where studentId='"
							+ studentId + "'").executeQuery();
			ResultSet wantedCourse = con.prepareStatement(
					"select * from courses where id='" + courseId + "'")
					.executeQuery();
			ResultSet whoChosedThisCourse = con.createStatement().executeQuery(
					"select count(*) from studentChooseCourse where courseId="
							+ courseId);

			int chosedNumber = 0;
			if (whoChosedThisCourse.next()) {
				chosedNumber = whoChosedThisCourse.getInt(1);
			} else {
				return "获取选课人数失败";
			}
			int capacity = 0;
			if (wantedCourse.next()) {
				capacity = wantedCourse.getInt("capacity");
				for (; myCourses.next();) {
					ResultSet thisCourseInfo = con.prepareStatement(
							"select * from courses where id='"
									+ myCourses.getInt("courseId") + "'")
							.executeQuery();
					if (!thisCourseInfo.next()) {
						return "sql挂了不关我事";
					}
					if (wantedCourse.getInt("day") == thisCourseInfo
							.getInt("day")
							&& wantedCourse.getInt("block") == thisCourseInfo
									.getInt("block")) {
						return "时间冲突";
					}
				}
			} else {
				return "没这个课";
			}

			if (chosedNumber < capacity) {
				con.createStatement().executeUpdate(
						"insert into studentChooseCourse(studentId, courseId) values('"
								+ studentId + "','" + courseId + "')");
			} else {
				return "人满";
			}
			con.commit();
			
			PreparedStatement st = Conn.getConn().prepareStatement("insert into studentChooseCourseHistory(studentId, courseId, operation,time) values(?,?,?,?)");
			st.setInt(1, studentId);
			st.setInt(2, courseId);
			st.setString(3, "select");
			st.setTimestamp(4, Timestamp.from(Calendar.getInstance().toInstant()));
			st.executeUpdate();
			
			return null;

		} catch (SQLException e) {
			con.rollback();
			throw e;
		}
	}

	public static String deselect(int studentId, int courseId) throws ClassNotFoundException, SQLException {
		
		PreparedStatement st = Conn.getConn().prepareStatement("insert into studentChooseCourseHistory(studentId, courseId, operation,time) values(?,?,?,?)");
		st.setInt(1, studentId);
		st.setInt(2, courseId);
		st.setString(3, "deselect");
		st.setTimestamp(4, Timestamp.from(Calendar.getInstance().toInstant()));
		st.executeUpdate();
		
		int result = Conn.getConn().createStatement().executeUpdate(
			"delete from studentChooseCourse where studentId='"
					+ studentId + "' and courseId='" + courseId + "'");
		if (result > 0) {
			return null;
		}else {
			return "你没选这门课";
		}
		
	}
}
