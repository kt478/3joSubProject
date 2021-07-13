package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MessageDTO;

public class MessageDAO {
private static MessageDAO instance;
	
	private MessageDAO() {}
	
	public synchronized static MessageDAO getInstance() {
		if(instance==null) {
			instance = new MessageDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insert(MessageDTO dto) throws Exception {
		String sql = "insert into pet_message values (pm_seq.nextval,?,?,?,?,?,'Y',null)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, dto.getPb_seq());
			pstat.setNString(2, dto.getTitle());
			pstat.setNString(3, dto.getSend_id());
			pstat.setNString(4, dto.getTo_id());
			pstat.setNString(5, dto.getContents());
			
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
		}
	}
	
	public List<MessageDTO> sendMessage(String id) throws Exception { // 보낸메세지
		String sql = "select * from pet_message where send_id=? order by 1 desc";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<MessageDTO> list = new ArrayList<>();
				while(rs.next()) {
					MessageDTO dto = new MessageDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setPb_seq(rs.getInt("pb_seq"));
					dto.setTitle(rs.getNString("title"));
					dto.setSend_id(rs.getNString("send_id"));
					dto.setTo_id(rs.getNString("to_id"));
					dto.setContents(rs.getNString("contents"));

					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public List<MessageDTO> toMessage(String id) throws Exception { // 받은메세지
		String sql = "select * from pet_message where to_id like ? order by 1 desc";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<MessageDTO> list = new ArrayList<>();
				while(rs.next()) {
					MessageDTO dto = new MessageDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setPb_seq(rs.getInt("pb_seq"));
					dto.setTitle(rs.getNString("title"));
					dto.setSend_id(rs.getNString("send_id"));
					dto.setTo_id(rs.getNString("to_id"));
					dto.setContents(rs.getNString("contents"));
					
					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public int accept(int seq) throws Exception {
		String sql = "update pet_message set accept2='Y' where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			
			int result = pstat.executeUpdate();
			return result;
		}
	}
	
	public int cancel(int seq) throws Exception {
		String sql = "delete from pet_message where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
		}
	}
	
	public boolean check(int pd_seq) throws Exception {
		String sql = "select * from pet_message where pb_seq=? and accept1='Y' and accept2='Y'";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, pd_seq);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}
}
