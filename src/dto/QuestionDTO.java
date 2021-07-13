package dto;

import java.sql.Date;

public class QuestionDTO {
	
	private int seq;
	private String type;
	private String name;
	private String email;
	private String contents;
	private Date ask_date;
	
	public QuestionDTO() {
		super();
	}

	public QuestionDTO(int seq, String type, String name, String email, String contents, Date ask_date) {
		super();
		this.seq = seq;
		this.type = type;
		this.name = name;
		this.email = email;
		this.contents = contents;
		this.ask_date = ask_date;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Date getAsk_date() {
		return ask_date;
	}

	public void setAsk_date(Date ask_date) {
		this.ask_date = ask_date;
	}
	
}
