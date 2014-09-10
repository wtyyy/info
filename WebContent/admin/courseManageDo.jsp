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
<jsp:useBean id="course" class="util.CourseInfo" scope="request" />
<jsp:setProperty name="course" property="*" />
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		out.println(user);
		if ((!"admin".equals(user.getPrivilege()))) {
			response.sendRedirect("../index.jsp");
		} else if ("delete".equals((String) request.getParameter("oper"))) {
			if ("delete".equals((String) request.getParameter("isModify"))) {
				response.sendRedirect("couseManage.jsp?courseId=" + request
						.getParameter("courseId"));
			}
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
			out.println(course);
			if (CourseTime.fromDayAndBlock(course.getDay(), course.getBlock()) == null) {
				out.println("时间不对");
			} else {
				try {
					PreparedStatement st = Conn.getConn().prepareStatement(
							"insert into courses(name, teacher,day,block, text, capacity, startTime, endTime)"
									+ "values(?,?,?,?,?,?,?,?)");
					st.setString(1, course.getName());
					st.setString(2, course.getTeacher());
					st.setInt(3, course.getDay());
					st.setInt(4, course.getBlock());
					st.setString(5, course.getText());
					st.setInt(6, course.getCapacity());
					st.setDate(7, Date.valueOf(course.getStartTime()));
					st.setDate(8, Date.valueOf(course.getEndTime()));
					int i = st.executeUpdate();
					if (i > 0) {
						out.println("成功啦");
					}
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