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
<%@page import="java.net.URLEncoder"%>
<% try { 
if ( ! ("cs".equals(request.getParameter("zone")) || "food".equals(request.getParameter("zone")) || "music".equals(request.getParameter("zone")) || "other".equals(request.getParameter("zone")) )) {
	response.sendRedirect("/Test/discussion/index.jsp");
	return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	if (user.getName()==null) {
		
		out.println("<script language=\"javascript\">");
		out.println("if(confirm(\"您尚未登陆，不能发言。现在登陆？\"))");
		out.println("{");
		out.println("location.href=\"/Test/signin.jsp\";");
		out.println("}");
		out.println("else");
		out.println("{");
		out.println("location.href=\"/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone")+"\";");
		out.println("}</script>");
		
	} else {
	
	PreparedStatement st =  Conn.getConn().prepareStatement("select * from Forbidden where id=?");
	st.setInt(1, user.getId());
	ResultSet rs = st.executeQuery();
	if (rs.next()) {
		out.println("<script language=\"javascript\">");
		out.println("alert(\"你已被禁言，尚不能发言\");");
		out.println("location.href=\"/Test/discussion/postTopic.jsp"+"\";");
		out.println("</script>");
	} else {
	st = Conn.getConn().prepareStatement(
		"insert into discussion(topic, content, appendixURL, userid, discussType, pros, cons, postDate, belongs, zone, " +
		"userName, lastReplyId, lastReplyName, lastReplyTime) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	String myTopic = request.getParameter("topic");
	myTopic = myTopic.replaceAll("<", "&lt;");
	myTopic = myTopic.replaceAll(">", "&gt;");
	st.setString(1, myTopic);
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
	
	response.sendRedirect("/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"));
	//test
	}
	}
%>
</body>
</html>

<%
	} catch (NumberFormatException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ URLEncoder.encode("&redirect=/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"), "utf-8"));
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ URLEncoder.encode("&redirect=/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"), "utf-8"));
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ URLEncoder.encode("&redirect=/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"), "utf-8"));
		return;
	}
%>