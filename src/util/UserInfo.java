package util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import jdbc.Conn;

import org.apache.commons.dbutils.BeanProcessor;
/**
 * A Bean class that holds a row of UserInfo table
 * @author 天一
 *
 */
public class UserInfo {
	public int getValidated() {
		return validated;
	}

	public void setValidated(int validated) {
		this.validated = validated;
	} 

	static public UserInfo getById(int userId) throws SQLException, IOException, ClassNotFoundException {
		ResultSet rs = Conn.getConn().prepareStatement("select * from users where id=" + userId).executeQuery();
		if (rs.next()) {
			return (UserInfo)new BeanProcessor().toBean(rs, UserInfo.class);
		}else {
			throw new SQLException();
		}
	}
	static public UserInfo getByEmail(String email) throws SQLException, IOException, ClassNotFoundException {
		ResultSet rs = Conn.getConn().prepareStatement("select * from users where email='" + email+"'").executeQuery();
		if (rs.next()) {
			return (UserInfo)new BeanProcessor().toBean(rs, UserInfo.class);
		}else {
			throw new SQLException();
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

	public String getAddress() {
		return address;
	}

	public int getBlocked() {
		return blocked;
	}

	public String getDateBorn() {
		return dateBorn;
	}

	public String getEmail() {
		return email;
	}

	public String getEmergencyContactName() {
		return emergencyContactName;
	}

	public String getEmergencyContactTel() {
		return emergencyContactTel;
	}

	public String getGender() {
		return gender;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getPassword() {
		return password;
	}

	public String getPrivilege() {
		return privilege;
	}

	public String getQq() {
		return qq;
	}

	public String getTel() {
		return tel;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setBlocked(int blocked) {
		this.blocked = blocked;
	}
	public void setDateBorn(String dateBorn) {
		this.dateBorn = dateBorn;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setEmergencyContactName(String emergencyContactName) {
		this.emergencyContactName = emergencyContactName;
	}
	public void setEmergencyContactTel(String emergencyContactTel) {
		this.emergencyContactTel = emergencyContactTel;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
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
	public String checkValid() {
		Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9\\-_\\.]+@[a-zA-Z0-9\\-_]+\\.[a-zA-Z0-9\\-_]+");
		Pattern genderPattern = Pattern.compile("^(male)|(female)$");
		Pattern dateBornPattern = Pattern.compile("^[0-9]{4}-[0-9]{2}-[0-9]{2}$");
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
