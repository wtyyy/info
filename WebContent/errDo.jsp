<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String errName = request.getParameter("errName")==null?"未知错误":request.getParameter("errName");
	String toUrl = request.getParameter("toUrl")==null?"/Test/index.jsp":request.getParameter("toUrl");
%>
</head>
<body>
<%
		out.println("<script language=\"javascript\">");
		out.println("alert(\""+errName+"\");");
		out.println("</script>");
		response.sendRedirect(toUrl);
%>	
</body>
</html>