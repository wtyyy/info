<%@page import="util.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
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
<%
	PublicInfo info = PublicInfo.getById(Integer.parseInt(request.getParameter("id")));
%>
<title><%out.println(info.getTitle()); %></title>
</head>
<body>
<h1><% out.println(info.getTitle()); %></h1><br>
<%
	out.println(BBAdapter.process(info.getText()));
%>
</body>
</html>