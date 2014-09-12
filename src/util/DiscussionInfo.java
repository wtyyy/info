package util;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.jsp.JspWriter;

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

	public String toString() {
		return "DiscussionInfoTable=[id="+id+" topic="+topic+" appendixURL="+appendixURL+" userid="
				+" discussType="+discussType+" pros="+pros+" cons="+cons+ " postDate="+postDate
				+" belongs="+belongs+" zone="+zone+"]";
	}
	
	public String getTopicPrint() {
		return "<a href="+"/Test/discussion/postReply.jsp?topicid="+id+">"+topic+"</a>";
	}
	
	public String getNamePrint() {
		return userName;
	}
	
	public String getLastReplyNamePrint() {
		return lastReplyName;
	}
	
	public String getDeletePrint() {
		return "<a href="+"/Test/discussion/deleteTDO.jsp?id="+id+">删</a>";
	}
	
	public String getForbiddenPrint() {
		return "<a href="+"/Test/discussion/forbidDO.jsp?id="+userid+">封</a>";
	}
	
	public String getZanCaiPrint() {
		return "<a href="+"/Test/discussion/zanTDO.jsp?id="+id+">赞("+pros+")</a>"
				+ "<a href="+"/Test/discussion/caiTDO.jsp?id="+id+">踩("+cons+")</a>";
	}
	
	public void printTitle(JspWriter out, int i) throws IOException {
		out.println(
				"<tr><td>"+i
				+ "<td>"+getTopicPrint()+"</td>"
				+ "<td>"+getNamePrint()+"</td>" 
				+ "<td>"+DateTimePrint.dateTimePrint(lastReplyTime)+"</td>"
				+ "<td>"+getLastReplyNamePrint()+"</td>"
				+ "</tr>");
	}
	
	public void printContent(JspWriter out, boolean isSelf, boolean isAdmin) throws IOException {
		out.println(
				"<tr><td>"+topic+"</td></tr>"
				+ "<tr>"
				+ "<td>"+1+"</td>"
				+ "<td>"+getNamePrint()+"</td>"
				+ "<td>"+DateTimePrint.dateTimePrint(postDate)+"</td></tr>"
				+ "<tr><td>"+content+"</td>"
				+ "</tr>"
				+ "<tr><td>"+((isSelf||isAdmin)?getDeletePrint():"")+"</td>"
				+"<td>"+(isAdmin?getForbiddenPrint():"")+"</td>"
				+"<td>"+getZanCaiPrint()+"</td></tr>");
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
