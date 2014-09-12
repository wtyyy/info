<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	session.setAttribute("user", null);
	session.invalidate();
	response.sendRedirect("index.jsp");
%>