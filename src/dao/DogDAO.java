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

import dto.DogDTO;
import dto.PersonDTO;

public class DogDAO {
	private static DogDAO instance = null;
	


		public synchronized static DogDAO getInstance(){		
			if(instance==null) {
				instance = new DogDAO();
			}
			return instance; //싱글톤 적용
		}
	
		private DogDAO() {}
		private Connection getConnection()throws Exception {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
			return ds.getConnection();
		}

		public int dogregist(DogDTO dto)throws Exception {
			String sql ="insert into dog_info values(dog_info_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate)";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setNString(1,dto.getDog_name());
				pstat.setNString(2, dto.getDog_breed());
				pstat.setNString(3, dto.getDog_gender());
				pstat.setNString(4,dto.getDog_feature());
				pstat.setNString(5, dto.getDog_age());
				pstat.setNString(6, dto.getDog_neutering());
				pstat.setNString(7, dto.getDog_sysName());
				pstat.setNString(8, dto.getDog_oriName());
				pstat.setString(9, dto.getDog_parent_id());
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
		}

		public DogDTO OwnDogList(String sessionid)throws Exception{
			String sql = "select * from dog_info where dog_parent_id=? order by seq desc ";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){pstat.setString(1,sessionid);
					try(ResultSet rs = pstat.executeQuery()){
						
						if(rs.next()) {
							int seq =rs.getInt("seq");
							String dog_name = rs.getNString("dog_name");
							String dog_breed = rs.getNString("dog_breed");
							String dog_gender =rs.getNString("dog_gender");
							String dog_feature = rs.getNString("dog_feature");
							String dog_age =rs.getString("dog_age");
							String dog_neutering=rs.getNString("dog_neutering");
							String dog_oriName = rs.getString("dog_oriName");
							String dog_sysName= rs.getNString("dog_sysName");
							String dog_parent_id=rs.getNString("dog_parent_id");
							Date dog_reg_date =rs.getDate("dog_reg_date");
							
							return new DogDTO(0,dog_name,dog_breed,dog_gender,dog_feature,dog_age,dog_neutering,dog_sysName,dog_oriName,dog_parent_id,null);
						}
						return null;
					}
				}
		}
		
		public int doginfomodify(DogDTO dto)throws Exception {
			
			String sql ="update dog_info set dog_name=?, dog_breed=?, dog_gender=?, "
					+ "dog_feature=? , dog_age=? , dog_neutering=? , dog_sysName=? , "
					+ "dog_oriName=? where dog_parent_id=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setString(1,dto.getDog_name());
				pstat.setNString(2, dto.getDog_breed());
				pstat.setNString(3, dto.getDog_gender());
				pstat.setNString(4, dto.getDog_feature());
				pstat.setNString(5, dto.getDog_age());
				pstat.setNString(6,dto.getDog_neutering());
				pstat.setNString(7,dto.getDog_sysName());
				pstat.setNString(8,dto.getDog_oriName());
				pstat.setNString(9,dto.getDog_parent_id());
			
				
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}		
		}
		
		public DogDTO filesById(String dog_parent_id)throws Exception{
			String sql ="select * from dog_info where dog_parent_id=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setNString(1, dog_parent_id);
				try(ResultSet rs = pstat.executeQuery()){

					if(rs.next()) {
						String dog_parent_id1 = rs.getNString("dog_parent_id");
						String oriName= rs.getNString("dog_oriName");
						String sysName= rs.getNString("dog_sysName");
						
						return new DogDTO(dog_parent_id1,oriName,sysName);
					}
					return null;
				}
			}
		}

		public DogDTO information(String id) throws Exception {
			String sql = "select * from dog_info where dog_parent_id=?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setNString(1, id);
				try(
						ResultSet rs = pstat.executeQuery();
						){
					if(rs.next()) {
						String name = rs.getNString("dog_name");
						String breed = rs.getNString("dog_breed"); //품좀
						String gender = rs.getNString("dog_gender");
						String feature = rs.getNString("dog_feature"); //특징
						String age = rs.getNString("dog_age");
						String neutering = rs.getNString("dog_neutering"); //중성화여부
						String person_id = rs.getNString("dog_parent_id");
						
						return new DogDTO(name, breed, gender, feature, age, neutering, person_id);
					}
					return null;
				}
			}
		}
		
		public String getFeature (String person_id) throws Exception {
			String sql = "select dog_feature from dog_info where dog_parent_id=?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setNString(1, person_id);
				try(
						ResultSet rs = pstat.executeQuery();
						){
					if(rs.next()) {
						return rs.getNString("dog_feature");
					}else {
						return null;
					}
				}
			}
		}
}
