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
<%@page import="java.net.URLEncoder"%>
<% try { %>

<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int id = Integer.valueOf(request.getParameter("userId"));
	Conn.getConn().prepareStatement("delete from Forbidden where id="+id).execute();
	response.sendRedirect("/Test/discussion/adminForbidden.jsp");
%>
</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=/Test/discussion/adminForbidden.jsp");
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=/Test/discussion/adminForbidden.jsp");
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=/Test/discussion/adminForbidden.jsp");
		return;
	}
%>