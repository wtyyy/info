<%@page import="util.UserTable"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="util.StudentChooseCourseHistory"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="util.CourseTime"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="util.UserInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	String email = request.getParameter("uname");
	String pwd = request.getParameter("pass");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from users where email='" + email
	+ "' and password='" + pwd + "'");
	if (rs.next()) {
		UserInfo tempUser = (UserInfo)new BeanProcessor().toBean(rs,
				UserInfo.class);
		out.println(tempUser);
		if (tempUser.getBlocked() == 1) {
			out.println("你被禁止登录了，请联系管理员");
			session.setAttribute("user", null);
		} else {
			session.setAttribute("user", tempUser);
			response.sendRedirect("success.jsp");
			return;
		}
	} else {
		out.println("Invalid password <a href='index.jsp'>try again</a>");
	}
%>