<%@page import="util.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (!"admin".equals(user.getPrivilege())) {
			response.sendRedirect("../index.jsp");
			return;
		}
		int userId = Integer.parseInt(request.getParameter("userId"));
		UserInfo userInfo = UserInfo.getById(userId);
		if ("delete".equals(request.getParameter("oper"))) {
			if (Conn.getConn()
					.prepareStatement(
							"delete from users where id=" + userId)
					.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				out.println("删除失败");
			}
		} else if ("changeBlock".equals(request.getParameter("oper"))) {
			PreparedStatement st = Conn.getConn().prepareStatement(
					"update users set blocked=? where id=" + userId);
			st.setInt(1, 1 - userInfo.getBlocked());
			if (st.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				out.println("更改封禁情况失败");
			}
		} else if ("changePrivilege".equals(request.getParameter("oper"))) {
			PreparedStatement st = Conn.getConn().prepareStatement(
					"update users set privilege=? where id=" + userId);
			st.setString(1,
					userInfo.getPrivilege().equals("admin") ? "student"
							: "admin");
			if (st.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				out.println("更改权限失败");
			}
		}
	%>
</body>
</html>