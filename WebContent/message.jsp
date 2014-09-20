<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.CourseTable"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>通知</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
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
						<li><a href="/Test/publicResource/"><span>公共资源页面 </span></a></li>
						<li><a href="/Test/student/courseSelect.jsp"><span>
									课程管理页面</span></a></li>
						<li><a href="/Test/discussion/"><span>讨论区</span></a></li>
						<li><a href="/Test/teachers.jsp"><span> 师资力量</span></a></li>
						<li><a href="/Test/about.jsp" class="active"><span>
									网站简介</span></a></li>
					</ul>
				</div>
				<div class="clr"></div>
				<div class="clr"></div>
			</div>
		</div>
		<div class="clr"></div>
		<div class="header_blog2">
			<div class="header">
				<h2>信息</h2>
				<p>
					我想告诉你 <br /> 一些事事情
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="left">
					<p>
						<%
							if (request.getParameter("message") != null) {
								out.print(request.getParameter("message"));
							} else if (request.getAttribute("message") != null) {
								out.print(request.getAttribute("message"));
							} else {
								out.print("未知错误");
							}

							if (request.getParameter("redirect") != null) {
								out.print("<br/><a href=\"" + request.getParameter("redirect")
										+ "\">返回</a>");
							} else {
						%>
						<br /> <a href="javascript:history.back()">后退</a>
						<%
							}
						%>
					</p>
				</div>
				<div class="right">
					<h2>联系开发者</h2>
					<img src="images/team_1.gif" alt="" width="54" height="55"
						class="floated" />
					<p>
						<strong>王天一</strong><br /> 住在116
					</p>
					<p>&nbsp;</p>
					<img src="images/team_2.gif" alt="" width="54" height="55"
						class="floated" />
					<p>
						<strong>袁源 </strong><br /> 住在113
					</p>
					<p>&nbsp;</p>

				</div>
				<div class="clr"></div>
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
