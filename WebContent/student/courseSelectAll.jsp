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
<% try { %>
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
#customers
  {
  font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
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
<title>选课</title>
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
          <li><a href="/Test/student/courseSelect.jsp"class="active"><span> 课程管理页面</span></a></li>
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
      <p>添加、删除课程<br />
        </p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
      	<%

		Class.forName("com.mysql.jdbc.Driver");
		Connection con = Conn.getConn();
		ResultSet selectedCourseSet = null;
		if (user.getPrivilege() == null) {
			response.sendRedirect("../index.jsp");
			return;
		}
		if (user.getPrivilege().equals("student")) {
			String email = user.getEmail();
			int id = user.getId();
			Statement st = con.createStatement();
			selectedCourseSet = st
					.executeQuery("select * from studentChooseCourse where studentId='"
							+ id + "'");
		} else {
			response.sendRedirect("../admin/courseManage.jsp");
			return;
		}
	%>
	<form method="post" action="courseSelectDo.jsp">
		<input type="hidden" name="oper" value="delete">
		<table id="customers" border="1">
			<%
				HashSet<Integer> set = new HashSet<Integer>();
				if (user.getPrivilege().equals("student"))  {
					for (; selectedCourseSet.next();) {

						Statement st = con.createStatement();
						ResultSet thisCourse = st
								.executeQuery("select * from courses where id='"
										+ selectedCourseSet.getInt("courseId")
										+ "'");
						if (thisCourse.next()) {
							/*CourseTable.printSingleCourse(
									(CourseInfo) (new BeanProcessor().toBean(
											thisCourse, CourseInfo.class)), out,
									true, true);*/
						set.add(thisCourse.getInt("id"));
						} else {
							out.println("搞错了");
						}
					}
				}
			%>
		</table>
	</form>
	<h2>所有课程</h2>
	<form method="post" action="courseSelectDo.jsp">
		<input type="hidden" name="oper" value="add">
		 <table id="customers" border="1">
			<tr>
				<th>选择</th>
				<th>课程id</th>
				<th>名称</th>
				<th>教师</th>
				<th>星期</th>
				<th>节次</th>
				<th>容量</th>
				<th>选课人数</th>
				<th>所剩课时</th> 
				<th>更多信息</th> 
				<th>选课时间</th> 
			</tr>
		
		<%
			
			ResultSet allCourse = con
					.prepareStatement("select * from courses").executeQuery();
			for (;allCourse.next();) {
				Statement st = con.createStatement();
				ResultSet thisCourse = st
						.executeQuery("select * from courses where id='"
								+ allCourse.getInt("id")
								+ "'");
				if (thisCourse.next() && !set.contains(thisCourse.getInt("id"))) {
					CourseTable.printSingleCourse(
							(CourseInfo) (new BeanProcessor().toBean(
									thisCourse, CourseInfo.class)), out,
							true, false, false);
				
				} 
			}

		%>
		</table>
		<input type="submit" value="选课" />
	</form>
	
      </div>
          <div class="right">
	<table border="1" id="customers" align="center">
	<tr><td><a href="/Test/student/courseSelect.jsp">可选课程</a></td></tr>
	<tr><td><a href="/Test/student/courseSelectAlready.jsp">已选课程</a></td></tr>
	<tr><td><a >所有课程</a></td></tr>
	<tr><td><a href="/Test/student/courseSelectHistory.jsp">历史操作记录</a></td></tr>
	</table>	
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
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	}
%>
