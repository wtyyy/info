package util;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.jsp.JspWriter;

import jdbc.Conn;

/**
 * the data of a topic is recorded in this class
 * it is in accordance with the table "discussion" in the database
 * @author yuanyuan
 *
 */
public class DiscussionInfo {
	
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
	 * @return the info of the class in String
	 */
	public String toString() {
		return "DiscussionInfoTable=[id="+id+" topic="+topic+" appendixURL="+appendixURL+" userid="
				+" discussType="+discussType+" pros="+pros+" cons="+cons+ " postDate="+postDate
				+" belongs="+belongs+" zone="+zone+"]";
	}
	
	/**
	 * @return the name of the topic and its link
	 */
	public String getTopicPrint() {
		return "<a href="+"/Test/discussion/postReply.jsp?topicid="+id+"&zone="+zone+">"+topic+"</a>";
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
		return "<a href="+"/Test/discussion/deleteTDO.jsp?id="+id+"&zone="+zone+">删</a>";
	}
	
	/**
	 * @return "封" with the link
	 */
	@SuppressWarnings("finally")
	public String getForbiddenPrint() {
		try {
			ResultSet rs = Conn.getConn().prepareStatement("select * from Forbidden where id="+userid).executeQuery();
			if (!rs.next()) {
				return "<a href="+"/Test/discussion/forbidDO.jsp?userid="+userid+"&topicid="+id+"&zone="+zone+">封</a>";
			}
		} catch (Exception e) {
			return "";
		} finally {
			return "已封";
		}
	}
	
	/**
	 * @return "赞" & "踩" with the link
	 */
	public String getZanCaiPrint() {
		return "<a href="+"/Test/discussion/zanTDO.jsp?id="+id+"&zone="+zone+">赞("+pros+")</a>"
				+ " <a href="+"/Test/discussion/caiTDO.jsp?id="+id+"&zone="+zone+">踩("+cons+")</a>";
	}
	
	/**
	 * print the html in the postTopic.jsp
	 * @param out
	 * @param i
	 * @throws IOException
	 */
	public void printTitle(JspWriter out, int i) throws IOException {
		out.println(
				"<tr><td>"+i
				+ "<td>"+getTopicPrint()+"</td>"
				+ "<td>"+getNamePrint()+"</td>" 
				+ "<td>"+DateTimePrint.dateTimePrint(lastReplyTime)+"</td>"
				+ "<td>"+getLastReplyNamePrint()+"</td>"
				+ "</tr>");
	}
	
	/**
	 * @return the content of the topic after process of BBAdapter(img, video ...)
	 */
	public String getContentPrint() {
		return BBAdapter.process(content);
	} 
	
	/**
	 * print the content shown in postReply.jsp
	 * @param out
	 * @param isSelf
	 * @param isAdmin
	 * @throws IOException
	 */
	public void printContent(JspWriter out, boolean isSelf, boolean isAdmin) throws IOException {
		try {
			String img;
			PreparedStatement stmt = Conn.getConn().prepareStatement("select * from files where name=? and uploaderId=?");
	        stmt.setString(1, "avatar-" + userid + ".jpg");
	        stmt.setInt(2, userid);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	        	img = "<img src=\"/Test/DBFileGetter?id="+rs.getInt(1) + "\" height=125px width=100px />";
	        } else {
	        	img = "";
	        }

		out.println(
				"<th colspan=3>"+topic+"</th>"
				+ "<tr><td align=\"center\">"+1
				+ img +"</td>"
				+ "<td width=500px height=300px colspan=2>"+getContentPrint()+"</td></tr>"
				+ "<td><label align=\"left\">"
				+ DateTimePrint.dateTimePrint(postDate)+"</td>"
				+ "<td align=\"right\">发帖人："
				+ getNamePrint() + "</td><td  align=\"right\">" 
				+ ((isSelf||isAdmin)?getDeletePrint():"")+"  "
				+ (isAdmin?getForbiddenPrint():"")+"  "
				+ getZanCaiPrint()+"</td>"
				+ "</tr>");
		} catch (Exception e) {
			out.println("<%response.sendRedirect(\"/Test/message.jsp?message=\"	+ URLEncoder.encode(\"操作失败，请检查数据格式\" + request.getRequestURL(), \"utf-8\") + \"&redirect=\" +request.getRequestURL());%>");
		}
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAppendixURL() {
		return appendixURL;
	}
	public void setAppendixURL(String appendixURL) {
		this.appendixURL = appendixURL;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getDiscussType() {
		return discussType;
	}
	public void setDiscussType(String discussType) {
		this.discussType = discussType;
	}
	public int getPros() {
		return pros;
	}
	public void setPros(int pros) {
		this.pros = pros;
	}
	public int getCons() {
		return cons;
	}
	public void setCons(int cons) {
		this.cons = cons;
	}
	public Timestamp getPostDate() {
		return postDate;
	}
	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}
	public int getBelongs() {
		return belongs;
	}
	public void setBelongs(int belongs) {
		this.belongs = belongs;
	}
	public String getZone() {
		return zone;
	}
	public void setZone(String zone) {
		this.zone = zone;
	}
	public int getLastReplyId() {
		return lastReplyId;
	}
	public void setLastReplyId(int lastReplyId) {
		this.lastReplyId = lastReplyId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Timestamp getLastReplyTime() {
		return lastReplyTime;
	}
	public void setLastReplyTime(Timestamp lastReplyTime) {
		this.lastReplyTime = lastReplyTime;
	}
	public String getLastReplyName() {
		return lastReplyName;
	}
	public void setLastReplyName(String lastReplyName) {
		this.lastReplyName = lastReplyName;
	}


}
