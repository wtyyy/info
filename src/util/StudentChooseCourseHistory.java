package util;

public class StudentChooseCourseHistory {

	@Override
	public String toString() {
		return "StudentChooseCourseHistory [id=" + id + ", studentId="
				+ studentId + ", courseId=" + courseId + ", operation="
				+ operation + ", time=" + time + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public int getCourseId() {
		return courseId;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public java.sql.Timestamp getTime() {
		return time;
	}
	public void setTime(java.sql.Timestamp time) {
		this.time = time;
	}
	int id;
	int studentId;
	int courseId;
	String operation;
	java.sql.Timestamp time;
}
