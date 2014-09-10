package util;

public class StudentChooseCourse {
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
	@Override
	public String toString() {
		return "StudentChooseCourse [id=" + id + ", studentId=" + studentId
				+ ", courseId=" + courseId + "]";
	}
	int id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	int studentId;
	int courseId;
}
