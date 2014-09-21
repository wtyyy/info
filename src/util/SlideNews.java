package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * A Bean class that holds a row of SlideNews table
 * 
 * @author 天一
 *
 */
public class SlideNews {
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
	 * @return the image
	 */
	public String getImage() {
		return image;
	}

	/**
	 * @param image
	 *            the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}

	/**
	 * @return the href
	 */
	public String getHref() {
		return href;
	}

	/**
	 * @param href
	 *            the href to set
	 */
	public void setHref(String href) {
		this.href = href;
	}

	static public SlideNews getById(int id) throws SQLException, IOException,
			ClassNotFoundException {
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from slideInfo where id=" + id).executeQuery();
			if (rs.next()) {
				return (SlideNews) new BeanProcessor().toBean(rs,
						SlideNews.class);
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
		return "SlideInfo [id=" + id + ", image=" + image + ", href=" + href
				+ "]";
	}

	int id;
	String image;
	String href;

}
