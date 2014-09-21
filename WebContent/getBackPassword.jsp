<%@page import="util.MailUtil"%>
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
<%
Connection conn = null;
 try { 
	 conn = Conn.getConn();

%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
		String email = request.getParameter("uname");
		if (email == null || "".equals(email)) {
			response.sendRedirect("message.jsp?message="
					+ URLEncoder.encode("无效的email", "utf-8")
					+ "&redirect=/Test/signin.jsp");
			return;
		}
		
		UserInfo tempUser = UserInfo.getByEmail(email);
		MailUtil.sendTo("找回密码", "用户" + email + "想要找回密码，<a href=\"http://localhost:8080/Test/emailValidate.jsp?oper=getBack&id=" + tempUser.getId() + "&code=" + tempUser.getPassword()+ "\">点击继续</a>\0", email);
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("验证邮件已经发送，请查收", "utf-8"));
		return;
	
	} catch (NumberFormatException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8") + "&redirect="
				+ request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	}  finally {
		try {
			conn.close();
		} catch (Exception e) {
			
		}
		}
%>