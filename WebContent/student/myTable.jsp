<%@page import="java.net.URLEncoder"%>
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
<%
	Connection con = null;
	try {
		con = Conn.getConn();
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML a1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	if (user.getPrivilege() == null) {
		out.println("</head><body><script language=\"javascript\">");
		out.println("alert(\"你尚未登录\");");
		out.println("location.href=\"/Test/index.jsp\";");
		out.println("</script></body>");		
		return;
	}
%>
<style type="text/css">
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	word-break: break-all;
	word-wrap: break-all;
	width: 100%;
	border-collapse: collapse;
}

#customers td, #customers th {
	font-size: 0.8em;
	border: 1px solid #53868B;
	padding: 3px 7px 2px 7px;
}

#customers th {
	font-size: 0.9em;
	text-align: left;
	padding-top: 5px;
	padding-bottom: 4px;
	background-color: #53868B;
	color: #ffffff;
}

#customers tr.alt td {
	color: #000000;
	background-color: #EAF2D3;
}
</style>
<title>选课</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.color.js"></script>
<script type="text/javascript" charset="utf-8">
	// <![CDATA[
	$(document).ready(function() {
		$('div.blog_port').hover(function() {
			$(this).stop().animate({
				backgroundColor : "#f7f7f7"
			}, 300);
		}, function() {
			$(this).stop().animate({
				backgroundColor : "#fefefe"
			}, 300);
		});
	});
	// ]]>
</script>
</head>
<body>
	<div class="main">
		<div class="header_resize">
			<div class="header">
				<div class="logo">
					<a href="#"><img src="images/logo.gif" width="338" height="70"
						border="0" alt="" /></a>
				</div>
				<div class="menu">
					<ul>
						<li><a href="/Test/index.jsp"><span>登陆首页</span></a></li>
						<li><a href="/Test/publicResource/teach.jsp"><span>教务信息
							</span></a></li>

						<li><a href="/Test/publicResource/"><span>公共资源页面 </span></a></li>
						<li><a href="/Test/student/courseSelect.jsp" class="active"><span>
									课程管理页面</span></a></li>
						<li><a href="/Test/discussion/"><span>讨论区</span></a></li>
						<li><a href="/Test/teachers.jsp"><span> 师资力量</span></a></li>
						<li><a href="/Test/about.jsp"><span> 网站简介</span></a></li>
					</ul>
				</div>
				<div class="clr"></div>
				<div class="clr"></div>
			</div>
		</div>
		<div class="clr"></div>
		<div class="header_blog2">
			<div class="header">
				<h2>选课</h2>
				<p>
					添加、删除课程<br />
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="left">
					<%
						if ("student".equals(user.getPrivilege())) {
					%>
					<h2>你的课表</h2>
					<%
						List<CourseInfo> courseList = CourseInfo
										.getStudentCourseList(user.getId());
					%>
					<table border="1" id="customers">
						<tr>
							<th>节</th>
							<td width=100px>星期日</td>
							<th width=100px>星期一</th>
							<td width=100px>星期二</td>
							<th width=100px>星期三</th>
							<td width=100px>星期四</td>
							<th width=100px>星期五</th>
							<td width=100px>星期六</td>
						</tr>
						<%
							for (int i = 0; i < 5; i++) {
						%>
						<tr>
							<td><%=i%></td>
							<%
								for (int j = 0; j < 7; j++) {
							%>
							<td>
								<%
									for (CourseInfo course : courseList) {
														if (course.getDay() == j
																&& course.getBlock() == i) {
								%> <%=course.getName()%> <%
 	}
 					}
 %>
							</td>
							<%
								}
							%>
						</tr>
						<%
							}
						%>
					</table>
					<%
						} else {
					%>

					<%
						}
					%>
					<%
						if (user.getEmail() != null
									&& "student".equals(user.getPrivilege())) {
								out.println("<br/><h2>两天内你会上的课</h2><table id=\"customers\">");
								List<CourseInfo> courseList = CourseInfo
										.getStudentCourseList(user.getId());
								for (CourseInfo course : courseList) {
									Calendar now = Calendar.getInstance();
									int DayInWeek = now.get(Calendar.DAY_OF_WEEK) - 1;
									int courseDay = course.getDay();
									if (courseDay < DayInWeek) {
										courseDay += 7;
									}
									System.out.println(course.getName() + courseDay
											+ DayInWeek);
									if (courseDay - DayInWeek <= 2) {
					%><tr>
						<td><%=course.getName()%></td>
						<td><%=course.getTeacher()%></td>
						<td>
							<%
								switch (courseDay % 7) {
												case 0:
													out.print("星期日");
													break;
												case 1:
													out.print("星期一");
													break;
												case 2:
													out.print("星期二");
													break;
												case 3:
													out.print("星期三");
													break;
												case 4:
													out.print("星期四");
													break;
												case 5:
													out.print("星期五");
													break;
												case 6:
													out.print("星期六");
													break;
												default:
													break;
												}
							%>第<%=course.getBlock()%>节
						</td>
					</tr>
					<%
						}

								}
								out.println("</table>");
							}
					%>
					<br />

				</div>
				<div class="right">

					<table border="1" id="customers" align="center">
						<tr>
							<td><a>可选课程</a></td>
						</tr>
						<tr>
							<td><a href="/Test/student/courseSelectAlready.jsp">已选课程</a></td>
						</tr>
						<tr>
							<td><a href="/Test/student/courseSelectAll.jsp">所有课程</a></td>
						</tr>
						<tr>
							<td><a href="/Test/student/courseSelectHistory.jsp">历史操作记录</a></td>
						</tr>
						<tr>
							<td><a href="/Test/student/myTable.jsp">我的课表</a></td>
						</tr>
					</table>
				</div>

			</div>
		</div>
		<div class="clr"></div>
		<div class="footer">
			<div class="footer_resize">
				<p class="leftt">© Copyright wty&yy . All Rights Reserved</p>
				<p class="right">
					当前登录用户：<%=user.getEmail() == null ? "您尚未登录" : user.getEmail()%><br />
					<%=user.getEmail() == null ? "<a href=\"/Test/signin.jsp\">登录</a></p>"
						: "<a href=\"/Test/logout.jsp\">注销</a></p>"%>
				<div class="clr"></div>
			</div>
			<div class="clr"></div>

		</div>
	</div>

</body>
</html>
<%
	} catch (NumberFormatException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8") + "&redirect="
				+ request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		throw e;
		//return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	} finally {
		try {
			con.close();
		} catch (SQLException e) {

		}
	}
%>
