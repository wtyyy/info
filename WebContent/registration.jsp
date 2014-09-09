<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserTable" scope="session"/>
<jsp:setProperty name="user" property="*"/> 
<%
	out.println(user);
	

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
	Statement st = con.createStatement();
	try {
		java.sql.Date birthDate = java.sql.Date.valueOf(user.getDateBorn());
		
		int i = st
				.executeUpdate("insert into users(email, password, name, gender, dateBorn, tel, emergencyContactName, emergencyContactTel, address, qq) values ('"
						+ user.getEmail()
						+ "','"
						+ user.getPassword()
						+ "','"
						+ user.getName()
						+ "','"
						+ user.getGender()
						+ "','"
						+ user.getDateBorn()
						+ "','"
						+ user.getTel()
						+ "','"
						+ user.getEmergencyContactName()
						+ "','"
						+ user.getEmergencyContactTel()
						+ "','"
						+ user.getAddress()
						+ "','"
						+ user.getQq()
						+ "')");
		if (i > 0) {
			session.setAttribute("email", user.getEmail());
			session.setAttribute("privilege", "student");
			//response.sendRedirect("welcome.jsp");

			 out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
		} else {
			 out.print("有东西没填或者格式不对或者用户名已经有了");
		}
	} catch (SQLException e) {
		out.println("有东西没填或者格式不对或者用户名已经有了");
		//throw e;
	}
%>