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
	PreparedStatement st = Conn.getConn().prepareStatement("select * from Discussion where id=?");
	st.setInt(1, Integer.valueOf(request.getParameter("id")));
	ResultSet rs = st.executeQuery();
	if (rs.next()) {
		int pros = rs.getInt("pros")+1;
		PreparedStatement st2 = Conn.getConn().prepareStatement("update Discussion set pros=? where id=?");
		st2.setInt(1, pros);
		st2.setInt(2, Integer.valueOf(request.getParameter("id")));
		st2.executeUpdate();
	}
	response.sendRedirect((String)session.getAttribute("lastURL")==null?"/Test/index.jsp":(String)session.getAttribute("lastURL"));
%>
</body>
</html>