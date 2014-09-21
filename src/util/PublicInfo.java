package util;

import java.io.IOException;
import java.sql.Connection;
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
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(int type) {
		this.type = type;
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
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from publicInfo where id=" + id).executeQuery();
			if (rs.next()) {
				return (PublicInfo) new BeanProcessor().toBean(rs,
						PublicInfo.class);
			} else {
				return null;
			}
		} finally {
			con.close();
		}
	}

	int id;
	String title;
	String text;
	int type;
}
