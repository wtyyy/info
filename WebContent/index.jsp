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
<title>BestWebdesign</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery.cycle.all.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $('#slideshow').cycle({
        fx:     'fade',
        speed:  'slow',
        timeout: 5000,
        pager:  '#slider_nav',
        pagerAnchorBuilder: function(idx, slide) {
            // return sel string for existing anchor
            return '#slider_nav li:eq(' + (idx) + ') a';
        }
    });
});
</script>
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
  <div class="header_blog">
    <div id="slider">
      <!-- start slideshow -->
      <div id="slideshow">
      	<%
      		List<SlideNews> slideInfoList = new BeanProcessor().toBeanList(Conn.getConn().prepareStatement("select * from slideInfo").executeQuery(), SlideNews.class);
      	      		for (SlideNews info: slideInfoList) {
      	%>
      			<div class="slider-item"><a href="<%=info.getHref()%>"><img src="<%=info.getImage()%>" alt="" width="960" height="341" border="0" /></a></div>
      			<%
      				}
      			%>
      </div>
      <!-- end #slideshow -->
      <div class="controls-center">
        <div id="slider_controls">
          <ul id="slider_nav">
          <%
          	for (SlideNews info: slideInfoList) { 
          %>
          
            <li><a href="#"></a></li>
          <%} %>
          </ul>
        </div>
      </div>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body_bottom">
    <div class="body_bottom_resize">
      <div class="block"> <img src="images/fbg_1.gif" alt="" width="49" height="49" />
        <h2>新来的？<br />
          <span>赶紧注册吧！等大作业做完了服务器就关了！</span> </h2>
        <div class="bg"></div>
        <p>用户注册就像查户口本<br />
         	请提前准备好充足的个人信息  </p>
        <a href="register.jsp"><img src="images/fbg_read_more.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="block"> <img src="images/fbg_2.gif" alt="" width="49" height="49" />
        <h2>我想更加了解自己。。<br />
          <span>查看/修改个人信息 </span></h2>
        <div class="bg"></div>
        <p>不限制修改次数哦！ <br />
          修改个人信息不需要邮箱验证哦!</p>
        <a href="personalInfo.jsp"><img src="images/fbg_read_more.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="block"> <img src="images/fbg_3.gif" alt="" width="49" height="49" />
        <h2>我要登录！<br />
          <span>好吧，我差点忘了</span></h2>
        <div class="bg"></div>
        <p>没验证邮箱的话登录是没用的 <br />
          	请勿使用万能密码</p>
        <a href="signin.jsp"><img src="images/fbg_read_more.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
      	<%if("admin".equals(user.getPrivilege())) { %>
      		<h2>管理中心</h2>
      		<table id="customers">
      		<tr><td><a href="admin/courseManage.jsp">课程管理</a></td></tr>
      		<tr><td><a href="admin/userManage.jsp">用户管理</a></td></tr>
      		<tr><td><a href="admin/infoManage.jsp">公共资源管理</a></td></tr>
      		<tr><td><a href="">讨论区管理</a></td></tr>
      		</table>
      	<%} else if("student".equals(user.getPrivilege())){ %>
        <h2>你的课表</h2>
        <%
        		List<CourseInfo> courseList = CourseInfo.getStudentCourseList(user.getId());
        %>
        <table border="1" id="customers">
        	<tr><th>节</th><td>星期日</td><th>星期一</th><td>星期二</td><th>星期三</th><td>星期四</td><th>星期五</th><td>星期六</td></tr>
        	<%
        		for (int i = 0; i < 5; i ++) {
        			%>
        			<tr><td><%=i %></td>
        			<%
        			for (int j = 0; j < 7; j ++) {
        				%>
        				<td>
        				<%
        				for (CourseInfo course: courseList) {
        					if (course.getDay() == j && course.getBlock() == i) {
        						%>
        						<%=course.getName() %>
        						<%
        					}
        				}
        				%>
        				</td>
        				<%
        			}
        			%></tr><%
        		}
        	%>
        </table>
        <% } else { %>
        <h2>啊呀，你还没登陆呢，这里本来应该是一个课表呦。</h2>
        <%} %>
        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium mque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip exea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
        <h2>What We Do</h2>
        <p><span><em>Vestibulum vehicula purus nec dui accumsan fermentum. Suspendisse potenti.</em></span> <br />
          Ut dapibus est id odio pretium blandit in eget leo. Aliquam erat volutpat. Curabitur blandit odio eget odio eleifend vel mattis augue convallis. Praesent fringilla, eros et tristique tempus, libero metus porttitor velit, at ultrices eros dolor placerat nunc. Fusce ac egestas ante.</p>
      </div>
      <div class="right">
        <h2>两天以内你会上的课</h2>
        <%
        if (user.getEmail() != null) {
    		List<CourseInfo> courseList = CourseInfo.getStudentCourseList(user.getId());
        	for (CourseInfo course : courseList) {
        		Calendar now = Calendar.getInstance();
        		int DayInWeek = now.get(Calendar.DAY_OF_WEEK) - 1;
				int courseDay = course.getDay();
				if (courseDay < DayInWeek) {
					courseDay += 7;
				}
				System.out.println(course.getName() + courseDay + DayInWeek);
				if (courseDay - DayInWeek <= 2) {
					%>
					<%=course.getName() %>,　教师：<%=course.getTeacher() %><br/>
					<%
				}
        	}
        }
       	%>
        <br/>
        <p><a href="#">Original</a><br />
          Nulla id orci vel ante congue ornare. Cras laoreet pulvinar ante, non ullamcorper augue</p>
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
      <p class="leftt">Â© Copyright websitename . All Rights Reserved<br />
        <a href="#">Home</a> | <a href="#">Contact</a> | <a href="#">RSS</a></p>
      <p class="right">(Blue) <a href="http://www.bluewebtemplates.com">Website Templates</a></p>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
</body>
</html>
