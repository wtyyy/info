<%@page import="java.net.URLEncoder"%>
<%@page import="jdbc.Conn"%>
<%@page import="java.sql.*"%>
<%@page import="util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Connection con = null;
	try {
		con = Conn.getConn();
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	if (user == null || user.getEmail() == null || "".equals(user.getEmail())) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("你尚未登陆", "utf-8"));
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选课</title>
</head>
<body>
	<%
		out.println(user);

			int courseId = Integer.parseInt(request
					.getParameter("courseId"));
			if (request.getParameter("oper") == null) {
				response.sendRedirect("courseSelect.jsp");
			} else if (((String) request.getParameter("oper"))
					.equals("add")) {
				String errorMessage = CourseSelect.select(user.getId(),
						Integer.parseInt(request.getParameter("courseId")),
						false);
				if (errorMessage == null) {
					response.sendRedirect("courseSelect.jsp");
				} else {
					response.sendRedirect("../message.jsp?message="
							+ URLEncoder.encode(errorMessage, "utf-8"));
					return;
				}

			} else if (((String) request.getParameter("oper"))
					.equals("delete")) {
				String errorMessage = CourseSelect.deselect(user.getId(),
						Integer.parseInt(request.getParameter("courseId")));
				if (errorMessage == null) {
					response.sendRedirect("courseSelect.jsp");
				} else {
					response.sendRedirect("../message.jsp?message="
							+ URLEncoder.encode(errorMessage, "utf-8"));
					return;
				}
			}
	%>
</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=/Test/student/courseSelect.jsp");
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=/Test/student/courseSelect.jsp");
		return;
	} catch (Exception e) {

		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=/Test/student/courseSelect.jsp");
		return;
	} finally {
		try {
			con.close();
		} catch(Exception e) {
			
		}
	}
%>