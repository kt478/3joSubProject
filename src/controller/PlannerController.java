package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.CosDAO;
import dao.DogDAO;
import dao.PersonDAO;
import dao.PlannerDAO;
import dto.CosDTO;
import dto.DogDTO;
import dto.PersonDTO;
import dto.PlannerDTO;

@WebServlet("*.planner")
public class PlannerController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         request.setCharacterEncoding("utf-8");

         String requestURI = request.getRequestURI(); // 프로젝트명 + 파일명,주소명
         String ctxPath = request.getContextPath(); // 프로젝트명
         String url = requestURI.substring(ctxPath.length()); // (프로젝트명 + 파일명,주소명) - 프로젝트명 = 파일명, 주소명 
         System.out.println(url);
         
         try {
            PersonDAO mdao = PersonDAO.getInstance();
            PlannerDAO Pdao = PlannerDAO.getInstance();
            CosDAO cdao = CosDAO.getInstance();
            DogDAO ddao = DogDAO.getInstance();
            
            if(url.contentEquals("/history.planner")) { // 히스토리가지고 이동
               PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
               
               List<PlannerDTO> history = Pdao.history(dto.getId()); 
               if(history != null) {
                  request.setAttribute("history", history); // 히스토리
                  request.getRequestDispatcher("Mypage/walkPlanner.jsp").forward(request, response);
               }else {
                  response.sendRedirect("Mypage/walkPlanner.jsp");
               }
            }else if(url.contentEquals("/p_info.planner")) { // 히스토리 사람정보
               String other_id = request.getParameter("otherId");
               
               PersonDTO person = mdao.information(other_id); // 이름, 나이, 성별
               
               response.setContentType("text/html;charset=utf-8");
               Gson g = new Gson();
               
               String result = g.toJson(person);
               response.getWriter().append(result); 

            }else if(url.contentEquals("/d_info.planner")) { // 히스토리 강아지정보
               String other_id = request.getParameter("otherId");
               
               DogDTO dog = ddao.information(other_id);
               
               response.setContentType("text/html;charset=utf-8");
               Gson g = new Gson();
               
               String result = g.toJson(dog); 
               response.getWriter().append(result); 
               
            }else if(url.contentEquals("/add.planner")) { // 혼자 일정추가
               PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
               String id = dto.getId();
               
               String getStart = request.getParameter("start");
               String start_date = getStart.substring(0,10);
                String start_time = getStart.substring(11,16);
               String start =  start_date + " " + start_time;
               
                String getEnd = request.getParameter("end");
                String end_date = getEnd.substring(0,10);
                String end_time = getEnd.substring(11,16);
                String end = end_date + " " + end_time;
             
                String local = request.getParameter("local");
                String place_name = request.getParameter("place_name");

                String pet_feature = ddao.getFeature(id);

                CosDTO cdto = cdao.getAllAddress(place_name);
                
                PlannerDTO Pdto = new PlannerDTO(0, id, pet_feature, local, place_name, start, end, 
                      cdto.getPostcode(), cdto.getAddress1(), null, null);

                int result = Pdao.aloneAddPlan(Pdto);
                
                response.setContentType("text/html;charset=utf-8");
               if(result>0) {
                  response.getWriter().append("1");
               }else {
                  response.getWriter().append("0");
               }
               
            }else if(url.contentEquals("/update.planner")) { // 일정수정
               int seq = Integer.parseInt(request.getParameter("seq"));
               String title = request.getParameter("title");
               String start = request.getParameter("start");
               String end = request.getParameter("end");

               System.out.println(seq + ", " + title + ", " + start + ", " + end);
               
               int result = Pdao.update(seq, start, end);
               if(result>0) {
                  response.getWriter().append("1");
               }
            }else if(url.contentEquals("/delete.planner")) { // 일정수정
               int seq = Integer.parseInt(request.getParameter("seq"));
               
               System.out.println(seq);
               
               int result = Pdao.delete(seq);
               if(result>0) {
                  response.getWriter().append("1");
               }
            }
         }catch(Exception e) {
            
         }
      }


   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}