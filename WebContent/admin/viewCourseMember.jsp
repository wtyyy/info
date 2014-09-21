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
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.*"%>
<%@ page import="util.*"%>
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
<style type="text/css">
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	word-break: break-all;
	word-wrap: break-all;
	width: 100%;
	border-collapse: collapse;
}

#customers td, #customers th {
	font-size: 1em;
	border: 1px solid #53868B;
	padding: 3px 7px 2px 7px;
}

#customers th {
	font-size: 1.1em;
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
<%
	boolean isModify = false;
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
		}
	}
%>
<title>课程管理</title>
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

						<li><a href="/Test/publicResource/" class="active"><span>公共资源页面
							</span></a></li>
						<li><a href="/Test/student/courseSelect.jsp"><span>
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
				<h2>课程管理</h2>
				<p>
					添加、删除、修改课程<br /> 为课程添加或删除成员
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="full">
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
							int courseId = Integer.parseInt(request
									.getParameter("courseId"));
							ResultSet memberPairSet = con.prepareStatement(
									"select * from studentChooseCourse where courseId="
											+ courseId).executeQuery();
							List<StudentChooseCourse> memberPairList = new BeanProcessor()
									.toBeanList(memberPairSet, StudentChooseCourse.class);
							List<UserInfo> memberList = new ArrayList<UserInfo>();
							for (StudentChooseCourse pair : memberPairList) {
								ResultSet memberSet = con.prepareStatement(
										"select * from users where id="
												+ pair.getStudentId()).executeQuery();
								memberList.addAll(new BeanProcessor().toBeanList(memberSet,
										UserInfo.class));
							}
					%>
					<h2>删除成员:</h2>
					<form method="post" action="courseManageDo.jsp">
						<input type="hidden" name="redirect"
							value="<%=request.getRequestURL().toString() + "?"
						+ request.getQueryString()%>" />
						<input type="hidden" name="oper" value="deselect" /> <input
							type="hidden" name="courseId" value="<%=courseId%>" />
						<%
							UserTable.printUsers(memberList, out, true);
						%>
						<input type="submit" value="删除" />
					</form>
					<h2>添加成员：</h2>
					<form method="post" action="courseManageDo.jsp">
						<input type="hidden" name="redirect"
							value="<%=request.getRequestURL().toString() + "?"
						+ request.getQueryString()%>" />
						<input type="hidden" name="oper" value="select" /> <input
							type="hidden" name="courseId" value="<%=courseId%>" />
						<%
							UserTable
										.printUsers(
												new BeanProcessor()
														.toBeanList(
																con.prepareStatement(
																		"select * from users where privilege='student'")
																		.executeQuery(),
																UserInfo.class), out, true);
						%>
						<input type="submit" value="添加" />
					</form>
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
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	} finally {
		try {
			con.close();
		} catch (Exception e) {

		}
	}
%>
