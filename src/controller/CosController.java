package controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	
	private String XSSFilter(String target) {
	      if(target != null) {
	         target = target.replaceAll("<", "&lt;");
	         target = target.replaceAll(">", "&gt;");
	         target = target.replaceAll("&", "&amp;");
	      }
	      return target;
	   }
	
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
				String keyWord = XSSFilter(request.getParameter("keyWord"));
				
				
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
				System.out.println(id);
				
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
			//관리자 기능
				else if(cmd.contentEquals("/input.cos")) {
				
				String directory = request.getServletContext().getRealPath("map/img");
				
				File filesFolder = new File(directory);
				int maxSize = 1024 * 1024 * 10; // 기본단위 바이트  / maxSize = 10메가 바이트
				
				if(!filesFolder.exists()) filesFolder.mkdir();
				MultipartRequest multi = new MultipartRequest(request,directory,maxSize,"utf8",new DefaultFileRenamePolicy());
				
				Enumeration files = multi.getFileNames();
				String str = (String)files.nextElement();
				String lostFileRealName = multi.getFilesystemName(str);//실제 서버에 업로드가 된네임
				
				
				String course_area = multi.getParameter("local");
				String course_name = multi.getParameter("course_name");
				String address1 = multi.getParameter("address1");
				String postcode = multi.getParameter("postcode");
				String explain = multi.getParameter("explain");
				String ex_time = multi.getParameter("ex_time");
				String ex_way = multi.getParameter("ex_way");
		        
		            Set<String> fileNames = multi.getFileNameSet();  // file이 여러개가 있을 수가 있기때문에 for문을 돌려서 일일히 맞는지 확인용도
					for(String fileName : fileNames) {
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						
						if(oriName != null) {
						System.out.println(oriName +" 파 일 에 저 장");
						dao.insert(new CosDTO(0,course_area,course_name,address1,postcode,oriName,sysName,explain,ex_time,ex_way));
						}
					}
					List<CosDTO> list = dao.getAllList();
					for(CosDTO dto : list) {
						System.out.println(dto.getOriName());
					}
					System.out.println(list);
					System.out.println("저장완료");
				
					response.sendRedirect("cosList.cos?cpage=1");
				}else if(cmd.contentEquals("/delete.cos")) {
	
					String directory = request.getServletContext().getRealPath("map/img");
					
					File filesFolder = new File(directory);
					int maxSize = 1024 * 1024 * 10; // 기본단위 바이트  / maxSize = 10메가 바이트
					
					MultipartRequest multi = new MultipartRequest(request,directory,maxSize,"utf8",new DefaultFileRenamePolicy());
					
					String course_name = multi.getParameter("course_name");
					System.out.println("삭제할 : "+course_name);
					
					
							String sysName = dao.getSysName(course_name);
							System.out.println("사진 이름 :"+sysName);
							if(sysName !=null) {
							File targetFile = new File(directory+"/"+sysName);
							boolean result = targetFile.delete(); // 실제 파일지우는 기능
							dao.delete(course_name); 
							}else {
								int result = dao.delete(course_name);
							}
							
							response.sendRedirect("cosList.cos?cpage=1");
					
				}else if(cmd.contentEquals("/cosList.cos")) {
					
					
					int cpage = Integer.parseInt(request.getParameter("cpage"));
					String keyWord = request.getParameter("keyWord");
					
					int endNum=cpage*SearchMapConfig.RECORD_COUNT_PER_PAGE;
					int startNum =endNum -(SearchMapConfig.RECORD_COUNT_PER_PAGE-1);
					
					List<CosDTO> list;
					if(keyWord!=null) {
						list = dao.getPageList(startNum,endNum,keyWord);
						
					}else {
						list = dao.getPageList(startNum,endNum);
					}
					List<String> pageNavi = dao.getPageNavi(cpage,keyWord);
					
					request.setAttribute("cpage", cpage);
					request.setAttribute("keyWord", keyWord);
					request.setAttribute("list", list);
					request.setAttribute("navi", pageNavi);
					request.getRequestDispatcher("map/admin/list.jsp").forward(request, response);
					
					
					
					
					
				}else if(cmd.contentEquals("/detail.cos")) {
					String course_name = request.getParameter("course_name");
					System.out.println(course_name);
					CosDTO list = dao.getSearchList(course_name);
					System.out.println(list);
					request.setAttribute("list", list);
					request.getRequestDispatcher("map/admin/listDetail.jsp").forward(request, response);
				}else if(cmd.contentEquals("/update.cos")) {
					
					String directory = request.getServletContext().getRealPath("map/img");
					
					File filesFolder = new File(directory);
					int maxSize = 1024 * 1024 * 10; // 기본단위 바이트  / maxSize = 10메가 바이트
					
					MultipartRequest multi = new MultipartRequest(request,directory,maxSize,"utf8",new DefaultFileRenamePolicy());
					
					int seq = Integer.parseInt(multi.getParameter("seq"));
					String course_area = multi.getParameter("course_area");
					String course_name = multi.getParameter("course_name");
					String address1 = multi.getParameter("address1");
					String postcode = multi.getParameter("postcode");
					String explain = multi.getParameter("explain");
					String ex_time = multi.getParameter("ex_time");
					String ex_way = multi.getParameter("ex_way");
					
					dao.update(new CosDTO(seq,course_area,course_name,address1,postcode,null,null,explain,ex_time, ex_way));
					
					response.sendRedirect("cosList.cos?cpage=1");
				}else if(cmd.contentEquals("/listSearch.cos")) {
					
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
