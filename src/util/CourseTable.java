package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.jsp.JspWriter;

import jdbc.Conn;

/**
 * Helper class that helps to print a table about courses
 * 
 * @author 天一
 *
 */
public class CourseTable {
	/**
	 * Print a single row about a course.
	 * 
	 * @param course
	 *            The courseInfo
	 * @param out
	 *            The jsp writer, namely 'out' in jsp files
	 * @param haveChooser
	 *            Whether to print a form radio
	 * @param isAdmin
	 *            Whether the outdated courses could be chosen
	 * @throws IOException
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 * @throws ParseException
	 */
	public static void printSingleCourseForStudent(CourseInfo course,
			JspWriter out, boolean haveChooser, boolean isAdmin,
			boolean ableOnly) throws IOException, ParseException,
			ClassNotFoundException, SQLException {
		Connection conn = null;

		try {
			conn = Conn.getConn();
			out.println("<tr>");
			Calendar selectStartDate = Calendar.getInstance();
			selectStartDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(course.getSelectStartTime()));
			Calendar selectEndDate = Calendar.getInstance();
			selectEndDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(course.getSelectEndTime()));
			Date nowDate = new Date();

			if (haveChooser) {
				if (!isAdmin
						&& (nowDate.before(selectStartDate.getTime()) || nowDate
								.after(selectEndDate.getTime()))) {
					if (ableOnly)
						return;
					out.println("<td>-</td>");
				} else {
					out.println("<td><input type=\"radio\" checked=\"true\" name=\"courseId\" value=\""
							+ course.getId() + "\" /></td>");
				}
			}
			out.println("<td>" + course.getId() + "</td>");

			out.println("<td>" + course.getName() + "("
					+ course.getSelectStartTime() + "~"
					+ course.getSelectEndTime() + ")" + "</td>");

			PreparedStatement st = conn
					.prepareStatement("select * from professorInfo where name=?");

			st.setString(1, course.getTeacher());
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				out.println("<td><a href=\"/Test/viewTeacherInfo.jsp?id="
						+ rs.getInt("id") + "\">" + course.getTeacher()
						+ "</a></td>");

			} else {
				out.println("<td>" + course.getTeacher() + "</td>");
			}

			out.println("<td>" + course.getDay() + "</td>");
			out.println("<td>" + course.getBlock() + "</td>");
			out.println("<td>" + course.getCapacity() + "</td>");
			ResultSet whoChosedThisCourse = conn.createStatement()
					.executeQuery(
							"select count(*) from studentChooseCourse where courseId="
									+ course.getId());
			int chosedNumber = 0;
			if (whoChosedThisCourse.next()) {
				chosedNumber = whoChosedThisCourse.getInt(1);
			}
			out.println("<td>" + chosedNumber + "</td>");
			// 算所剩课时啦啦啦啦啦啦
			if (!(course.getStartTime() == null
					|| course.getStartTime().equals("")
					|| course.getEndTime() == null || course.getEndTime()
					.equals(""))) {
				int remainTime = 0;
				Calendar startDate = Calendar.getInstance();
				startDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
						.parse(course.getStartTime()));

				Calendar endDate = Calendar.getInstance();
				endDate.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(course
						.getEndTime()));
				Calendar nowCalendar = Calendar.getInstance();
				if (startDate.after(nowCalendar)) {
					nowCalendar = startDate;
				}
				for (; nowCalendar.get(GregorianCalendar.DAY_OF_WEEK) - 1 != course
						.getDay();) {
					nowCalendar.add(GregorianCalendar.DATE, 1);
				}
				for (; !nowCalendar.after(endDate);) {
					remainTime++;
					nowCalendar.add(GregorianCalendar.DATE, 7);
				}
				out.println("<td>" + remainTime + "</td>");
			} else {

				out.println("<td>不可用</td>");
			}

			out.println("<td>" + course.getText() + "</td>");
			if (nowDate.before(selectStartDate.getTime())) {
				out.print("<td>于" + course.getSelectStartTime() + "开始</td>");
			} else if (nowDate.after(selectEndDate.getTime())) {
				out.print("<td>选课已结束</td>");
			} else {
				out.print("<td>正在进行，于" + course.getSelectEndTime() + "结束</td>");
			}
			out.println("</tr>");
		} catch (Exception e) {

		} finally {
			conn.close();
		}
	}

	public static void printSingleCourse(CourseInfo course, JspWriter out,
			boolean haveChooser, boolean isAdmin, boolean ableOnly)
			throws IOException, SQLException, ClassNotFoundException,
			ParseException {
		Connection conn = null;

		try {
			conn = Conn.getConn();

			if (!isAdmin) {
				printSingleCourseForStudent(course, out, haveChooser, isAdmin,
						ableOnly);
				return;
			}
			Calendar selectStartDate = Calendar.getInstance();
			selectStartDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(course.getStartTime()));
			Calendar selectEndDate = Calendar.getInstance();
			selectEndDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
					.parse(course.getEndTime()));
			Date nowDate = new Date();

			if (haveChooser) {
				if (!isAdmin
						&& (nowDate.before(selectStartDate.getTime()) || nowDate
								.after(selectEndDate.getTime()))) {
					if (ableOnly) {
						return;
					}
					out.println("<tr>");
					out.println("<td>-</td>");
				} else {
					out.println("<td><input type=\"radio\" checked=\"true\" name=\"courseId\" value=\""
							+ course.getId() + "\" /></td>");
				}
			}
			out.println("<td>" + course.getId() + "</td>");
			out.println("<td>" + course.getName() + "</td>");

			PreparedStatement st = conn
					.prepareStatement("select * from professorInfo where name=?");

			st.setString(1, course.getTeacher());
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				out.println("<td><a href=\"/Test/viewTeacherInfo.jsp?id="
						+ rs.getInt("id") + "\">" + course.getTeacher()
						+ "</a></td>");

			} else {
				out.println("<td>" + course.getTeacher() + "</td>");
			}

			out.println("<td>" + course.getDay() + "</td>");
			out.println("<td>" + course.getBlock() + "</td>");
			out.println("<td>" + course.getCapacity() + "</td>");
			ResultSet whoChosedThisCourse = conn.createStatement()
					.executeQuery(
							"select count(*) from studentChooseCourse where courseId="
									+ course.getId());
			int chosedNumber = 0;
			if (whoChosedThisCourse.next()) {
				chosedNumber = whoChosedThisCourse.getInt(1);
			}
			out.println("<td>" + chosedNumber + "</td>");
			out.println("<td>" + course.getStartTime() + "</td>");
			out.println("<td>" + course.getEndTime() + "</td>");
			// 算所剩课时啦啦啦啦啦啦
			if (!(course.getStartTime() == null
					|| course.getStartTime().equals("")
					|| course.getEndTime() == null || course.getEndTime()
					.equals(""))) {
				int remainTime = 0;
				Calendar startDate = Calendar.getInstance();
				startDate.setTime(new SimpleDateFormat("yyyy-MM-dd")
						.parse(course.getStartTime()));

				Calendar endDate = Calendar.getInstance();
				endDate.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(course
						.getEndTime()));
				Calendar nowCalendar = Calendar.getInstance();
				if (startDate.after(nowCalendar)) {
					nowCalendar = startDate;
				}
				for (; nowCalendar.get(GregorianCalendar.DAY_OF_WEEK) - 1 != course
						.getDay();) {
					nowCalendar.add(GregorianCalendar.DATE, 1);
				}
				for (; !nowCalendar.after(endDate);) {
					remainTime++;
					nowCalendar.add(GregorianCalendar.DATE, 7);
				}
				out.println("<td>" + remainTime + "</td>");
			} else {

				out.println("<td>不可用</td>");
			}

			out.println("<td>" + course.getText() + "</td>");
			out.println("<td>" + course.getSelectStartTime() + "</td>");
			out.println("<td>" + course.getSelectEndTime() + "</td>");
			out.println("</tr>");
		} catch (Exception e) {

		} finally {
			conn.close();
		}
	}

	/**
	 * Print a whole table about some courses
	 * 
	 * @param courseList
	 * @param out
	 * @param haveChooser
	 * @param isAdmin
	 * @throws IOException
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 * @throws ParseException
	 */
	public static void printTable(java.util.List<CourseInfo> courseList,
			JspWriter out, boolean haveChooser, boolean isAdmin)
			throws IOException, SQLException, ClassNotFoundException,
			ParseException {
		out.println("<table id=\"customers\"><tr>"
				+ (haveChooser ? "<td>选择</td>" : "")
				+ "<td>课程id</td><td>名称</td><td>教师</td><td>星期</td>"
				+ "<td>第几节</td><td>课容量</td><td>选课人数</td>"
				+ ""
				+ "<td>起始日期</td><td>结束日期</td><td>所剩课时</td><td>更多信息</td><td>选课开始日期</td><td>选课结束日期</td></tr>");
		for (CourseInfo cs : courseList) {
			printSingleCourse(cs, out, haveChooser, isAdmin, false);
		}
		out.println("</table>");
	}
}
