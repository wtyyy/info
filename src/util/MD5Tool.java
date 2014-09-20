package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
/**
 * A class that could turn string into MD5-hashed hex String
 * @author 天一
 *
 */
public class MD5Tool {
	/**
	 * Turn string into MD5-hashed hex String
	 * @param input input String
	 * @return  Hashed String
	 * @throws NoSuchAlgorithmException It should never occur.
	 */
	public static String digest(String input) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(input.getBytes());
		byte[] digest = md.digest();
		StringBuffer sb = new StringBuffer();
		for (byte b : digest) {
			sb.append(String.format("%02x", b & 0xff));
		}
		return sb.toString();
	}
}
