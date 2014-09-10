<%@page import="util.UserInfo"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<%
	String email = request.getParameter("uname");
	String pwd = request.getParameter("pass");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from users where email='" + email
	+ "' and password='" + pwd + "'");
	if (rs.next()) {

		session.setAttribute("user", new BeanProcessor().toBean(rs,
		UserInfo.class));
		
		out.print(user);

		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("success.jsp");
	} else {
		out.println("Invalid password <a href='index.jsp'>try again</a>");
	}
%>