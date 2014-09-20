<%@page import="java.security.MessageDigest"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="util.UserInfo"%>
<%@page import="util.MailUtil"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jdbc.*"%>
<%try{ %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<jsp:useBean id="tempUser" class="util.UserInfo" scope="page" />
<jsp:setProperty name="tempUser" property="*" />
<% 
	out.println(user);
	/*
	 if (user.getEmail() == null || user.getPassword() == null
	 || user.getName() == null || user.getGender() == null
	 || user.getDateBorn() == null || user.getTel() == null
	 || user.getEmergencyContactName() == null
	 || user.getEmergencyContactTel() == null
	 || user.getAddress() == null) {
	 out.println("<script language=\"javascript\">");
	 out.println("alert(\"格式错误\");");
	 out.println("location.href=\"/Test/register.jsp;");
	 out.println("</script>");
	 } else {
	 if (user.getEmail().equals("") || user.getPassword().equals("")
	 || user.getName().equals("")
	 || user.getGender().equals("")
	 || user.getDateBorn().equals("")
	 || user.getTel().equals("")
	 || user.getEmergencyContactName().equals("")
	 || user.getEmergencyContactTel().equals("")
	 || user.getAddress().equals("")) {
	 out.println("<script language=\"javascript\">");
	 out.println("alert(\"格式错误\");");
	 out.println("location.href=\"/Test/register.jsp;");
	 out.println("</script>");
	 }
	 */
	if (tempUser.getEmail() == null
			|| tempUser.getName() == null || tempUser.getGender() == null
			|| tempUser.getDateBorn() == null || tempUser.getTel() == null
			|| tempUser.getEmergencyContactName() == null
			|| tempUser.getEmergencyContactTel() == null
			|| tempUser.getAddress() == null) {
		response.sendRedirect("message.jsp?message="
				+ URLEncoder.encode("必要字段不能为空", "utf-8"));
		return;
	}
	if (tempUser.getEmail().equals("")
			|| tempUser.getName().equals("") || tempUser.getGender().equals("")
			|| tempUser.getDateBorn().equals("")
			|| tempUser.getTel().equals("")
			|| tempUser.getEmergencyContactName().equals("")
			|| tempUser.getEmergencyContactTel().equals("")
			|| tempUser.getAddress().equals("")) {
		response.sendRedirect("message.jsp?message="
				+ URLEncoder.encode("必要字段不能为空", "utf-8"));
		return;

	}
	if (tempUser.checkValid() != null) {
		response.sendRedirect("message.jsp?message="
				+ URLEncoder.encode(tempUser.checkValid(), "utf-8"));
		return;
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = Conn.getConn();
	try {
		int i = 0;
		if ("reg".equals(request.getParameter("oper"))) {
			if (tempUser.getPassword() == null || "".equals(tempUser.getPassword())) {
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("密码不能为空", "utf-8")
						+ "&redirect=/Test/register.jsp");
				return;
			}
			
			PreparedStatement st = con
					.prepareStatement("insert into users(email, password, name, gender, dateBorn, tel, emergencyContactName, emergencyContactTel, address, qq) values (?,?,?,?,?,?,?,?,?,?)");
			st.setString(1, tempUser.getEmail());
			st.setString(2, MD5Tool.digest(tempUser.getPassword()));
			st.setString(3, tempUser.getName());
			st.setString(4, tempUser.getGender());
			st.setDate(5, java.sql.Date.valueOf(tempUser.getDateBorn()));
			st.setString(6, tempUser.getTel());
			st.setString(7, tempUser.getEmergencyContactName());
			st.setString(8, tempUser.getEmergencyContactTel());
			st.setString(9, tempUser.getAddress());
			st.setString(10, tempUser.getQq());
			
			
			
			if (st.executeUpdate() > 0) {
				tempUser = UserInfo
						.getByEmail(tempUser.getEmail());
				System.out.print(tempUser);
				MailUtil.sendTo("邮箱验证",
						"注册成功，<a href=\"http://localhost:8080/Test/emailValidate.jsp?id="
								+ tempUser.getId() + "&code="
								+ tempUser.getEmail().hashCode()
								+ "\">验证邮箱</a>\0", tempUser.getEmail());
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("注册成功，请验证邮箱", "utf-8")
						+ "&redirect=/Test/signin.jsp");
				return;
			} else {
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("格式错误或者email已经使用", "utf-8")
						+ "&redirect=/Test/register.jsp");
				return;
			}
		} else if ("update".equals(request.getParameter("oper"))) {
			out.print("修改个人信息");
			PreparedStatement st;
			if (tempUser.getPassword() != null
					&& !"".equals(tempUser.getPassword())) {
				st = con.prepareStatement("update users set name=?, gender=?, dateBorn=?, tel=?, emergencyContactName=?, emergencyContactTel=?, address=?, qq=?, password=? where id=?");
			} else {
				st = con.prepareStatement("update users set name=?, gender=?, dateBorn=?, tel=?, emergencyContactName=?, emergencyContactTel=?, address=?, qq=? where id=?");

			}
			st.setString(1, tempUser.getName());
			st.setString(2, tempUser.getGender());
			st.setString(3, tempUser.getDateBorn());
			st.setString(4, tempUser.getTel());
			st.setString(5, tempUser.getEmergencyContactName());
			st.setString(6, tempUser.getEmergencyContactTel());
			st.setString(7, tempUser.getAddress());
			st.setString(8, tempUser.getQq());
			if (tempUser.getPassword() != null
					&& !"".equals(tempUser.getPassword())) {
				System.out.println("["+tempUser.getPassword()+"]");
				st.setString(9, MD5Tool.digest(tempUser.getPassword()));
				st.setInt(10, user.getId());
			} else {
				st.setInt(9, user.getId());
			}
			if (st.executeUpdate() > 0) {

				session.setAttribute("user",
						UserInfo.getById(user.getId()));
				response.sendRedirect("personalInfo.jsp");
				return;
			} else {
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("格式错误或者email已经使用", "utf-8")
						+ "&redirect=/Test/personalInfo.jsp");
				return;
				/*
				out.println("<script language=\"javascript\">");
				out.println("alert(\"有东西没填或者格式不对或者用户名已经有了\");");
				out.println("</script>");
				 */
			}
		} else {
			response.sendRedirect("message.jsp?message="
					+ URLEncoder.encode("错误的操作类型", "utf-8")
					+ "&redirect=/Test");
			return;
			/*
			out.println("<script language=\"javascript\">");
			out.println("alert(\"您想干啥\");");
			out.println("</script>");
			 */
		}
	} catch (SQLException e) {
		response.sendRedirect("message.jsp?message="
				+ URLEncoder.encode("格式错误或者email已经使用,严重的错误", "utf-8"));
		//return;
		/*
		out.println("<script language=\"javascript\">");
		out.println("alert(\"有东西没填或者格式不对或者用户名已经有了\");");
		out.println("</script>");
		}}
		 */
	}
%>
<%
	} catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8"));
		throw e;
		//return;
	}
%>