package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import config.Gallery_ImgConfig;
import dao.GalleryDAO;
import dao.Gallery_ImgDAO;
import dto.GalleryDTO;
import dto.Gallery_ImgDTO;


@WebServlet("*.galImg")
public class Gallery_ImgController extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8"); 
		

		String requestURI = request.getRequestURI();
		
		String ctxPath = request.getContextPath();
		
		
		String url = requestURI.substring(ctxPath.length());
		System.out.println("url : " + url);
		
		
		
		
		
		try {
			
			GalleryDAO dao = GalleryDAO.getInstance();
			GalleryDTO dto = new GalleryDTO();
			
			Gallery_ImgDAO idao = Gallery_ImgDAO.getInstance();
			
			
			if(url.contentEquals("/upload.galImg")) {
//				response.getCharacterEncoding("utf8");
//				response.getContentType("text/html;charset=utf8");
				
				String filesPath = request.getServletContext().getRealPath("files");
				File filesFolder = new File(filesPath);   
				System.out.println(filesPath);
				
				
				if(!filesFolder.exists()) filesFolder.mkdir();
				  
				MultipartRequest multi = new MultipartRequest(request, filesPath , Gallery_ImgConfig.uploadMaxSize,"utf8", new DefaultFileRenamePolicy());
			  
				String oriName = multi.getOriginalFileName("file");
				String sysName = multi.getFilesystemName("file");
				
//				request.getSession().setAttribute("ingFiles", sysName);
				
//				((List)request.getSession().getAttribute("fileList")).add(sysName);
				
				Gallery_ImgDTO idto = new Gallery_ImgDTO(0,oriName, sysName,0);
				
				
				if(oriName!=null) {
					System.out.println("파일 이름" + oriName +"DB에 저장됨.");
					idao.filesInsert(idto);
					
					
				 }
				
				String returnPath = "/files/"+sysName;
				response.getWriter().append(returnPath);
				
				
				
				
			
				
			}else if(url.contentEquals("/resolveFiles.galImg")) {
				
				System.out.println("정리 요청 도착");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("error1.jsp");
		}
		
		
	}

	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		doGet(request, response);
	}

}
