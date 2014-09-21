
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
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
if ("admin".equals(user.getPrivilege())) {
	response.sendRedirect("../admin/infoManage.jsp");
	return;
}

%>
<title>公共资源</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
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
          <li><a href="/Test/publicResource/teach.jsp" ><span>教务信息 </span></a></li>
          <li><a href="/Test/publicResource/"  class="active"><span>公共资源页面 </span></a></li>
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
      <h2>公共资源</h2>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="full">
        <h2>公共资源</h2>
        <p>这里有小视频，小音频和小图片哟~</p>
        <div class="blog_port"><a href="/Test/publicResource/viewInfoList.jsp?type=1"> <img src="images/pub_1.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/publicResource/viewInfoList.jsp?type=1">视频专区</a></p>
          <p>想看神马？？来这里找吧啦啦啦 </p>
          
          <p>&nbsp;</p>
        </div>
        <div class="blog_port"> <a href="/Test/publicResource/viewInfoList.jsp?type=2"><img src="images/pub_2.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/publicResource/viewInfoList.jsp?type=2">音频专区</a></p>
          <p>在线听盗版歌曲？来呀 </p>
          
          <p>&nbsp;</p>
        </div>
        <div class="blog_port"> <a href="/Test/publicResource/viewInfoList.jsp?type=3"><img src="images/pub_3.jpg" alt="" width="271" height="235" /></a>
          <div class="clr"></div>
          <p style="font: normal 14px Arial, Helvetica, sans-serif; color:#2a2a2a;"><a href="/Test/publicResource/viewInfoList.jsp?type=3">图片专区</a></p>
          <p>你懂得！</p>
          
          <p>&nbsp;</p>
        </div>
        <div class="clr"></div>
        
        <div class="clr"></div>
      </div>
    </div>
  </div>
  <div class="clr"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="leftt">© Copyright websitename . All Rights Reserved</p>
      <p class="right"> 当前登录用户：<%=user.getEmail()==null?"您尚未登录":user.getEmail() %><br /><a href="../logout.jsp">注销</a></p>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
</body>
</html>
