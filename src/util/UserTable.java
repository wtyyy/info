package util;

public class UserTable {
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
		return "UserTable [id=" + id + ", email=" + email + ", password="
				+ password + ", name=" + name + ", gender=" + gender
				+ ", dateBorn=" + dateBorn + ", tel=" + tel
				+ ", emergencyContactName=" + emergencyContactName
				+ ", emergencyContactTel=" + emergencyContactTel + ", address="
				+ address + ", qq=" + qq + ", blocked=" + blocked
				+ ", privilege=" + privilege + "]";
	}
}
