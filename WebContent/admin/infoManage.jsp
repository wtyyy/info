<%@page import="util.*"%>
<%@page import="org.apache.commons.dbutils.BeanProcessor"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="jdbc.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="util.UserInfo" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息资源管理</title>
</head>

<body>
	添加/修改资源：
	<form method="get" action="infoManage.jsp" name="addForm">
		<input type="hidden" name="oper" value="add">
		信息id(-1代表添加):<input type="text" name="infoId" value="-1" /><br>
		<textarea name="docText" rows="20" cols="100"></textarea>
		<br> 插入图片：<input type="text" name="imageUrl"> <input
			type="button"
			onClick="javascript:document.addForm.docText.value+='[img]'+document.addForm.imageUrl.value+'[/img]';"
			value="插入" /><br> 插入flash视频：<input type="text" name="flashUrl" /><input
			type="button"
			onClick="javascript:document.addForm.docText.value+='[flash]'+document.addForm.flashUrl.value+'[/flash]';"
			value="插入" /><br> 插入声音：<input type="text" name="soundUrl" /><input
			type="button"
			onClick="javascript:document.addForm.docText.value+='[sound]'+document.addForm.soundUrl.value+'[/sound]';"
			value="插入" />
	</form>

	<form method="get" action="infoManage.jsp">
		<table>
			<tr>
				<td>选择</td>
				<td>标题</td>
			</tr>
			<%
				ResultSet rs = Conn.getConn()
						.prepareStatement("select * from publicInfo")
						.executeQuery();
				List<PublicInfo> infoList = new BeanProcessor().toBeanList(rs,
						PublicInfo.class);
				for (PublicInfo info : infoList) {
					out.print("<tr><td><input type=\"radio\" name=\"infoId\" value=\""
							+ info.getId()
							+ "\"</td>"
							+ "<td><a href=\"viewInfo.jsp?id="
							+ info.getId()
							+ "\">" + info.getTitle() + "</a></td></tr>");
				}
			%>
		</table>
		<button name="oper" type="submit" value="delete">删除</button>
		<button name="oper" type="submit" value="modify">修改</button>
	</form>
</body>
</html>