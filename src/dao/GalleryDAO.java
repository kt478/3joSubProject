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

import config.GalleryConfig;
import dto.GalleryDTO;

public class GalleryDAO {

	private static GalleryDAO instance = null;

	public synchronized static GalleryDAO getInstance() {
		
		if (instance == null) {
			instance = new GalleryDAO();
		}
		return instance;
	}

	private GalleryDAO() {}

	private Connection getConnection() throws Exception {

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();

	}
	
	public int galWrite(int seq, String title, String contents, String id) throws Exception {

		String sql = "insert into gallery values(?,?,?,?,sysdate,0)";
		
		try (Connection con = this.getConnection(); 
			PreparedStatement pstat = con.prepareStatement(sql);) 
		   {
			
			pstat.setInt(1, seq);
			pstat.setString(2, title);
			pstat.setString(3, contents);
			pstat.setString(4, id);
						
			int result = pstat.executeUpdate();
			con.commit();
			return result;

		}

	}
	
	
	public List<GalleryDTO> selectAll() throws Exception {

		String sql = "select * from gallery order by seq desc";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {

			List<GalleryDTO> list = new ArrayList<>();
			while (rs.next()) {
				
				int seq = rs.getInt("seq");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				String writer = rs.getString("writer");
				Date write_date = rs.getDate("write_date");
				int view_count = rs.getInt("view_count");
				GalleryDTO dto = new GalleryDTO(seq,title,contents, writer, write_date, view_count);
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
	 
	 
	 public GalleryDTO search(int seq) throws Exception{
			String sql = "select * from gallery where seq = ?  " ;
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setInt(1, seq);
				try(ResultSet rs = pstat.executeQuery();){

						if(rs.next()) {
						
						GalleryDTO dto = new GalleryDTO();
						
						dto.setSeq(rs.getInt("seq"));
						dto.setTitle(rs.getString("title"));
						dto.setContents(rs.getString("contents"));
						dto.setWriter(rs.getString("writer"));
						dto.setWrite_date(rs.getDate("write_date"));
						dto.setView_count(rs.getInt("view_count"));
						

						return dto;
						}
				
					
				}
			}
			return null;
		}
	 
	 
	 public int update(int seq, String title, String contents) throws Exception {

			String sql = "update gallery set title= ?, contents = ? where seq = ?";
			try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
				
				
				pstat.setString(1, title);
				pstat.setString(2, contents);
				pstat.setInt(3, seq);

				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}

		}
	 
	 public int delete(int seq) throws Exception{
			String sql = "delete from gallery where seq=?";
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
	 
	 public List<GalleryDTO> getPageList(int startNum,int endNum)throws Exception{
			String sql = "select * from " + 
					"(select " + 
					"    row_number() over(order by seq desc) rnum," + 
					"    seq," + 
					"    title," + 
					"    writer," + 
					"    write_date," + 
					"    view_count" + 
					"    from gallery) where rnum between ? and ? ";  
			try (Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					) {
				pstat.setInt(1, startNum);
				pstat.setInt(2, endNum);
				
				
				try(ResultSet rs = pstat.executeQuery();){
				List<GalleryDTO> list = new ArrayList<GalleryDTO>();
					while (rs.next()) {
					
						GalleryDTO dto = new GalleryDTO();
						
						dto.setSeq(rs.getInt("seq"));
						dto.setTitle(rs.getString("title"));
						dto.setWriter(rs.getString("writer"));
						dto.setWrite_date(rs.getDate("write_date"));
						dto.setView_count(rs.getInt("view_count"));
						list.add(dto);
						
					}
					return list;
				}
			}
		}
	 
	 
	 public List<GalleryDTO> getPageList(int startNum,int endNum,String category,String keyword)throws Exception{
			String sql = "select * from " + 
					"(select " + 
					"    row_number() over(order by seq desc) rnum," + 
					"    seq, " +  
					"    title, " + 
					"    writer, " + 
					"    write_date, " + 
					"    view_count " + 
					"    from gallery where " +category+ " like ?) where rnum between ? and ? ";  
			try (Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					) {
				pstat.setString(1, "%"+keyword+"%");
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);
				
				
				try(ResultSet rs = pstat.executeQuery();){
				List<GalleryDTO> list = new ArrayList<GalleryDTO>();
					while (rs.next()) {
					
						GalleryDTO dto = new GalleryDTO();
						
						dto.setSeq(rs.getInt("seq"));
						dto.setTitle(rs.getString("title"));
						dto.setWriter(rs.getString("writer"));
						dto.setWrite_date(rs.getDate("write_date"));
						dto.setView_count(rs.getInt("view_count"));
						list.add(dto);
						
					}
					return list;
				}
			}
		}
	 
	 
	 
	 
	 	private int getRecordCount()throws Exception {
			
			String sql ="select count(*)from gallery";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	 	
	 	private int getRecordCount(String category,String keyword)throws Exception {
			
			String sql ="select count(*) from gallery where "+category+" like ?";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, "%"+keyword+"%");
				try(ResultSet rs = pstat.executeQuery();){
				
				
				rs.next();
				return rs.getInt(1);
				}
			}
		}
		
		public List<String> getPageNavi(int currentPage,String category,String keyword)throws Exception{
			   
			  int recordTotalCount = 0; 
			  recordTotalCount =this.getRecordCount(); // record ??? ?????? ????????????(????????????) / record??? ??????(??????)
			
			  if(keyword == null) {
					 recordTotalCount =this.getRecordCount(); // record ??? ?????? ????????????(????????????) / record??? ??????(??????)
				 }else {
					 
					 recordTotalCount =this.getRecordCount(category,keyword);
				 }
		     
		      int recordCountPerpage = GalleryConfig.RECORD_COUNT_PER_PAGE; // ??? ???????????? ????????? ???????????? ??????
		      int naviCountPerPage = GalleryConfig.NAVI_COUNT_PER_PAGE; // ??? ?????? ???????????? ???????????? ???????????? ???????????? ???????????? ??? ????????????. 
		      
		      int pageTotalCount = 0;
		      if(recordTotalCount%recordCountPerpage>0) {   // ??? ????????? ???????????? ???????????????   
		         pageTotalCount = recordTotalCount / recordCountPerpage + 1;
		      }else {
		         pageTotalCount = recordTotalCount / recordCountPerpage ;
		      }
		      
//		      int currentPage = 24; // ?????? ?????????????????? ????????? ?????? ( 3???????????????, 13???????????????)
		      
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
	
}
