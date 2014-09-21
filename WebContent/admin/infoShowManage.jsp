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
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	Connection con = null;
try {
	con = Conn.getConn();
%>
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
<title>公共资源管理</title>
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
				<h2>资源管理</h2>
				<p>
					添加、删除、修改资源<br />
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
							PublicInfo modifyInfo = null;
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
										st = con.prepareStatement("insert into publicInfo(title, text) values(?,?)");
									} else {
										st = con.prepareStatement("update publicInfo set title=?,text=? where id="
												+ id);
									}
									st.setString(1, title);
									st.setString(2, text);

									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" + request.getRequestURL());
										return;
									}

								} else if (operation.equals("delete")) {
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									PreparedStatement st = con
											.prepareStatement("delete from publicInfo where id="
													+ id);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" + request.getRequestURL());
										return;
									}
								} else if (operation.equals("modify")) {
									isModify = true;
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									modifyInfo = PublicInfo.getById(id);
								} else if (operation.equals("modifySlide")) {
									slideModify = true;
									int id = Integer.parseInt(request
											.getParameter("slideId"));
									modifySlide = SlideNews.getById(id);
								} else if (operation.equals("addSlide")) {
									int id = Integer.parseInt(request
											.getParameter("slideId"));
									String image = request.getParameter("image");
									String href = request.getParameter("href");
									PreparedStatement st;
									if (id == -1) {
										st = con.prepareStatement("insert into slideInfo(image, href) values(?,?)");
									} else {
										st = con.prepareStatement("update slideInfo set image=?, href=? where id="
												+ id);
									}
									st.setString(1, image);
									st.setString(2, href);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" + request.getRequestURL());
										return;
									}
								} else if (operation.equals("deleteSlide")) {
									int id = Integer.parseInt(request
											.getParameter("slideId"));
									PreparedStatement st = con
											.prepareStatement("delete from slideInfo where id="
													+ id);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" + request.getRequestURL());
										return;
									}
								}
							}
					%>
					<br /> <a href="infoManage.jsp">资源管理</a> <a
						href="infoShowManage.jsp">展示板管理</a>

					<h2>
						<b>添加/修改动态展示板</b>
					</h2>
					<form method="get" action="infoManage.jsp" name="addForm"
						id="contactform">
						<input type="hidden" name="oper" value="addSlide">
						<ol>
							<li><label for="slideId">修改ID(-1为添加)</label><input
								type="text" name="slideId" id="slideId"
								value="<%=slideModify ? modifySlide.getId() : -1%>" class="text" /></li>
							<li><label for="image">图片路径</label> <input type="text"
								name="image" id="image"
								value="<%=slideModify ? modifySlide.getImage() : ""%>"
								class="text" /></li>
							<li><label for="href">链接到</label> <input type="text"
								name="href" id="href"
								value="<%=slideModify ? modifySlide.getHref() : ""%>"
								class="text" /></li>
							<li><label for="submitButton">点击提交更改</label><input
								type="submit" value="提交" id="submitButton"></li>
					</form>

					<h2>
						<b>管理已有展示</b>
					</h2>
					<form method="get" action="infoManage.jsp">
						<table id="customers">
							<tr>
								<td>选择</td>
								<td>标题</td>
							</tr>
							<%
								ResultSet rs = con.prepareStatement("select * from slideInfo")
											.executeQuery();
									java.util.List<SlideNews> slideList = new BeanProcessor()
											.toBeanList(rs, SlideNews.class);
									for (SlideNews info : slideList) {
										out.print("<tr><td><input type=\"radio\" name=\"slideId\" value=\""
												+ info.getId()
												+ "\" checked></td>"
												+ "<td><a href=\""
												+ info.getHref()
												+ "\"><img src=\""
												+ info.getImage()
												+ "\">"
												+ "</a></td></tr>");
									}
							%>
						</table>
						<button name="oper" type="submit" value="deleteSlide">删除</button>
						<button name="oper" type="submit" value="modifySlide">修改</button>
					</form>
					<br /> <a href="fileManage.jsp">你可以使用上传功能上传资源，然后在此发布。</a>

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
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8") + "&redirect="
				+ request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode(e.getMessage(), "utf-8")
				+ "&redirect=" + request.getRequestURL());
		return;
	} finally {
		try {
			con.close();
		} catch (Exception e) {

		}
	}
%>
