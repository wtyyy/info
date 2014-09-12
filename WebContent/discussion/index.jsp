
<%@page import="util.StudentChooseCourseHistory"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.*"%>
<%@page import="util.CourseTime"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>讨论区之<%out.println((String)session.getAttribute("zone")==null?"other":(String)session.getAttribute("zone")); %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
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
  text-align:center;
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
</head>
<body>
<div class="main">
  <div class="header_resize">
    <div class="header">
      <div class="logo"><a href="#"><img src="images/logo.gif" width="338" height="70" border="0" alt="" /></a></div>
      <div class="menu">
        <ul>
          <li><a href="/Test/index.jsp" ><span>登陆首页</span></a></li>
          <li><a href="/Test/publicResource/" class="active"><span>公共资源页面 </span></a></li>
          <li><a href="/Test/student/courseSelect.jsp"><span> 课程管理页面</span></a></li>
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
      <h2>讨论区</h2>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="full">
        <h2>Our best work</h2>
        <p>Donec varius, lorem ac euismod lobortis, dui tortor vehicula massa, a consectetur nisi sem consectetur urna. Duis mollis tempus nunc sit amet hendrerit. Aliquam sem nisl, pharetra hendrerit scelerisque et, ornare eget dui. Nunc gravida rhoncus diam, vestibulum dignissim Etiam in nisi at metus sagittis iaculis nec ut diam. Sed in enim quis metus ullamcorper pulvinar. Mauris aliquet blandit lobortis. Vivamus accumsan semper dui sit amet semper.</p>
        <div class="blog_port"><a href="/Test/discussion/postTopic.jsp?zone=cs"> <img src="images/port_1.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/discussion/postTopic.jsp?zone=cs">贵系贵系</a></p>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sed enim justo, ac adipiscing dui. Maecenas ut justo nec dui fermentum </p>
          <p><a href="#" class="port">Visit project</a></p>
          <p>&nbsp;</p>
        </div>
        <div class="blog_port"> <a href="/Test/discussion/postTopic.jsp?zone=food"><img src="images/port_2.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/discussion/postTopic.jsp?zone=food">想吃美食</a></p>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sed enim justo, ac adipiscing dui. Maecenas ut justo nec dui fermentum </p>
          <p><a href="#" class="port">Visit project</a></p>
          <p>&nbsp;</p>
        </div>
        <div class="blog_port"> <a href="/Test/discussion/postTopic.jsp?zone=music"><img src="images/port_3.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/discussion/postTopic.jsp?zone=music">音乐之声</a></p>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sed enim justo, ac adipiscing dui. Maecenas ut justo nec dui fermentum </p>
          <p><a href="#" class="port">Visit project</a></p>
          <p>&nbsp;</p>
        </div>
        <div class="clr"></div>
        <div class="butons"> <a href="#"><img src="images/l_arrow.gif" alt="" width="23" height="23" border="0" /></a> <a href="#"><img src="images/r_arrow.gif" alt="" width="23" height="23" border="0" /></a> </div>
        <div class="clr"></div>
      </div>
    </div>
  </div>
  <div class="clr"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="leftt">© Copyright websitename . All Rights Reserved<br />
        <a href="#">Home</a> | <a href="#">Contact</a> | <a href="#">RSS</a></p>
      <p class="right">(Blue) <a href="http://www.bluewebtemplates.com">Website Templates</a></p>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
<div align=center>This template  downloaded form <a href='http://all-free-download.com/free-website-templates/'>free website templates</a></div></body>
</html>