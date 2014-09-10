<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	if (user.getPrivilege().equals("admin")) {
		response.sendRedirect("admin/index.jsp");
	} else if (user.getPrivilege().equals("student")){
		response.sendRedirect("student/index.jsp");
		
	}
%>