<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="util.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看课程成员</title>
</head>
<body>
	<%
		if (user.getPrivilege() == null
				|| !"admin".equals(user.getPrivilege())) {
			response.sendRedirect("../index.jsp");
			return;
		}
		if (request.getParameter("courseId") == null) {
			response.sendRedirect("courseManage.jsp");
			return;
		}
		int courseId = Integer.parseInt(request.getParameter("courseId"));
		ResultSet memberPairSet = Conn
				.getConn()
				.prepareStatement(
						"select * from studentChooseCourse where courseId="
								+ courseId).executeQuery();
		List<StudentChooseCourse> memberPairList = new BeanProcessor()
				.toBeanList(memberPairSet, StudentChooseCourse.class);
		List<UserInfo> memberList = new ArrayList<UserInfo>();
		for (StudentChooseCourse pair : memberPairList) {
			ResultSet memberSet = Conn
					.getConn()
					.prepareStatement(
							"select * from users where id="
									+ pair.getStudentId()).executeQuery();
			memberList.addAll(new BeanProcessor().toBeanList(memberSet,
					UserInfo.class));
		}
	%>
	删除成员:
	<form method="post" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="deselect"> <input
			type="hidden" name="courseId" value="<%=courseId%>" />
		<%
			UserTable.printUsers(memberList, out, true);
		%>
		<input type="submit" value="删除" />
	</form>
	添加成员：
	<form method="post" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="select"> <input
			type="hidden" name="courseId" value="<%=courseId%>" />
		<%
			UserTable
					.printUsers(
							new BeanProcessor()
									.toBeanList(
											Conn.getConn()
													.prepareStatement(
															"select * from users where privilege='student'")
													.executeQuery(), UserInfo.class),
							out, true);
		%>
		<input type="submit" value="添加" />
	</form>
</body>
</html>