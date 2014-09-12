
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
      <h2>讨论区管理员界面</h2>
      <p>已被禁言用户</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
    <div class="body">
    <div class="body_resize">
      <div class="full">
  
<form name="form1" method="post" action="adminForbiddenDO.jsp">
<%
	if (user.getPrivilege()==null || !user.getPrivilege().equals("admin")) 
	{
		out.println("<script language=\"javascript\">");
		out.println("alert(\"您越权了亲\");");
		out.println("location.href=\"/Test/index.jsp\";");
		out.println("</script>");
	}
	else 
	{
		PreparedStatement st = Conn.getConn().prepareStatement("select * from Forbidden");
		ResultSet rs = st.executeQuery();
		ArrayList<UserInfo> users = new ArrayList<UserInfo>();
		while (rs.next()) {
			int userid = rs.getInt("id");
			PreparedStatement st2 = Conn.getConn().prepareStatement("select * from users where id="+userid);
			ResultSet rs2 = st2.executeQuery();
			while (rs2.next()) {
				UserInfo ui = ((UserInfo) (new BeanProcessor().toBean(
						rs2, UserInfo.class)));
				users.add(ui);
			}
		}
		UserTable.printUsers(users, out, true);
		out.println("<label><input name=\"submit\" type=\"submit\" id=\"submit\" value=\"解 封\" /></label>");
	}
	
%>

</form></div></div></div></div>
</body>
</html>