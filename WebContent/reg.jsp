<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration</title>
</head><%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<body>
	<form method="post" action="registration.jsp">
			<table border="1">
				<thead>
					<tr>
						<th colspan="2">Enter Information Here</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>name</td>
						<td><input type="text" name="name" value="" /></td>
					</tr>
					<tr>
						<td>gender</td>
						<td><input type="radio" name="gender" value="male" checked/>male
							<input type="radio" name="gender" value="female" />female</td>
					</tr>
					<tr>
						<td>Email</td>
						<td><input type="email" name="email" value="" /></td>
					</tr>
					<tr>
						<td>date of birth</td>
						<td><input type="date" name="dateBorn" value="" /></td>
					</tr>
					<tr>
						<td>tel</td>
						<td><input type="number" name="tel" value="" /></td>
					</tr>
					<tr>
						<td>紧急联系人</td>
						<td><input type="text" name="emergencyContactName" value="" /></td>
					</tr>
					<tr>
						<td>紧急联系人电话</td>
						<td><input type="number" name="emergencyContactTel" value="" /></td>
					</tr>
					<tr>
						<td>家庭住址</td>
						<td><input type="text" name="address" value="" /></td>
					</tr>				
					<tr>
						<td>QQ</td>
						<td><input type="number" name="qq" value="" /></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" name="password" value="" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="Submit" /></td>
						<td><input type="reset" value="Reset" /></td>
					</tr>
					<tr>
						<td colspan="2">Already registered!! <a href="index.jsp">Login
								Here</a></td>
					</tr>
				</tbody>
			</table>
	</form>
</body>
</html>
