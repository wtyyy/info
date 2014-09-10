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
	Connection con = Conn.getConn();
	ResultSet set = null;
	
	Statement st = con.createStatement();
	set = st.executeQuery("select * from discussion where discussType='T' order by postDate DESC ");
	while (set.next()) {
		DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
				set, DiscussionInfo.class)));
		di.printTitle(out);
	}
	
%>
</body>
</html>
