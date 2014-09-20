package util;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;


/**
 * to print a time
 * if this time is today
 * we print the time without date
 * otherwise we print only the date
 * @author yuanyuan
 *
 */
public class DateTimePrint {
	
	public static String dateTimePrint(Timestamp ts) {
		Date d = new Date();
		DecimalFormat f = new DecimalFormat("00");
		if (ts.getDate() == d.getDate()) {
			return f.format(ts.getHours())+":"+f.format(ts.getMinutes())+":"+f.format(ts.getSeconds());
		} else {
			  
			return ts.toString().split(" ")[0];
		}
	}
}
