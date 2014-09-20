package util;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.jsp.JspWriter;
/**
 * the data of a topic-reply is recorded in this class
 * it is in accordance with the table "discussReply" in the database
 * @author yuanyuan
 *
 */
public class DiscussionReplyInfo {
	
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
		return "<a href="+"/Test/discussion/deleteDO.jsp?id="+id+"&topicid="+belongs+"&zone="+zone+">删</a>";
	}
	
	/**
	 * @return "封" with the link
	 */
	public String getForbiddenPrint() {
		return "<a href="+"/Test/discussion/forbidDO.jsp?userid="+userid+"&id="+id+"&topicid="+belongs+"&zone="+zone+">封</a>";
	}
	
	/**
	 * @return "赞" & "踩" with the link
	 */
	public String getZanCaiPrint() {
		return "<a href="+"/Test/discussion/zanDO.jsp?id="+id+"&topicid="+belongs+"&zone="+zone+ ">赞("+pros+")</a>"
				+ " <a href="+"/Test/discussion/caiDO.jsp?id="+id+"&topicid="+belongs+"&zone="+zone+">踩("+cons+")</a>";
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
	 * @param floor
	 * @param isSelf
	 * @param isAdmin
	 * @throws IOException
	 */
	public void printContent(JspWriter out, int floor, boolean isSelf, boolean isAdmin) throws IOException {
		out.println(
				 "<tr><td align=\"center\">"+floor+"</td>"
				+ "<td width=500px height=100px colspan=2>"+getContentPrint()+"</td></tr>"
				+ "<td><label align=\"left\">"
				+ DateTimePrint.dateTimePrint(postDate)+"</td>"
				+ "<td align=\"right\">回帖人："
				+ getNamePrint() + "</td><td align=\"right\">" 
				+ ((isSelf||isAdmin)?getDeletePrint():"")+"  "
				+ (isAdmin?getForbiddenPrint():"")+"  "
				+ getZanCaiPrint()+"</td>"
				+ "</td></tr>");
	}

	/**
	 * @return the name of the person who posts the topic
	 */
	public String getNamePrint() {
		return userName;
	}

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	
	
}
