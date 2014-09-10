<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
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
	CourseInfo currentCourse = null;
	if (request.getParameter("courseId") != null
			&& !request.getParameter("courseId").equals("")) {
		ResultSet rs = Conn
				.getConn()
				.prepareStatement(
						"select * from courses where id="
								+ request.getParameter("courseId"))
				.executeQuery();
		if (rs.next()) {
			isModify = true;
			currentCourse = (CourseInfo) (new BeanProcessor().toBean(
					rs, CourseInfo.class));
		} else {
			out.println("没有");
		}
	}
%>
<body>
	<%
		if (isModify) {

			out.println("<a href=\"courseManage.jsp\">当前处于修改模式，转移到添加模式</a>");
		}
	%>
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
					<td>被修改的课程id(-1代表添加新课程)</td>
					<td><input type="text" name="id"
						value="<%=isModify ? currentCourse.getId() : "-1"%>" readonly /></td>
				</tr>
				<tr>
					<td>名字</td>
					<td><input type="text" name="name"
						value="<%=isModify ? currentCourse.getName() : "课程名称"%>" /></td>
				</tr>
				<tr>
					<td>老师</td>
					<td><input type="text" name="teacher"
						value="<%=isModify ? currentCourse.getTeacher() : "任课教师"%>" /></td>
				</tr>
				<tr>
					<td>星期几(0是星期天哦)</td>
					<td><input type="number" name="day"
						value="<%=isModify ? currentCourse.getDay() : "0"%>" /></td>
				</tr>
				<tr>
					<td>第几节(0~14)</td>
					<td><input type="number" name="block"
						value="<%=isModify ? currentCourse.getBlock() : "0"%>" /></td>
				</tr>
				<tr>
					<td>容量</td>
					<td><input type="number" name="capacity"
						value="<%=isModify ? currentCourse.getCapacity() : "100"%>" /></td>
				</tr>
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="startTime"
						value="<%=isModify ? currentCourse.getStartTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="endTime"
						value="<%=isModify ? currentCourse.getEndTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>更多介绍</td>
					<td><input type="text" name="text" value="课程介绍" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	删除/修改课程：
	<form method="get" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="delete">
		<%
			CourseTable.printTable(
					new BeanProcessor().toBeanList(Conn.getConn()
							.prepareStatement("select * from courses")
							.executeQuery(), CourseInfo.class), out, true);
		%>
		<input type="submit" formaction="courseManage.jsp" value="modify">
		<input type="submit" formaction="viewCourseMember.jsp" value="查看成员">
		<input type="submit" value="delete" />
	</form>
</body>
</html>