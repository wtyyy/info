<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<%
Connection con = null;
try {
	con = Conn.getConn();
%>
<jsp:useBean id="course" class="util.CourseInfo" scope="request" />
<jsp:setProperty name="course" property="*" />
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		out.println(user);
		if ((!"admin".equals(user.getPrivilege()))) {
			response.sendRedirect("../index.jsp");
			return;
		} else if ("delete".equals((String) request.getParameter("oper"))) {

			out.println("别拿那种眼神看着我，我知道你想删东西");


			int courseId = Integer.parseInt(request
					.getParameter("courseId"));
			con
					.createStatement()
					.executeUpdate(
							"delete from studentChooseCourse where courseId='"
									+ courseId + "'");
			int result = Conn
					.getConn()
					.createStatement()
					.executeUpdate(
							"delete from courses where id='" + courseId
									+ "'");
			if (result > 0) {
				response.sendRedirect("courseManage.jsp");
				return;
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode("查无此课，可能被别的管理员删了", "utf-8")+"&redirect=/Test/admin/courseManage.jsp");
			 	return;
			}

		} else if ("add".equals(request.getParameter("oper"))) {
			out.println("别拿那种眼神看着我，我知道你想加东西");
			out.println(course);
			if (CourseTime.fromDayAndBlock(course.getDay(),
					course.getBlock()) == null) {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode("无效的上课时间", "utf-8")+"&redirect=/Test/admin/courseManage.jsp");
			 	return;
			}
			try {
				PreparedStatement st = null;
				if (course.getId() == -1) {
					st = Conn
							.getConn()
							.prepareStatement(
									"insert into courses(name, teacher,day,block, text, capacity, startTime, endTime, selectStartTime, selectEndTime)"
											+ "values(?,?,?,?,?,?,?,?,?,?)");
				} else {
					st = Conn
							.getConn()
							.prepareStatement(
									"update courses set name=?,teacher=?,day=?,block=?,text=?,capacity=?,startTime=?,endTime=?,selectStartTime=?,selectEndTime=? where id=?");

					st.setInt(9, course.getId());
				}
				st.setString(1, course.getName());
				st.setString(2, course.getTeacher());
				st.setInt(3, course.getDay());
				st.setInt(4, course.getBlock());
				st.setString(5, course.getText());
				st.setInt(6, course.getCapacity());
				st.setDate(7, Date.valueOf(course.getStartTime()));
				st.setDate(8, Date.valueOf(course.getEndTime()));
				st.setDate(9, Date.valueOf(course.getSelectStartTime()));
				st.setDate(10, Date.valueOf(course.getSelectEndTime()));
				int i = st.executeUpdate();
				if (i > 0) {
					response.sendRedirect("courseManage.jsp");
					return;
				}
			} catch (SQLException e) {
				if (e.getErrorCode() == 1062) {
					response.sendRedirect("../message.jsp?message="+URLEncoder.encode("课程名称已经存在", "utf-8")+"&redirect=/Test/admin/courseManage.jsp");
				 	return;
				} else {
					response.sendRedirect("../message.jsp?message="+URLEncoder.encode("数据格式有误", "utf-8")+"&redirect=/Test/admin/courseManage.jsp");
				 	return;
				}
			}
		}else if ("select".equals(request.getParameter("oper"))) {
			out.println("拉人啦!");
			int studentId = Integer.parseInt(request.getParameter("userId"));
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			String errorMessage = CourseSelect.select(studentId, courseId, true);
			if ( errorMessage == null) {
				response.sendRedirect(request.getParameter("redirect"));
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode(errorMessage, "utf-8")+"&redirect=/Test/admin/courseManage.jsp");
			 	return;
			}
		}else if ("deselect".equals(request.getParameter("oper"))) {
			out.println("踢人啦!");
			int studentId = Integer.parseInt(request.getParameter("userId"));
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			String errorMessage = CourseSelect.deselect(studentId, courseId);
			if ( errorMessage == null) {
				response.sendRedirect(request.getParameter("redirect"));
			} else {
				response.sendRedirect("../message.jsp?message="+URLEncoder.encode(errorMessage, "utf-8") + "&redirect=/Test/admin/courseManage.jsp");
			 	return;
			}
		}
		//
	%>
</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} finally {
		try {
			con.close();
		} catch (Exception e) {
			
		}
	}
%>