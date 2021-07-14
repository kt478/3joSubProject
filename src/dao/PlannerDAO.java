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
import dto.PlannerDTO;
import dto.CosDTO;

public class PlannerDAO {
	private static PlannerDAO instance;
	
	private PlannerDAO() {}
	
	public synchronized static PlannerDAO getInstance() {
		if(instance==null) {
			instance = new PlannerDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insert(PetBoardDTO pbdto, String other_id, CosDTO wpdto) throws Exception {
		String sql = "insert into planner values (planner_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, pbdto.getId());
			System.out.println(pbdto.getId());
			pstat.setNString(2, pbdto.getPet_feature());
			System.out.println(pbdto.getPet_feature());
			pstat.setNString(3, pbdto.getLocal());
			System.out.println(pbdto.getLocal());
			pstat.setNString(4, pbdto.getPlace_name());
			System.out.println(pbdto.getPlace_name());
			pstat.setNString(5, pbdto.getStart_date());
			System.out.println(pbdto.getStart_date());
			pstat.setNString(6, pbdto.getEnd_date());
			pstat.setNString(7, wpdto.getPostcode());
			pstat.setNString(8, wpdto.getAddress1());
			pstat.setNString(9, pbdto.getCategory());
			pstat.setNString(10, other_id);

			int result = pstat.executeUpdate();
			
			con.commit();
			
			return result;
		}
	}
	
	public int aloneAddPlan(PlannerDTO dto) throws Exception { // 혼자산책하는 일정 추가
		String sql = "insert into planner values (planner_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, dto.getPerson_id());
			pstat.setNString(2, dto.getPet_feature());
			pstat.setNString(3, dto.getLocal());
			pstat.setNString(4, dto.getPlace_name());
			pstat.setNString(5, dto.getStart());
			pstat.setNString(6, dto.getEnd());
			pstat.setNString(7, dto.getPostcode());
			pstat.setNString(8, dto.getAddress1());
			pstat.setNString(9, null);
			pstat.setNString(10, null);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<PlannerDTO> calendarlist(String local) throws Exception { // 같은 자치구 일정 출력
		String sql = "select * from planner where local=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, local);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<PlannerDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					PlannerDTO dto = new PlannerDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setPerson_id(rs.getString("person_id"));
					dto.setPet_feature(rs.getNString("pet_feature"));
					dto.setLocal(rs.getNString("local")); //자치구
					dto.setPlace_name(rs.getString("place_name"));
					dto.setStart(rs.getString("start_date"));
					dto.setEnd(rs.getString("end_date"));
					dto.setPostcode(rs.getNString("postcode"));
					dto.setAddress1(rs.getNString("address1"));
					dto.setCategory(rs.getNString("category"));
					dto.setOther_id(rs.getNString("other_id"));
					
					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public List<PlannerDTO> history(String id) throws Exception { // 산책히스토리 출력
		String sql = "select * from planner where person_id like ? or other_id like ? order by 5 desc";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, id);
			pstat.setNString(2, id);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<PlannerDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					PlannerDTO dto = new PlannerDTO();
					
					dto.setSeq(rs.getInt("seq"));
					dto.setPerson_id(rs.getString("person_id"));
					dto.setLocal(rs.getNString("local")); //자치구
					dto.setPlace_name(rs.getString("place_name"));
					dto.setStart(rs.getString("start_date"));
					dto.setEnd(rs.getString("end_date"));
					dto.setPostcode(rs.getNString("postcode"));
					dto.setAddress1(rs.getNString("address1"));
					dto.setCategory(rs.getNString("category"));
					dto.setOther_id(rs.getNString("other_id"));
					
					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public int update(int seq, String start, String end) throws Exception {
		String sql = "update planner set start_date=?, end_date=? where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setNString(1, start);
			pstat.setNString(2, end);
			pstat.setInt(3, seq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int delete (int seq) throws Exception {
		String sql = "delete from planner where seq=?";
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
