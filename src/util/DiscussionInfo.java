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
 * the data of a topic is recorded in this class it is in accordance with the
 * table "discussion" in the database
 * 
 * @author yuanyuan
 *
 */
public class DiscussionInfo {

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
	 * @return the topic
	 */
	public String getTopic() {
		return topic;
	}

	/**
	 * @param topic
	 *            the topic to set
	 */
	public void setTopic(String topic) {
		this.topic = topic;
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

	/**
	 * @return the lastReplyId
	 */
	public int getLastReplyId() {
		return lastReplyId;
	}

	/**
	 * @param lastReplyId
	 *            the lastReplyId to set
	 */
	public void setLastReplyId(int lastReplyId) {
		this.lastReplyId = lastReplyId;
	}

	/**
	 * @return the lastReplyTime
	 */
	public Timestamp getLastReplyTime() {
		return lastReplyTime;
	}

	/**
	 * @param lastReplyTime
	 *            the lastReplyTime to set
	 */
	public void setLastReplyTime(Timestamp lastReplyTime) {
		this.lastReplyTime = lastReplyTime;
	}

	/**
	 * @return the lastReplyName
	 */
	public String getLastReplyName() {
		return lastReplyName;
	}

	/**
	 * @param lastReplyName
	 *            the lastReplyName to set
	 */
	public void setLastReplyName(String lastReplyName) {
		this.lastReplyName = lastReplyName;
	}

	int id;
	String topic;
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
	int lastReplyId;
	Timestamp lastReplyTime;
	String lastReplyName;

	/**
	 * overwrite toString
	 * 
	 * @return the info of the class in String
	 */
	@Override
	public String toString() {
		return "DiscussionInfoTable=[id=" + id + " topic=" + topic
				+ " appendixURL=" + appendixURL + " userid=" + " discussType="
				+ discussType + " pros=" + pros + " cons=" + cons
				+ " postDate=" + postDate + " belongs=" + belongs + " zone="
				+ zone + "]";
	}

	/**
	 * @return the name of the topic and its link
	 */
	public String getTopicPrint() {
		return "<a href=" + "/Test/discussion/postReply.jsp?topicid=" + id
				+ "&zone=" + zone + ">" + topic + "</a>";
	}

	/**
	 * @return the name of the person who posts the topic
	 */
	public String getNamePrint() {
		return userName;
	}

	/**
	 * @return the name of the person who is the last one to reply the topic
	 */
	public String getLastReplyNamePrint() {
		return lastReplyName;
	}

	/**
	 * @return "删" with the link
	 */
	public String getDeletePrint() {
		return "<a href=" + "/Test/discussion/deleteTDO.jsp?id=" + id
				+ "&zone=" + zone + ">删</a>";
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
						+ userid + "&topicid=" + id + "&zone=" + zone
						+ ">封</a>";
			}
		} catch (Exception e) {
			return "";
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "<a>已封</a>";

	}

	/**
	 * @return "赞" & "踩" with the link
	 */
	public String getZanCaiPrint() {
		return "<a href=" + "/Test/discussion/zanTDO.jsp?id=" + id + "&zone="
				+ zone + ">赞(" + pros + ")</a>" + " <a href="
				+ "/Test/discussion/caiTDO.jsp?id=" + id + "&zone=" + zone
				+ ">踩(" + cons + ")</a>";
	}

	/**
	 * print the html in the postTopic.jsp
	 * 
	 * @param out
	 * @param i
	 * @throws IOException
	 */
	public void printTitle(JspWriter out, int i) throws IOException {
		out.println("<tr><td>" + i + "<td>" + getTopicPrint() + "</td>"
				+ "<td>" + getNamePrint() + "</td>" + "<td>"
				+ DateTimePrint.dateTimePrint(lastReplyTime) + "</td>" + "<td>"
				+ getLastReplyNamePrint() + "</td>" + "</tr>");
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
	 * @param isSelf
	 * @param isAdmin
	 * @throws IOException
	 */
	public void printContent(JspWriter out, boolean isSelf, boolean isAdmin)
			throws IOException {
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
				img = "<img src=\"/Test/DBFileGetter?id=" + rs.getInt(1)
						+ "\" height=125px width=100px />";
			} else {
				img = "";
			}

			out.println("<th colspan=3>" + topic + "</th>"
					+ "<tr><td align=\"center\">" + 1 + img + "</td>"
					+ "<td width=500px height=300px colspan=2>"
					+ getContentPrint() + "</td></tr>"
					+ "<td><label align=\"left\">"
					+ DateTimePrint.dateTimePrint(postDate) + "</td>"
					+ "<td align=\"right\">发帖人：" + getNamePrint()
					+ "</td><td  align=\"right\">"
					+ ((isSelf || isAdmin) ? getDeletePrint() : "") + "  "
					+ (isAdmin ? getForbiddenPrint() : "") + "  "
					+ getZanCaiPrint() + "</td>" + "</tr>");
		} catch (Exception e) {
			out.println("<%response.sendRedirect(\"/Test/message.jsp?message=\"	+ URLEncoder.encode(\"操作失败，请检查数据格式\" + request.getRequestURL(), \"utf-8\") + \"&redirect=\" +request.getRequestURL());%>");
		} finally {
			try {
				con.close();
			} catch (Exception e) {

			}
		}
	}

}
