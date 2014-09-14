
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
<%
	String zone;
	if (request.getParameter("zone")!=null && !request.getParameter("zone").equals("")) {
		zone = request.getParameter("zone");
	} else if (session.getAttribute("zone")!=null) {
		zone = (String)session.getAttribute("zone");
	} else zone = "other";
	session.setAttribute("zone", zone);
	
	String zoneName;
	switch(zone) {
	case "food": zoneName = "想吃美食"; break;
	case "music": zoneName = "音乐之声"; break;
	case "cs": zoneName = "贵系贵系"; break;
	default: zoneName = "other";
	}
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
          <li><a href="/Test/publicResource/" ><span>公共资源页面 </span></a></li>
          <li><a href="/Test/student/courseSelect.jsp"><span> 课程管理页面</span></a></li>
          <li><a href="/Test/discussion/" class="active"><span>讨论区</span></a></li>
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
      <p>欢迎来到 <%out.println(zoneName);%>版面</p>
    </div>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
  <div class="body">
    <div class="body_resize">
      <div class="left">
      
       <%
       		int $page = request.getParameter("page")==null?1:Integer.valueOf(request.getParameter("page"));
       		 
       		Connection con = Conn.getConn();
       		ResultSet set = null;
       		
       		Statement st = con.createStatement();
       		
       		set = st.executeQuery("select * from discussion where zone='" + zone + "' order by lastReplyTime DESC ");
       		int i = 1;
       		
       		out.println("<table id='customers'>");
       		out.println("<tr><th>#</th>"+
       					"<th width=300px >标题</th>" +
       					"<th >发帖人</th>"+
       					"<th width=85px>回复时间</th>"+
       					"<th >回复人</th></tr>");
       		while (set.next()) {
       			if (i<=$page*20 && i>($page-1)*20) {
	       			DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
	       					set, DiscussionInfo.class)));
	       			di.printTitle(out, i++);
       			} else i++;
       		}
       		
       		session.setAttribute("lastURL", "/Test/discussion/postTopic.jsp?zone="+zone);
       		out.println("</table>");
       		i--;
       		int totPage = (i-1)/20+1;
       		if ($page>1) {
       			out.println("<a href=\""+"/Test/discussion/postTopic.jsp?zone="+zone+"&page="+($page-1)+"\">上一页"+"</a>");
       		}
       		out.println(" 第"+$page+"页 ");
       		if ($page<totPage) {
       			out.println("<a href=\""+"/Test/discussion/postTopic.jsp?zone="+zone+"&page="+($page+1)+"\">下一页"+"</a>");
       		}
       		
       		%>
       <br/>
<form id="contactform" name="form1" method="post" action="postTopicDO.jsp">
  <input name="discussType" type="hidden" value="T"/>
   <input name="belongs" type="hidden" value="0"/>
          <ol>
            <li>
              <label for="topic">标  题 </label>
              <input id="name" name="topic" class="text" maxlength="45" size="80"/>
            </li>
            <li>
              <label for="content">内 容 </label>
              <textarea id="content" name="content"  rows="8"></textarea>
            </li>
			<li><label for="imageUrl">插入图片</label> <input type="text"
				name="imageUrl" class="text"/> <input type="button"
				onclick="javascript:this.form.content.value+='[img]'+this.form.imageUrl.value+'[/img]';"
				value="插入" /></li>
			<li><label for="flashurl">插入flash视频</label> <input
				type="text" name="flashUrl" class="text" id="flashUrl" /><input
				type="button"
				onclick="javascript:this.form.content.value+='[flash]'+this.form.flashUrl.value+'[/flash]';"
				value="插入" /></li>
			<li><label for="soundUrl">插入声音</label><input type="text"
				name="soundUrl" id="soundUrl" class="text" /><input
				type="button"
				onclick="javascript:this.form.content.value+='[sound]'+this.form.soundUrl.value+'[/sound]';"
				value="插入" /></li>					
            <li class="buttons">
              <input type="image" name="imageField" id="imageField" src="images/send.gif" class="send" value="提 交"/>
              <div class="clr"></div>
            </li>
          </ol>
          </form>
      </div>
 <div class="right">
	<table id="customers">
		<tr><th>版面浏览</th></tr>
		<tr><td align="center"><a href="/Test/discussion/postTopic.jsp?zone=cs">贵系贵系</a></td></tr>
		<tr><td align="center"><a href="/Test/discussion/postTopic.jsp?zone=food">想吃美食</a></td></tr>
		<tr><td align="center"><a href="/Test/discussion/postTopic.jsp?zone=music">音乐之声</a></td></tr>
		<%
			if (user.getName()!=null && user.getPrivilege().equals("admin")) {
				out.println("<tr><td align=\"center\"><a href=\"/Test/discussion/postTopic.jsp?zone=other\">other</a></td></tr>");
			}
		%>
	</table>
	<br></br>
	<table id="customers">
	<tr><th colspan="2">精华帖子</th></tr>
			<%
			ResultSet rs = Conn.getConn().prepareStatement("select * from Discussion where zone='"+zone +"' order by pros DESC").executeQuery();
			int j=0;
			
			while ((j++<8) && rs.next()) {
       			DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
       					rs, DiscussionInfo.class)));
       			out.println("<tr><td>"+di.getTopicPrint()+"</td><td>"+di.getNamePrint()+"</td></tr>");
			}
			
		%>
	</table>      
	<br></br>
		<table id="customers">
		<tr><th colspan="2">快来吐槽</th></tr>
	
				<%
			ResultSet rs2 = Conn.getConn().prepareStatement("select * from Discussion where zone='"+zone +"' order by cons DESC").executeQuery();
			int jj=0;
			
			while ((jj++<8) && rs2.next()) {
       			DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
       					rs2, DiscussionInfo.class)));
       			out.println("<tr><td>"+di.getTopicPrint()+"</td><td>"+di.getNamePrint()+"</td></tr>");
			}
			
		%>
		</table> 
	<br />
	<%
		if (user.getName()!=null && user.getPrivilege().equals("admin")) {
			out.println("管理员权限：<a href=\"/Test/discussion/adminForbidden.jsp\">解封</a>");
		}
	%>
	</div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="clr"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="leftt">© Copyright wty&yy . All Rights Reserved</p>
      <p class="right"> 当前登录用户：<%=user.getEmail()==null?"您尚未登录":user.getEmail() %><br /><a href="../logout.jsp">注销</a></p>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
</body>
</html>
