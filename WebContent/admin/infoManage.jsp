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
									<li><a href="/Test/publicResource/teach.jsp" ><span>教务信息 </span></a></li>
						
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
									if (request
											.getParameter("infoId") == null || request.getParameter("type") == null ||
													request.getParameter("title") == null) {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("缺少必填项", "utf-8")
												+ "&redirect=" +request.getRequestURL());
										return;
									}
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									int type = Integer.parseInt(request.getParameter("type"));
									if (type <= 0 || type > 3) {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("类型不正确", "utf-8")
												+ "&redirect=" +request.getRequestURL());
										return;
									}
									System.out.println(id);
									String title = request.getParameter("title"), text = request
											.getParameter("docText");
									if (text == null) {
										text = "";
									}
									PreparedStatement st = null;
									if (id == -1) {
										st = Conn
												.getConn()
												.prepareStatement(
														"insert into publicInfo(title, text, type) values(?,?,?)");
									} else {
										st = con.prepareStatement(
												"update publicInfo set title=?,text=?,type=? where id="
														+ id);
									}
									st.setString(1, title);
									st.setString(2, text);
									st.setInt(3, type);

									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" +request.getRequestURL());
										return;
									}

								} else if (operation.equals("delete")) {
									int id = Integer.parseInt(request
											.getParameter("infoId"));
									PreparedStatement st = con.prepareStatement(
											"delete from publicInfo where id=" + id);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" +request.getRequestURL());
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
										st = Conn
												.getConn()
												.prepareStatement(
														"insert into slideInfo(image, href) values(?,?)");
									} else {
										st = con.prepareStatement(
												"update slideInfo set image=?, href=? where id="
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
												+ "&redirect=" +request.getRequestURL());
										return;
									}
								} else if (operation.equals("deleteSlide")) {
									int id = Integer.parseInt(request
											.getParameter("slideId"));
									PreparedStatement st = con.prepareStatement(
											"delete from slideInfo where id=" + id);
									if (st.executeUpdate() > 0) {
										out.println("操作成功");
									} else {
										response.sendRedirect("../message.jsp?message="
												+ URLEncoder
														.encode("操作失败，请检查数据格式", "utf-8")
												+ "&redirect=" +request.getRequestURL());
										return;
									}
								}
							}
					%>
					<br/>
					<a href="infoManage.jsp">资源管理</a>
					<a href="infoShowManage.jsp">展示板管理</a>
					
					<h2><b>添加/修改资源</b></h2>

					<form method="post" action="infoManage.jsp" name="addForm"
						id="contactform">
						<input type="hidden" name="oper" value="add">
						<ol>
							<li><label for="infoId">修改ID(-1为添加)</label><input
								type="text" name="infoId" id="infoId"
								value="<%=isModify ? modifyInfo.getId() : -1%>" class="text" /></li>
							<li><label for="title">标题</label> <input type="text"
								name="title" id="title"
								value="<%=isModify ? modifyInfo.getTitle() : ""%>" class="text" /></li>
							<li><label for="docText">内容</label> <textarea id="docText"
									name="docText" rows="20" cols="100" id="docText" class="text"
									class="text"><%=isModify ? modifyInfo.getText() : ""%></textarea></li>

							<li><label for="imageUrl">插入图片</label> <input type="text"
								name="imageUrl" class="text"> <input type="button"
								onClick="javascript:this.form.docText.value+='[img]'+this.form.imageUrl.value+'[/img]';"
								value="插入" /></li>
							<li><label for="flashurl">插入flash视频</label> <input
								type="text" name="flashUrl" class="text" id="flashUrl" /><input
								type="button"
								onClick="javascript:this.form.docText.value+='[flash]'+this.form.flashUrl.value+'[/flash]';"
								value="插入" /></li>
							<li><label for="soundUrl">插入声音</label><input type="text"
								name="soundUrl" id="soundUrl" class="text" /><input
								type="button"
								onClick="javascript:this.form.docText.value+='[sound]'+this.form.soundUrl.value+'[/sound]';"
								value="插入" /></li>
							<li>
							<input type="radio" name="type" value="1" <%=isModify&&modifyInfo.getType()==1?"checked":"" %>/><label>视频资源</label>
 							</li>
 							<li>
 							<input type="radio" name="type" value="2" <%=isModify&&modifyInfo.getType()==2?"checked":"" %>/><label>音频资源</label>
 							</li>
 							<li>
 							<input type="radio" name="type" value="3" <%=isModify&&modifyInfo.getType()==3?"checked":"" %>/><label>图片资源</label>
							</li>
							<li><label for="submitButton">点击提交更改</label><input
								type="submit" value="提交" id="submitButton"></li>
								
						</ol>
					</form>

					<h2><b>管理已有资源</b></h2>
					<form method="get" action="infoManage.jsp">
						<table id="customers">
							<tr>
								<td>选择</td>
								<td>标题</td>
							</tr>
							<%
								ResultSet rs = con
											.prepareStatement("select * from publicInfo")
											.executeQuery();
									java.util.List<PublicInfo> infoList = new BeanProcessor()
											.toBeanList(rs, PublicInfo.class);
									for (PublicInfo info : infoList) {
										out.print("<tr><td><input type=\"radio\" name=\"infoId\" value=\""
												+ info.getId()
												+ "\" checked></td>"
												+ "<td><a href=\"../publicResource/viewInfo.jsp?id="
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
					<br/><a href="fileManage.jsp">你可以使用上传功能上传资源，然后在此发布。</a>

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
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("数字格式错误", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode(e.getMessage(), "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} 
%>
