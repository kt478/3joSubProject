package dto;

import java.sql.Date;

public class Gallery_ImgDTO {

	private int seq;
	private String oriName;
	private String sysName;
	private int gallery_seq;
	
	
	
	
	
	public Gallery_ImgDTO() {
		super();
	}
	public Gallery_ImgDTO(int seq, String oriName, String sysName, int gallery_seq) {
		super();
		this.seq = seq;
		this.oriName = oriName;
		this.sysName = sysName;
		this.gallery_seq = gallery_seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
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
	public int getGallery_seq() {
		return gallery_seq;
	}
	public void setGallery_seq(int gallery_seq) {
		this.gallery_seq = gallery_seq;
	}
	
	
	
	
	
	
	
}
