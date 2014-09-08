<%@page import="jdbc.Conn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		int courseId = Integer.parseInt(request.getParameter("courseId"));
		Connection con = Conn.getConn();
		if (con == null) {
			out.print("fuck !");
		} else if (request.getParameter("oper") == null) {
			response.sendRedirect("courseSelect.jsp");
		} else if (((String)request.getParameter("oper")).equals("add")) {
			out.println("你想选课");
			ResultSet myCourses = con.prepareStatement(
					"select * from studentChooseCourse where studentId='"
							+ id + "'").executeQuery();
			ResultSet wantedCourse = con.prepareStatement(
					"select * from courses where id='" + courseId + "'")
					.executeQuery();
			boolean failed = false;
			if (wantedCourse.next()) {
				for (; myCourses.next();) {
					ResultSet thisCourseInfo = con.prepareStatement(
							"select * from courses where id='"
									+ myCourses.getInt("courseId") + "'")
							.executeQuery();
					if (!thisCourseInfo.next()) {
						out.println("课程被删了");
						failed = true;
					}
					if (wantedCourse.getInt("time") == thisCourseInfo
							.getInt("time")) {
						out.println("时间冲突");
						failed = true;
						break;
					}
				}
			} else {
				out.println("没这个课");
				failed = true;
			}
			if (!failed) {
				con.createStatement().executeUpdate(
						"insert into studentChooseCourse(studentId, courseId) values('"
								+ id + "','" + courseId + "')");
				response.sendRedirect("courseSelect.jsp");
			}
		} else if (((String)request.getParameter("oper")).equals("delete")) {
			out.println("你想删课");
			int result = Conn.getConn().createStatement().executeUpdate(
					"delete from studentChooseCourse where studentId='"
							+ id + "' and courseId='" + courseId + "'");
			out.println("删除了" + result +"个");
			
			
		}
	%>
</body>
</html>