<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "jdbc.*" %>
<%
	String email = request.getParameter("email");  
	String password = request.getParameter("password");
    String name = request.getParameter("name");  
    String gender = request.getParameter("gender");
    //String dateborn = request.getParameter("lname");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con =  Conn.getConn();
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into users(email, password, name, gender, dateBorn) values ('" + email + "','" + password + "','" + name + "','" + gender +  "', CURDATE())");
    if (i > 0) {
        session.setAttribute("email", email);
        session.setAttribute("privilege", "student");
        response.sendRedirect("welcome.jsp");
        
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
%>