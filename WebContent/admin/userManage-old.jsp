<%@page import="util.UserTable"%>
<%@page import="util.UserInfo"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="util.StudentChooseCourseHistory"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="util.CourseTime"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body>

	<%
		if (!"admin".equals(user.getPrivilege())) {
			response.sendRedirect("../index.jsp");
			return;
		}
	%>
	<form method="post" action="userManageDo.jsp">
		<table border="1">
			<%
				UserTable.printUsers(
						new BeanProcessor().toBeanList(Conn.getConn()
								.prepareStatement("select * from users")
								.executeQuery(), UserInfo.class), out, true);
			%>
		</table>
			<button name="oper" type="submit" value="delete">删除</button>
			<button name="oper" type="submit" value="changeBlock">（解除）禁止登录</button>
			<button name="oper" type="submit" value="changePrivilege">（解除）提升为管理员</button>
	</form>
</body>
</html>