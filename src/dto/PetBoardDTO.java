package dto;

import java.sql.Date;

public class PetBoardDTO {
	
	private int seq;
	private String id;
	private String person_name;
	private String person_gender;
	private String person_age;
	private String local;
	private String place_name;
	private String pet_name;
	private String pet_breed;
	private String pet_gender;
	private String pet_age;
	private String pet_neutering;
	private String pet_feature;
    private String start_date;
    private String end_date;
    private String category;
    private String title;
    private String contents;
    private Date write_date;  
    private int view_count;
    private String accept1;
    private String accept2;
    
	public PetBoardDTO() {}

	public PetBoardDTO(int seq, String id, String person_name, String person_gender, String person_age, String local,
			String place_name, String pet_name, String pet_breed, String pet_gender, String pet_age,
			String pet_neutering, String pet_feature, String start_date, String end_date, String category, String title,
			String contents, Date write_date, int view_count, String accept1, String accept2) {
		super();
		this.seq = seq;
		this.id = id;
		this.person_name = person_name;
		this.person_gender = person_gender;
		this.person_age = person_age;
		this.local = local;
		this.place_name = place_name;
		this.pet_name = pet_name;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_feature = pet_feature;
		this.start_date = start_date;
		this.end_date = end_date;
		this.category = category;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.accept1 = accept1;
		this.accept2 = accept2;
	}
	
	public PetBoardDTO(int seq, String local, String place_name, String pet_name, String pet_breed, String pet_gender, String pet_age,
			String pet_neutering, String pet_feature, String start_date, String end_date, String category, String title,
			String contents) {
		super();
		this.seq = seq;
		this.local = local;
		this.place_name = place_name;
		this.pet_name = pet_name;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_feature = pet_feature;
		this.start_date = start_date;
		this.end_date = end_date;
		this.category = category;
		this.title = title;
		this.contents = contents;
	}
	
	public PetBoardDTO(int seq, String local, String pet_name, String pet_breed, String pet_gender, String pet_age,
			String pet_neutering, String pet_feature, String start_date, String end_date, String category, String title,
			String contents) {
		super();
		this.seq = seq;
		this.local = local;
		this.pet_name = pet_name;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_feature = pet_feature;
		this.start_date = start_date;
		this.end_date = end_date;
		this.category = category;
		this.title = title;
		this.contents = contents;
	}
	
	public PetBoardDTO(int seq, String id, String person_name, String person_gender, String person_age, String local,
			String place_name, String pet_name, String pet_breed, String pet_gender, String pet_age,
			String pet_neutering, String pet_feature, String start_date, String end_date, String category, String title,
			String contents) {
		this.seq = seq;
		this.id = id;
		this.person_name = person_name;
		this.person_gender = person_gender;
		this.person_age = person_age;
		this.local = local;
		this.place_name = place_name;
		this.pet_name = pet_name;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_feature = pet_feature;
		this.start_date = start_date;
		this.end_date = end_date;
		this.category = category;
		this.title = title;
		this.contents = contents;
	}
	
	public PetBoardDTO( String category,String title,String local,String pet_name, String pet_breed, String pet_gender, 
			String pet_age,String pet_neutering, String pet_feature, String start_date, String end_date, String place_name, 
			String contents, int seq) {
		this.category = category;
		this.title = title;
		this.local = local;
		this.pet_name = pet_name;
		this.pet_breed = pet_breed;
		this.pet_gender = pet_gender;
		this.pet_age = pet_age;
		this.pet_neutering = pet_neutering;
		this.pet_feature = pet_feature;
		this.start_date = start_date;
		this.end_date = end_date;
		this.place_name = place_name;
		this.contents = contents;
		this.seq = seq;
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPerson_name() {
		return person_name;
	}

	public void setPerson_name(String person_name) {
		this.person_name = person_name;
	}

	public String getPerson_gender() {
		return person_gender;
	}

	public void setPerson_gender(String person_gender) {
		this.person_gender = person_gender;
	}

	public String getPerson_age() {
		return person_age;
	}

	public void setPerson_age(String person_age) {
		this.person_age = person_age;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public String getPet_breed() {
		return pet_breed;
	}

	public void setPet_breed(String pet_breed) {
		this.pet_breed = pet_breed;
	}

	public String getPet_gender() {
		return pet_gender;
	}

	public void setPet_gender(String pet_gender) {
		this.pet_gender = pet_gender;
	}

	public String getPet_age() {
		return pet_age;
	}

	public void setPet_age(String pet_age) {
		this.pet_age = pet_age;
	}

	public String getPet_neutering() {
		return pet_neutering;
	}

	public void setPet_neutering(String pet_neutering) {
		this.pet_neutering = pet_neutering;
	}

	public String getPet_feature() {
		return pet_feature;
	}

	public void setPet_feature(String pet_feature) {
		this.pet_feature = pet_feature;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public String getAccept1() {
		return accept1;
	}

	public void setAccept1(String accept1) {
		this.accept1 = accept1;
	}

	public String getAccept2() {
		return accept2;
	}

	public void setAccept2(String accept2) {
		this.accept2 = accept2;
	}
}
