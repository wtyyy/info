<%@ page import ="java.sql.*" %>
<%@ page import = "jdbc.*" %>
<%
    String email = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = Conn.getConn();
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where email='" + email + "' and password='" + pwd + "'");
    if (rs.next()) {
    	session.setAttribute("id", rs.getInt("id"));
    	session.setAttribute("privilege", rs.getString("privilege"));
        session.setAttribute("email", email);
        //session.setAttribute)
        //out.println("welcome " + userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>