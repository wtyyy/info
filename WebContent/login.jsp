<%@page import="util.MD5Tool"%>
<%@page import="java.net.URLEncoder"%>
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
	
	if (email == null || pwd == null) {
		 response.sendRedirect("message.jsp?message="+URLEncoder.encode("无效的用户名密码", "utf-8") +"&redirect=/Test/signin.jsp");
		 return;
	}
	pwd = MD5Tool.digest(pwd);
	
	PreparedStatement st = Conn.getConn().prepareStatement("select * from users where email=? and password=?");
	st.setString(1, email);
	st.setString(2, pwd);
	ResultSet rs = st.executeQuery();
	if (rs.next()) {
		UserInfo tempUser = (UserInfo)new BeanProcessor().toBean(rs,
				UserInfo.class);
		out.println(tempUser);
		if (tempUser.getBlocked() == 1) {
			session.setAttribute("user", null);
			 response.sendRedirect("message.jsp?message="+URLEncoder.encode("你是封禁用户", "utf-8"));
			 return;
		} else if (tempUser.getValidated() == 0)  {
			session.setAttribute("user", null);
			 response.sendRedirect("message.jsp?message="+URLEncoder.encode("邮箱没有验证哦", "utf-8"));
			 return;
		} else {
			session.setAttribute("user", tempUser);
			response.sendRedirect("index.jsp");
			return;
		}
	} else {

		/*
		out.println("</head><body><script language=\"javascript\">");
		out.println("alert(\"密码错误\");");
		out.println("location.href=\"/Test/signin.jsp\";");
		out.println("</script></body>");		
		*/
		 response.sendRedirect("message.jsp?message="+URLEncoder.encode("密码错误", "utf-8") + "&redirect=/Test/signin.jsp");

	}
%>