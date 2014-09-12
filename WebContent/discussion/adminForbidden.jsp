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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="form1" method="post" action="adminForbiddenDO.jsp">
<%
	if (user.getPrivilege()==null || !user.getPrivilege().equals("admin")) 
	{
		out.println("<script language=\"javascript\">");
		out.println("alert(\"您越权了亲\");");
		out.println("location.href=\"/Test/index.jsp\";");
		out.println("</script>");
	}
	else 
	{
		PreparedStatement st = Conn.getConn().prepareStatement("select * from Forbidden");
		ResultSet rs = st.executeQuery();
		ArrayList<UserInfo> users = new ArrayList<UserInfo>();
		while (rs.next()) {
			int userid = rs.getInt("id");
			PreparedStatement st2 = Conn.getConn().prepareStatement("select * from users where id="+userid);
			ResultSet rs2 = st2.executeQuery();
			while (rs2.next()) {
				UserInfo ui = ((UserInfo) (new BeanProcessor().toBean(
						rs2, UserInfo.class)));
				users.add(ui);
			}
		}
		out.println("<table id=\"customers\">");

		UserTable.printUsers(users, out, true);
		out.println("<label><input name=\"submit\" type=\"submit\" id=\"submit\" value=\"解 封\" /></label>");
		out.println("</table>");
	}
	
%>

</form>
</body>
</html>