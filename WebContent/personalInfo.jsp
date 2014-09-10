<%@page import="javax.print.attribute.ResolutionSyntax"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="jdbc.*"%>
<%@page import="util.*"%>
<%@page import="org.apache.commons.dbutils.*"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (user.getEmail() == null || user.getEmail().equals("")) {
			out.print(user);
		}
	%>
	<form method="post" action="registration.jsp">
		<input type="hidden" name="oper" value="update">
		<table border="1">
			<thead>
				<tr>
					<th colspan="2">查看并修改个人信息</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>name</td>
					<td><input type="text" name="name" value="<%=user.getName()%>" /></td>
				</tr>
				<tr>
					<td>gender</td>
					<td><input type="radio" name="gender" value="male"
						<%=user.getGender().equals("male") ? "checked" : ""%> />male <input
						type="radio" name="gender" value="female"
						<%=user.getGender().equals("female") ? "checked" : ""%> />female</td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="email" name="email"
						value="<%=user.getEmail()%>" readonly /></td>
				</tr>
				<tr>
					<td>date of birth</td>
					<td><input type="date" name="dateBorn"
						value="<%=user.getDateBorn()%>" /></td>
				</tr>
				<tr>
					<td>phone</td>
					<td><input type="number" name="tel"
						value="<%=user.getTel()%>" /></td>
				</tr>
				<tr>
					<td>紧急联系人</td>
					<td><input type="text" name="emergencyContactName"
						value="<%=user.getEmergencyContactName()%>" /></td>
				</tr>
				<tr>
					<td>紧急联系人电话</td>
					<td><input type="number" name="emergencyContactTel"
						value="<%=user.getEmergencyContactTel()%>" /></td>
				</tr>
				<tr>
					<td>家庭住址</td>
					<td><input type="text" name="address"
						value="<%=user.getAddress()%>" /></td>
				</tr>
				<tr>
					<td>QQ</td>
					<td><input type="number" name="qq" value="<%=user.getQq()%>" /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="password"
						value="<%=user.getPassword()%>" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>