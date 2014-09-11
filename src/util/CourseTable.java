package util;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.jsp.JspWriter;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction;

import org.apache.naming.java.javaURLContextFactory;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import jdbc.*;

public class CourseTable {
	public static void printSingleCourse(CourseInfo course, JspWriter out,
			boolean haveChooser) throws IOException, SQLException,
			ClassNotFoundException, ParseException {
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
		out.println("<td>" + course.getStartTime() + "</td>");
		out.println("<td>" + course.getEndTime() + "</td>");
		// 算所剩课时啦啦啦啦啦啦
		if (!(course.getStartTime() == null || course.getStartTime().equals("")
				|| course.getEndTime() == null || course.getEndTime()
				.equals(""))) {
			int remainTime = 0;
			Calendar startDate = Calendar.getInstance();
			startDate.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(course
					.getStartTime()));

			Calendar endDate = Calendar.getInstance();
			endDate.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(course
					.getEndTime()));
			Calendar nowCalendar = Calendar.getInstance();
			if(startDate.after(nowCalendar)) {
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
		out.println("</tr>");
	}

	public static void printTable(java.util.List<CourseInfo> courseList,
			JspWriter out, boolean haveChooser) throws IOException,
			SQLException, ClassNotFoundException, ParseException {
		out.println("<table id=\"customers\"><tr>"
				+ (haveChooser ? "<td>选择</td>" : "")
				+ "<td>课程id</td><td>名称</td><td>教师</td><td>星期</td>"
				+ "<td>第几节</td><td>课容量</td><td>选课人数</td>" + ""
				+ "<td>起始日期</td><td>结束日期</td><td>所剩课时</td><td>更多信息</td></tr>");
		for (CourseInfo cs : courseList) {
			printSingleCourse(cs, out, haveChooser);
		}
		out.println("</table>");
	}
}
