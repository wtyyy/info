<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = null;
	try {
		conn = Conn.getConn();
%>
<%
	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
</head>
<body>
	<%
		if ("validate".equals(request.getParameter("oper"))) {
				if (request.getParameter("id") == null
						|| request.getParameter("code") == null) {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("您在试图验证邮箱吗？这是错误的用法",
									"utf-8") + "&redirect=index.jsp");
					return;
				}
				int id = Integer.parseInt(request.getParameter("id"));
				int code = Integer.parseInt(request.getParameter("code"));
				UserInfo user = UserInfo.getById(id);
				if (user.getEmail().hashCode() == code) {
					conn.prepareStatement(
							"update users set validated=1 where id=" + id)
							.execute();
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("验证email成功，可以登录了", "utf-8")
							+ "&redirect=/Test/signin.jsp");
					return;
				} else {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("验证码错误", "utf-8")
							+ "&redirect=index.jsp");
					return;
				}
			} else if("getBack".equals(request.getParameter("oper"))){
				if (request.getParameter("id") == null
						|| request.getParameter("code") == null) {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("您在试图找回密码吗？这是错误的用法",
									"utf-8") + "&redirect=index.jsp");
					return;
				}
				int id = Integer.parseInt(request.getParameter("id"));
				String code = request.getParameter("code");
				UserInfo user = UserInfo.getById(id);
				
				if (user.getPassword().equals(code)) {
					PreparedStatement stmt = conn.prepareStatement("update users set password=? where id=?");
					stmt.setString(1, MD5Tool.digest(code));
					stmt.setInt(2, id);
					stmt.executeUpdate();
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("你的密码已经重设为" + code+"，请尽快修改",
									"utf-8") + "&redirect=signin.jsp");
					return;
				} else {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("您在试图找回密码吗？验证码错了",
									"utf-8") + "&redirect=index.jsp");
					return;
				}
				
			} else {
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("无效的参数", "utf-8")
						+ "&redirect=/Test/index.jsp");
			}
	%>

</body>
</html>
<%
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
	} finally {
		try {
			conn.close();
		} catch (Exception e) {

		}
	}
%>