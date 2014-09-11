package util;

public class SlideNews {
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
