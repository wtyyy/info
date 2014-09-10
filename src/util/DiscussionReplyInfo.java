package util;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.jsp.JspWriter;

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

	public void printContent(JspWriter out, int floor) throws IOException {
		out.println(
				"<tr><td>"+floor+"</td>"
				+ "<td>"+userName+"</td>"
				+ "<td>"+postDate+"</td></tr>"
				+ "<tr><td>"+content+"</td>"
				+ "</tr>");
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
