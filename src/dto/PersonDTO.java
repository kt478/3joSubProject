package dto;

import java.sql.Date;

public class PersonDTO {

private String id;
private String pw;
private String person_name;
private String email;
private String person_age;
private String person_gender;
private String local;
private String contact;
private String person_sysName;
private String person_oriName;
private Date reg_date;

public PersonDTO() {
	super();
}

public PersonDTO(String id, String pw, String person_name, String email, String person_age, String person_gender,
		String local, String contact, String person_sysName, String person_oriName, Date reg_date) {
	super();
	this.id = id;
	this.pw = pw;
	this.person_name = person_name;
	this.email = email;
	this.person_age = person_age;
	this.person_gender = person_gender;
	this.local = local;
	this.contact = contact;
	this.person_sysName = person_sysName;
	this.person_oriName = person_oriName;
	this.reg_date = reg_date;
}







public PersonDTO(String id, String person_sysName, String person_oriName) {
	this.id = id;
	this.person_sysName = person_sysName;
	this.person_oriName = person_oriName;
}

public PersonDTO(String id, String person_name, String local, String person_gender) {
	this.id = id;
	this.person_name = person_name;
	this.local = local;
	this.person_gender = person_gender;
}

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getPw() {
	return pw;
}

public void setPw(String pw) {
	this.pw = pw;
}

public String getPerson_name() {
	return person_name;
}

public void setPerson_name(String person_name) {
	this.person_name = person_name;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getPerson_age() {
	return person_age;
}

public void setPerson_age(String person_age) {
	this.person_age = person_age;
}

public String getPerson_gender() {
	return person_gender;
}

public void setPerson_gender(String person_gender) {
	this.person_gender = person_gender;
}

public String getLocal() {
	return local;
}

public void setLocal(String local) {
	this.local = local;
}

public String getContact() {
	return contact;
}

public void setContact(String contact) {
	this.contact = contact;
}

public String getPerson_sysName() {
	return person_sysName;
}

public void setPerson_sysName(String person_sysName) {
	this.person_sysName = person_sysName;
}

public String getPerson_oriName() {
	return person_oriName;
}

public void setPerson_oriName(String person_oriName) {
	this.person_oriName = person_oriName;
}

public Date getReg_date() {
	return reg_date;
}

public void setReg_date(Date reg_date) {
	this.reg_date = reg_date;
}






}