<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	out.println("你的情况是:");
	out.println(session.getAttribute("privilege"));
	out.println(session.getAttribute("id"));
	out.println(session.getAttribute("email"));
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
		ResultSet rs = null;
		if (session.getAttribute("privilege").equals("student")) {
			String email = (String) session.getAttribute("email");
			int id = (int) session.getAttribute("id");
			Statement st = con.createStatement();
			rs = st.executeQuery("select * from studentChooseCourse where studentId='"
					+ id + "'");
		} else {
			out.println("你不是学生");
		}
	%>
	已选课程：
	<table border="1">
		<tr>
			<td>课程id</td>
			<td>名称</td>
			<td>教师</td>
			<td>时间</td>
		</tr>
		<%
			if (session.getAttribute("privilege").equals("student")) {
				for (; rs.next();) {			
	
					Statement st = con.createStatement();
					ResultSet rs2 = st.executeQuery("select * from courses where id='"
									+ rs.getInt("courseId") + "'");
					if (rs2.next()) {
					out.println("<tr>");
					out.println("<td>" + rs2.getInt("id") + "</td>");
					out.println("<td>" + rs2.getString("name") + "</td>");
					out.println("<td>" + rs2.getString("teacher") + "</td>");
					out.println("<td>" + rs2.getInt("time") + "</td>");
					out.println("</tr>");
					} else {
						out.println("搞错了");
					}
				}
			}
		%>
	</table>
	可选课程：
	<form method="post" action="courseSelectDo.jsp">
			<table border="1">
			<tr>
			<td>choose</td>
			<td>id</td>
			<td>name</td>
			<td>teacher</td>
			<td>time</td>
			<%
			if (session.getAttribute("privilege").equals("student")) {
					Statement st = con.createStatement();
					rs = st.executeQuery("select * from courses");
					if (rs.next()) {
					out.println("<tr>");

					out.println("<td><input type=\"radio\" name=\"courseId\" value=\"" + rs.getInt("id") + "\" /></td>");
					out.println("<td>" + rs.getInt("id") + "</td>");
					out.println("<td>" + rs.getString("name") + "</td>");
					out.println("<td>" + rs.getString("teacher") + "</td>");
					out.println("<td>" + rs.getInt("time") + "</td>");
					out.println("</tr>");
					} else {
						out.println("搞错了");
					}
			}
			%>
			</tr>
			</table>
			<input type="submit" value="Submit" />
	</form>

	
</body>
</html>