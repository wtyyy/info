<%@page import="util.*"%>
<%@page import="jdbc.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我在发帖子！！</title>
</head>
<body>
<div>
<table border="1">
<%
	
	
	Connection con = Conn.getConn();
	ResultSet set = null;
	
	Statement st = con.createStatement();
	
	String zone;
	if (request.getParameter("zone") != null)
		zone = request.getParameter("zone");
	else zone = "other";
	set = st.executeQuery("select * from discussion where zone='" + zone + "' order by lastReplyTime DESC ");
	int i = 1;
	session.setAttribute("zone", zone);
	while (set.next()) {
		DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
				set, DiscussionInfo.class)));
		di.printTitle(out, i++);
	}
%>
</table>
</div>

<div>
<form id="form1" name="form1" method="get" action="postTopicDO.jsp">
  <input name="discussType" type="hidden" value="T">
   <input name="belongs" type="hidden" value="0">
  <label>
  <div align="center">标 题
    <input name="topic" type="text" size="100" maxlength="45"/>
  </div>
  </label>
  <p align="center">
    <label>内 容
    <textarea name="content" cols="102" rows="8"></textarea>
    </label>
  </p>
  <p align="center">
    <label>附 件
    <input name="appendixURL" type="text" size="100" maxlength="45" />
    </label>
  </p>
  <p align="center">
    <label>
    <input name="submit" type="submit" id="submit" value="提 交" />
    </label>
    <label>
     <input name="reset" type="reset" id="reset" value="重 置" />
    </label>
  </p>
</form>
</div>

</body>
</html>