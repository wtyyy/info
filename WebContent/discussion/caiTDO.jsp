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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// add the #cons of a topic
PreparedStatement st = Conn.getConn().prepareStatement("select * from Discussion where id=?");
st.setInt(1, Integer.valueOf(request.getParameter("id")));
ResultSet rs = st.executeQuery();
if (rs.next()) {
	int cons = rs.getInt("cons")+1;
	PreparedStatement st2 = Conn.getConn().prepareStatement("update Discussion set cons=? where id=?");
	st2.setInt(1, cons);
	st2.setInt(2, Integer.valueOf(request.getParameter("id")));
	st2.executeUpdate();
}
response.sendRedirect("/Test/discussion/postReply.jsp?topicid="+request.getParameter("id")+"&zone="+request.getParameter("zone"));

%>
</body>
</html>
<%
} catch (NumberFormatException e) {
	response.sendRedirect("../message.jsp?message="
			+ URLEncoder.encode("数字格式错误", "utf-8")
			+ "&redirect="+ URLEncoder.encode("/Test/discussion/postReply.jsp?topicid="+request.getParameter("id")+"&zone="+request.getParameter("zone"),"utf-8"));
	return;
} catch (SQLException e) {
	response.sendRedirect("../message.jsp?message="
			+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
			+ "&redirect="+ URLEncoder.encode("/Test/discussion/postReply.jsp?topicid="+request.getParameter("id")+"&zone="+request.getParameter("zone"),"utf-8"));
	return;
} catch (Exception e) {
	response.sendRedirect("../message.jsp?message="
			+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
			+ "&redirect="+ URLEncoder.encode("/Test/discussion/postReply.jsp?topicid="+request.getParameter("id")+"&zone="+request.getParameter("zone"),"utf-8"));
	return;
}
%>