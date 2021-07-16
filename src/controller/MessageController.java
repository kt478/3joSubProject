package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MessageDAO;
import dao.PetBoardDAO;
import dao.PlannerDAO;
import dao.CosDAO;
import dto.PersonDTO;
import dto.MessageDTO;
import dto.PetBoardDTO;
import dto.CosDTO;

@WebServlet("*.message")
public class MessageController extends HttpServlet {
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

		String requestURI = request.getRequestURI(); // 프로젝트명 + 파일명,주소명
		String ctxPath = request.getContextPath(); // 프로젝트명
		String url = requestURI.substring(ctxPath.length()); // (프로젝트명 + 파일명,주소명) - 프로젝트명 = 파일명, 주소명 
		System.out.println(url);
		
		try {
			MessageDAO mdao = MessageDAO.getInstance();
			PetBoardDAO pbdao = PetBoardDAO.getInstance();
			CosDAO wpdao = CosDAO.getInstance();
			PlannerDAO pdao = PlannerDAO.getInstance();
			
			if(url.contentEquals("/mypage/plannerAdd.message")) { // planner에서 쪽지 보내기
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				
				int pb_seq = Integer.parseInt(request.getParameter("pb_seq"));
				String title = XSSFilter(request.getParameter("title"));
				String send_id = dto.getId();		
				String to_id = request.getParameter("to_id");
				String contents = XSSFilter(request.getParameter("contents"));
				System.out.println(pb_seq + " : " + title + " : " + send_id + " : " + to_id + " : " + contents);
				
				int result = mdao.insert(new MessageDTO(pb_seq, title, send_id, to_id, contents));
				if(result>0) {
					response.getWriter().append("1");
				}
			}else if(url.contentEquals("/petboardAdd.message")) { // petboard에서 쪽지 보내기
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				
	            int pb_seq = Integer.parseInt(request.getParameter("pb_seq"));
	            String title = XSSFilter(request.getParameter("title"));

	            String send_id = dto.getId();     
	            String to_id = request.getParameter("to_id");

	            String contents = XSSFilter(request.getParameter("contents"));

	            System.out.println(pb_seq + " : " + title + " : " + send_id + " : " + to_id + " : " + contents);

	            int result = mdao.insert(new MessageDTO(pb_seq, title, send_id, to_id, contents));
	            System.out.println(result);
	            
	            response.sendRedirect("detailWrite.pet?seq="+pb_seq);
				
			}else if(url.contentEquals("/list.message")) { // 쪽지 list뿌리기
			
				PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
				
				List<MessageDTO> sends = mdao.sendMessage(dto.getId()); // 보낸 메세지
				List<MessageDTO> tos = mdao.toMessage(dto.getId()); // 받은 메세지

				request.setAttribute("sends", sends); 
				request.setAttribute("tos", tos); 
				
				request.getRequestDispatcher("Mypage/message.jsp").forward(request, response);
				
			}else if(url.contentEquals("/check.message")) {
				int pb_seq = Integer.parseInt(request.getParameter("pb_seq"));
				
				 boolean result = mdao.check(pb_seq);
				 
				 if(result) {
					 response.getWriter().append("true"); // 이미 일정이 생성됨.
				 }else {
					 response.getWriter().append("false");  // 수락가능. 글 보기 가능
				 }
			
			}else if(url.contentEquals("/accept.message")) { // 쪽지 수락
				int mseq = Integer.parseInt(request.getParameter("seq"));
				int seq = Integer.parseInt(request.getParameter("pb_seq"));
				
				int m_result = mdao.accept(mseq);
				
				String other_id = request.getParameter("other_id");

				if(m_result>0) { // planner에 일정등록
					PetBoardDTO pbdto = pbdao.chooseboard(seq);
					CosDTO wpdto = wpdao.getAllAddress(pbdto.getPlace_name());
					System.out.println("1");
					int p_result = pdao.insert(pbdto, other_id, wpdto);
					System.out.println("2");
					if(p_result>0) {
						response.getWriter().append("1");
					}else {
						response.getWriter().append("0");
					}
				}
			}else if(url.contentEquals("/cancel.message")) { // 쪽지 삭제 취소
				int seq = (Integer.parseInt(request.getParameter("seq")));
				
				int result = mdao.cancel(seq);
				
				if(result>0) {
					response.sendRedirect("list.message");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error1.jsp");
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
