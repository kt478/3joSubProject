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

import dao.BlackListDAO;
import dao.DogDAO;
import dao.PersonDAO;
import dto.BlackListDTO;
import dto.DogDTO;
import dto.PersonDTO;

@WebServlet("*.mem")
public class PersonController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset =utf-8");
		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();

		String url = requestURI.substring(ctxPath.length());
		System.out.println("요청 URL : " +url);
		//	      System.out.println("getInstance완료");

		try { 
			PersonDTO dto = new PersonDTO();
			PersonDAO dao = PersonDAO.getInstance();
			DogDTO ddto = new DogDTO();
			DogDAO ddao = DogDAO.getInstance();	
			BlackListDAO Bdao = BlackListDAO.getInstance();
			BlackListDTO Bdto = new BlackListDTO();
			//회원가입 정보 DB등록
			if(url.contentEquals("/Signup/signup.mem")) {
				System.out.println("signup Arrival");
				String filesPath = request.getServletContext().getRealPath("person_img");
				System.out.println(filesPath);
				File filesFolder= new File(filesPath); //파일 객체를 통해서 파일의 이름 사이즈 폴더생성가능
				int maxSize = 1024*1024*20;
				if(!filesFolder.exists()) filesFolder.mkdir(); 
				MultipartRequest multi = new MultipartRequest(request,filesPath,maxSize,"utf8",new DefaultFileRenamePolicy()); 

				String id=multi.getParameter("id");
				String pw=dao.getSHA512(multi.getParameter("pw"));
				String email =multi.getParameter("email");
				String name=multi.getParameter("name");
				String person_age=multi.getParameter("person_age");
				String gender=multi.getParameter("person_gender");
				String contact=multi.getParameter("contact");
				String oriName = multi.getOriginalFileName("profile");
				String sysName = multi.getFilesystemName("profile");
				String local=multi.getParameter("local");
				System.out.println("원본파일 이름 : "+oriName);
				System.out.println("원본파일 이름 : "+sysName);

				int result =  dao.signup(new PersonDTO(id,pw,name,email,person_age,gender,local,contact,oriName,sysName,null));


				response.sendRedirect("login.jsp");

			
			}
		
			else if(url.contentEquals("/block_member.mem")) {
				//회원 블랙리스트 지정 
				System.out.println("회원 블랙리스트 입장");
				String id = request.getParameter("id");
				System.out.println(id);
				
				String name = request.getParameter("name");
				System.out.println(name);
				String contact =request.getParameter("contact");
				System.out.println(contact);
				
				String email =request.getParameter("email");
				System.out.println(email);
				
				String block_reason =request.getParameter("block_reason");
				System.out.println(block_reason);
				
				int result = Bdao.blackListin(new BlackListDTO(0,id,name,email,contact,block_reason,null));
				int result2 = dao.MemberOut(id);
				System.out.println("회원 블랙리스트 등록완료");
			
				response.sendRedirect("admain.ad");

			//회원가입 폼으로 이동!

			}else if(url.contentEquals("/signupgo.mem")) { 
				response.sendRedirect("Signup/signupView.jsp");


			}
			//로그인 폼으로 이동!
			else if(url.contentEquals("/logingo.mem")) {
				response.sendRedirect("Signup/login.jsp");




			}
			//아이디 비밀번호로 로그인!
			else if(url.contentEquals("/login.mem")) { 
				System.out.println("로그인절차실행");

				String id = request.getParameter("id");
				System.out.println(id);
				String pw = dao.getSHA512(request.getParameter("pw"));
				System.out.println(pw);
				dto = dao.login(id,pw);
				System.out.println(dto);

				if(dto!=null) {
					System.out.println("dto가 null이 아닐때");

					request.getSession().setAttribute("login",dto);


					request.getSession().setAttribute("login",dto);
					response.getWriter().append("1");
				}else {
					System.out.println("dto가 null일때");
					response.getWriter().append("null");
				}

			}//가입간 아이디 중복 체크!
			else if(url.contentEquals("/idCheck.mem")) {

				String id = request.getParameter("id");
				boolean result = dao.isIdExist(id);

				response.getWriter().append(String.valueOf(result));


			}//로그아웃 !
			else if(url.contentEquals("/logout.mem")) {
				request.getSession().invalidate();//내 세션에 모든 값들을 무효화시켜라.
				response.sendRedirect("main.jsp");

			}//마이페이지로 이동!
			else if(url.contentEquals("/Mypage.mem")) {
				PersonDTO sessionDTO= (PersonDTO)request.getSession().getAttribute("login");
				System.out.println("마이페이지로 이동");
				
				PersonDTO person_img =dao.onefilesById(sessionDTO.getId());
				System.out.println(person_img.getPerson_oriName());
				
				DogDTO dog_list = ddao.OwnDogList(sessionDTO.getId());
				DogDTO dog_img = ddao.filesById(sessionDTO.getId());
				
				request.setAttribute("person_img",person_img); //이미지뽑기
				
				request.setAttribute("dog_list",dog_list);//개정보
				request.setAttribute("dog_img", dog_img);
				request.getRequestDispatcher("Mypage/mypagefin.jsp").forward(request,response);
			}
			//홈으로 !
			else if(url.contentEquals("/Direct2home.mem")) {

				response.sendRedirect("main.jsp");

			}//회원정보 수정으로 진입!
			else if(url.contentEquals("/modify.mem")) {

				PersonDTO sessionDTO= (PersonDTO)request.getSession().getAttribute("login");
				List<PersonDTO> list = dao.memberList(sessionDTO.getId());

				request.setAttribute("list",list);
				request.getRequestDispatcher("Signup/infomodify.jsp").forward(request,response);

			}//회원 수정 절차!
			else if(url.contentEquals("/infomodifyPro.mem")) {
				PersonDTO sessionDTO = (PersonDTO)request.getSession().getAttribute("login");
				String filesPath = request.getServletContext().getRealPath("person_img");
				System.out.println(filesPath);
				File filesFolder= new File(filesPath); //파일 객체를 통해서 파일의 이름 사이즈 폴더생성가능
				int maxSize = 1024*1024*20;
				if(!filesFolder.exists()) filesFolder.mkdir();
				MultipartRequest multi = new MultipartRequest(request,filesPath,maxSize,"utf8",new DefaultFileRenamePolicy());

				String pw=dao.getSHA512(multi.getParameter("pw"));
				System.out.println(pw);
				String email =multi.getParameter("email");
				System.out.println(email);
				String person_name=multi.getParameter("person_name");
				System.out.println(person_name);
				String person_age=multi.getParameter("person_age");
				System.out.println(person_age);
				String person_gender=multi.getParameter("person_gender");
				System.out.println(person_gender);
				String local=multi.getParameter("local");
				System.out.println(local);
				String contact=multi.getParameter("contact");
				System.out.println(contact);
				String person_oriName = multi.getOriginalFileName("profile");
				String person_sysName = multi.getFilesystemName("profile");
				System.out.println("원본파일 이름 : "+person_oriName);
				System.out.println("원본파일 이름 : "+person_sysName);
				String id = sessionDTO.getId();
				System.out.println(id);
				int result =  dao.infomodify(new PersonDTO(id,pw,person_name,email,person_age,person_gender,local,contact,person_sysName,person_oriName,null));
				System.out.println(result);
				System.out.println("수정완료");
				response.sendRedirect("Mypage.mem");

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
