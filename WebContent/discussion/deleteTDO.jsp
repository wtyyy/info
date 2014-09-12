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

<title>Insert title here</title>
</head>
<body>
<%

	int id = Integer.valueOf(request.getParameter("id"));
	Conn.getConn().prepareStatement("delete from discussion where id="+id).execute();
	Conn.getConn().prepareStatement("delete from discussReply where belongs="+id).execute();
	response.sendRedirect("/Test/discussion/postTopic.jsp?zone="+session.getAttribute("zone"));
%>
</body>
</html>