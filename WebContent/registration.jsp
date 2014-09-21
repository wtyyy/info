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
<%
	Connection conn = null;
	try {
		conn = Conn.getConn();
%>

<%
	request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<jsp:useBean id="tempUser" class="util.UserInfo" scope="page" />
<jsp:setProperty name="tempUser" property="*" />
<%
		if (tempUser.getEmail() == null || tempUser.getName() == null
				|| tempUser.getGender() == null
				|| tempUser.getDateBorn() == null
				|| tempUser.getTel() == null
				|| tempUser.getEmergencyContactName() == null
				|| tempUser.getEmergencyContactTel() == null
				|| tempUser.getAddress() == null) {
			response.sendRedirect("message.jsp?message="
					+ URLEncoder.encode("必要字段不能为空", "utf-8"));
			return;
		}
		if (tempUser.getEmail().equals("")
				|| tempUser.getName().equals("")
				|| tempUser.getGender().equals("")
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

		Connection con = conn;
		//try {
			int i = 0;
			if ("reg".equals(request.getParameter("oper"))) {
				if (tempUser.getPassword() == null
						|| "".equals(tempUser.getPassword())) {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("密码不能为空", "utf-8")
							+ "&redirect=/Test/register.jsp");
					return;
				}

				PreparedStatement st = con
						.prepareStatement("insert into users(email, password, name, gender, dateBorn, tel, emergencyContactName, emergencyContactTel, address, qq, nickName) values (?,?,?,?,?,?,?,?,?,?,?)");
				st.setString(1, tempUser.getEmail());
				st.setString(2, MD5Tool.digest(tempUser.getPassword()));
				st.setString(3,  BBAdapter.encode(tempUser.getName()));
				st.setString(4, tempUser.getGender());
				st.setDate(5,
						java.sql.Date.valueOf(tempUser.getDateBorn()));
				st.setString(6, tempUser.getTel());
				st.setString(7,  BBAdapter.encode(tempUser.getEmergencyContactName()));
				st.setString(8, tempUser.getEmergencyContactTel());
				st.setString(9,  BBAdapter.encode(tempUser.getAddress()));
				st.setString(10, tempUser.getQq());
				st.setString(11, BBAdapter.encode(tempUser.getName()));

				if (st.executeUpdate() > 0) {
					tempUser = UserInfo.getByEmail(tempUser.getEmail());
					System.out.print(tempUser);
					MailUtil.sendTo("邮箱验证",
							"注册成功，<a href=\"http://localhost:8080/Test/emailValidate.jsp?id="
									+ tempUser.getId() + "&oper=validate&code="
									+ tempUser.getEmail().hashCode()
									+ "\">验证邮箱</a>\0",
							tempUser.getEmail());
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("注册成功，请验证邮箱", "utf-8")
							+ "&redirect=/Test/signin.jsp");
					return;
				} else {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("格式错误或者email已经使用",
									"utf-8")
							+ "&redirect=/Test/register.jsp");
					return;
				}
			} else if ("update".equals(request.getParameter("oper"))) {
				out.print("修改个人信息");
				PreparedStatement st;
				if (tempUser.getPassword() != null
						&& !"".equals(tempUser.getPassword())) {
					String oldPass = request
							.getParameter("oldPassword");
					if (oldPass == null || "".equals(oldPass)) {
						response.sendRedirect("message.jsp?message="
								+ URLEncoder.encode("如果修改密码，旧密码不能为空",
										"utf-8")
								+ "&redirect=/Test/personalInfo.jsp");
						return;
					}

					PreparedStatement stmt = con
							.prepareStatement("select * from users where id=? and password=?");
					stmt.setInt(1, user.getId());
					stmt.setString(2, MD5Tool.digest(oldPass));
					if (stmt.executeQuery().next()) {
						st = con.prepareStatement("update users set name=?, gender=?, dateBorn=?, tel=?, emergencyContactName=?, emergencyContactTel=?, address=?, qq=?, nickName=?, password=? where id=?");
					} else {
						response.sendRedirect("message.jsp?message="
								+ URLEncoder.encode("旧密码错误", "utf-8")
								+ "&redirect=/Test/personalInfo.jsp");
						return;
					}

				} else {
					st = con.prepareStatement("update users set name=?, gender=?, dateBorn=?, tel=?, emergencyContactName=?, emergencyContactTel=?, address=?, qq=?, nickName=? where id=?");

				}
				st.setString(1, BBAdapter.encode(tempUser.getName()));
				st.setString(2,  BBAdapter.encode(tempUser.getGender()));
				st.setString(3,  BBAdapter.encode(tempUser.getDateBorn()));
				st.setString(4,  BBAdapter.encode(tempUser.getTel()));
				st.setString(5,  BBAdapter.encode(tempUser.getEmergencyContactName()));
				st.setString(6,  BBAdapter.encode(tempUser.getEmergencyContactTel()));
				st.setString(7,  BBAdapter.encode(tempUser.getAddress()));
				st.setString(8,  BBAdapter.encode(tempUser.getQq()));
				st.setString(9,  BBAdapter.encode(tempUser.getNickName()));
				if (tempUser.getPassword() != null
						&& !"".equals(tempUser.getPassword())) {
					System.out.println("[" + tempUser.getPassword()
							+ "]");
					st.setString(10,
							MD5Tool.digest(tempUser.getPassword()));
					st.setInt(11, user.getId());
				} else {
					st.setInt(10, user.getId());
				}
				if (st.executeUpdate() > 0) {

					session.setAttribute("user",
							UserInfo.getById(user.getId()));
					if (tempUser.getPassword() != null
							&& !"".equals(tempUser.getPassword())) {
						response.sendRedirect("message.jsp?message="
								+ URLEncoder.encode("修改个人资料及密码成功",
										"utf-8")
								+ "&redirect=/Test/personalInfo.jsp");
					} else {
						response.sendRedirect("message.jsp?message="
								+ URLEncoder.encode("修改个人资料（不含密码）成功",
										"utf-8")
								+ "&redirect=/Test/personalInfo.jsp");
					}
					return;
				} else {
					response.sendRedirect("message.jsp?message="
							+ URLEncoder.encode("格式错误或者email已经使用",
									"utf-8")
							+ "&redirect=/Test/personalInfo.jsp");
					return;
				}
			} else {
				response.sendRedirect("message.jsp?message="
						+ URLEncoder.encode("错误的操作类型", "utf-8")
						+ "&redirect=/Test");
				return;
			}
	}  catch (SQLException e) {
		response.sendRedirect("message.jsp?message="
				+ URLEncoder.encode("格式错误或者email已经使用,严重的错误",
						"utf-8"));
		return;
	}catch (Exception e) {
		response.sendRedirect("/Test/message.jsp?message="
				+ URLEncoder.encode("操作失败，请检查数据格式", "utf-8"));
		return;
	} finally {
		try {
			conn.close();
		} catch (Exception e) {

		}
	}
%>