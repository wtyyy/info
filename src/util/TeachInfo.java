package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * A Bean class that holds a row of TeachInfo table
 * 
 * @author 天一
 *
 */
public class TeachInfo {
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
	 * Get a piece of teachInfo by its unique id
	 * 
	 * @param id
	 * @return TeachInfo instance
	 * @throws SQLException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	static public TeachInfo getById(int id) throws SQLException, IOException,
			ClassNotFoundException {
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from teachInfo where id=" + id).executeQuery();
			if (rs.next()) {
				return (TeachInfo) new BeanProcessor().toBean(rs,
						TeachInfo.class);
			} else {
				throw new SQLException();
			}
		} finally {
			con.close();
		}
	}

	/**
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TeachInfo [id=" + id + ", title=" + title + ", text=" + text
				+ "]";
	}

	int id;
	String title;
	String text;
}
