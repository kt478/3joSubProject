package dto;

public class PlannerDTO {
	private int seq;
	private String person_id;
	private String pet_feature;
	private String local;
	private String place_name;
	private String start;
	private String end;
	private String postcode;
	private String address1;
	private String category;
	private String other_id;
	
	public PlannerDTO() {}

	public PlannerDTO(int seq, String person_id, String pet_feature, String local, String place_name, String start,
			String end, String postcode, String address1, String category, String other_id) {
		super();
		this.seq = seq;
		this.person_id = person_id;
		this.pet_feature = pet_feature;
		this.local = local;
		this.place_name = place_name;
		this.start = start;
		this.end = end;
		this.postcode = postcode;
		this.address1 = address1;
		this.category = category;
		this.other_id = other_id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getPerson_id() {
		return person_id;
	}

	public void setPerson_id(String person_id) {
		this.person_id = person_id;
	}

	public String getPet_feature() {
		return pet_feature;
	}

	public void setPet_feature(String pet_feature) {
		this.pet_feature = pet_feature;
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

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getOther_id() {
		return other_id;
	}

	public void setOther_id(String other_id) {
		this.other_id = other_id;
	}
}
