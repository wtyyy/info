<%@page import="jdbc.Conn"%>
<%@page import="java.sql.*"%>
<%@page import="util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选课</title>
</head>
<body>
	<%
		out.println(user);

		int courseId = Integer.parseInt(request.getParameter("courseId"));
		Connection con = Conn.getConn();
		if (request.getParameter("oper") == null) {
			response.sendRedirect("courseSelect.jsp");
		} else if (((String) request.getParameter("oper")).equals("add")) {
			String errorMessage = CourseSelect.select(user.getId(), Integer.parseInt(request.getParameter("courseId")));
			if ( errorMessage == null) {
				response.sendRedirect("courseSelect.jsp");
			} else {
				out.println(errorMessage);
			}

		} else if (((String) request.getParameter("oper")).equals("delete")) {
			String errorMessage = CourseSelect.deselect(user.getId(), Integer.parseInt(request.getParameter("courseId")));
			if ( errorMessage == null) {
				response.sendRedirect("courseSelect.jsp");
			} else {
				out.println(errorMessage);
			}
		}
	%>
</body>
</html>