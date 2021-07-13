package dto;

import java.sql.Date;

public class BlackListDTO {

	private int seq;
	private String id;
	private String name;
	private String email;
	private String contact;
	private String block_reason;
	private Date block_date;
	
	public BlackListDTO () {
		super();
	}
	
	public BlackListDTO(int seq, String id, String name, String email, String contact, String block_reason
			,Date block_date) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.email = email;
		this.contact = contact;
		this.block_reason = block_reason;
		this.block_date = block_date;
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


	public String getContact() {
		return contact;
	}


	public void setContact(String contact) {
		this.contact = contact;
	}


	public String getBlock_reason() {
		return block_reason;
	}


	public void setBlock_reason(String block_reason) {
		this.block_reason = block_reason;
	}


	public Date getBlock_date() {
		return block_date;
	}


	public void setBlock_date(Date block_date) {
		this.block_date = block_date;
	}
	
	
	
	
	
}
