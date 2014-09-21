package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;

/**
 * A Bean class that holds a row of UserInfo table
 * 
 * @author 天一
 *
 */
public class UserInfo {

	/**
	 * @return the nickName
	 */
	public String getNickName() {
		return nickName;
	}

	/**
	 * @param nickName
	 *            the nickName to set
	 */
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

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
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
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
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * @param gender
	 *            the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @return the dateBorn
	 */
	public String getDateBorn() {
		return dateBorn;
	}

	/**
	 * @param dateBorn
	 *            the dateBorn to set
	 */
	public void setDateBorn(String dateBorn) {
		this.dateBorn = dateBorn;
	}

	/**
	 * @return the tel
	 */
	public String getTel() {
		return tel;
	}

	/**
	 * @param tel
	 *            the tel to set
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}

	/**
	 * @return the emergencyContactName
	 */
	public String getEmergencyContactName() {
		return emergencyContactName;
	}

	/**
	 * @param emergencyContactName
	 *            the emergencyContactName to set
	 */
	public void setEmergencyContactName(String emergencyContactName) {
		this.emergencyContactName = emergencyContactName;
	}

	/**
	 * @return the emergencyContactTel
	 */
	public String getEmergencyContactTel() {
		return emergencyContactTel;
	}

	/**
	 * @param emergencyContactTel
	 *            the emergencyContactTel to set
	 */
	public void setEmergencyContactTel(String emergencyContactTel) {
		this.emergencyContactTel = emergencyContactTel;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the qq
	 */
	public String getQq() {
		return qq;
	}

	/**
	 * @param qq
	 *            the qq to set
	 */
	public void setQq(String qq) {
		this.qq = qq;
	}

	/**
	 * @return the blocked
	 */
	public int getBlocked() {
		return blocked;
	}

	/**
	 * @param blocked
	 *            the blocked to set
	 */
	public void setBlocked(int blocked) {
		this.blocked = blocked;
	}

	/**
	 * @return the privilege
	 */
	public String getPrivilege() {
		return privilege;
	}

	/**
	 * @param privilege
	 *            the privilege to set
	 */
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

	/**
	 * @return the validated
	 */
	public int getValidated() {
		return validated;
	}

	/**
	 * @param validated
	 *            the validated to set
	 */
	public void setValidated(int validated) {
		this.validated = validated;
	}

	/**
	 * get a piece of user by its unique id
	 * 
	 * @param userId
	 * @return the UserInfo instance
	 * @throws SQLException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	static public UserInfo getById(int userId) throws SQLException,
			IOException, ClassNotFoundException {
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from users where id=" + userId).executeQuery();
			if (rs.next()) {
				return (UserInfo) new BeanProcessor()
						.toBean(rs, UserInfo.class);
			} else {
				throw new SQLException();
			}
		} finally {
			con.close();
		}
	}

	/**
	 * get a piece of user by its unique email
	 * 
	 * @param email
	 * @return the UserInfo instance
	 * @throws SQLException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	static public UserInfo getByEmail(String email) throws SQLException,
			IOException, ClassNotFoundException {
		Connection con = null;
		try {
			con = Conn.getConn();
			ResultSet rs = con.prepareStatement(
					"select * from users where email='" + email + "'")
					.executeQuery();
			if (rs.next()) {
				return (UserInfo) new BeanProcessor()
						.toBean(rs, UserInfo.class);
			} else {
				return null;
			}
		} finally {
			con.close();
		}
	}

	int id;

	String email;

	String password;

	String name;

	String gender;

	String dateBorn;

	String tel;

	String emergencyContactName;

	String emergencyContactTel;

	String address;

	String qq;

	int blocked;

	String privilege;

	int validated;

	String nickName;

	/**
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", email=" + email + ", password="
				+ password + ", name=" + name + ", gender=" + gender
				+ ", dateBorn=" + dateBorn + ", tel=" + tel
				+ ", emergencyContactName=" + emergencyContactName
				+ ", emergencyContactTel=" + emergencyContactTel + ", address="
				+ address + ", qq=" + qq + ", blocked=" + blocked
				+ ", privilege=" + privilege + ", validated=" + validated + "]";
	}

	/**
	 * @return whether the userInfo is valid
	 */
	public String checkValid() {
		Pattern emailPattern = Pattern
				.compile("^[a-zA-Z0-9\\-_\\.]+@[a-zA-Z0-9\\-_]+\\.[a-zA-Z0-9\\-_]+");
		Pattern genderPattern = Pattern.compile("^(male)|(female)$");
		Pattern dateBornPattern = Pattern
				.compile("^[0-9]{4}-[0-9]{2}-[0-9]{2}$");
		Pattern telPattern = Pattern.compile("^[0-9]{1,15}$");
		Pattern qqPattern = Pattern.compile("^[0-9]{1,15}$");
		if (!emailPattern.matcher(email).matches()) {
			return "email格式错误";
		}
		if (!genderPattern.matcher(gender).matches()) {
			return "性别格式错误";
		}
		if (!dateBornPattern.matcher(dateBorn).matches()) {
			return "出生日期格式错误";
		}
		if (!telPattern.matcher(tel).matches()) {
			return "电话号码错误";
		}
		if (!telPattern.matcher(emergencyContactTel).matches()) {
			return "紧急联系人号码格式错误";
		}
		if (qq != null && !"".equals(qq) && !qqPattern.matcher(qq).matches()) {
			return "qq号码格式错误";
		}
		return null;
	}
}
