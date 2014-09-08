<%@ page import ="java.sql.*" %>
<%
	String email = request.getParameter("email");  
	String password = request.getParameter("password");
    String name = request.getParameter("name");  
    String gender = request.getParameter("gender");
    //String dateborn = request.getParameter("lname");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webinfo",
            "root", "");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into users(email, password, name, gender, dateBorn) values ('" + email + "','" + password + "','" + name + "','" + gender +  "', CURDATE())");
    if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("welcome.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
%>