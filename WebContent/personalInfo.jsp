<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% try { %>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
	<%
	System.out.println(user);
		if (user.getEmail() == null || user.getEmail().equals("")) {
			response.sendRedirect("index.jsp");
			return;
		}
		session.setAttribute("user", UserInfo.getById(user.getId()));
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>个人资料</title>
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
      <h2>查看并修改个人信息</h2>
      <p>我们不会倒卖你的<br />
        个人资料</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
        <h2>你的个人信息</h2>
        <p>不想改密码请留空</p>
        <p>&nbsp;</p>
        <form action="registration.jsp" method="post" id="contactform">
		<input type="hidden" name="oper" value="update"/>
          <ol>
            <li>
              <label for="email">电子邮箱地址 <span class="red">*</span></label>
              <input id="email" name="email" class="text" value="<%=user.getEmail() %>" />
            </li>
            <li>
              <label for="password">密码<span class="red">*</span></label>
              <input type="password" name="password" class="text" value=""/>
            </li>
            <li>
              <label for="name">姓名<span class="red">*</span></label>
              <input id="name" name="name" class="text" value="<%=user.getName() %>"/>
            </li>
            <li>
              <label for="gender">性别<span class="red">*</span></label>
              <input type="radio" name="gender" value="male"  <%=user.getGender().equals("male")?"checked":"" %>/>male
			  <input type="radio" name="gender" value="female" <%=user.getGender().equals("female")?"checked":"" %> />female
            </li>
            <li>
              <label for="dateBorn">出生日期<span class="red">*</span></label>
              <input type="date" id="dateBorn" name="dateBorn"  class="text" value="<%=user.getDateBorn() %>"/>
            </li>
            <li>
              <label for="tel">电话<span class="red">*</span></label>
              <input type="number" id="tel" name="tel"  class="text" value="<%=user.getTel() %>"/>
            </li>
            <li>
              <label for="emergencyContactName">紧急联系人<span class="red">*</span></label>
			  <input type="text" id="emergencyContactName" name="emergencyContactName" class="text" value="<%=user.getEmergencyContactName() %>"/>
            </li>
            <li>
              <label for="emergencyContactTel">紧急联系人电话<span class="red">*</span></label>
			  <input type="number" id="emergencyContactTel" name="emergencyContactTel"  class="text" value="<%=user.getEmergencyContactTel() %>"/>
            </li>
			<li>
              <label for="address">家庭住址<span class="red">*</span></label>
			  <input type="text" id="address" name="address"  class="text" value="<%=user.getAddress() %>"/>
            </li>
            <li>
              <label for="qq">QQ号码</label>
			  <input type="number" id="qq" name="qq" class="text" value="<%=user.getQq() %>" />
            </li>
            
            <li class="buttons">
            	<input type="image" name="imageField" id="imageField" src="images/send.gif" class="send" alt="Submit Form" />
              <div class="clr"></div>
            </li>
          </ol>
          <h2>当前头像</h2>
          <%
          	PreparedStatement stmt = Conn.getConn().prepareStatement("select * from files where name=? and uploaderId=?");
            stmt.setString(1, "avatar-" + user.getId() + ".jpg");
            stmt.setInt(2, user.getId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
            	%>
            	<img src="/Test/DBFileGetter?id=<%=rs.getInt(1)%>"></img>
            	<%
            } else {
            	out.println("你没有头像");
            }
          %>
          <h2>上传头像</h2>
        </form>
        					<form action="/Test/uploadServlet" method="post"
						enctype="multipart/form-data" id="contactform">
						<input type="hidden" name="name" value="avatar-<%=user.getId()%>.jpg"/>
						<ol>
							<li><label for="file">文件</label><input type="file" name="file" id="file" class="text" /></li>
							
							<li><input type="submit" value="上传" /></li>
						</ol>	
					</form>
      </div>
      <div class="right">
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
</html>
<%
	} catch (SQLException e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("SQL操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式" + request.getRequestURL(), "utf-8")
				+ "&redirect=" +request.getRequestURL());
		return;
	}
%>

