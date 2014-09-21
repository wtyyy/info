<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="jdbc.Conn"%>
<%@page import="util.*" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
Connection conn = null;
 try { 
	 conn = Conn.getConn();

%>
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
  font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; word-break:break-all; word-wrap:break-all;
  width:100%;
  border-collapse:collapse;
  }

#customers td, #customers th 
  {
  font-size:0.8em;
  border:1px solid #53868B;
  padding:3px 7px 2px 7px;
  }

#customers th 
  {
  font-size:0.9em;
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
<title>Welcome to Sky-1 INFO</title>
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
          			<li><a href="/Test/publicResource/teach.jsp" ><span>教务信息 </span></a></li>
          
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
      		List<SlideNews> slideInfoList = new BeanProcessor().toBeanList(conn.prepareStatement("select * from slideInfo").executeQuery(), SlideNews.class);
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
        <a <%if (user.getName()==null) out.print("href=\"register.jsp\""); %>><img src="images/fbg_read_more_3<%if (user.getName()==null) out.print(3);%>.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="block"> <img src="images/fbg_2.gif" alt="" width="49" height="49" />
        <h2>我想更加了解自己。。<br />
          <span>查看/修改个人信息 </span></h2>
        <div class="bg"></div>
        <p>不限制修改次数哦！ <br />
          修改个人信息不需要邮箱验证哦!</p>
        <a <%if (user.getName()!=null) out.print("href=\"personalInfo.jsp\""); %>><img src="images/fbg_read_more_2<%if (user.getName()!=null) out.print(2);%>.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="block"> <img src="images/fbg_3.gif" alt="" width="49" height="49" />
        <h2>我要登录！<br />
          <span>好吧，我差点忘了</span></h2>
        <div class="bg"></div>
        <p>没验证邮箱的话登录是没用的 <br />
          	请勿使用万能密码</p>
        <a <%if (user.getName()==null) out.print("href=\"signin.jsp\""); %>><img src="images/fbg_read_more_1<%if (user.getName()==null) out.print(1);%>.gif" alt="" width="87" height="31" border="0" /></a></div>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="<%=user.getPrivilege()==null?"full":"right"%>">
      	
        	<h2>教务信息</h2>
	<table id="customers">
<%
	ResultSet rs = conn.prepareStatement("select * from teachInfo order by id DESC").executeQuery();
	int ci=0;
	List<PublicInfo> infoList = new BeanProcessor().toBeanList(rs, PublicInfo.class);
	for (PublicInfo info : infoList) {
		out.print("<tr><td><a id=\"speicialLink\" href=\"publicResource/viewTeachInfo.jsp?id=" + info.getId()+ "\">" + info.getTitle() + "</a><br/>");
		out.print("<a id=\"teachContent\">"+info.getText().substring(0, info.getText().length()<40?info.getText().length():40)+(info.getText().length()<40?"":"...")+"</a></td></tr>");
		ci++;
		if (ci==5) break;
	}
%>
</table>
<div align="right"><a href="/Test/publicResource/teach.jsp" id="teachContent" >更多</a></div>
      </div>
      <div class="left">
        <%if("admin".equals(user.getPrivilege())) { %>
      		<h2>管理中心</h2>
      		<table id="customers">
      		<tr><td><a href="admin/courseManage.jsp">课程管理</a></td></tr>
      		<tr><td><a href="admin/userManage.jsp">用户管理</a></td></tr>
      		<tr><td><a href="admin/infoManage.jsp">公共资源管理</a></td></tr>
      		<tr><td><a href="admin/teachInfoManage.jsp">教务信息管理</a></td></tr>
      		<tr><td><a href="discussion/adminForbidden.jsp">讨论区发言管理</a></td></tr>
      		<tr><td><a href="admin/fileManage.jsp">上传文件管理</a></td></tr>
      		</table>
      	<%} else if("student".equals(user.getPrivilege())){ %>
        <h2>你的课表</h2>
        <%
        		List<CourseInfo> courseList = CourseInfo.getStudentCourseList(user.getId());
        %>
        <table border="1" id="customers">
        	<tr><th>节</th><td width=100px>星期日</td><th width=100px>星期一</th><td width=100px>星期二</td><th width=100px>星期三</th><td width=100px>星期四</td><th width=100px>星期五</th><td width=100px>星期六</td></tr>
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
        
        <%} %>
        <%
        if (user.getEmail() != null && "student".equals(user.getPrivilege())) {
        	out.println("<br/><h2>两天内你会上的课</h2><table id=\"customers\">");
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
					%><tr><td>
					<%=course.getName() %></td><td><%=course.getTeacher() %></td><td>
					<%switch(courseDay%7) {
					case 0:out.print("星期日");break;
					case 1:out.print("星期一");break;
					case 2:out.print("星期二");break;
					case 3:out.print("星期三");break;
					case 4:out.print("星期四");break;
					case 5:out.print("星期五");break;
					case 6:out.print("星期六");break;
					default:break; }
					%>第<%=course.getBlock()%>节</td></tr>
					<%
				}
			
        	}
        	out.println("</table>");
        }
       	%>
        <br/>
        
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
	}  finally {
		try {
			conn.close();
		} catch (Exception e) {
			
		}
		}
%>