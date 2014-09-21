package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * Bean class that holds a row of CourseInfo in the database It contains only
 * getters and setters
 * 
 * @author 天一
 *
 */
public class CourseInfo {

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
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the teacher
	 */
	public String getTeacher() {
		return teacher;
	}

	/**
	 * @param teacher
	 *            the teacher to set
	 */
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	/**
	 * @return the day
	 */
	public int getDay() {
		return day;
	}

	/**
	 * @param day
	 *            the day to set
	 */
	public void setDay(int day) {
		this.day = day;
	}

	/**
	 * @return the block
	 */
	public int getBlock() {
		return block;
	}

	/**
	 * @param block
	 *            the block to set
	 */
	public void setBlock(int block) {
		this.block = block;
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
	 * @return the startTime
	 */
	public String getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime
	 *            the startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime
	 *            the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the capacity
	 */
	public int getCapacity() {
		return capacity;
	}

	/**
	 * @param capacity
	 *            the capacity to set
	 */
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	/**
	 * @return the selectStartTime
	 */
	public String getSelectStartTime() {
		return selectStartTime;
	}

	/**
	 * @param selectStartTime
	 *            the selectStartTime to set
	 */
	public void setSelectStartTime(String selectStartTime) {
		this.selectStartTime = selectStartTime;
	}

	/**
	 * @return the selectEndTime
	 */
	public String getSelectEndTime() {
		return selectEndTime;
	}

	/**
	 * @param selectEndTime
	 *            the selectEndTime to set
	 */
	public void setSelectEndTime(String selectEndTime) {
		this.selectEndTime = selectEndTime;
	}

	static public CourseInfo getById(int courseId) throws SQLException,
			IOException, ClassNotFoundException {
		ResultSet rs = Conn.getConn()
				.prepareStatement("select * from courses where id=" + courseId)
				.executeQuery();
		if (rs.next()) {
			return (CourseInfo) new BeanProcessor()
					.toBean(rs, CourseInfo.class);
		} else {
			throw new SQLException();
		}
	}

	static public List<CourseInfo> getStudentCourseList(int studentId)
			throws ClassNotFoundException, SQLException {
		Connection con = null;
		try {
			con = Conn.getConn();
			List<StudentChooseCourse> pairList = new BeanProcessor()
					.toBeanList(
							con.prepareStatement(
									"select * from studentChooseCourse where studentId="
											+ studentId).executeQuery(),
							StudentChooseCourse.class);
			ArrayList<CourseInfo> result = new ArrayList<CourseInfo>();
			for (StudentChooseCourse pair : pairList) {
				ResultSet rs = con.prepareStatement(
						"select * from Courses where id=" + pair.courseId)
						.executeQuery();
				if (rs.next()) {
					result.add((CourseInfo) new BeanProcessor().toBean(rs,
							CourseInfo.class));
				}
			}
			return result;
		} finally {
			con.close();
		}
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

	String selectStartTime;

	String selectEndTime;

	/**
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CourseInfo [id=" + id + ", name=" + name + ", teacher="
				+ teacher + ", day=" + day + ", block=" + block + ", text="
				+ text + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", capacity=" + capacity + ", selectStartTime="
				+ selectStartTime + ", selectEndTime=" + selectEndTime + "]";
	}
}
