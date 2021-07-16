package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.GalleryDTO;
import dto.Gallery_ImgDTO;



public class Gallery_ImgDAO {

	private static Gallery_ImgDAO instance = null;

	public synchronized static Gallery_ImgDAO getInstance() {

		if (instance == null) {
			instance = new Gallery_ImgDAO();
		}
		return instance;
	}

	private Gallery_ImgDAO() {}

	private Connection getConnection() throws Exception {

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();

	}
	public int filesInsert(Gallery_ImgDTO dto)throws Exception{
		String sql= "insert into gallery_img values(gallery_img_seq.nextval,?,?,?)";
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);) 
		{
			pstat.setString(1, dto.getOriName());
			pstat.setString(2, dto.getSysName());
			pstat.setInt(3, dto.getGallery_seq());
			int result = pstat.executeUpdate();

			con.commit(); 
			return result;
		}
	}

	public List<Gallery_ImgDTO> filesBySeq(int gallery_seq) throws Exception {

		String sql = "select * from gallery_img where gallery_seq = ?";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, gallery_seq);
			try(ResultSet rs = pstat.executeQuery()){
				List<Gallery_ImgDTO> list = new ArrayList<>();
				while (rs.next()) {

					int seq = rs.getInt("seq");
					String oriName = rs.getString("oriName");
					String sysName = rs.getString("sysName");
					int gallery_seq_ = rs.getInt("gallery_seq");

					list.add(new Gallery_ImgDTO(seq,oriName,sysName,gallery_seq_));
				}
				return list;
			}
		}
	}
	
	public Gallery_ImgDTO selectThumbBySeq(int seq) throws Exception{
		String sql = "select * from gallery_img where gallery_seq = ? and seq =(select min(seq) from gallery_img where gallery_seq=?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			pstat.setInt(2, seq);

			try(ResultSet rs = pstat.executeQuery();){

				if(rs.next()) {
					Gallery_ImgDTO dto = new Gallery_ImgDTO();

					dto.setSeq(rs.getInt("seq"));
					dto.setOriName(rs.getString("oriName"));
					dto.setSysName(rs.getString("sysName"));

					return dto;
				}
			}
		}
		return null;
	}

	public int fileDelete(int seq)throws Exception {

		String sql = "delete from gallery_img where seq=?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;

		}
	}

	public String getOriName(int seq)throws Exception {
		String sql = "select oriname from gallery_img where gallery_seq = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)	){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getString("oriname");
			}
		}
	}

	public String getSysName(int seq)throws Exception {
		String sql = "select sysname from gallery_img where seq = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)	){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getString("sysname");
			}


		}


	}
	public List<Gallery_ImgDTO> selectAll() throws Exception {

		String sql = "select * from gallery_img order by seq desc";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {

			List<Gallery_ImgDTO> list = new ArrayList<>();
			while (rs.next()) {

				int seq = rs.getInt("seq");
				String oriName = rs.getString("oriName");
				String sysName = rs.getString("sysName");

				Gallery_ImgDTO dto = new Gallery_ImgDTO(seq,oriName,sysName,0);
				list.add(dto);
			}
			return list;
		}

	}
	
	public int getSeq() throws Exception{
		String sql = "select gallery_seq.nextval from dual" ;
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){

			ResultSet rs = pstat.executeQuery();

			rs.next(); 

			return rs.getInt(1);
		}
	}

}
