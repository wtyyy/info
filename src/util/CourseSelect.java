package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * Course Selection class. Use Select to force a user to select a class
 * 
 * @author 天一
 *
 */
public class CourseSelect {
	/**
	 * let a student to select a course
	 * 
	 * @param studentId
	 *            The id of student
	 * @param courseId
	 *            The id of course
	 * @return null if succeeds, or error message
	 * @throws SQLException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws ParseException
	 */
	public static String select(int studentId, int courseId, boolean isAdmin)
			throws SQLException, IOException, ClassNotFoundException,
			ParseException {

		Connection con = Conn.getConn();
		try {
			con.setAutoCommit(false);

			ResultSet myCourses = con.prepareStatement(
					"select * from studentChooseCourse where studentId='"
							+ studentId + "'").executeQuery();
			ResultSet wantedCourseSet = con.prepareStatement(
					"select * from courses where id='" + courseId + "'")
					.executeQuery();
			if (!wantedCourseSet.next()) {
				return "没有这门课";
			}
			CourseInfo wantedCourse = (CourseInfo) new BeanProcessor().toBean(
					wantedCourseSet, CourseInfo.class);
			ResultSet whoChosedThisCourse = con.createStatement().executeQuery(
					"select count(*) from studentChooseCourse where courseId="
							+ courseId);

			Calendar selectStartDate = Calendar.getInstance();
			selectStartDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(wantedCourse.getSelectStartTime()));
			Calendar selectEndDate = Calendar.getInstance();
			selectEndDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(wantedCourse.getEndTime()));
			Date nowDate = new Date();

			if (!isAdmin
					&& (nowDate.before(selectStartDate.getTime()) || nowDate
							.after(selectEndDate.getTime()))) {
				return "不在选课日期内";
			}

			int chosedNumber = 0;
			if (whoChosedThisCourse.next()) {
				chosedNumber = whoChosedThisCourse.getInt(1);
			} else {
				return "获取选课人数失败";
			}
			int capacity = 0;
			capacity = wantedCourse.getCapacity();
			for (; myCourses.next();) {
				ResultSet thisCourseInfo = con.prepareStatement(
						"select * from courses where id='"
								+ myCourses.getInt("courseId") + "'")
						.executeQuery();
				if (!thisCourseInfo.next()) {
					return "sql挂了不关我事";
				}
				if (wantedCourse.getDay() == thisCourseInfo.getInt("day")
						&& wantedCourse.getBlock() == thisCourseInfo
								.getInt("block")) {
					return "时间冲突";
				}
			}

			if (chosedNumber < capacity) {
				con.createStatement().executeUpdate(
						"insert into studentChooseCourse(studentId, courseId) values('"
								+ studentId + "','" + courseId + "')");
			} else {
				return "人满";
			}

			PreparedStatement st = con
					.prepareStatement("insert into studentChooseCourseHistory(studentId, courseId, operation,time) values(?,?,?,?)");
			st.setInt(1, studentId);
			st.setInt(2, courseId);
			st.setString(3, "select");
			st.setTimestamp(4,
					Timestamp.from(Calendar.getInstance().toInstant()));
			st.executeUpdate();

			con.commit();
			return null;

		} catch (SQLException e) {
			con.rollback();
			throw e;
		} finally {
			try {
				con.close();
			} catch (SQLException e) {

			}
		}
	}

	public static String deselect(int studentId, int courseId)
			throws ClassNotFoundException, SQLException {
		int result = Conn
				.getConn()
				.createStatement()
				.executeUpdate(
						"delete from studentChooseCourse where studentId='"
								+ studentId + "' and courseId='" + courseId
								+ "'");
		if (result > 0) {
			PreparedStatement st = Conn
					.getConn()
					.prepareStatement(
							"insert into studentChooseCourseHistory(studentId, courseId, operation,time) values(?,?,?,?)");
			st.setInt(1, studentId);
			st.setInt(2, courseId);
			st.setString(3, "deselect");
			st.setTimestamp(4,
					Timestamp.from(Calendar.getInstance().toInstant()));
			st.executeUpdate();
			return null;
		} else {
			return "你没选这门课";
		}

	}
}
