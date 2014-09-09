<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
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
<jsp:useBean id="user" class="util.UserTable" scope="session" />
<jsp:setProperty name="user" property="*" />
<%
	out.println(user);

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
		try {
		int i = 0;
		if ("reg".equals(request.getParameter("oper"))) {

			i = con.prepareStatement("insert into users(email, password, name, gender, dateBorn, tel, emergencyContactName, emergencyContactTel, address, qq) values ('"
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
					+ user.getAddress() + "','" + user.getQq() + "')").executeUpdate();
		} else if ("update".equals(request.getParameter("oper"))) {
			out.print("修改个人信息");
			PreparedStatement st = con.prepareStatement("update users set password=?, name=?, gender=?, dateBorn=?, tel=?, emergencyContactName=?, emergencyContactTel=?, address=?, qq=? where id=?");
			st.setString(1, user.getPassword());
			st.setString(2, user.getName());
			st.setString(3, user.getGender());
			st.setString(4, user.getDateBorn());
			st.setString(5, user.getTel());
			st.setString(6, user.getEmergencyContactName());
			st.setString(7, user.getEmergencyContactTel());
			st.setString(8, user.getAddress());
			st.setString(9, user.getQq());
			st.setInt(10, user.getId());
			i = st.executeUpdate();
		} else {
			out.print("你想干啥");
		}
		if (i > 0) {

			out.print("成功啦 快去"
					+ "<a href='index.jsp'>登陆</a>吧");
		} else {
			out.print("有东西没填或者格式不对或者用户名已经有了");
		}
	} catch (SQLException e) {
		out.println("有东西没填或者格式不对或者用户名已经有了");
		//throw e;
	}
%>