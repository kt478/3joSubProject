package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.PersonDTO;
import dto.PetBoardDTO;



public class PetBoardDAO {


	private static PetBoardDAO instance;

	public synchronized static PetBoardDAO getInstance() {
		if(instance == null) {
			instance = new PetBoardDAO();
		}
		return instance;
	}

	private PetBoardDAO() {}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	public PersonDTO myinfo(String info_id) throws Exception{
		String sql = "select * from person_info where id=?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setNString(1, info_id);
			try(ResultSet rs = pstat.executeQuery()){
				PersonDTO dto = new PersonDTO();

				if(rs.next()) {
					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setLocal(rs.getNString("local"));

					return dto;
				}
			}
		}
		return null;
	}

	public int getSeq() throws Exception{
		String sql = "select pb_seq.nextval from dual";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			int seq = rs.getInt("nextval");
			return seq;
		}
	}

	public int insertWrite(PetBoardDTO dto) throws Exception{
		String sql = "insert into petboard values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,0,null,null) ";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){

			pstat.setInt(1, dto.getSeq());
			pstat.setNString(2, dto.getId());
			pstat.setNString(3, dto.getPerson_name());
			pstat.setNString(4, dto.getPerson_gender());
			pstat.setNString(5, dto.getPerson_age());
			pstat.setNString(6, dto.getLocal());
			pstat.setNString(7, dto.getPlace_name());
			pstat.setNString(8, dto.getPet_name());
			pstat.setNString(9, dto.getPet_breed());
			pstat.setNString(10, dto.getPet_gender());
			pstat.setNString(11, dto.getPet_age());
			pstat.setNString(12, dto.getPet_neutering());
			pstat.setNString(13, dto.getPet_feature());
			pstat.setNString(14, dto.getStart_date());
			pstat.setNString(15, dto.getEnd_date());
			pstat.setNString(16, dto.getCategory());
			pstat.setNString(17, dto.getTitle());
			pstat.setNString(18, dto.getContents());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public List<PetBoardDTO> boardList() throws Exception{
		String sql = "select * from petboard order by seq desc";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery()){

			List<PetBoardDTO> list = new ArrayList<>();

			while(rs.next()) {
				PetBoardDTO dto = new PetBoardDTO();

				dto.setSeq(rs.getInt("seq"));
				dto.setId(rs.getNString("id"));
				dto.setPerson_name(rs.getNString("person_name"));
				dto.setPerson_gender(rs.getNString("person_gender"));
				dto.setPerson_age(rs.getNString("person_age"));
				dto.setLocal(rs.getNString("local"));
				dto.setPlace_name(rs.getNString("place_name"));
				dto.setPet_name(rs.getNString("pet_name"));
				dto.setPet_breed(rs.getNString("pet_breed"));
				dto.setPet_gender(rs.getNString("pet_gender"));
				dto.setPet_age(rs.getNString("pet_age"));
				dto.setPet_neutering(rs.getNString("pet_neutering"));
				dto.setStart_date(rs.getNString("start_date"));
				dto.setEnd_date(rs.getNString("end_date"));
				dto.setCategory(rs.getNString("category"));
				dto.setTitle(rs.getNString("title"));
				dto.setContents(rs.getNString("contents"));
				dto.setView_count(rs.getInt("view_count"));

				list.add(dto);
			}
			return list;
		}
	}

	public PetBoardDTO searchWrite(int find_seq) throws Exception {
		String sql = "select * from petboard where seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, find_seq);
			try(ResultSet rs = pstat.executeQuery()){
				PetBoardDTO dto = new PetBoardDTO();
				rs.next();
				dto.setSeq(rs.getInt("seq"));
				dto.setId(rs.getNString("id"));
				dto.setPerson_name(rs.getNString("person_name"));
				dto.setPerson_gender(rs.getNString("person_gender"));
				dto.setPerson_age(rs.getNString("person_age"));
				dto.setLocal(rs.getNString("local"));
				dto.setPlace_name(rs.getNString("place_name"));
				dto.setPet_name(rs.getNString("pet_name"));
				dto.setPet_breed(rs.getNString("pet_breed"));
				dto.setPet_gender(rs.getNString("pet_gender"));
				dto.setPet_age(rs.getNString("pet_age"));
				dto.setPet_neutering(rs.getNString("pet_neutering"));
				dto.setPet_feature(rs.getNString("pet_feature"));
				dto.setStart_date(rs.getNString("start_date"));
				dto.setEnd_date(rs.getNString("end_date"));
				dto.setCategory(rs.getNString("category"));
				dto.setTitle(rs.getNString("title"));
				dto.setContents(rs.getNString("contents"));
				dto.setWrite_date(rs.getDate("write_date"));
				dto.setView_count(rs.getInt("view_count"));

				return dto;
			}
		}
	}

	public int delete(int seq) throws Exception{
		String sql = "delete from petboard where seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int update(PetBoardDTO dto) throws Exception{
		String sql = "update petboard set category=?, title=?, local=?, pet_name=?, pet_breed=?,"
				+ "pet_age=?, pet_neutering=?, pet_gender=?, pet_feature=?, start_date=?,"
				+ "end_date=?, place_name=? , contents=?, write_date=sysdate where seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setNString(1, dto.getCategory());
			pstat.setNString(2, dto.getTitle());
			pstat.setNString(3, dto.getLocal());
			pstat.setNString(4, dto.getPet_name());
			pstat.setNString(5, dto.getPet_breed());
			pstat.setNString(6, dto.getPet_age());
			pstat.setNString(7, dto.getPet_neutering());
			pstat.setNString(8, dto.getPet_gender());
			pstat.setNString(9, dto.getPet_feature());
			pstat.setNString(10, dto.getStart_date());
			pstat.setNString(11, dto.getEnd_date());
			pstat.setNString(12, dto.getPlace_name());
			pstat.setNString(13, dto.getContents());
			pstat.setInt(14, dto.getSeq());
			
			int result = pstat.executeUpdate();
			System.out.println("116");
			con.commit();
			return result;
		}
	}
	

	// 페이징 
	private int getRecordCount() throws Exception{
		String sql = "select count(*) from petboard";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	private int getRecordCount(String search2) throws Exception{
		String sql = "select count(*) from petboard where category=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setNString(1, search2);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	private int getRecordCount(String search, String keyword) throws Exception{
		String sql = "select count(*) from petboard where "+search+" like ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, "%"+keyword+"%");
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}

	public List<String> getPageNavi(int cpage, String search, String search2, String keyword) throws Exception{
		int recordTotalCount = 0;
		
		//search==null||search2==null||keyword == null
		if(search==null&&search2==null&&keyword==null) {
			recordTotalCount=this.getRecordCount();
		}else if(search.contentEquals("category")&&search2!=null&&keyword!=null) {
			recordTotalCount=this.getRecordCount(search2);
		}else {
			recordTotalCount=this.getRecordCount(search,keyword);
		}

		int recordCountPerPage = 10;
		int naviCountPerPage = 10;

		int pageTotalCount = 0;

		if(recordTotalCount % recordCountPerPage > 0) {  
			pageTotalCount = recordTotalCount / recordCountPerPage + 1; 
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if(cpage > pageTotalCount) { 
			cpage = pageTotalCount; 

		}else if(cpage < 1) {
			cpage = 1;
		}

		int startNavi = (cpage-1) / naviCountPerPage * naviCountPerPage + 1;

		int endNavi = startNavi + (naviCountPerPage - 1);
		if(endNavi > pageTotalCount ) { 
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}

		List<String> pageNavi = new ArrayList<>();

		if(needPrev) {pageNavi.add("<");}

		for(int i = startNavi; i <= endNavi; i ++) { 
			pageNavi.add(String.valueOf(i));
		}

		if(needNext) {pageNavi.add(">");}

		return pageNavi;
	}
	// (select row_number() over(order by decode(writer, 'admin', 1) asc, seq desc)
	public List<PetBoardDTO> getPageList(int startNum, int endNum) throws Exception{
		String sql = "select * from (select row_number() over (order by decode(id, 'admin', 1) asc, seq desc) rnum, seq, id, person_name,"
				+ "person_gender, person_age, local, place_name, pet_name, pet_breed,"
				+ "pet_gender, pet_age, pet_neutering, start_date, end_date, category, title, contents,"
				+ "write_date, view_count from petboard) where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				List<PetBoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					PetBoardDTO dto = new PetBoardDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setLocal(rs.getNString("local"));
					dto.setPlace_name(rs.getNString("place_name"));
					dto.setPet_name(rs.getNString("pet_name"));
					dto.setPet_breed(rs.getNString("pet_breed"));
					dto.setPet_gender(rs.getNString("pet_gender"));
					dto.setPet_age(rs.getNString("pet_age"));
					dto.setPet_neutering(rs.getNString("pet_neutering"));
					dto.setStart_date(rs.getNString("start_date"));
					dto.setEnd_date(rs.getNString("end_date"));
					dto.setCategory(rs.getNString("category"));
					dto.setTitle(rs.getNString("title"));
					dto.setContents(rs.getNString("contents"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setWrite_date(rs.getDate("write_date"));

					list.add(dto);
				}
				return list;	
			}
		}

	}
	
	public List<PetBoardDTO> getPageList(int startNum, int endNum, String search2) throws Exception{
		String sql = "select * from (select row_number() over (order by decode(id, 'admin', 1) asc, seq desc) rnum, seq, id, person_name,"
				+ "person_gender, person_age, local, place_name, pet_name, pet_breed,"
				+ "pet_gender, pet_age, pet_neutering, start_date, end_date, category, title, contents,"
				+ "write_date, view_count from petboard where category=?) where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setNString(1, search2);
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				List<PetBoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					PetBoardDTO dto = new PetBoardDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setLocal(rs.getNString("local"));
					dto.setPlace_name(rs.getNString("place_name"));
					dto.setPet_name(rs.getNString("pet_name"));
					dto.setPet_breed(rs.getNString("pet_breed"));
					dto.setPet_gender(rs.getNString("pet_gender"));
					dto.setPet_age(rs.getNString("pet_age"));
					dto.setPet_neutering(rs.getNString("pet_neutering"));
					dto.setStart_date(rs.getNString("start_date"));
					dto.setEnd_date(rs.getNString("end_date"));
					dto.setCategory(rs.getNString("category"));
					dto.setTitle(rs.getNString("title"));
					dto.setContents(rs.getNString("contents"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setWrite_date(rs.getDate("write_date"));

					list.add(dto);
				}
				return list;	
			}
		}

	}

	public List<PetBoardDTO> getPageList(int startNum, int endNum, String search, String keyword) throws Exception{
		String sql = "select * from (select row_number() over (order by decode(id, 'admin', 1) asc, seq desc) rnum, seq, id, person_name,"
				+ "person_gender, person_age, local, place_name, pet_name, pet_breed,"
				+ "pet_gender, pet_age, pet_neutering, start_date, end_date, category, title, contents,"
				+ "write_date, view_count from petboard where " + search + " like ?) where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setNString(1, "%"+keyword+"%");
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				List<PetBoardDTO> list = new ArrayList<>();

				while(rs.next()) {
					PetBoardDTO dto = new PetBoardDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setLocal(rs.getNString("local"));
					dto.setPlace_name(rs.getNString("place_name"));
					dto.setPet_name(rs.getNString("pet_name"));
					dto.setPet_breed(rs.getNString("pet_breed"));
					dto.setPet_gender(rs.getNString("pet_gender"));
					dto.setPet_age(rs.getNString("pet_age"));
					dto.setPet_neutering(rs.getNString("pet_neutering"));
					dto.setStart_date(rs.getNString("start_date"));
					dto.setEnd_date(rs.getNString("end_date"));
					dto.setCategory(rs.getNString("category"));
					dto.setTitle(rs.getNString("title"));
					dto.setContents(rs.getNString("contents"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setWrite_date(rs.getDate("write_date"));

					list.add(dto);
				}
				return list;	
			}
		}

	}
	
	// 조회수
	public void view_count(int seq) throws Exception{
		String sql = "update petboard set view_count = view_count +1 where seq=?";
		try( Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);

			pstat.executeUpdate();
			con.commit();
		}
	}
	
	public PetBoardDTO chooseboard(int seq) throws Exception {
		String sql = "select * from petboard where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					String id = rs.getNString("id");
					String person_name = rs.getNString("person_name");
					String person_gender = rs.getNString("person_gender");
					String person_age = rs.getNString("person_age");
					String local = rs.getNString("local");
					String place_name = rs.getNString("place_name");
					String pet_name = rs.getNString("pet_name");
					String pet_breed = rs.getNString("pet_breed"); //품종
					String pet_gender = rs.getNString("pet_gender");
					String pet_feature = rs.getNString("pet_feature"); //특징
					String pet_age = rs.getNString("pet_age");
					String pet_neutering = rs.getNString("pet_neutering"); // 중성화여부
					String start_date = rs.getNString("start_date");
					String end_date = rs.getNString("end_date");
					String category = rs.getNString("category");
					String title = rs.getNString("title");
					String contents = rs.getNString("contents");
					Date write_date = rs.getDate("write_date");
					int view_count = rs.getInt("view_count");
					String accept1 = rs.getNString("accept1");
					String accept2 = rs.getNString("accept2");;
					
					return new PetBoardDTO(seq, id, person_name, person_gender, person_age, local, place_name, 
							pet_name, pet_breed, pet_gender, pet_age, pet_neutering, pet_feature, 
							start_date, end_date, category, title, contents, write_date, view_count, accept1, accept2);
				}else {
					return null;
				}
			}
		}
	}
}
