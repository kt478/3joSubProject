package controller;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentsDAO;
import dto.CommentsDTO;
import dto.PersonDTO;




@WebServlet("*.coms")
public class CommentsController extends HttpServlet {
	
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); 
		
		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();
		
		String url = requestURI.substring(ctxPath.length());
		System.out.println(url);
		
		try{
		CommentsDAO dao = CommentsDAO.getInstance();
		
		
		if(url.contentEquals("/add.coms")) {
			
			String writer = ((PersonDTO)request.getSession().getAttribute("login")).getId();
			String comments = request.getParameter("comments");
			String gallery_seq = request.getParameter("gallery_seq");
			
			
			
			
			CommentsDTO dto = new CommentsDTO(0,writer,comments,null,Integer.parseInt(gallery_seq));
			
			dao.insert(dto);			
		
			
			response.sendRedirect("galDetail.gal?seq="+gallery_seq);
			
			
		}else if(url.contentEquals("/delete.coms")) {
				
			int seq = Integer.parseInt(request.getParameter("seq"));
			dao.delete(seq);
			
			int gallery_seq = Integer.parseInt(request.getParameter("gallery_seq"));
			response.sendRedirect("galDetail.gal?seq=" + gallery_seq);
			
			
			
		}else if(url.contentEquals("/update.coms")) {
			
			System.out.println("여기로와?");
			int seq = Integer.parseInt(request.getParameter("seq"));
			System.out.println(seq);
			String comment = request.getParameter("comments");
			int result = dao.update(seq, comment);
			
			int gallery_seq = Integer.parseInt(request.getParameter("gallery_seq"));
			response.sendRedirect("galDetail.gal?seq=" + gallery_seq);
			
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
