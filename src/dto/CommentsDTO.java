package dto;

import java.sql.Date;

public class CommentsDTO {

	private int seq;
	private String writer;
	private String comments;
	private Date write_date;
	private int gallery_seq;
	
	
	
	
	public CommentsDTO() {
		super();
	}
	public CommentsDTO(int seq, String writer, String comments, Date write_date, int gallery_seq) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.comments = comments;
		this.write_date = write_date;
		this.gallery_seq = gallery_seq;
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
	public int getGallery_seq() {
		return gallery_seq;
	}
	public void setGallery_seq(int gallery_seq) {
		this.gallery_seq = gallery_seq;
	}
	
	
	
	
}
