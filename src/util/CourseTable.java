package util;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.jsp.JspWriter;

import java.sql.*;

import jdbc.*;

public class CourseTable {
	public static void printSingleCourse(CourseInfo course, JspWriter out,
			boolean haveChooser) throws IOException, SQLException,
			ClassNotFoundException {
		out.println("<tr>");
		if (haveChooser) {
			out.println("<td><input type=\"radio\" checked=\"true\" name=\"courseId\" value=\""
					+ course.getId() + "\" /></td>");
		}
		out.println("<td>" + course.getId() + "</td>");
		out.println("<td>" + course.getName() + "</td>");
		out.println("<td>" + course.getTeacher() + "</td>");
		out.println("<td>" + course.getDay() + "</td>");
		out.println("<td>" + course.getBlock() + "</td>");
		out.println("<td>" + course.getCapacity() + "</td>");
		out.println("<td>" + course.getStartTime() + "</td>");
		out.println("<td>" + course.getEndTime() + "</td>");
		out.println("<td>" + course.getText() + "</td>");

		ResultSet whoChosedThisCourse = Conn
				.getConn()
				.createStatement()
				.executeQuery(
						"select count(*) from studentChooseCourse where courseId="
								+ course.getId());

		int chosedNumber = 0;
		if (whoChosedThisCourse.next()) {
			chosedNumber = whoChosedThisCourse.getInt(1);
		}
		out.println("<td>" + chosedNumber + "</td>");

		out.println("</tr>");
	}

	public static void printTable(java.util.List<CourseInfo> courseList,
			JspWriter out, boolean haveChooser) throws IOException,
			SQLException, ClassNotFoundException {
		out.println("<table border=\"1\">"
				+ (haveChooser ? "<tr><td>选择</td>" : "")
				+ "<td>课程id</td><td>名称</td><td>教师</td><td>星期</td>"
				+ "<td>第几节</td><td>课容量</td><td>选课人数</td>" +""
						+ "<td>起始日期</td><td>结束日期</td><td>更多信息</td></tr>");
		for (CourseInfo cs : courseList) {
			printSingleCourse(cs, out, haveChooser);
		}
		out.println("</table>");
	}
}
