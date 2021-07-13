package dto;

public class WeatherDTO {
	private String text;
	private String dust;
	private String maxTemper;
	private String minTemper;
	
	public WeatherDTO() {
		super();
	}
	
	public WeatherDTO(String text, String dust, String maxTemper, String minTemper) {
		super();
		this.text = text;
		this.dust = dust;
		this.maxTemper = maxTemper;
		this.minTemper = minTemper;
	}
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getDust() {
		return dust;
	}
	public void setDust(String dust) {
		this.dust = dust;
	}
	public String getMaxTemper() {
		return maxTemper;
	}
	public void setMaxTemper(String maxTemper) {
		this.maxTemper = maxTemper;
	}
	public String getMinTemper() {
		return minTemper;
	}
	public void setMinTemper(String minTemper) {
		this.minTemper = minTemper;
	}
}
