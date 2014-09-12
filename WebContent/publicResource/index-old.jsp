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
<title>Insert title here</title>
</head>
<body>
<table>
<%
	ResultSet rs = Conn.getConn().prepareStatement("select * from publicInfo").executeQuery();
	List<PublicInfo> infoList = new BeanProcessor().toBeanList(rs, PublicInfo.class);
	for (PublicInfo info : infoList) {
		out.print("<tr><td><a href=\"viewInfo.jsp?id=" + info.getId()+ "\">" + info.getTitle() + "</a></td></tr>");
	}
%>
</table>
</body>
</html>