package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.CommentsDTO;

public class CommentsDAO {

	private static CommentsDAO instance = null;

	public synchronized static CommentsDAO getInstance() {
		
		if (instance == null) {
			instance = new CommentsDAO();
		}
		return instance;
	}

	private CommentsDAO() {}

	private Connection getConnection() throws Exception {

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();

	}
	
	public int insert(CommentsDTO dto) throws Exception {

		String sql = "insert into gallery_comments values(gallery_comments_seq.nextval,?,?,sysdate,?)";
		
		try (Connection con = this.getConnection(); 
			PreparedStatement pstat = con.prepareStatement(sql);) 
		   {
			
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getComments());
			pstat.setInt(3, dto.getGallery_seq());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;

		}

	}

	
	public List<CommentsDTO> list(int gallery_seq) throws Exception{
		String sql = "select * from gallery_comments where gallery_seq =? order by seq desc";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, gallery_seq);
			try(
					ResultSet rs = pstat.executeQuery();	
					){
				List<CommentsDTO> list = new ArrayList<>();
				while(rs.next()) {
					CommentsDTO dto = new CommentsDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setWriter(rs.getString("writer"));
					dto.setComments(rs.getString("comments"));
					dto.setWrite_date(rs.getDate("write_date"));
					dto.setGallery_seq(rs.getInt("gallery_seq")); 

					list.add(dto);
				}
				return list;
			}
		}
	}
	public int update(int seq, String comments) throws Exception {
		String sql = "update gallery_comments set comments=? where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, comments);
			pstat.setInt(2, seq);
			
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
		}
	}
	
	public int delete(int seq) throws Exception {
		String sql = "delete from gallery_comments where seq=?";
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
	
	
	
	
}
