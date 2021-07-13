package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BoardCmtDTO;

public class BoardCmtDAO {
	
	// DB 연결
	private static BoardCmtDAO instance;
	private BoardCmtDAO() {}
	public synchronized static BoardCmtDAO getInstance() {
		if (instance == null) {
			instance = new BoardCmtDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	// 댓글 작성
	public int insertCmt(BoardCmtDTO dto) throws Exception {
		String sql = "insert into fb_comments values(fb_comments_seq.nextval, ?, ?, sysdate, ?)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getComments());
			pstat.setInt(3, dto.getParent_seq());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 댓글 출력
	public List<BoardCmtDTO> getCommentsList(int parent_seq) throws Exception {
		String sql = "select * from fb_comments where parent_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, parent_seq);
			try (ResultSet rs = pstat.executeQuery();) {
				List<BoardCmtDTO> list = new ArrayList<>();

				while (rs.next()) {
					BoardCmtDTO dto = new BoardCmtDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setWriter(rs.getString("writer"));
					dto.setComments(rs.getString("comments"));
					dto.setWrite_date(rs.getDate("write_date"));
					dto.setParent_seq(rs.getInt("parent_seq"));

					list.add(dto);
				}
				return list;
			}
		}
	}

	// 댓글 수정
	public int modifyCmt(int seq, String comments) throws Exception {
		String sql = "update fb_comments set comments=? where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, comments);
			pstat.setInt(2, seq);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 댓글 삭제
	public int deleteCmt(int seq) throws Exception {
		String sql = "delete from fb_comments where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 댓글 갯수
	public int countCmt(int parent_seq) throws Exception{
		String sql = "select count(seq) from fb_comments where parent_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, parent_seq);
			
			int result= pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
}
