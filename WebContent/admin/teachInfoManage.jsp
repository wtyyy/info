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
<%
	Connection con = null;
try {
	con = Conn.getConn();
%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	if (!"admin".equals(user.getPrivilege())) {
	response.sendRedirect("../index.jsp");
	return;
		}
%>
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
<title>教务信息管理</title>
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
						<li><a href="/Test/publicResource/teach.jsp" class="active"><span>教务信息
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
				<h2>教务信息管理</h2>
				<p>
					添加、删除、修改教务信息<br />
				</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">
				<div class="full">

					<%
						boolean slideModify = false;
							SlideNews modifySlide = null;
							boolean isModify = false;
							TeachInfo modifyInfo = null;
							String operation = request.getParameter("oper");
							if (operation != null) {
								if (operation.equals("add")) {
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									System.out.println(id);
									String title = request.getParameter("title"), text = request
											.getParameter("docText");
									if (title == null) {
										title = "";
									}
									if (text == null) {
										text = "";
									}
									PreparedStatement st = null;
									if (id == -1) {
										st = con.prepareStatement("insert into teachInfo(title, text) values(?,?)");
									} else {
										st = con.prepareStatement("update teachInfo set title=?,text=? where id="
												+ id);
									}
									st.setString(1, BBAdapter.encode(title));
									st.setString(2, text);

									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8"));
										return;
									}

								} else if (operation.equals("delete")) {
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									PreparedStatement st = con
											.prepareStatement("delete from teachInfo where id="
													+ id);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8"));
										return;
									}
								} else if (operation.equals("modify")) {
									isModify = true;
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									modifyInfo = TeachInfo.getById(id);
								}
							}
					%>
					<body>
						<h2>添加/修改教务信息：</h2>
						<form method="post" action="teachInfoManage.jsp" name="addForm"
							id="contactform">
							<input type="hidden" name="oper" value="add">
							<ol>
								<li><label for="infoId">修改ID(-1为添加)</label><input
									type="text" name="infoId" id="infoId"
									value="<%=isModify ? modifyInfo.getId() : -1%>" class="text" /></li>
								<li><label for="title">标题</label> <input type="text"
									name="title" id="title"
									value="<%=isModify ? modifyInfo.getTitle() : ""%>" class="text" /></li>
								<li><label for="docText">内容：</label>
								<textarea name="docText" rows="20" cols="100" id="docText"
										class="text" class="text" /><%=isModify ? modifyInfo.getText() : ""%></textarea></li>

								<li><label for="submitButton">点击提交更改</label><input
									type="submit" value="提交" id="submitButton"></li>
							</ol>
						</form>

						<h2>管理已有教务信息：</h2>
						<form method="get" action="teachInfoManage.jsp">
							<table id="customers">
								<tr>
									<td>选择</td>
									<td>标题</td>
								</tr>
								<%
									ResultSet rs = con.prepareStatement("select * from teachInfo")
												.executeQuery();
										java.util.List<TeachInfo> infoList = new BeanProcessor()
												.toBeanList(rs, TeachInfo.class);
										for (TeachInfo info : infoList) {
											out.print("<tr><td><input type=\"radio\" name=\"infoId\" value=\""
													+ info.getId()
													+ "\" checked></td>"
													+ "<td><a href=\"../publicResource/viewTeachInfo.jsp?id="
													+ info.getId()
													+ "\">"
													+ info.getTitle()
													+ "</a></td></tr>");
										}
								%>
							</table>
							<button name="oper" type="submit" value="delete">删除</button>
							<button name="oper" type="submit" value="modify">修改</button>
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