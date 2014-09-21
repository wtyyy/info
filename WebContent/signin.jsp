<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>登录</title>
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
						<li><a href="/Test/index.jsp" class="active"><span>登陆首页</span></a></li>
						<li><a href="/Test/publicResource/teach.jsp"><span>教务信息
							</span></a></li>

						<li><a href="/Test/publicResource/"><span>公共资源页面
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
				<h2>登录</h2>
				<p>
					一旦你登录进来 <br /> 就可以为所欲为
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="left">
					<h2>请输入你的邮箱和密码</h2>
					<p>&nbsp;</p>
					<form action="login.jsp" method="post" id="contactform">
						<%
							if (request.getParameter("redirect") != null
									&& !"".equals(request.getParameter("redirect"))) {
						%>
						<input type="hidden" name="redirect"
							value="<%=request.getParameter("redirect")%>" />
						<%
							}
						%>
						<ol>
							<li><label for="email">电子邮箱地址 <span class="red">*</span></label>
								<input id="email" name="uname" class="text" /></li>
							<li><label for="password">密码<span class="red">*</span></label>
								<input type="password" name="pass" class="text" /></li>
							<li class="buttons"><input type="image" name="imageField"
								id="imageField" src="images/send.gif" class="send"
								onclick="javascript:document.getElementById('contactform').submit();" />
								<div class="clr"></div></li>
						</ol>
					</form>
				</div>
				<div class="right"></div>
				<div class="clr"></div>
			</div>
		</div>
		<div class="clr"></div>
		<div class="footer">
			<div class="footer_resize">
				<p class="leftt">
					© Copyright wty&yy . All Rights Reserved<br />
				</p>
				<p class="right">
					当前登录用户：<%=user.getEmail() == null ? "您尚未登录" : user.getEmail()%><br />
					<%=user.getEmail() == null ? "<a href=\"/Test/signin.jsp\">登录</a></p>"
					: "<a href=\"/Test/logout.jsp\">注销</a></p>"%>
					<div class="clr"></div>
			</div>
			<div class="clr"></div>
		</div>
	</div>
</html>

