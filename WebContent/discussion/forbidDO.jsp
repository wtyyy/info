<%@page import="java.net.URLEncoder"%>
<%@page import="util.*"%>
<%@page import="jdbc.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int id = Integer.valueOf(request.getParameter("id"));
try {
	Conn.getConn().prepareStatement("insert into Forbidden(id) values("+id+")").execute();
} catch(SQLException e) {
	response.sendRedirect("../message.jsp?message=" + URLEncoder.encode("此人已被封过", "utf-8") + "&redirect="+session.getAttribute("lastURL"));
	return;
}
	response.sendRedirect((String)session.getAttribute("lastURL"));
%>
</body>
</html>