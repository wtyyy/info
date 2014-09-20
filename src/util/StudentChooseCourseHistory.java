package util;

/**
 * A Bean class that holds a row of StudentChooseCourseHistory table
 * 
 * @author 天一
 *
 */
public class StudentChooseCourseHistory {

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
	 * @return the studentId
	 */
	public int getStudentId() {
		return studentId;
	}

	/**
	 * @param studentId
	 *            the studentId to set
	 */
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	/**
	 * @return the courseId
	 */
	public int getCourseId() {
		return courseId;
	}

	/**
	 * @param courseId
	 *            the courseId to set
	 */
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	/**
	 * @return the operation
	 */
	public String getOperation() {
		return operation;
	}

	/**
	 * @param operation
	 *            the operation to set
	 */
	public void setOperation(String operation) {
		this.operation = operation;
	}

	/**
	 * @return the time
	 */
	public java.sql.Timestamp getTime() {
		return time;
	}

	/**
	 * @param time
	 *            the time to set
	 */
	public void setTime(java.sql.Timestamp time) {
		this.time = time;
	}

	/**
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "StudentChooseCourseHistory [id=" + id + ", studentId="
				+ studentId + ", courseId=" + courseId + ", operation="
				+ operation + ", time=" + time + "]";
	}

	int id;
	int studentId;
	int courseId;
	String operation;
	java.sql.Timestamp time;
}
