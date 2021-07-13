package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BlackListDTO;
import dto.PersonDTO;

public class BlackListDAO {

	private static BlackListDAO instance = null;

	public synchronized static BlackListDAO getInstance(){		
		if(instance==null) {
			instance = new BlackListDAO();
		}
		return instance; //싱글톤 적용
	}

	private BlackListDAO() {}
	private Connection getConnection()throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}




	public int blackListin(BlackListDTO dto) throws Exception {
		String sql = "insert into black_list values(black_List_seq.nextval,?,?,?,?,?,sysdate)";

		try(Connection con =this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			pstat.setString(1,dto.getId());
			pstat.setString(2,dto.getName());
			pstat.setNString(3, dto.getEmail());
			pstat.setString(4,dto.getContact());
			pstat.setString(5,dto.getBlock_reason());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}



	}

	public List <BlackListDTO> BlackListShow() throws Exception{
		String sql = "select * from black_List" ;
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			try(ResultSet rs = pstat.executeQuery()){
				List <BlackListDTO> Blacklist = new ArrayList<>();

				while(rs.next()){
					int seq = rs.getInt("seq");
					String id = rs.getNString("id");
					String name = rs.getNString("name");
					String email = rs.getNString("email");
					String contact=rs.getNString("contact");
					String block_reason=rs.getNString("block_reason");
					Date block_date = rs.getDate("block_date");

					Blacklist.add(new BlackListDTO(0,id,name,email,contact,block_reason,block_date));
				}
				return Blacklist;
			}

		}
	}




}
