<%@page import="java.util.*"%>
<%@page import="java.text.*" %>
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

<title>Insert title here</title>
</head>
<body>
<%
	int topicid = Integer.parseInt(request.getParameter("topicid"));	
	Connection con = Conn.getConn();
	ResultSet set = null;
	session.setAttribute("topicid", topicid);
	Statement st = con.createStatement();
	
	set = st.executeQuery("select * from discussion where id="+topicid+" order by postDate ");
	
	while (set.next()) {
		DiscussionInfo di = ((DiscussionInfo) (new BeanProcessor().toBean(
				set, DiscussionInfo.class)));
		di.printContent(out);
	}
	
	int i = 2;
	
	set = st.executeQuery("select * from discussionReply where belongs="+topicid+" order by postDate ");

	while (set.next()) {
		DiscussionReplyInfo dri = ((DiscussionReplyInfo) (new BeanProcessor().toBean(
				set, DiscussionReplyInfo.class)));
		dri.printContent(out, i++);
	}
	
	
%>

<div>
<form id="form1" name="form1" method="post" action="postReplyDO.jsp">
  <input name="discussType" type="hidden" value="R">
   <input name="zone" type="hidden" value="other">
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