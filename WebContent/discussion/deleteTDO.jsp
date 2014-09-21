<%@page import="util.*"%>
<%@page import="jdbc.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session"/>
<%@page import="java.net.URLEncoder"%>
<%
Connection conn = null;
 try { 
	 conn = Conn.getConn();

%>

<title>Insert title here</title>
</head>
<body>
<%
//delete a topic and redirect to the zone page
	int id = Integer.valueOf(request.getParameter("id"));

ResultSet set = conn.prepareStatement("select * from discussion where id="+id).executeQuery();
if (!set.next()) {
	 response.sendRedirect("/Test/discussion/postReply.jsp?topicid="+request.getParameter("topicid")+"&zone="+request.getParameter("zone"));
	 return;
} else {
	 if ( (set.getInt("userid")!=user.getId()) && (!"admin".equals(user.getPrivilege())) ) {
		 response.sendRedirect("/Test/discussion/postReply.jsp?topicid="+request.getParameter("topicid")+"&zone="+request.getParameter("zone"));
		 return;
	 }
}

	conn.prepareStatement("delete from discussion where id="+id).execute();
	conn.prepareStatement("delete from discussReply where belongs="+id).execute();
	response.sendRedirect("/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"));
	
%>
</body>
</html>
<%
	} catch (Exception e) {
		response.sendRedirect("../message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8")
				+ "&redirect=" + URLEncoder.encode("/Test/discussion/postTopic.jsp?zone="+request.getParameter("zone"),"utf-8"));
		return;
	}  finally {
		try {
			conn.close();
		} catch (Exception e) {
			
		}
		}
%>