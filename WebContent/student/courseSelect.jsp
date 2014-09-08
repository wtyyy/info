<%@page import="util.CourseTable"%>
<%@page import="util.CourseTime"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
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
		if (request.getAttribute("message") != null) {
			out.println(request.getAttribute("message"));
		}
		out.println("你的情况是:");
		out.println(session.getAttribute("privilege"));
		out.println(session.getAttribute("id"));
		out.println(session.getAttribute("email"));
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = Conn.getConn();
		ResultSet selectedCourseSet = null;
		if (session.getAttribute("privilege").equals("student")) {
			String email = (String) session.getAttribute("email");
			int id = (int) session.getAttribute("id");
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
			</tr>
			<%
				if (session.getAttribute("privilege").equals("student")) {
					for (; selectedCourseSet.next();) {

						Statement st = con.createStatement();
						ResultSet thisCourse = st
								.executeQuery("select * from courses where id='"
										+ selectedCourseSet.getInt("courseId")
										+ "'");
						if (thisCourse.next()) {
							CourseTable.printSingleCourse(thisCourse, out, true);
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
			CourseTable.printTable(con
					.prepareStatement("select * from courses").executeQuery(),
					out, true);
		%>
		<input type="submit" value="Submit" />
	</form>


</body>
</html>