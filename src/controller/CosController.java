package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.SearchMapConfig;
import dao.CosDAO;
import dao.DogDAO;
import dao.MapDAO;
import dao.PlannerDAO;
import dto.CosDTO;
import dto.MapDTO;
import dto.PersonDTO;
import dto.PlannerDTO;

@WebServlet("*.cos")
public class CosController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // post방식일때는 한글이 안깨짐 / get방식은 깨짐 
		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd =requestURI.substring(ctxPath.length());
		System.out.println("요청 된 명령"+cmd);
		
		try {
			CosDAO dao = CosDAO.getInstance();
			MapDAO mdao = MapDAO.getInstance();
			DogDAO ddao = DogDAO.getInstance();
			PlannerDAO Pdao = PlannerDAO.getInstance();
			
			request.setCharacterEncoding("utf8");
			if(cmd.contentEquals("/getCourse.cos")) {
				String course_name = request.getParameter("course_name");
				System.out.println("코스이름은 : "+course_name);
				
				if(course_name!=null) {
					CosDTO searchList = dao.getSearchList(course_name);
					List<CosDTO> clist = dao.getCosList(searchList.getCourse_area());
					MapDTO mlist = mdao.setAll(searchList.getCourse_area());
					request.setAttribute("searchList", searchList);
					request.setAttribute("mlist", mlist);
					request.setAttribute("clist", clist);
					
				}else {
					String course_area = request.getParameter("course_area");
					System.out.println("자치구는 : "+course_area);
					List<CosDTO> clist = dao.getCosList(course_area);
					MapDTO mlist = mdao.setAll(course_area);
					
					System.out.println(clist);
					request.setAttribute("mlist", mlist);
					request.setAttribute("clist", clist);
					
				}
				request.getRequestDispatcher("map/map.jsp").forward(request, response);
				
			}else if(cmd.contentEquals("/search.cos")) {
				int cpage = Integer.parseInt(request.getParameter("cpage"));
				String keyWord = request.getParameter("keyWord");
				
				
				int endNum=cpage*SearchMapConfig.RECORD_COUNT_PER_PAGE;
				int startNum =endNum -(SearchMapConfig.RECORD_COUNT_PER_PAGE-1);
				
				
				List<CosDTO> list;
				list = dao.getPageList(startNum,endNum,keyWord);
				List<String> pageNavi = dao.getPageNavi(cpage,keyWord);
				System.out.println(list);
				
				int listSize = list.size();
				if(listSize ==0) {System.out.println("aaaaa");}
				request.setAttribute("listSize", listSize);
				request.setAttribute("cpage", cpage);
				request.setAttribute("keyWord", keyWord);
				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.getRequestDispatcher("map/searchView.jsp").forward(request, response);

				

				


			}else if(cmd.contentEquals("/exam.cos")) {
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				String id = dto.getId();
				
				String getStart = request.getParameter("start_date");
				String start_date = getStart.substring(0,10);
    			String start_time = getStart.substring(11,16);
				String start =  start_date + " " + start_time;
				
				String getEnd = request.getParameter("end_date");
				String end_date = getEnd.substring(0,10);
    			String end_time = getEnd.substring(11,16);
    			String end = end_date + " " + end_time;
			
				String local = request.getParameter("local");
				String place_name = request.getParameter("place_name");
				
				String postcode = request.getParameter("postcode");
				String address1 = request.getParameter("address1");

				System.out.println(start + " : " + end);
				System.out.println(local + " : " + place_name);
				System.out.println(postcode + " : " + address1);
				
				  String pet_feature = ddao.getFeature(id);
				  
				  CosDTO wdto = dao.getAllAddress(place_name);
				  
				  PlannerDTO Pdto = new PlannerDTO(0, id, pet_feature, local, place_name,
						  start, end, wdto.getPostcode(), wdto.getAddress1(), null, null);
				  
				  int result = Pdao.aloneAddPlan(Pdto);
				  
				  response.setContentType("text/html;charset=utf-8");
				  if(result>0) {
					  response.getWriter().append("1");
				  }else {
					  response.getWriter().append("0");
				  }



			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
