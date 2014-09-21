<%@page import="java.net.URLEncoder"%>
<%@page import="util.*"%>
<%@page import="jdbc.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
Connection conn = null;
 try { 
	 conn = Conn.getConn();



			int id = Integer.valueOf(request.getParameter("userid"));
			if (!"admin".equals(user.getPrivilege())) {
				response.sendRedirect("/Test/discussion/postReply.jsp?topicid="
						+ request.getParameter("topicid") + "&zone="
						+ request.getParameter("zone"));
				return;

			}
			conn
					.prepareStatement(
							"insert into Forbidden(id) values(" + id + ")")
					.execute();
			out.println("<script language=\"javascript\">");
			out.println("alert(\"封人成功！\");");
			out.println("location.href=\"/Test/discussion/postReply.jsp?topicid="
					+ request.getParameter("topicid")
					+ "&zone="
					+ request.getParameter("zone")+"\";");
			out.println("</script>");

		} catch (Exception e) {
			response.sendRedirect("../message.jsp?message="
					+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
					+ "&redirect=" + URLEncoder.encode("/Test/discussion/postReply.jsp?topicid="
					+ request.getParameter("topicid") + "&zone="
					+ request.getParameter("zone"), "utf-8"));
			return;
		}  finally {
			try {
				conn.close();
			} catch (Exception e) {
				
			}
			}
		// if a person has been forbidden, then the one should not be forbidden again
	%>

</body>
</html>
