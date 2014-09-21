package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.jsp.JspWriter;

import jdbc.Conn;

/**
 * the data of a topic-reply is recorded in this class it is in accordance with
 * the table "discussReply" in the database
 * 
 * @author yuanyuan
 *
 */
public class DiscussionReplyInfo {
	/**
	 * @return the name of the person who posts the topic
	 */
	public String getNamePrint() {
		return userName;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content
	 *            the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the appendixURL
	 */
	public String getAppendixURL() {
		return appendixURL;
	}

	/**
	 * @param appendixURL
	 *            the appendixURL to set
	 */
	public void setAppendixURL(String appendixURL) {
		this.appendixURL = appendixURL;
	}

	/**
	 * @return the userid
	 */
	public int getUserid() {
		return userid;
	}

	/**
	 * @param userid
	 *            the userid to set
	 */
	public void setUserid(int userid) {
		this.userid = userid;
	}

	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName
	 *            the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * @return the discussType
	 */
	public String getDiscussType() {
		return discussType;
	}

	/**
	 * @param discussType
	 *            the discussType to set
	 */
	public void setDiscussType(String discussType) {
		this.discussType = discussType;
	}

	/**
	 * @return the pros
	 */
	public int getPros() {
		return pros;
	}

	/**
	 * @param pros
	 *            the pros to set
	 */
	public void setPros(int pros) {
		this.pros = pros;
	}

	/**
	 * @return the cons
	 */
	public int getCons() {
		return cons;
	}

	/**
	 * @param cons
	 *            the cons to set
	 */
	public void setCons(int cons) {
		this.cons = cons;
	}

	/**
	 * @return the postDate
	 */
	public Timestamp getPostDate() {
		return postDate;
	}

	/**
	 * @param postDate
	 *            the postDate to set
	 */
	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}

	/**
	 * @return the belongs
	 */
	public int getBelongs() {
		return belongs;
	}

	/**
	 * @param belongs
	 *            the belongs to set
	 */
	public void setBelongs(int belongs) {
		this.belongs = belongs;
	}

	/**
	 * @return the zone
	 */
	public String getZone() {
		return zone;
	}

	/**
	 * @param zone
	 *            the zone to set
	 */
	public void setZone(String zone) {
		this.zone = zone;
	}

	int id;
	String content;
	String appendixURL;
	int userid;
	String userName;
	String discussType;
	int pros;
	int cons;
	Timestamp postDate;
	int belongs;
	String zone;

	/**
	 * @return "删" with the link
	 */
	public String getDeletePrint() {
		return "<a href=" + "/Test/discussion/deleteDO.jsp?id=" + id
				+ "&topicid=" + belongs + "&zone=" + zone + ">删</a>";
	}

	/**
	 * @return "封" with the link
	 */
	public String getForbiddenPrint() {
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from Forbidden where id=" + userid)
					.executeQuery();
			if (!rs.next()) {
				return "<a href=" + "/Test/discussion/forbidDO.jsp?userid="
						+ userid + "&id=" + id + "&topicid=" + belongs
						+ "&zone=" + zone + ">封</a>";
			}
		} catch (Exception e) {
			return "";
		}
		return "<a>已封</a>";

	}

	/**
	 * @return "赞" & "踩" with the link
	 */
	public String getZanCaiPrint() {
		return "<a href=" + "/Test/discussion/zanDO.jsp?id=" + id + "&topicid="
				+ belongs + "&zone=" + zone + ">赞(" + pros + ")</a>"
				+ " <a href=" + "/Test/discussion/caiDO.jsp?id=" + id
				+ "&topicid=" + belongs + "&zone=" + zone + ">踩(" + cons
				+ ")</a>";
	}

	/**
	 * @return the content of the topic after process of BBAdapter(img, video
	 *         ...)
	 */
	public String getContentPrint() {
		return BBAdapter.process(content);
	}

	/**
	 * print the content shown in postReply.jsp
	 * 
	 * @param out
	 * @param floor
	 * @param isSelf
	 * @param isAdmin
	 * @throws IOException
	 */
	public void printContent(JspWriter out, int floor, boolean isSelf,
			boolean isAdmin) throws IOException {
		Connection con = null;
		try {
			con = Conn.getConn();
			String img;
			PreparedStatement stmt = con
					.prepareStatement("select * from files where name=? and uploaderId=?");
			stmt.setString(1, "avatar-" + userid + ".jpg");
			stmt.setInt(2, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				img = "<img src='/Test/DBFileGetter?id=" + rs.getInt(1)
						+ "' height=125px width=100px />";
			} else {
				img = "";
			}
			out.println("<tr><td align=\"center\">" + floor + "" + img
					+ "</td>" + "<td width=500px height=100px colspan=2>"
					+ getContentPrint() + "</td></tr>"
					+ "<td><label align=\"left\">"
					+ DateTimePrint.dateTimePrint(postDate) + "</td>"
					+ "<td align=\"right\">回帖人：" + getNamePrint()
					+ "</td><td align=\"right\">"
					+ ((isSelf || isAdmin) ? getDeletePrint() : "") + "  "
					+ (isAdmin ? getForbiddenPrint() : "") + "  "
					+ getZanCaiPrint() + "</td>" + "</td></tr>");
		} catch (Exception e) {
			out.println("<%response.sendRedirect(\"/Test/message.jsp?message=\"	+ URLEncoder.encode(\"操作失败，请检查数据格式\" + request.getRequestURL(), \"utf-8\") + \"&redirect=\" +request.getRequestURL());%>");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
	}
}
