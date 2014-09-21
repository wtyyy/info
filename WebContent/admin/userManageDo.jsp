<%@page import="java.net.URLEncoder"%>
<%@page import="util.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
Connection con = null;
try {
	con = Conn.getConn();
%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (!"admin".equals(user.getPrivilege())) {
			response.sendRedirect("../index.jsp");
			return;
		}
		int userId = Integer.parseInt(request.getParameter("userId"));
		UserInfo userInfo = UserInfo.getById(userId);
		if ("delete".equals(request.getParameter("oper"))) {
			if (con
					.prepareStatement(
							"delete from users where id=" + userId)
					.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode("操作失败，请检查数据格式", "utf-8")+ "&redirect=/Test/admin/userManage.jsp");
			 	return;
			}
		} else if ("changeBlock".equals(request.getParameter("oper"))) {
			PreparedStatement st = con.prepareStatement(
					"update users set blocked=? where id=" + userId);
			st.setInt(1, 1 - userInfo.getBlocked());
			if (st.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode("操作失败，请检查数据格式", "utf-8")+ "&redirect=/Test/admin/userManage.jsp");
			 	return;
			}
		} else if ("changePrivilege".equals(request.getParameter("oper"))) {
			PreparedStatement st = con.prepareStatement(
					"update users set privilege=? where id=" + userId);
			st.setString(1,
					userInfo.getPrivilege().equals("admin") ? "student"
							: "admin");
			if (st.executeUpdate() > 0) {
				response.sendRedirect("userManage.jsp");
				return;
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode("操作失败，请检查数据格式", "utf-8") + "&redirect=/Test/admin/userManage.jsp");
			 	return;
			}
		}
	%>
</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	}finally {
		try {
			con.close();
		} catch (Exception e) {
			
		}
	}
%>