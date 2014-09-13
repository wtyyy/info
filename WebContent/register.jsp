<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>BestWebdesign | Contact</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="main">
  <div class="header_resize">
    <div class="header">
      <div class="logo"><a href="#"><img src="images/logo.gif" width="338" height="70" border="0" alt="" /></a></div>
      <div class="menu">
        <ul>
          <li><a href="/Test/index.jsp" class="active" ><span>登陆首页</span></a></li>
          <li><a href="/Test/publicResource/" ><span>公共资源页面 </span></a></li>
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
      <h2>注册</h2>
      <p>加入这个牛逼闪闪的 <br />
        网站</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
        <h2>输入注册信息</h2>
        <p>注册就像户口检查</p>
        <p>我们想知道关于你的一切</p>
        <p>&nbsp;</p>
        <form action="registration.jsp" method="post" id="contactform">
		<input type="hidden" name="oper" value="reg">
          <ol>
            <li>
              <label for="email">电子邮箱地址 <span class="red">*</span></label>
              <input id="email" name="email" class="text" />
            </li>
            <li>
              <label for="password">密码<span class="red">*</span></label>
              <input type="password" name="password" class="text" />
            </li>
            <li>
              <label for="name">姓名<span class="red">*</span></label>
              <input id="name" name="name" class="text" />
            </li>
            <li>
              <label for="gender">性别<span class="red">*</span></label>
              <input type="radio" name="gender" value="male"  checked/>male
			  <input type="radio" name="gender" value="female" />female
            </li>
            <li>
              <label for="dateBorn">出生日期<span class="red">*</span></label>
              <input type="date" id="dateBorn" name="dateBorn" value=""  class="text"/>
            </li>
            <li>
              <label for="tel">电话<span class="red">*</span></label>
              <input type="number" id="tel" name="tel" value="" class="text"/>
            </li>
            <li>
              <label for="emergencyContactName">紧急联系人<span class="red">*</span></label>
			  <input type="text" id="emergencyContactName" name="emergencyContactName" value="" class="text" />
            </li>
            <li>
              <label for="emergencyContactTel">紧急联系人电话<span class="red">*</span></label>
			  <input type="number" id="emergencyContactTel" name="emergencyContactTel" value=""  class="text"/>
            </li>
			<li>
              <label for="address">家庭住址<span class="red">*</span></label>
			  <input type="text" id="address" name="address" value=""  class="text" />
            </li>
            <li>
              <label for="qq">QQ号码</label>
			  <input type="number" id="qq" name="qq" value="" class="text" />
            </li>
            
            <li class="buttons">
            	<input type="image" name="imageField" id="imageField" src="images/send.gif" class="send" alt="Submit Form" />
              <div class="clr"></div>
            </li>
          </ol>
        </form>
      </div>
      <div class="right">
        <h2>Details</h2>
        <p><a href="#">Customer Support</a><br />
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed ut felis orci, ac semper justo.<br />
          <strong>111-222-4444<br />
          support@example.com<br />
          Monday-Friday 8am-8pm</strong></p>
        <p><a href="#">Sales Enquiry</a><br />
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit.<br />
          <strong>111-222-3333<br />
          sales@example.com<br />
          Monday-Friday 8am-5pm</strong></p>
        <p>&nbsp;</p>
        <h2>What Our Client says...</h2>
        <p> <img src="images/test.gif" alt="" width="18" height="13" />Aenean id justo eu est sodales rhoncus ac et sem. Nunc aliquam, magnaa placerat congue, ante urna tincidunt.<br />
          <strong>Jason, Founder, www.website.com </strong></p>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="clr"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="leftt">© Copyright wty&yy . All Rights Reserved</p>
      <p class="right"> 当前登录用户：<%=user.getEmail()==null?"您尚未登录":user.getEmail() %><br /><a href="logout.jsp">注销</a></p>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
</body>
</html>

