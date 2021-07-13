package dto;

public class MessageDTO {
	private int seq;
	private int pb_seq;
	private String title;
	private String send_id;
	private String to_id;
	private String contents;
	private String accept1;
	private String accept2;
	  
	public MessageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MessageDTO(int pb_seq, String title, String send_id, String to_id, String contents) {
		super();
		this.pb_seq = pb_seq;
		this.title = title;
		this.send_id = send_id;
		this.to_id = to_id;
		this.contents = contents;
	}
	
	public MessageDTO(int seq, int pb_seq, String title, String send_id, String to_id, String contents, String accept1,
			String accept2) {
		super();
		this.seq = seq;
		this.pb_seq = pb_seq;
		this.title = title;
		this.send_id = send_id;
		this.to_id = to_id;
		this.contents = contents;
		this.accept1 = accept1;
		this.accept2 = accept2;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getPb_seq() {
		return pb_seq;
	}
	public void setPb_seq(int pb_seq) {
		this.pb_seq = pb_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getTo_id() {
		return to_id;
	}
	public void setTo_id(String to_id) {
		this.to_id = to_id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
