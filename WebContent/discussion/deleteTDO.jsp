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
<%@page import="java.net.URLEncoder"%>
<% try { %>

<title>Insert title here</title>
</head>
<body>
<%

	int id = Integer.valueOf(request.getParameter("id"));
	Conn.getConn().prepareStatement("delete from discussion where id="+id).execute();
	Conn.getConn().prepareStatement("delete from discussReply where belongs="+id).execute();
	response.sendRedirect("/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"));
	
%>
</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	}
%>