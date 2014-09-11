<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if (request.getParameter("id")==null || request.getParameter("code") == null) {
		out.println("少参数呦");
		return;
	}
	int id = Integer.parseInt(request.getParameter("id"));
	int code = Integer.parseInt(request.getParameter("code"));
	UserInfo user = UserInfo.getById(id);
	if (user.getEmail().hashCode() == code) {
		out.println("验证成功");
		Conn.getConn().prepareStatement("update users set validated=1 where id=" + id);
	} else {
		out.println(user.getEmail().hashCode() + "\n"+  code);
		out.println("验证失败");
	}
%>

</body>
</html>