package util;

import javax.servlet.jsp.JspWriter;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class UserTable {
	public static void printSingleUser(UserInfo userInfo, JspWriter out,
			boolean showOper) throws IOException, SQLException {
		out.println("<tr>");
		if (showOper) {
			out.print("<td><input type=\"radio\" checked=\"true\" name=\"userId\" value=\""
					+ userInfo.getId() + "\" /></td>");
		}
		out.println("<td>" + userInfo.getId() + "</td>");
		out.println("<td>" + userInfo.getEmail() + "</td>");
		out.println("<td>" + userInfo.getName() + "</td>");
		out.println("<td>" + userInfo.getGender()+ "</td>");
		out.println("<td>" + userInfo.getDateBorn() + "</td>");
		out.println("<td>" + userInfo.getTel() + "</td>");
		out.println("<td>" + userInfo.getEmergencyContactName() + "</td>");
		out.println("<td>" + userInfo.getEmergencyContactTel() + "</td>");
		out.println("<td>" + userInfo.getAddress() + "</td>");
		out.println("<td>" + userInfo.getQq() + "</td>");
		out.println("<td>" + userInfo.getBlocked() + "</td>");
		out.println("<td>" + userInfo.getPrivilege() + "</td>");
		out.print("</tr>");
	}
 
	public static void printUsers(List<UserInfo> userInfoList, JspWriter out,
			boolean showOper) throws IOException, SQLException {
		out.println("<table id=\"customers\"><tr>" + (showOper ? "<td>选择</td>" : "")
				+ "<td>id</td>" + "<td>邮箱</td>" + "<td>名字</td>" + "<td>性别</td>"
				+ "<td>出生日期</td>" + "<td>电话</td>" + "<td>紧急联系人</td>"
				+ "<td>紧急联系人电话</td>" + "<td>地址</td>" + "<td>qq</td>"
				+ "<td>屏蔽</td>" + "<td>权限</td>" + "</tr>");
		for (UserInfo info : userInfoList) {
			printSingleUser(info, out, showOper);
		}
		out.println("</table>");
	}
}
