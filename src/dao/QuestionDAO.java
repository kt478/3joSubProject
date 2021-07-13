package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.PetBoardDTO;
import dto.QuestionDTO;

public class QuestionDAO {

	// DB 연결
	private static QuestionDAO instance;

	private QuestionDAO() {
	}

	public synchronized static QuestionDAO getInstance() {
		if (instance == null) {
			instance = new QuestionDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	public int insert(String type, String name, String email, String contents) throws Exception {
		String sql = "insert into question values(question_seq.nextval, ?, ?, ?, ?, sysdate)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setString(1, type);
			pstat.setString(2, name);
			pstat.setString(3, email);
			pstat.setString(4, contents);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int delete(int seq) throws Exception {
		String sql = "delete from question where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public List<QuestionDTO> getQuestionList() throws Exception {
		String sql = "select * from question";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<QuestionDTO> list = new ArrayList<>();
			while (rs.next()) {
				QuestionDTO dto = new QuestionDTO();

				dto.setSeq(rs.getInt("seq"));
				dto.setType(rs.getString("type"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setContents(rs.getNString("contents"));
				dto.setAsk_date(rs.getDate("ask_date"));

				list.add(dto);
			}
			return list;
		}
	}


	public QuestionDTO view(int seq) throws Exception {
		String sql = "select * from question where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, seq);
			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();

				QuestionDTO dto = new QuestionDTO();

				dto.setSeq(rs.getInt("seq"));
				dto.setType(rs.getString("type"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setContents(rs.getNString("contents"));
				dto.setAsk_date(rs.getDate("ask_date"));

				return dto;
			}
		}
	}


	public List<QuestionDTO> getPageList(int startNum, int endNum) throws Exception {
		String sql = "select * from (select row_number() over(order by seq desc) rnum, seq, type, name, email, contents, ask_date from question) where rnum between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			try (ResultSet rs = pstat.executeQuery();) {
				List<QuestionDTO> list = new ArrayList<QuestionDTO>();
				while (rs.next()) {
					QuestionDTO dto = new QuestionDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setType(rs.getString("type"));
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setContents(rs.getString("contents"));
					dto.setAsk_date(rs.getDate("ask_date"));

					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public List<QuestionDTO> getPageList(int startNum, int endNum, String category) throws Exception {
		String sql = "select * from (select row_number() over(order by seq desc) rnum, seq, type, name, email, contents, ask_date from question where= "+category+") where rnum between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);

			try (ResultSet rs = pstat.executeQuery();) {
				List<QuestionDTO> list = new ArrayList<QuestionDTO>();

				while (rs.next()) {
					QuestionDTO dto = new QuestionDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setType(rs.getString("type"));
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setContents(rs.getNString("contents"));
					dto.setAsk_date(rs.getDate("ask_date"));

					list.add(dto);
				}
				return list;
			}
		}
	}

	public List<QuestionDTO> getPageList(int startNum, int endNum, String category, String keyword) throws Exception {
		String sql = "select * from (select row_number() over(order by seq desc) rnum, seq, type, name, email, contents, ask_date from question where "+category+" like ?) where rnum between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setString(1, "%"+keyword+"%");
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);

			try (ResultSet rs = pstat.executeQuery();) {
				List<QuestionDTO> list = new ArrayList<QuestionDTO>();

				while (rs.next()) {
					QuestionDTO dto = new QuestionDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setType(rs.getString("type"));
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setContents(rs.getNString("contents"));
					dto.setAsk_date(rs.getDate("ask_date"));

					list.add(dto);
				}
				return list;
			}
		}
	}

	private int getRecordCount() throws Exception {
		String sql = "select count(*) from question";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getRecordCount(String category, String keyword) throws Exception {
		String sql = "select count(*) from question where " + category + " like ?";
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
