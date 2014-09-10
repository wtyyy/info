<%@page import="jdbc.Conn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		out.println(user);

		int courseId = Integer.parseInt(request.getParameter("courseId"));
		Connection con = Conn.getConn();
		if (con == null) {
			out.print("fuck !");
		} else if (request.getParameter("oper") == null) {
			response.sendRedirect("courseSelect.jsp");
		} else if (((String) request.getParameter("oper")).equals("add")) {
			boolean success = true;
			boolean notCommmit = false;
			con.setAutoCommit(false);

			out.println("你想选课");
			try {
				ResultSet myCourses = con.prepareStatement(
						"select * from studentChooseCourse where studentId='"
								+ user.getId() + "'").executeQuery();
				ResultSet wantedCourse = con
						.prepareStatement(
								"select * from courses where id='"
										+ courseId + "'").executeQuery();
				ResultSet whoChosedThisCourse = con.createStatement().executeQuery("select count(*) from studentChooseCourse where courseId=" + courseId);
				
				int chosedNumber = 0;
				if (whoChosedThisCourse.next()) {
					chosedNumber = whoChosedThisCourse.getInt(1);
				}
				int capacity = 0;
				if (wantedCourse.next()) {
					capacity = wantedCourse.getInt("capacity");
					for (; myCourses.next();) {
						ResultSet thisCourseInfo = con.prepareStatement(
								"select * from courses where id='"
										+ myCourses.getInt("courseId")
										+ "'").executeQuery();
						if (!thisCourseInfo.next()) {
							out.println("mysql太不靠谱了");
							notCommmit = true;
							break;
						}
						if (wantedCourse.getInt("day") == thisCourseInfo
								.getInt("day") && wantedCourse.getInt("block") == thisCourseInfo
										.getInt("block")) {
							out.println("时间冲突");
							notCommmit = true;
							break;
						}
					}
				} else {
					out.println("没这个课");
					notCommmit = true;
				}

				if (!notCommmit) {
					if (chosedNumber < capacity) {
						con.createStatement().executeUpdate(
								"insert into studentChooseCourse(studentId, courseId) values('"
										+ user.getId() + "','" + courseId + "')");
						response.sendRedirect("courseSelect.jsp");
					} else {
						notCommmit = true;
						out.println("满了");
					}
				}
				con.commit();

			} catch (SQLException e) {
				success = false;
				con.rollback();
				out.println("别人抢先了亲");
				throw e;
			} finally {
				con.setAutoCommit(true);
			}
			if (success && !notCommmit) {
				out.println("成功了");
			}

		} else if (((String) request.getParameter("oper")).equals("delete")) {
			out.println("你想删课");
			int result = con.createStatement().executeUpdate(
					"delete from studentChooseCourse where studentId='"
							+ user.getId() + "' and courseId='" + courseId + "'");
			out.println("删除了" + result + "个");
			response.sendRedirect("courseSelect.jsp");
		}
	%>
</body>
</html>