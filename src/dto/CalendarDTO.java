package dto;

public class CalendarDTO {
	private int id; //일정 seq
	private String title; //userid
	private String start;
	private String end;
	private String color;
	private DogDTO extendedProps; // 주소로 지도 마커
	
	public CalendarDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CalendarDTO(int id, String title, String start, String end, String color, DogDTO extendedProps) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.color = color;
		this.extendedProps = extendedProps;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public DogDTO getExtendedProps() {
		return extendedProps;
	}

	public void setExtendedProps(DogDTO extendedProps) {
		this.extendedProps = extendedProps;
	}
}
