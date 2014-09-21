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
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
Connection con = null;
try {
	con = Conn.getConn();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML a1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
#customers
  {
  font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; word-break:break-all; word-wrap:break-all;
  width:100%;
  border-collapse:collapse;
  }

#customers td, #customers th 
  {
  font-size:1em;
  border:1px solid #53868B;
  padding:3px 7px 2px 7px;
  }

#customers th 
  {
  font-size:1.1em;
  text-align:left;
  padding-top:5px;
  padding-bottom:4px;
  background-color:#53868B;
  color:#ffffff;
  }

#customers tr.alt td 
  {
  color:#000000;
  background-color:#EAF2D3;
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
$(document).ready(function(){
	$('div.blog_port').hover(
	  function(){
		$(this).stop().animate({backgroundColor: "#f7f7f7"}, 300);
	  }, 
	  function(){
		$(this).stop().animate({backgroundColor: "#fefefe"}, 300);
	  });
});
// ]]>
</script>
</head>
<body>
<div class="main">
  <div class="header_resize">
    <div class="header">
      <div class="logo"><a href="#"><img src="images/logo.gif" width="338" height="70" border="0" alt="" /></a></div>
      <div class="menu">
        <ul>
          <li><a href="/Test/index.jsp" ><span>登陆首页</span></a></li>
			<li><a href="/Test/publicResource/teach.jsp" ><span>教务信息 </span></a></li>
          <li><a href="/Test/publicResource/" ><span>公共资源页面 </span></a></li>
          <li><a href="/Test/student/courseSelect.jsp" class="active"><span> 课程管理页面</span></a></li>
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
      <p>添加、删除、修改课程<br />
        为课程添加或删除成员</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="full">
      	<form method="post" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="add">
		<table id="customers">
			<thead>
				<tr>
					<th colspan="2">Enter Information Here</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>被修改的课程id(-1代表添加新课程)</td>
					<td><input type="text" name="id"
						value="<%=isModify ? currentCourse.getId() : "-1"%>" readonly /></td>
				</tr>
				<tr>
					<td>名字</td>
					<td><input type="text" name="name"
						value="<%=isModify ? currentCourse.getName() : "课程名称"%>" /></td>
				</tr>
				<tr>
					<td>老师</td>
					<td><input type="text" name="teacher"
						value="<%=isModify ? currentCourse.getTeacher() : "任课教师"%>" /></td>
				</tr>
				<tr>
					<td>星期几(0是星期天哦)</td>
					<td><input type="number" name="day"
						value="<%=isModify ? currentCourse.getDay() : "0"%>" /></td>
				</tr>
				<tr>
					<td>第几节(0~5)</td>
					<td><input type="number" name="block"
						value="<%=isModify ? currentCourse.getBlock() : "0"%>" /></td>
				</tr>
				<tr>
					<td>容量</td>
					<td><input type="number" name="capacity"
						value="<%=isModify ? currentCourse.getCapacity() : "100"%>" /></td>
				</tr>
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="startTime"
						value="<%=isModify ? currentCourse.getStartTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>开始日期</td>
					<td><input type="date" name="endTime"
						value="<%=isModify ? currentCourse.getEndTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>选课开始日期</td>
					<td><input type="date" name="selectStartTime"
						value="<%=isModify ? currentCourse.getEndTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>选课结束日期</td>
					<td><input type="date" name="selectEndTime"
						value="<%=isModify ? currentCourse.getEndTime()
					: new SimpleDateFormat("yyyy-MM-dd").format(Date
							.from(Calendar.getInstance().toInstant()))%>" /></td>
				</tr>
				<tr>
					<td>更多介绍</td>
					<td><input type="text" name="text" value="课程介绍" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	<h2>现有课程列表</h2>
	<form method="get" action="courseManageDo.jsp">
		<input type="hidden" name="oper" value="delete">
		<%
			CourseTable.printTable(
					new BeanProcessor().toBeanList(con
							.prepareStatement("select * from courses")
							.executeQuery(), CourseInfo.class), out, true, true);
		%>
		<input type="submit" formaction="courseManage.jsp" value="modify">
		<input type="submit" formaction="viewCourseMember.jsp" value="查看成员">
		<input type="submit" value="delete" />
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
