<%@page import="util.StudentChooseCourseHistory"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="util.CourseTime"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (request.getAttribute("message") != null) {
			out.println(request.getAttribute("message"));
		}
		out.println(user);
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = Conn.getConn();
		ResultSet selectedCourseSet = null;
		if (user.getPrivilege().equals("student")) {
			String email = user.getEmail();
			int id = user.getId();
			Statement st = con.createStatement();
			selectedCourseSet = st
					.executeQuery("select * from studentChooseCourse where studentId='"
							+ id + "'");
		} else {
			out.println("你不是学生");
		}
	%>
	已选课程：
	<form method="post" action="courseSelectDo.jsp">
		<input type="hidden" name="oper" value="delete">
		<table border="1">
			<tr>
				<td>删除</td>
				<td>课程id</td>
				<td>名称</td>
				<td>教师</td>
				<td>星期</td>
				<td>第几节</td>
				<td>容量</td>
				<td>选课人数</td>
				<td>起始日期</td>
				<td>结束日期</td>
				<td>更多信息</td>
			</tr>
			<%
				if (user.getPrivilege().equals("student")) {
					for (; selectedCourseSet.next();) {

						Statement st = con.createStatement();
						ResultSet thisCourse = st
								.executeQuery("select * from courses where id='"
										+ selectedCourseSet.getInt("courseId")
										+ "'");
						if (thisCourse.next()) {
							CourseTable.printSingleCourse(
									(CourseInfo) (new BeanProcessor().toBean(
											thisCourse, CourseInfo.class)), out,
									true);
						} else {
							out.println("搞错了");
						}
					}
				}
			%>
		</table>
		<input type="submit" value="Submit" />
	</form>
	可选课程：
	<form method="post" action="courseSelectDo.jsp">
		<input type="hidden" name="oper" value="add">
		<%
			CourseTable.printTable(new BeanProcessor().toBeanList(con
					.prepareStatement("select * from courses").executeQuery(),
					CourseInfo.class), out, true);
		%>
		<input type="submit" value="Submit" />
	</form>
	选课历史纪录：
	<table>
		<tr>
			<td>课程id</td>
			<td>课程名</td>
			<td>操作</td>
			<td>时间</td>
		</tr>
		<%
			ResultSet rs = Conn
					.getConn()
					.prepareStatement(
							"select * from studentChooseCourseHistory where studentId ="
									+ user.getId()).executeQuery();
			List<StudentChooseCourseHistory> historyList = new BeanProcessor()
					.toBeanList(rs, StudentChooseCourseHistory.class);
			for (StudentChooseCourseHistory history : historyList) {
				out.println("<tr><td>" + history.getCourseId() + "</td><td>"
						+ CourseInfo.getById(history.getCourseId()).getName()
						+ "</td><td>" + history.getOperation() + "</td><td>"
						+ history.getTime() + "</td></tr>");
			}
		%>
	</table>

</body>
</html>