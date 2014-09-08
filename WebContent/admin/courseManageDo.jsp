<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		out.println("你的情况是:");
		String privilege = (String) session.getAttribute("privilege");
		int id = (int) session.getAttribute("id");

		out.println(privilege);
		out.println(id);
		if ((!"admin".equals(privilege))) {
			response.sendRedirect("../index.jsp");
		} else if ("delete".equals((String) request.getParameter("oper"))) {
			out.println("别拿那种眼神看着我，我知道你想删东西");
			out.println("你想删课");

			Connection con = Conn.getConn();

			int courseId = Integer.parseInt(request
					.getParameter("courseId"));
			Conn.getConn()
					.createStatement()
					.executeUpdate(
							"delete from studentChooseCourse where courseId='"
									+ courseId + "'");
			int result = Conn
					.getConn()
					.createStatement()
					.executeUpdate(
							"delete from courses where id='" + courseId
									+ "'");
			out.println("删除了" + result + "个");

		} else if ("add".equals((String) request.getParameter("oper"))) {
			out.println("别拿那种眼神看着我，我知道你想加东西");
			String name = request.getParameter("name");
			String teacher = request.getParameter("teacher");
			int day = Integer.parseInt(request.getParameter("day"));
			int timeInDay = Integer.parseInt(request
					.getParameter("timeInDay"));
			int capacity = Integer.parseInt(request
					.getParameter("capacity"));
			out.println(name + teacher + day + " " + timeInDay + " "
					+ capacity);
			String text = request.getParameter("text");
			if (CourseTime.fromDayAndBlock(day, timeInDay) == null) {
				out.println("时间不对");
			} else {
				int time = CourseTime.fromDayAndBlock(day, timeInDay)
						.getEncodedTime();
				out.println(time);
				try {
					Conn.getConn()
							.prepareStatement(
									"insert into courses(name, teacher,time, text, capacity) values('"
											+ name + "','" + teacher
											+ "','" + time + "','" + text
											+ "','" + capacity + "') ")
							.executeUpdate();
				} catch (SQLException e) {
					if (e.getErrorCode() == 1062) {
						out.println("课程名称不能重复哦亲");
					} else
						throw e;
				}
			}
			//

		}
	%>
</body>
</html>