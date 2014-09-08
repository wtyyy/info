package util;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.jsp.JspWriter;

import java.sql.*;


import jdbc.*;
public class CourseTable {
	public static void printSingleCourse(ResultSet rs, JspWriter out,
			boolean haveChooser) throws IOException, SQLException, ClassNotFoundException {
		out.println("<tr>");
		if (haveChooser) {
			out.println("<td><input type=\"radio\" checked=\"true\" name=\"courseId\" value=\""
					+ rs.getInt("id") + "\" /></td>");
		}
		out.println("<td>" + rs.getInt("id") + "</td>");
		out.println("<td>" + rs.getString("name") + "</td>");
		out.println("<td>" + rs.getString("teacher") + "</td>");
		out.println("<td>"
				+ CourseTime.fromEncodedTime(rs.getInt("time")).getDay()
				+ "</td>");
		out.println("<td>"
				+ CourseTime.fromEncodedTime(rs.getInt("time")).getTimeInDay()
				+ "</td>");
		out.println("<td>" + rs.getInt("capacity") + "</td>");
		
		ResultSet whoChosedThisCourse = Conn.getConn().createStatement().executeQuery("select count(*) from studentChooseCourse where courseId=" + rs.getInt("id"));
		
		int chosedNumber = 0;
		if (whoChosedThisCourse.next()) {
			chosedNumber = whoChosedThisCourse.getInt(1);
		}
		out.println("<td>" + chosedNumber + "</td>");
		
		out.println("</tr>");
	}

	public static void printTable(ResultSet rs, JspWriter out,
			boolean haveChooser) throws IOException, SQLException, ClassNotFoundException {
		out.println("<table border=\"1\">"
				+ (haveChooser ? "<tr><td>选择</td>" : "")
				+ "<td>课程id</td><td>名称</td><td>教师</td><td>星期</td><td>第几节</td><td>课容量</td><td>选课人数</td></tr>");
		for (;rs.next();) {
			printSingleCourse(rs, out, haveChooser);
		}
		out.println("</table>");
	}
}
