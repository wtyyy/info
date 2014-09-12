package util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

public class SlideNews {
	static public SlideNews getById(int id) throws SQLException, IOException,
			ClassNotFoundException {
		ResultSet rs = Conn.getConn()
				.prepareStatement("select * from slideInfo where id=" + id)
				.executeQuery();
		if (rs.next()) {
			return (SlideNews) new BeanProcessor()
					.toBean(rs, SlideNews.class);
		} else {
			throw new SQLException();
		}
	}

	@Override
	public String toString() {
		return "SlideInfo [id=" + id + ", image=" + image + ", href=" + href
				+ "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	int id;
	String image;
	String href;

}
