package util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;
 
/**
 * A Bean class that holds a row of PublicInfo table
 * @author 天一
 *
 */
public class PublicInfo {
	static public PublicInfo getById(int id) throws SQLException, IOException,
			ClassNotFoundException {
		ResultSet rs = Conn.getConn()
				.prepareStatement("select * from publicInfo where id=" + id)
				.executeQuery();
		if (rs.next()) {
			return (PublicInfo) new BeanProcessor()
					.toBean(rs, PublicInfo.class);
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
		return "PublicInfo [id=" + id + ", title=" + title + ", text=" + text
				+ "]";
	}

	int id;
	String title;
	String text;
}
