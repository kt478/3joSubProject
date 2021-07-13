package dto;

public class CosDTO {
	private int seq;
	private String course_area; // 자치구
	private String course_name;
	private String address1;
	private String postcode;
	private String oriName;
	private String sysName;
	private String explain; //설명
	private String ex_time;
	private String ex_way;
	
	public CosDTO() {
		super();
	}
	
	public CosDTO(String postcode, String address1) {
		this.postcode = postcode;
		this.address1 = address1;
	}

	public CosDTO(int seq, String course_area, String course_name, String address1, String postcode, String oriName,
			String sysName, String explain, String ex_time, String ex_way) {
		super();
		this.seq = seq;
		this.course_area = course_area;
		this.course_name = course_name;
		this.address1 = address1;
		this.postcode = postcode;
		this.oriName = oriName;
		this.sysName = sysName;
		this.explain = explain;
		this.ex_time = ex_time;
		this.ex_way = ex_way;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getCourse_area() {
		return course_area;
	}

	public void setCourse_area(String course_area) {
		this.course_area = course_area;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getOriName() {
		return oriName;
	}

	public void setOriName(String oriName) {
		this.oriName = oriName;
	}

	public String getSysName() {
		return sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getEx_time() {
		return ex_time;
	}

	public void setEx_time(String ex_time) {
		this.ex_time = ex_time;
	}

	public String getEx_way() {
		return ex_way;
	}

	public void setEx_way(String ex_way) {
		this.ex_way = ex_way;
	}
}
