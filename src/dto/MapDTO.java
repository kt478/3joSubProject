package dto;

public class MapDTO {
	private int seq;
	private String area_name;
	private String lat;
	private String lng;
	
	public MapDTO() {
		super();
	}
	
	public MapDTO(int seq, String area_name, String lat, String lng) {
		super();
		this.seq = seq;
		this.area_name = area_name;
		this.lat = lat;
		this.lng = lng;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getArea_name() {
		return area_name;
	}
	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
}
