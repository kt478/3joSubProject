package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MapDTO;

public class MapDAO {
	private static MapDAO instance;
	
	private MapDAO() {}
	
	public synchronized static MapDAO getInstance() {
		if(instance==null) {
			instance = new MapDAO();
		}
		return instance;
	}

	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	} 
	
	public MapDTO setAll(String courseArea) throws Exception {
		String sql="select * from area where area_name=?";
		try(
				Connection con= this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,courseArea);
			try(
					ResultSet rs=pstat.executeQuery();
				){
				if(rs.next()) {
				int seq = rs.getInt("seq");
				String area_name = rs.getString("area_name");
				String lat = rs.getString("lat");
				String lng = rs.getString("lng");
				return new MapDTO(seq,area_name,lat,lng);
				
				}
			}
		}
		return null;
	}
}
