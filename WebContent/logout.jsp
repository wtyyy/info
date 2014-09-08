<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>