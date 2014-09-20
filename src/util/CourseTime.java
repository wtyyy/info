package util;

/**
 * A wrapper class around a course time.
 * @author 天一
 *
 */
public class CourseTime {
	static int BLOCKS_IN_DAY = 5;
	int time;

	/**
	 * private Constructor through a encoded time
	 * @param time
	 */
	private CourseTime(int time) {
		this.time = time;
	}
 
	/**
	 * private Constructor through a pair of integer
	 * @param day
	 * @param timeInDay
	 */
	private CourseTime(int day, int timeInDay) {
		time = day * BLOCKS_IN_DAY + timeInDay;
	}

	/**
	 * validate the time, and then returns it
	 * @param time
	 * @return null if the time is invalid, or a CourseTime instance
	 */
	public static CourseTime fromEncodedTime(int time) {
		CourseTime res = new CourseTime(time);
		if (res.getDay() >= 0 && res.getDay() < 7 && res.getTimeInDay() >= 0
				&& res.getTimeInDay() < BLOCKS_IN_DAY) {
			return res;
		} else {
			return null;
		}
	}

	/**
	 *  validate the time, and then returns it
	 * @param day
	 * @param block
	 * @return null if the time is invalid, or a CourseTime instance
	 */
	public static CourseTime fromDayAndBlock(int day, int block) {
		if (day >= 0 && day < 7 && block >= 0 && block < BLOCKS_IN_DAY) {
			return new CourseTime(day, block);
		} else {
			return null;
		}
	}

	public int getDay() {
		return time / BLOCKS_IN_DAY;
	}

	public int getTimeInDay() {
		return time % BLOCKS_IN_DAY;
	}
	public int getEncodedTime() {
		return time;
	}

}
