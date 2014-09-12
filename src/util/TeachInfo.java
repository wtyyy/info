package util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;
 
public class TeachInfo {
	static public TeachInfo getById(int id) throws SQLException, IOException,
			ClassNotFoundException {
		ResultSet rs = Conn.getConn()
				.prepareStatement("select * from teachInfo where id=" + id)
				.executeQuery();
		if (rs.next()) {
			return (TeachInfo) new BeanProcessor()
					.toBean(rs, TeachInfo.class);
		} else {
			throw new SQLException();
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "TeachInfo [id=" + id + ", title=" + title + ", text=" + text
				+ "]";
	}

	int id;
	String title;
	String text;
}
