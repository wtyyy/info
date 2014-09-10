<%@page import="java.util.*"%>
<%@page import="java.text.*" %>
<%@page import="util.*"%>
<%@page import="jdbc.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
	PreparedStatement st = Conn.getConn().prepareStatement(
		"insert into discussion(topic, content, appendixURL, userid, discussType, pros, cons, postDate, belongs, zone, " +
		"userName, lastReplyId, lastReplyName, lastReplyTime) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
	st.setString(1, request.getParameter("topic"));
	st.setString(2, request.getParameter("content"));
	st.setString(3, request.getParameter("appendixURL"));
	st.setInt(4, user.getId());
	st.setString(5, request.getParameter("discussType"));
	st.setInt(6, 0);
	st.setInt(7, 0);
	st.setTimestamp(8, Timestamp.from(Calendar.getInstance().toInstant()));
	st.setString(9, request.getParameter("belongs"));
	st.setString(10, request.getParameter("zone"));
	st.setString(11, user.getName());
	st.setInt(12, user.getId());
	st.setString(13, user.getName());
	st.setTimestamp(14, Timestamp.from(Calendar.getInstance().toInstant()));
	
	st.executeUpdate();
	
	response.sendRedirect("/Test/discussion/postTopic.jsp");
	//test
	
%>
</body>
</html>