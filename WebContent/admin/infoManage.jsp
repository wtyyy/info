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

<%
	boolean isModify = false;
	PublicInfo modifyInfo = null;
	String operation = request.getParameter("oper");
	if (operation != null) {
		if (operation.equals("add")) {
			int id = Integer.parseInt(request.getParameter("infoId"));
			System.out.println(id);
			String title = request.getParameter("title"), text = request
					.getParameter("docText");
			if (title ==null) {
				title = "";
			}
			if (text ==null) {
				text = "";
			}
			PreparedStatement st = null;
			if (id == -1) {
				st = Conn
						.getConn()
						.prepareStatement(
								"insert into publicInfo(title, text) values(?,?)");
			} else {
				st = Conn.getConn().prepareStatement(
						"update publicInfo set title=?,text=? where id="
								+ id);
			}
			st.setString(1, title);
			st.setString(2, text);
			
			if (st.executeUpdate() > 0) {
				out.println("操作成功");
			} else {
				out.println("操作失败");
			}

		} else if (operation.equals("delete")) {
			int id = Integer.parseInt(request.getParameter("infoId"));
			PreparedStatement st = Conn.getConn().prepareStatement(
					"delete from publicInfo where id=" + id);
			st.executeUpdate();
			if (st.executeUpdate() > 0) {
				out.println("操作成功");
			} else {
				out.println("操作失败");
			}
		} else if (operation.equals("modify")) {
			isModify = true;
			int id = Integer.parseInt(request.getParameter("infoId"));
			modifyInfo = PublicInfo.getById(id);
		}
	}
%>
<body>
	添加/修改资源：
	<form method="get" action="infoManage.jsp" name="addForm">
		<input type="hidden" name="oper" value="add"> 信息id(-1代表添加):<input
			type="text" name="infoId"
			value="<%=isModify ? modifyInfo.getId() : -1%>" /><br>标题： <input
			type="text" name="title"
			value="<%=isModify ? modifyInfo.getTitle() : ""%>" /><br>
		<textarea name="docText" rows="20" cols="100"><%=isModify ? modifyInfo.getText() : ""%></textarea>
		
			<br><input type="submit" value="提交"><br>
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
							+ "<td><a href=\"../publicResource/viewInfo.jsp?id="
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