package util;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.jsp.JspWriter;

import java.sql.*;

public class CourseTable {
	public static void printSingleCourse(ResultSet rs, JspWriter out,
			boolean haveChooser) throws IOException, SQLException {
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
		out.println("</tr>");
	}

	public static void printTable(ResultSet rs, JspWriter out,
			boolean haveChooser) throws IOException, SQLException {
		out.println("<table border=\"1\">"
				+ (haveChooser ? "<tr><td>选择</td>" : "")
				+ "<td>课程id</td><td>名称</td><td>教师</td><td>星期</td><td>第几节</td></tr>");
		for (;rs.next();) {
			printSingleCourse(rs, out, haveChooser);
		}
		out.println("</table>");
	}
}
