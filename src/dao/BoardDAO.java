package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BoardDTO;

public class BoardDAO {

	// DB 연결
	private static BoardDAO instance;
	private BoardDAO() {}
	public synchronized static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	
	public int getSeq() throws Exception {
		String sql = "select freeboard_seq.nextval from dual";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	// 글 작성하기
	public int insert(String title, String contents, String writer) throws Exception {
		String sql = "insert into freeboard values (freeboard_seq.nextval, ?, ?, ?, sysdate, 0)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setNString(1, title);
			pstat.setNString(2, contents);
			pstat.setNString(3, writer);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 글 보기
	public List<BoardDTO> getBoardList() throws Exception {
		String sql = "select * from freeboard";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<BoardDTO> list = new ArrayList<>();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getNString("title"));
				dto.setContents(rs.getNString("contents"));
				dto.setWriter(rs.getNString("writer"));
				dto.setWrite_date(rs.getDate("write_date"));
				dto.setView_count(rs.getInt("view_count"));

				list.add(dto);
			}
			return list;
		}
	}

	// 글 상세보기
	public BoardDTO view(int seq) throws Exception {
		String sql = "select * from freeboard where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);
			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();

				BoardDTO dto = new BoardDTO();

				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getNString("title"));
				dto.setContents(rs.getNString("contents"));
				dto.setWriter(rs.getNString("writer"));
				dto.setWrite_date(rs.getDate("write_date"));
				dto.setView_count(rs.getInt("view_count"));

				return dto;
			}
		}
	}

	// 글 수정하기
	public int modify(int seq, String title, String contents) throws Exception {
		String sql = "update freeboard set title=?, contents=? where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setNString(1, title);
			pstat.setNString(2, contents);
			pstat.setInt(3, seq);

			int result = pstat.executeUpdate();
			con.commit();

			return result;
		}
	}

	// 글 삭제하기
	public int delete(int seq) throws Exception {
		String sql = "delete from freeboard where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);

			int result = pstat.executeUpdate();
			con.commit();

			return result;
		}
	}

	// 조회수
	private int view_countSearch(int seq) throws Exception {
		String sql = "select view_count from freeboard where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);
			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();
				int view_count = rs.getInt("view_count");
				return view_count;
			}
		}
	}

	public void view_countPlus(int seq) throws Exception {
		BoardDAO dao = new BoardDAO();
		int view_count = dao.view_countSearch(seq);
		String sql = "update freeboard set view_count=? where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, view_count + 1);
			pstat.setInt(2, seq);

			pstat.executeUpdate();
			con.commit();
		}
	}

	// 페이징
	public List<BoardDTO> getPageList(int startNum, int endNum) throws Exception {
		String sql = "select * from (select row_number() over(order by decode(writer, 'admin', 1) asc, seq desc) rnum, seq, title, contents, writer, write_date, view_count from freeboard) where rnum between ? and ?";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			try (ResultSet rs = pstat.executeQuery();) {
				List<BoardDTO> list = new ArrayList<BoardDTO>();
				while (rs.next()) {
					BoardDTO dto = new BoardDTO();
					dto.setSeq(rs.getInt("seq"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getNString("contents"));
					dto.setWriter(rs.getNString("writer"));
					dto.setWrite_date(rs.getDate("write_date"));
					dto.setView_count(rs.getInt("view_count"));

					list.add(dto);
				}
				return list;
			}
		}
	}

	public List<BoardDTO> getPageList(int startNum, int endNum, String category, String keyword) throws Exception {
		String sql = "select * from (select row_number() over(order by decode(writer, 'admin', 1) asc, seq desc) rnum, seq, title, contents, writer, write_date, view_count from freeboard where "
				+ category + " like ?) " + "where rnum between ? and ?";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setString(1, "%" + keyword + "%");
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);

			try (ResultSet rs = pstat.executeQuery();) {
				List<BoardDTO> list = new ArrayList<BoardDTO>();

				while (rs.next()) {
					BoardDTO dto = new BoardDTO();
					dto.setSeq(rs.getInt("seq"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getNString("contents"));
					dto.setWriter(rs.getNString("writer"));
					dto.setWrite_date(rs.getDate("write_date"));
					dto.setView_count(rs.getInt("view_count"));

					list.add(dto);
				}
				return list;
			}
		}
	}

	private int getRecordCount() throws Exception {
		String sql = "select count(*) from freeboard";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getRecordCount(String category, String keyword) throws Exception {
		String sql = "select count(*) from freeboard where " + category + " like ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, "%" + keyword + "%");

			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();
				return rs.getInt(1);
			}
		}
	}

	public List<String> getPageNavi(int currentPage, String category, String keyword) throws Exception {

		int recordTotalCount = 0;

		if (keyword == null || keyword.contentEquals("")) {
			recordTotalCount = this.getRecordCount();
		} else {
			recordTotalCount = this.getRecordCount(category, keyword);
		}

		int recordCountPerPage = 10;
		int naviCountPerPage = 10;

		int pageTotalCount = 0;

		if (recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;

		} else if (currentPage < 1) {
			currentPage = 1;
		}

		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1; // 앞에 자리의 숫자만 떼고 거기에 곱하고 다시 +1

		int endNavi = startNavi + (naviCountPerPage - 1);
		if (endNavi > pageTotalCount) { // 범위 통제 -> 안정성 확보
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		List<String> pageNavi = new ArrayList<>();

		if (needPrev) {
			pageNavi.add("<");
		}

		for (int i = startNavi; i <= endNavi; i++) {
			pageNavi.add(String.valueOf(i));
		}

		if (needNext) {
			pageNavi.add(">");
		}

		return pageNavi;
	}
}