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
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {
	int id = Integer.valueOf(request.getParameter("userid"));

	Conn.getConn().prepareStatement("insert into Forbidden(id) values("+id+")").execute();
} catch(SQLException e) {
	response.sendRedirect("../message.jsp?message=" + URLEncoder.encode("此人已被封过", "utf-8") + "&redirect="+session.getAttribute("lastURL"));
	return;
} catch (Exception e) {
	response.sendRedirect("../message.jsp?message="
			+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
			+ "&redirect=/Test/discussion/postReply.jsp?topicid="+request.getParameter("topicid")+"&zone="+request.getParameter("zone")+"\";");
	return;
} 
// if a person has been forbidden, then the one should not be forbidden again
%>
<%
out.println("<script language=\"javascript\">");
out.println("alert(\"封人成功！\");");
out.println("location.href=\"/Test/discussion/postReply.jsp?topicid="+request.getParameter("topicid")+"&zone="+request.getParameter("zone")+"\";");
out.println("</script>");

%>
</body>
</html>
