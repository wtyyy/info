package util;

public class CourseInfo {
	
	@Override
	public String toString() {
		return "CourseInfo [id=" + id + ", name=" + name + ", teacher="
				+ teacher + ", day=" + day + ", block=" + block + ", text="
				+ text + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", capacity=" + capacity + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getBlock() {
		return block;
	}
	public void setBlock(int block) {
		this.block = block;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	int id;
	String name;
	String teacher;
	int day;
	int block;
	String text;
	String startTime;
	String endTime;
	int capacity;
}