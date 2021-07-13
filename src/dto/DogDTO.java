package dto;

import java.sql.Date;

public class DogDTO {
    private int seq;
    private String dog_name ;
    private String dog_breed;
    private String dog_gender; 
    private String dog_feature;
    private String dog_age ;
    private String dog_neutering; 
    private String dog_sysName ;
    private String dog_oriName;
    private String dog_parent_id;
    private Date dog_reg_date;
    
    
    public DogDTO() {
    	super();
    }

	public DogDTO(int seq, String dog_name, String dog_breed, String dog_gender, String dog_feature, String dog_age,
			String dog_neutering, String dog_sysName, String dog_oriName,String dog_parent_id, Date dog_reg_date) {
		super();
		this.seq = seq;
		this.dog_name = dog_name;
		this.dog_breed = dog_breed;
		this.dog_gender = dog_gender;
		this.dog_feature = dog_feature;
		this.dog_age = dog_age;
		this.dog_neutering = dog_neutering;
		this.dog_sysName = dog_sysName;
		this.dog_oriName = dog_oriName;
		this.dog_reg_date = dog_reg_date;
		this.dog_parent_id = dog_parent_id;
	}
	
	public DogDTO(String dog_sysName, String dog_oriName,String dog_parent_id) {
		super();

		this.dog_sysName = dog_sysName;
		this.dog_oriName = dog_oriName;
		this.dog_parent_id = dog_parent_id;
	}

	public DogDTO(String dog_name, String dog_breed, String dog_gender, String dog_feature, String dog_age,
			String dog_neutering, String dog_parent_id) {
		super();
		this.dog_name = dog_name;
		this.dog_breed = dog_breed;
		this.dog_gender = dog_gender;
		this.dog_feature = dog_feature;
		this.dog_age = dog_age;
		this.dog_neutering = dog_neutering;
		this.dog_parent_id = dog_parent_id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getDog_name() {
		return dog_name;
	}

	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}

	public String getDog_breed() {
		return dog_breed;
	}

	public void setDog_breed(String dog_breed) {
		this.dog_breed = dog_breed;
	}

	public String getDog_gender() {
		return dog_gender;
	}

	public void setDog_gender(String dog_gender) {
		this.dog_gender = dog_gender;
	}

	public String getDog_feature() {
		return dog_feature;
	}

	public void setDog_feature(String dog_feature) {
		this.dog_feature = dog_feature;
	}

	public String getDog_age() {
		return dog_age;
	}

	public void setDog_age(String dog_age) {
		this.dog_age = dog_age;
	}

	public String getDog_neutering() {
		return dog_neutering;
	}

	public void setDog_neutering(String dog_neutering) {
		this.dog_neutering = dog_neutering;
	}

	public String getDog_sysName() {
		return dog_sysName;
	}

	public void setDog_sysName(String dog_sysName) {
		this.dog_sysName = dog_sysName;
	}

	public String getDog_oriName() {
		return dog_oriName;
	}

	public void setDog_oriName(String dog_oriName) {
		this.dog_oriName = dog_oriName;
	}

	public Date getDog_reg_date() {
		return dog_reg_date;
	}

	public void setDog_reg_date(Date dog_reg_date) {
		this.dog_reg_date = dog_reg_date;
	}

	public String getDog_parent_id() {
		return dog_parent_id;
	}

	public void setDog_parent_id(String dog_parent_id) {
		this.dog_parent_id = dog_parent_id;
	}
    
	
	
	
    
    
    
}