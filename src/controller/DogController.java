package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.DogDAO;
import dto.DogDTO;
import dto.PersonDTO;


@WebServlet("*.dog")
public class DogController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	      response.setCharacterEncoding("utf-8");
	      response.setContentType("text/html; charset =utf-8");
	      String requestURI = request.getRequestURI();
	      String ctxPath = request.getContextPath();
	      
	      String url = requestURI.substring(ctxPath.length());
	      System.out.println("요청 URL : " +url);
	      System.out.println("getInstance완료");
	      try {
	    	  DogDTO dto = new DogDTO();
	    	  DogDAO dao = DogDAO.getInstance();
	    	  
	    	 PersonDTO pdto = new PersonDTO();
	    	 PersonDTO pdo = new PersonDTO();
	    	 
	    	 
	    	  if(url.contentEquals("/doginfo.dog")) {
	    	      System.out.println("강아지 정보수정 입장");
	    	      PersonDTO sessionDTO= (PersonDTO)request.getSession().getAttribute("login");
	    	    System.out.println(sessionDTO.getId());
	    	    
	    	    
	    	    
	    	    
	    	      response.sendRedirect("Signup/doginfo.jsp");
//	    	 
	    	      
	    	      
	    	      }else if(url.contentEquals("/dogregist.dog")) {
	    		  
	  	    	PersonDTO sessionDTO= (PersonDTO)request.getSession().getAttribute("login");
	  	    	
		    	  	String parentid= sessionDTO.getId();
		    	  System.out.println("마이페이지로 이동");
		    	 
		    	  System.out.println("signup Arrival");
		    	  String filesPath = request.getServletContext().getRealPath("files");
		    	  System.out.println(filesPath);
		    		File filesFolder= new File(filesPath); //파일 객체를 통해서 파일의 이름 사이즈 폴더생성가능
					int maxSize = 1024*1024*20;
					if(!filesFolder.exists()) filesFolder.mkdir(); 
					MultipartRequest multi = new MultipartRequest(request,filesPath,maxSize,"utf8",new DefaultFileRenamePolicy()); 
			    	
				dto= new DogDTO();
					
				
				dto.setDog_name(multi.getParameter("dog_name"));
				dto.setDog_breed(multi.getParameter("dog_breed"));
				dto.setDog_gender(multi.getParameter("dog_gender"));
				dto.setDog_feature(multi.getParameter("dog_feature"));
				dto.setDog_age(multi.getParameter("dog_age"));
				dto.setDog_neutering(multi.getParameter("dog_neutering"));
				dto.setDog_sysName(multi.getOriginalFileName("profile"));
				dto.setDog_oriName(multi.getFilesystemName("profile"));
				dto.setDog_parent_id(multi.getParameter("dog_parent_id"));
				String dog_parent_id=(multi.getParameter("dog_parent_id"));
				System.out.println(dog_parent_id);
				int result = dao.dogregist(dto);
				System.out.println("rkddkwl");
				 request.getSession().setAttribute("login",sessionDTO);
		     

				 response.sendRedirect("main.jsp");
		      	 
	    	  }else if(url.contentEquals("/doginfomodify.dog")) {
	    		  System.out.println("강아지정보수정 controller도착");
	    		  PersonDTO sessionDTO= (PersonDTO)request.getSession().getAttribute("login");
	    		  System.out.println(sessionDTO);
	    		  
	    		  DogDTO list = dao.OwnDogList(sessionDTO.getId());
	    		  request.setAttribute("list",list);
	    		  request.getRequestDispatcher("Signup/doginfomodify.jsp").forward(request,response);
	    	    	  
	    	      }else if(url.contentEquals("/doginfomodifyPro.dog")) {
	    	    	  
	  	    	    
	    	    	  PersonDTO sessionDTO = (PersonDTO)request.getSession().getAttribute("login");
	    	    	  String filesPath = request.getServletContext().getRealPath("dog_img");
	    	    	  System.out.println(filesPath);
	    	    		File filesFolder= new File(filesPath); //파일 객체를 통해서 파일의 이름 사이즈 폴더생성가능
	    				int maxSize = 1024*1024*20;
	    				if(!filesFolder.exists()) filesFolder.mkdir(); 
	    				MultipartRequest multi = new MultipartRequest(request,filesPath,maxSize,"utf8",new DefaultFileRenamePolicy()); 
	    				
	    				String dog_name =multi.getParameter("dog_name");
	    				System.out.println(dog_name);
	    				String dog_breed= multi.getParameter("dog_breed");
	    				System.out.println(dog_breed);
	    				String dog_gender =multi.getParameter("dog_gender");
	    				System.out.println(dog_gender);
	    				String dog_feature = multi.getParameter("dog_feature");
	    				System.out.println(dog_feature);
	    				String dog_age = multi.getParameter("dog_age");
	    				System.out.println(dog_age);
	    				String dog_neutering = multi.getParameter("dog_neutering");
	    				System.out.println(dog_neutering);
	    				String oriName = multi.getOriginalFileName("profile");
	    				System.out.println(oriName);
	    				String sysName = multi.getFilesystemName("profile");
	    				System.out.println(sysName);
	    				String dog_parent_id =multi.getParameter("dog_parent_id");
	    				System.out.println(dog_parent_id);
	    				
	    				int result = dao.doginfomodify(new DogDTO(0,dog_name,dog_breed,dog_gender,dog_feature,dog_age,dog_neutering,oriName,sysName,dog_parent_id,null));
//	    				dto.setDog_name(multi.getParameter("dog_name"));
//	    				dto.setDog_breed(multi.getParameter("dog_breed"));
//	    				dto.setDog_gender(multi.getParameter("dog_gender"));
//	    				dto.setDog_feature(multi.getParameter("dog_feature"));
//	    				dto.setDog_age(multi.getParameter("dog_age"));
//	    				dto.setDog_neutering(multi.getParameter("dog_neutering"));
//	    				dto.setDog_sysName(multi.getOriginalFileName("profile"));
//	    				dto.setDog_oriName(multi.getFilesystemName("profile"));
//	    				dto.setDog_parent_id(multi.getParameter("dog_parent_id"));
//	    				
//	    				
//	    				int result = dao.doginfomodify(dto);
	    				
    		    	System.out.println("수정완료");
	    		      	 response.sendRedirect("main.jsp");
	    		      
	    	    	  
	    	    	  
	    	    	  
	    	    	  
	    	    	  
	    	    	  
	    	    	  
	    	      }
	    	    
	    	  
	    	  
	    	  
	    	  
	      }catch(Exception e ) {
	    	  e.printStackTrace();
	    	  response.sendRedirect("error1.jsp");
	      }
	      
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
