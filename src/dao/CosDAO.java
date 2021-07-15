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

import dto.CosDTO;

public class CosDAO {
	private static CosDAO instance;
	
	private CosDAO() {}
	
	public synchronized static CosDAO getInstance() {
		if(instance==null) {
			instance = new CosDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public String getPlaceAddress(String placeName) throws Exception {
		String sql = "select address1 from course where course_name=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, placeName);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				rs.next();
				
				return rs.getNString("address1");
			}
			
		}
	}
	
	public CosDTO getAllAddress (String place_name) throws Exception {
		String sql = "select postcode, address1 from course where course_name=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, place_name);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					return new CosDTO(rs.getNString("postcode"),rs.getNString("address1"));
				}else {
					return null;
				}
			}
		}
	}
	
	public String getPlace_Name(String address1) throws Exception {
		String sql = "select course_name from course where address1=?";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, address1);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					return rs.getNString("course_name");
				}else {
					return null;
				}
			}
		}
	}
	
	// 경태꺼
	public List<CosDTO> getCosList(String courseArea) throws Exception{
		String sql="select * from course where course_area=?";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,courseArea);
			try(ResultSet rs=pstat.executeQuery();){
			List<CosDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String course_area = rs.getString("course_area");
				String course_name = rs.getString("course_name");
				String address1 = rs.getString("address1");
				String postcode = rs.getString("postcode");
				String oriName= rs.getString("oriName");
				String sysName= rs.getString("sysName");
				String explain = rs.getString("explain");
				String ex_time = rs.getString("ex_time");
				String ex_way = rs.getString("ex_way");
				list.add(new CosDTO(seq,course_area,course_name,address1,postcode, oriName,sysName,explain, ex_time, ex_way));
			}
			return list;
			}
		}
	}
	
	public CosDTO getSearchList(String courseName) throws Exception{
		String sql="select * from course where course_name=?";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,courseName);
			try(ResultSet rs=pstat.executeQuery();){
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String course_area = rs.getString("course_area");
				String course_name = rs.getString("course_name");
				String address1 = rs.getString("address1");
				String postcode = rs.getString("postcode");
				String oriName= rs.getString("oriName");
				String sysName= rs.getString("sysName");
				String explain = rs.getString("explain");
				String ex_time = rs.getString("ex_time");
				String ex_way = rs.getString("ex_way");
				return new CosDTO(seq,course_area,course_name,address1,postcode,oriName,sysName, explain, ex_time, ex_way);
			}
			}
		}
		return null;
	}
	
	public int insert(CosDTO dto)throws Exception{
		String sql="insert into course values(course_seq.nextval,?,?,?,?,?,?,?,?,?)";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getCourse_area());
			pstat.setString(2, dto.getCourse_name());
			pstat.setString(3, dto.getAddress1());
			pstat.setString(4, dto.getPostcode());
			pstat.setString(5, dto.getOriName());
			pstat.setString(6, dto.getSysName());
			pstat.setString(7, dto.getExplain());
			pstat.setString(8, dto.getEx_time());
			pstat.setString(9, dto.getEx_way());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<CosDTO> getAllList() throws Exception{
		String sql="select * from course";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs=pstat.executeQuery();
				){
			List<CosDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String course_area = rs.getString("course_area");
				String course_name = rs.getString("course_name");
				String address1 = rs.getString("address1");
				String postcode = rs.getString("postcode");
				String oriName= rs.getString("oriName");
				String sysName= rs.getString("sysName");
				String explain = rs.getString("explain");
				String ex_time = rs.getString("ex_time");
				String ex_way = rs.getString("ex_way");
				list.add(new CosDTO(seq,course_area,course_name,address1,postcode,oriName,sysName, explain, ex_time, ex_way));
			}
			return list;
			}
		
	}
	
	public List<CosDTO> search(String keyword) throws Exception{
		String sql = "select * from course where course_area like ? or course_name like ? or address1 like ? order by 2,3";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, "%"+keyword+"%");
			pstat.setString(2, "%"+keyword+"%");
			pstat.setString(3, "%"+keyword+"%");
			try(ResultSet rs = pstat.executeQuery();){
				List<CosDTO> list = new ArrayList<>();
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String course_area = rs.getString("course_area");
					String course_name = rs.getString("course_name");
					String address1 = rs.getString("address1");
					String postcode = rs.getString("postcode");
					String oriName= rs.getString("oriName");
					String sysName= rs.getString("sysName");
					String explain = rs.getString("explain");
					String ex_time = rs.getString("ex_time");
					String ex_way = rs.getString("ex_way");
					list.add(new CosDTO(seq,course_area,course_name,address1,postcode,oriName,sysName,explain, ex_time, ex_way));
				}
				return list;
			}
			
		}
	}
	public List<CosDTO> getPageList(int startNum,int endNum)throws Exception{
		String sql="select * from "
				+ "(select row_number() over(order by seq desc) rnum,course_area,course_name,address1,postcode,oriName from course) "
				+ "where rnum between ? and ?";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			try(ResultSet rs=pstat.executeQuery();){
				List<CosDTO> list = new ArrayList<>();
				while(rs.next()) {
					String course_area = rs.getString("course_area");
					String course_name = rs.getString("course_name");
					String address1 = rs.getString("address1");
					String postcode = rs.getString("postcode");
					String oriName= rs.getString("oriName");
					list.add(new CosDTO(0,course_area,course_name,address1,postcode,oriName,null,null,null,null));
				}
				return list;
			}
		}
	}
	
	public List<CosDTO> getPageList(int startNum,int endNum,String keyword)throws Exception{
		String sql="select * from "
				+ "(select row_number() over(order by seq asc) rnum,course_area,course_name,address1,postcode,oriName from course where course_area like ? or course_name like ? or address1 like ? ) "
				+ "where rnum between ? and ?";
		try(Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, "%"+keyword+"%");
			pstat.setString(2, "%"+keyword+"%");
			pstat.setString(3, "%"+keyword+"%");
			pstat.setInt(4, startNum);
			pstat.setInt(5, endNum);
			try(ResultSet rs=pstat.executeQuery();){
				List<CosDTO> list = new ArrayList<>();
				while(rs.next()) {
					String course_area = rs.getString("course_area");
					String course_name = rs.getString("course_name");
					String address1 = rs.getString("address1");
					String postcode = rs.getString("postcode");
					String oriName= rs.getString("oriName");
					list.add(new CosDTO(0,course_area,course_name,address1,postcode,oriName,null,null,null,null));
				}
				return list;
			}
		}
	}
	
	private int getRecordCount() throws Exception {
		String sql = "select count(*) from course";
		try (Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			
			rs.next();
			return rs.getInt(1);
			
		}
	}
	
	private int getRecordCount(String keyword) throws Exception {
		String sql = "select count(*) from course where course_area like ? or course_name like ? or address1 like ?";
		try (Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, "%"+keyword+"%");
			pstat.setString(2, "%"+keyword+"%");
			pstat.setString(3, "%"+keyword+"%");
			try(ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
			}
		}
	}
	
	public List<String> getPageNavi(int currentPage,String keyword)throws Exception{
		int recordTotalCount =0;
		
		if(keyword==null) {
			recordTotalCount = this.getRecordCount();
		}else {
			recordTotalCount = this.getRecordCount(keyword);
		}
		
		
		
		int recordCountPerpage = 10; // 한 페이지당 보여줄 게시글의 개수
		int naviCountPerPage =10; // 내 위치 페이지를 기준으로 시작부터 끝까지의 페이지가 총 몇개인지. 
		
		int pageTotalCount = 0;
		if(recordTotalCount%recordCountPerpage>0) {   // 총 몇개의 페이지로 구분되는지   
			pageTotalCount = recordTotalCount / recordCountPerpage + 1 ;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerpage ;
		}
		
		//int currentPage; // 현재 위치하고있는 페이지 번호 ( 3페이지인지, 13페이지인지)
		
		if(currentPage > pageTotalCount) {
			currentPage= pageTotalCount;
		}else if(currentPage <1) {
			currentPage=1;
		}
		
		
		int startNavi = (currentPage-1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage -1);
		if(endNavi > pageTotalCount) {endNavi = pageTotalCount;}
		
		boolean needPrev =true;
		boolean needNext = true;
		
		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}
		
		List<String> pageNavi = new ArrayList<>();
		if(needPrev) {pageNavi.add("<");}
		
		for(int i= startNavi; i<=endNavi;i++) {
			pageNavi.add(String.valueOf(i));
		}
		if(needNext) {pageNavi.add(">");}
		return pageNavi;
	}
	
	//관리자 기능
	
	
	public int delete(String course_name)throws Exception {
		String sql ="delete from course where course_name = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1,course_name);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public String getSysName(String course_name) throws Exception{
		String sql ="select sysName from course where course_name=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, course_name);
			try(ResultSet rs = pstat.executeQuery()){
				if(rs.next()) {
				return rs.getString("sysName");
			}
			}	
		}
		return null;
	}
	public int update(CosDTO dto) throws Exception{
		String sql="update course set course_area=?, course_name=?, address1=?, postcode=?, oriName=?,sysName=?, explain=?, ex_time=?, ex_way=? where seq=?";
		try(
				Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getCourse_area());
			pstat.setString(2, dto.getCourse_name());
			pstat.setString(3, dto.getAddress1());
			pstat.setString(4, dto.getPostcode());
			pstat.setString(5, dto.getOriName());
			pstat.setString(6, dto.getSysName());
			pstat.setString(7, dto.getExplain());
			pstat.setString(8, dto.getEx_time());
			pstat.setString(9, dto.getEx_way());
			pstat.setInt(10, dto.getSeq());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	
	
}
