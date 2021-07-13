package dto;

import java.sql.Date;

public class BoardCmtDTO {	
	
	private int seq;
	private String writer;
	private String comments;
	private Date write_date;
	private int parent_seq;
	
	public BoardCmtDTO() {
		super();
	}
	
	public BoardCmtDTO(int seq, String writer, String comments, Date write_date, int parent_seq) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.comments = comments; 
		this.write_date = write_date;
		this.parent_seq = parent_seq;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	
}
