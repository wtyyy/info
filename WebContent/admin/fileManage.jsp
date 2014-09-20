<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
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
<% try{ %>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML a1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
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
				<h2>文件管理</h2>
				<p>
					上传文件<br /> 建议上传图片
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="full">
					<form action="/Test/uploadServlet" method="post"
						enctype="multipart/form-data" id="contactform">
						<ol>
							<li><label for="name">文件名（请务必保留源文件后缀）</label><input
								type="text" name="name" id="name" class="text" /></li>
							<li><label for="file">文件</label><input type="file" name="file" id="file" class="text" /></li>
							
							<li><input type="submit" value="上传" /></li>
						</ol>	
					</form>
					<%
						int deleteId = -1;
						if (request.getParameter("fileId") != null) {
							try {
								deleteId = Integer.parseInt(request.getParameter("fileId"));
							} catch (NumberFormatException e) {
							}
						}
						if (deleteId != -1) {
							Conn.getConn()
									.prepareStatement(
											"delete from files where id=" + deleteId)
									.execute();
						}
					%>
					<h2>已有文件</h2>
					<form action="fileManage.jsp" method="post">
						<table id="customers">
							<tr>
								<th>选择</th>
								<th>id</th>
								<th>文件名</th>
								<th>链接</th>
							</tr>

							<%
								ResultSet rs = Conn.getConn()
										.prepareStatement("select * from files").executeQuery();
								for (; rs.next();) {
							%>
							<tr>
								<td><input type="radio" name="fileId"
									value="<%=rs.getInt("id")%>" /></td>
								<td><%=rs.getInt("id")%></td>
								<td><%=rs.getString("name")%></td>
								<td><a href="/Test/DBFileGetter?id=<%=rs.getInt("id")%>">/Test/DBFileGetter?id=<%=rs.getInt("id")%></a>
							</tr>
							<%
								}
							%>
						</table>
						<input type="submit" value="删除" />
					</form>
				</div>
			</div>
		</div>
		<div class="clr"></div>
		<div class="footer">
			<div class="footer_resize">
				<p class="leftt">© Copyright wty&yy . All Rights Reserved</p>
      <p class="right"> 当前登录用户：<%=user.getEmail()==null?"您尚未登录":user.getEmail() %><br />
      <%=user.getEmail()==null?"<a href=\"/Test/signin.jsp\">登录</a></p>":"<a href=\"/Test/logout.jsp\">注销</a></p>"%>
				
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
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=admin/infoManage.jsp");
		return;
	}
%>