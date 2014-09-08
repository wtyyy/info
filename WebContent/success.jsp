<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("email")%>
<a href = 'student/index.jsp'>学生主页  </a>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
