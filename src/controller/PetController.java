package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PetBoardDAO;
import dto.PersonDTO;
import dto.PetBoardDTO;


@WebServlet("*.pet")
public class PetController extends HttpServlet {
	
	private String XSSFilter(String target) {
		if(target != null) {
			target = target.replaceAll("<", "&lt;");
			target = target.replaceAll(">", "&gt;");
			target = target.replaceAll("&", "&amp;");
		}
		return target;
	}
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset =utf-8");

		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();

		String cmd = requestURI.substring(ctxPath.length());

		System.out.println("요청 url " + cmd);

		try {
			PetBoardDAO dao = PetBoardDAO.getInstance();

			if(cmd.contentEquals("/petBoardWrite.pet")) {
				System.out.println("글쓰는 화면으로 보내주자 로그인한 회원의 정보를 가지고");
				
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				System.out.println(dto.getId());
				String id = dto.getId();
				PersonDTO info = dao.myinfo(id);

				request.setAttribute("info", info);

				request.getRequestDispatcher("petboard/petBoardWrite.jsp").forward(request, response);

			}else if(cmd.contentEquals("/writeProc.pet")) {
				System.out.println("글쓰기 버튼 눌렀을 때");
				
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				String id = dto.getId(); // 나증에 id는 session으로 받기
				int seq = dao.getSeq(); // seq 매서드
				
				String category = request.getParameter("category");
				String title = XSSFilter(request.getParameter("title"));
				String pet_name = XSSFilter(request.getParameter("pet_name"));
				String pet_breed = request.getParameter("pet_breed");
				String pet_gender = request.getParameter("pet_gender");
				String pet_age = request.getParameter("pet_age");
				String pet_neutering = request.getParameter("pet_neutering");
				String pet_feature = request.getParameter("pet_feature");
				String person_name = request.getParameter("person_name");
				String person_gender = request.getParameter("person_gender");
				String person_age = request.getParameter("person_age");
				String local = request.getParameter("local");
				String place_name = request.getParameter("place_name");

				// 날짜 시간에서 T 빼고 넘기기
				String start = request.getParameter("start_date");
				System.out.println(start);
				String s_date = start.substring(0,10);
				String s_time = start.substring(11,16);
				String start_date = s_date+s_time;
				System.out.println(start_date);
				String end = request.getParameter("end_date");
				String e_date = start.substring(0,10);
				String e_time = start.substring(11,16);
				String end_date = e_date+e_time;

				String contents = XSSFilter(request.getParameter("contents"));
				System.out.println(contents);
				
				System.out.println(local + place_name);
				System.out.println(category+":"+title+":"+pet_name+":"+pet_breed+":"+pet_gender+":"+pet_age+":"+pet_neutering);
				System.out.println(pet_feature);
				System.out.println(id+":"+person_name+":"+person_gender+":"+person_age+":"+local);				
				System.out.println(start_date+"시작"+ end_date+"끝"+ contents); 
				
				if(pet_name.contentEquals("")) {
					dao.insertWrite(new PetBoardDTO(seq,id,person_name,person_gender,person_age,local,place_name,null,
							null,null,null,null,null,start_date,end_date,category,title,contents));
				}else if(id.contentEquals("admin")) {
					System.out.println("안빠지니");
					dao.insertWrite(new PetBoardDTO(seq,id,person_name,person_gender,person_age,null,null,null,
							null,null,null,null,null,"admin","admin",category,title,contents));
				}else {
					dao.insertWrite(new PetBoardDTO(seq,id,person_name,person_gender,person_age,local,place_name,pet_name,
					pet_breed,pet_gender,pet_age,pet_neutering,pet_feature,start_date,end_date,category,title,contents));
				}
				
				
				System.out.println("dao");
				
				response.sendRedirect("petBoardList.pet?cpage=1");
				
			}else if(cmd.contentEquals("/petBoardList.pet")) {
				System.out.println("리스트");
				
				int cpage = Integer.parseInt(request.getParameter("cpage"));
				String search = request.getParameter("search");
				String search2 = XSSFilter(request.getParameter("search2"));
				String keyword = XSSFilter(request.getParameter("keyword"));
				System.out.println(cpage);
				System.out.println(search);
				System.out.println(search2);
				System.out.println(keyword);
				
				int endNum = cpage * 10; 
				int startNum = endNum - 9;
				
				List<PetBoardDTO> list;
				
				if(search==null&&search2==null&&keyword==null) {
					System.out.println("전체");
					list = dao.getPageList(startNum, endNum);
					
					List<String> pageNavi = dao.getPageNavi(cpage, search, search2, keyword);
					
					request.setAttribute("list", list);
					request.setAttribute("navi", pageNavi);

					request.getRequestDispatcher("petboard/petboard.jsp").forward(request, response);
					
				}else if(search.contentEquals("category")&&search2!=null&&keyword!=null) {
					System.out.println("카테고리 선택");
					list = dao.getPageList(startNum, endNum, search2);
					List<String> pageNavi = dao.getPageNavi(cpage, search, search2, keyword);
					request.setAttribute("list", list);
					request.setAttribute("navi", pageNavi);
					request.setAttribute("search", search);
					request.setAttribute("search2", search2);

					request.getRequestDispatcher("petboard/petboard.jsp").forward(request, response);
				}else {
					System.out.println("검색");
					list = dao.getPageList(startNum, endNum, search, keyword);
					List<String> pageNavi = dao.getPageNavi(cpage, search, search2, keyword);
					request.setAttribute("list", list);
					request.setAttribute("navi", pageNavi);
					request.setAttribute("search", search);
					request.setAttribute("keyword", keyword);
					
					request.getRequestDispatcher("petboard/petboard.jsp").forward(request, response);
				}
			
			}else if(cmd.contentEquals("/detailWrite.pet")) {
				System.out.println("게시글 상세페이지");
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.view_count(seq);
				PetBoardDTO dto = dao.searchWrite(seq);
				request.setAttribute("dto", dto);
				
				PersonDTO login = (PersonDTO)request.getSession().getAttribute("login");
				request.setAttribute("login", login);
				
				request.getRequestDispatcher("petboard/detailWrite.jsp").forward(request, response);
				
			}else if(cmd.contentEquals("/deleteProc.pet")) {
				// 글 삭제 controller
				System.out.println("삭제");
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.delete(seq);
				
				response.sendRedirect("petBoardList.pet?cpage=1");
			}else if(cmd.contentEquals("/updateWrite.pet")) {
				System.out.println("수정 할 수 있는 페이지로 보내주기");
				int seq = Integer.parseInt(request.getParameter("seq"));
				PetBoardDTO dto = dao.searchWrite(seq);
				request.setAttribute("dto", dto);
				
				request.getRequestDispatcher("petboard/updateWrite.jsp").forward(request, response);
			}else if(cmd.contentEquals("/updateProc.pet")) {
				System.out.println("수정사항 받은 것");
				
				// 관리자 때문에 넣은 것 
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				String id = dto.getId();
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				System.out.println(seq);
				String category = request.getParameter("category");
				System.out.println(category);
				String title = XSSFilter(request.getParameter("title"));
				System.out.println(title);
				String local = request.getParameter("local");
				System.out.println(local);
				String place_name = request.getParameter("place_name");
				System.out.println(place_name);
				String pet_name = XSSFilter(request.getParameter("pet_name"));
				System.out.println(pet_name);
				String pet_breed = request.getParameter("pet_breed");
				System.out.println(pet_breed);
				String pet_age = request.getParameter("pet_age");
				System.out.println(pet_age);
				String pet_neutering = request.getParameter("pet_neutering");
				System.out.println(pet_neutering);
				String pet_gender = request.getParameter("pet_gender");
				System.out.println(pet_gender);
				String pet_feature = request.getParameter("pet_feature");
				System.out.println(pet_feature);
				
				// 날짜 시간에서 T 빼고 넘기기
				String start = request.getParameter("start_date");
				String s_date = start.substring(0,10);
				String s_time = start.substring(11,16);
				String start_date = s_date+s_time;
				System.out.println(start_date);
				
				String end = request.getParameter("end_date");
				String e_date = start.substring(0,10);
				String e_time = start.substring(11,16);
				String end_date = e_date+e_time;
				System.out.println(end_date);
				String contents = XSSFilter(request.getParameter("contents"));
				System.out.println(contents);
				
				if(pet_name.contentEquals("")) {
					System.out.println("하");
					dao.update(new PetBoardDTO(category,title,local,null,null,null,null,null,null,
							start_date,end_date,place_name,contents,seq));
				}else if(id.contentEquals("admin")){
					dao.update(new PetBoardDTO(category,title,local,null,null,null,null,null,null,
							start_date,end_date,null,contents,seq));
				}else {
					System.out.println("히히");
					dao.update(new PetBoardDTO(category,title,local,pet_name,pet_breed,pet_age,pet_neutering,pet_gender,
						pet_feature,start_date,end_date,place_name,contents,seq));
					
					System.out.println("glgl");
				}
				
				request.setAttribute("seq", seq);
				request.getRequestDispatcher("detailWrite.pet").forward(request, response);
			}
			// 관리자부분
			else if(cmd.contentEquals("/adminPetWrite.pet")){
				System.out.println("공지사항 글쓰기");
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				System.out.println(dto.getId());
				String id = dto.getId();
				PersonDTO info = dao.myinfo(id);

				request.setAttribute("info", info);

				request.getRequestDispatcher("petboard/adminPetWrite.jsp").forward(request, response);
			}else if(cmd.contentEquals("/adminUpdateWrite.pet")) {
				System.out.println("gg");
				int seq = Integer.parseInt(request.getParameter("seq"));
				PetBoardDTO dto = dao.searchWrite(seq);
				request.setAttribute("dto", dto);
				
				request.getRequestDispatcher("petboard/adminUpdateWrite.jsp").forward(request, response);
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
