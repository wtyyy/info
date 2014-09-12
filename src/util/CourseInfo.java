package util;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import org.apache.commons.dbutils.BeanProcessor;

import jdbc.Conn;

public class CourseInfo {
 
	static public List<CourseInfo> getStudentCourseList(int studentId) throws ClassNotFoundException, SQLException {
		List<StudentChooseCourse> pairList = new BeanProcessor().toBeanList(
				Conn.getConn()
						.prepareStatement(
								"select * from studentChooseCourse where studentId="
										+ studentId).executeQuery(),
				StudentChooseCourse.class);
		ArrayList<CourseInfo> result = new ArrayList<CourseInfo>();
		for (StudentChooseCourse pair : pairList) {
			ResultSet rs = Conn.getConn()
					.prepareStatement(
							"select * from Courses where id="
									+ pair.courseId).executeQuery();
			if (rs.next()) {
				result.add((CourseInfo)new BeanProcessor().toBean(rs, CourseInfo.class));
			}
		}
		return result;
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
