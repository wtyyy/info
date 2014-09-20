package util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * A Bean class that holds a row of PublicInfo table
 * 
 * @author 天一
 *
 */
public class PublicInfo {
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
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title
	 *            the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the text
	 */
	public String getText() {
		return text;
	}

	/**
	 * @param text
	 *            the text to set
	 */
	public void setText(String text) {
		this.text = text;
	}

	/**
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PublicInfo [id=" + id + ", title=" + title + ", text=" + text
				+ "]";
	}

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

	int id;
	String title;
	String text;
}
