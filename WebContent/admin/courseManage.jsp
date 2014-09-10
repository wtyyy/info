<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程管理</title>
</head>
<%
	boolean isModify = false;
	out.println(user);
	if (!"admin".equals(user.getPrivilege())) {
		response.sendRedirect("../index.jsp");
	}
	if (request
	.getParameter("courseId") != null &&  !request
			.getParameter("courseId").equals("")) {
		isModify = true;
	}
%>
<body>
	<%=isModify?"修改":"添加" %>课程：
	<form method="post" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="add">
		<table border="1">
			<thead>
				<tr>
					<th colspan="2">Enter Information Here</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>名字</td>
					<td><input type="text" name="name" value="" /></td>
				</tr>
				<tr>
					<td>老师</td>
					<td><input type="text" name="teacher" value="" /></td>
				</tr>
				<tr>
					<td>星期几</td>
					<td><input type="number" name="day" value="" /></td>
				</tr>
				<tr>
					<td>第几节</td>
					<td><input type="number" name="block" value="" /></td>
				</tr>
				<tr>
					<td>容量</td>
					<td><input type="number" name="capacity" value="" /></td>
				</tr>
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="startTime" value="" /></td>
				</tr>				
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="endTime" value="" /></td>
				</tr>
				<tr>
					<td>更多介绍</td>
					<td><input type="text" name="text" value="" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	删除/修改课程：
	<form method="post" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="delete">
		<%
			CourseTable.printTable(new BeanProcessor().toBeanList(Conn.getConn()
					.prepareStatement("select * from courses").executeQuery(), CourseInfo.class), out, true);
		%>
		<input type="checkbox" name="isModify">修改 
		<input type="submit" value="Submit" />
	</form>
</body>
</html>