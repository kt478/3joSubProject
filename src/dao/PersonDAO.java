package dao;

import java.math.BigInteger;
import java.security.MessageDigest;
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

public class PersonDAO {

	private static PersonDAO instance = null;

	public synchronized static PersonDAO getInstance(){		
		if(instance==null) {
			instance = new PersonDAO();
		}
		return instance; //싱글톤 적용
	}

	private PersonDAO() {}
	private Connection getConnection()throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	public static String getSHA512(String pw){ //암호화 복호화 메서드
		String toReturn = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-512");
			digest.reset();
			digest.update(pw.getBytes("utf8"));
			toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return toReturn;
	}


	public boolean isIdExist(String id)throws Exception{ //idCheck기능 사용가능한지를 알려주는 Boolean으로 
		String sql = "select * from person_info where Id=?";
		try(Connection con =this.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql);){
			pstat.setNString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				return rs.next();
			}

		}
	}

	public int signup(PersonDTO dto) throws Exception {
		String sql = "insert into person_info values(?,?,?,?,?,?,?,?,?,?,sysdate)";

		try(Connection con =this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			pstat.setString(1,dto.getId());
			pstat.setString(2,dto.getPw());
			pstat.setNString(3, dto.getEmail());
			pstat.setString(4,dto.getPerson_name());
			pstat.setString(5,dto.getPerson_age());
			pstat.setString(6,dto.getPerson_gender());
			pstat.setString(7,dto.getLocal());
			pstat.setString(8,dto.getContact());
			pstat.setString(9,dto.getPerson_sysName());
			pstat.setString(10,dto.getPerson_oriName());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}

	}

	public PersonDTO onefilesById(String id) throws Exception{
		String sql ="select * from person_info where id=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			try(
					ResultSet rs = pstat.executeQuery()
				){
				if(rs.next()) {
					String image_id = rs.getNString("id");
					String oriName= rs.getNString("person_oriName");
					String sysName= rs.getNString("person_sysName");
					
					return new PersonDTO(image_id,oriName,sysName);
				}
				return null;
			}
		}
	}

	public String findId(String user_name,String user_email, String user_contact) throws Exception {



		String sql = "select id from person_info where person_name=? and email=? and contact=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);

				){
			pstat.setString(1,user_name);
			pstat.setString(2,user_email);
			pstat.setString(3,user_contact);

			try(
					ResultSet rs = pstat.executeQuery();

					){
				if(rs.next()) {
					return rs.getString("id");
				}else {
					return null;
					}
			}
		}

	}

	public List<PersonDTO> filesById(String id)throws Exception{
		String sql ="select * from person_info where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				List<PersonDTO> ilist =new ArrayList<>();
				while(rs.next()) {
					String image_id = rs.getNString("id");
					String oriName= rs.getNString("person_oriName");
					String sysName= rs.getNString("person_sysName");
					ilist.add(new PersonDTO(image_id,oriName,sysName));
				}
				return ilist;
			}
		}
	}

	public PersonDTO login(String id, String pw)throws Exception {
		String sql = "select * from person_info where id=? and pw=?";
		try(Connection con =this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			pstat.setNString(2,pw);
			try(ResultSet rs=pstat.executeQuery();){
				if(rs.next()) {
					String loginId = rs.getNString("id");
					String name = rs.getNString("person_name");
					String local = rs.getNString("local");
					String gender = rs.getNString("person_gender");

					return new PersonDTO(loginId, name, local, gender);
				}
			}
		}
		return null;
	}
	public int MemberOut(String id) throws Exception{
		String sql = "delete from person_info where id = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setNString(1, id);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	public List <PersonDTO> memberList(String id)throws Exception {
		String sql ="select * from person_info where id=?";
		try(Connection con =this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setNString(1, id);
			try(ResultSet rs =pstat.executeQuery()){
				List<PersonDTO> list = new ArrayList<>();

				while(rs.next()) {


					String id2 =rs.getNString("id");
					String pw =rs.getNString("pw");
					String email = rs.getNString("email");
					String person_name=rs.getNString("person_name");
					String person_age=rs.getNString("person_age");
					String person_gender=rs.getNString("person_gender");
					String local=rs.getString("local");
					String contact=rs.getNString("contact");
					String person_sysName=rs.getNString("person_sysname");
					String person_oriName=rs.getNString("person_oriname");
					Date reg_date=rs.getDate("reg_date");

					list.add(new PersonDTO(id2,pw,person_name,email,person_age,person_gender,local,contact,person_sysName,person_oriName,reg_date));

				}
				return list;
			}
		}

	}public List <PersonDTO> memberList()throws Exception {
		String sql ="select * from person_info ";
		try(Connection con =this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			try(ResultSet rs =pstat.executeQuery()){
				List<PersonDTO> list = new ArrayList<>();

				while(rs.next()) {


					String id2 =rs.getNString("id");
					String pw =rs.getNString("pw");
					String email = rs.getNString("email");
					String person_name=rs.getNString("person_name");
					String person_age=rs.getNString("person_age");
					String person_gender=rs.getNString("person_gender");
					String local=rs.getString("local");
					String contact=rs.getNString("contact");
					String person_sysName=rs.getNString("person_sysname");
					String person_oriName=rs.getNString("person_oriname");
					Date reg_date=rs.getDate("reg_date");

					list.add(new PersonDTO(id2,pw,person_name,email,person_age,person_gender,local,contact,person_sysName,person_oriName,reg_date));

				}
				return list;
			}
		}

	}
	public int infomodify(PersonDTO dto)throws Exception {

		String sql ="update person_info set pw=?, email=?, person_name=?, person_age=?, person_gender=?, local=?, contact=?, person_sysName=?, person_oriName=? where id=? ";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, dto.getPw());
			pstat.setNString(2, dto.getEmail());
			pstat.setNString(3, dto.getPerson_name());
			pstat.setNString(4, dto.getPerson_age());
			pstat.setNString(5, dto.getPerson_gender());
			pstat.setNString(6, dto.getLocal());
			pstat.setNString(7, dto.getContact());
			pstat.setNString(8, dto.getPerson_sysName());
			pstat.setNString(9, dto.getPerson_oriName());
			pstat.setNString(10, dto.getId());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public PersonDTO information(String otehrId) throws Exception {
		String sql = "select person_name, person_age, person_gender from person_info where id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, otehrId);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					String name = rs.getNString("person_name");
					String age = rs.getNString("person_age");
					String gender = rs.getNString("person_gender");

					return new PersonDTO(name, age, gender);
				}else{
					return null;
				}
			}
		}
	}

	// 관리자 페이지 회원 리스트 페이징
	private int getRecordCount() throws Exception {
		String sql = "select count(*) from person_info";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getRecordCount(String category, String keyword) throws Exception {
		String sql = "select count(*) from person_info where " + category + " like ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, "%" + keyword + "%");

			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	// 가입일로 검색하는건 쿼리문이 다르다.
	private int getRecordCount(String keyword) throws Exception {
		String sql = "select count(*) from person_info where reg_date like to_date(?)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, keyword);

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
		}else if(category.contentEquals("reg_date")) {
			recordTotalCount = this.getRecordCount(keyword);
		}else {
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

		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1;

		int endNavi = startNavi + (naviCountPerPage - 1);
		if (endNavi > pageTotalCount) { 
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

	public List<PersonDTO> memberList(int startNum, int endNum) throws Exception{
		String sql = "select * from (select row_number() over (order by reg_date desc) rnum, id, person_name, person_age,"
				+ "person_gender, email, local, contact, person_sysName, person_oriName, reg_date from person_info) "
				+ "where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql); ){
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			try(ResultSet rs = pstat.executeQuery()){
				List<PersonDTO> list = new ArrayList<>();

				while(rs.next()) {
					PersonDTO dto = new PersonDTO();

					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setEmail(rs.getNString("email"));
					dto.setLocal(rs.getNString("local"));
					dto.setContact(rs.getNString("contact"));
					dto.setPerson_sysName(rs.getNString("person_sysName"));
					dto.setPerson_oriName(rs.getNString("person_oriName"));
					dto.setReg_date(rs.getDate("reg_date"));

					list.add(dto);

				}return list;
			}
		}
	}	
	
	public List<PersonDTO> memberList(int startNum, int endNum, String category, String keyword) throws Exception{
		String sql = "select * from (select row_number() over (order by reg_date desc) rnum, id, person_name, person_age,"
				+ "person_gender, email, local, contact, person_sysName, person_oriName, reg_date from "
				+ "person_info where " + category + " like ?) where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, "%"+keyword+"%");
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery()){
				List<PersonDTO> list = new ArrayList<>();

				while(rs.next()) {
					PersonDTO dto = new PersonDTO();

					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setEmail(rs.getNString("email"));
					dto.setLocal(rs.getNString("local"));
					dto.setContact(rs.getNString("contact"));
					dto.setPerson_sysName(rs.getNString("person_sysName"));
					dto.setPerson_oriName(rs.getNString("person_oriName"));
					dto.setReg_date(rs.getDate("reg_date"));

					list.add(dto);

				}return list;
			}
		}
	}
	
	public List<PersonDTO> memberList(int startNum, int endNum, String keyword) throws Exception{
		String sql = "select * from (select row_number() over (order by reg_date desc) rnum, id, person_name, person_age,"
				+ "person_gender, email, local, contact, person_sysName, person_oriName, reg_date from "
				+ "person_info where reg_date like to_date(?)) where rnum between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, keyword);
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery()){
				List<PersonDTO> list = new ArrayList<>();

				while(rs.next()) {
					PersonDTO dto = new PersonDTO();

					dto.setId(rs.getNString("id"));
					dto.setPerson_name(rs.getNString("person_name"));
					dto.setPerson_age(rs.getNString("person_age"));
					dto.setPerson_gender(rs.getNString("person_gender"));
					dto.setEmail(rs.getNString("email"));
					dto.setLocal(rs.getNString("local"));
					dto.setContact(rs.getNString("contact"));
					dto.setPerson_sysName(rs.getNString("person_sysName"));
					dto.setPerson_oriName(rs.getNString("person_oriName"));
					dto.setReg_date(rs.getDate("reg_date"));

					list.add(dto);

				}return list;
			}
		}
	}
}
