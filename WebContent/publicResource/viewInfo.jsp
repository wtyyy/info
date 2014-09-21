<%@page import="java.net.URLEncoder"%>
<%@page import="util.StudentChooseCourseHistory"%>
<%@page import="util.CourseInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="util.*"%>
<%@page import="util.CourseTime"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%try{ %>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>查看公共资源</title>
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
	PublicInfo info = PublicInfo.getById(Integer.parseInt(request.getParameter("id")));
%>
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
      <h2>公共资源页面</h2>
      <p>包括视频资源、音频资源<br />
        图片资源和文字资源</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
       <h2><% out.println(info.getTitle()); %></h2><br/>
			<%
			out.println(BBAdapter.process(info.getText()));
				%>
      </div>
          <div class="right">
    
    	<table border="1" id="customers" align="center">
    	<th>资源分类</th>
	<tr><td><a href="/Test/publicResource/viewInfoList.jsp?type=1">视频资源</a></td></tr>
	<tr><td><a href="/Test/publicResource/viewInfoList.jsp?type=2">图片资源</a></td></tr>
	<tr><td><a href="/Test/publicResource/viewInfoList.jsp?type=3">音乐资源</a></td></tr>
	</table>	
	
	<br/>
    	<table border="1" id="customers" align="center">
    	<th>资源列表</th>
<% 
	ResultSet rs = Conn.getConn().prepareStatement("select * from publicInfo where type="+info.getType()).executeQuery();
	List<PublicInfo> infoList = new BeanProcessor().toBeanList(rs, PublicInfo.class);
	for (PublicInfo inf : infoList) {
		out.print("<tr><td><a href=\"/Test/publicResource/viewInfo.jsp?id=" + info.getId()+ "\">" + inf.getTitle() + "</a></td></tr>");
	}
%>
    	</table>
    </div>
      <div class="clr"></div>
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