package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardCmtDAO;
import dto.BoardCmtDTO;
import dto.PersonDTO;

@WebServlet("*.fbc")  // *.freeBoardComments
public class BoardCmtController extends HttpServlet {
	
	private String XSSFilter(String target) {
		if (target != null) {
			target = target.replaceAll("<", "$lt;"); // lt = less than(작다), 기능 escape 해버림
			target = target.replaceAll(">", "$gt;");
			target = target.replaceAll("&", "$amp;");
		}
		return target;
	}   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");

		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = requestURI.substring(ctxPath.length());
		System.out.println("요청된 연결 : " + cmd);
		
		try {
			
			BoardCmtDAO cdao = BoardCmtDAO.getInstance(); 
			
			// 댓글 작성
			if(cmd.contentEquals("/writeCmt.fbc")) {
				String writer = ((PersonDTO)request.getSession().getAttribute("login")).getId();
				String comments = request.getParameter("comments");
				String parent_seq = request.getParameter("parent_seq");
				
				comments = XSSFilter(comments);
				
				System.out.println(writer + " : " + comments + " : " + parent_seq);

				BoardCmtDTO dto = new BoardCmtDTO(0, writer, comments, null, Integer.parseInt(parent_seq));
				int result = cdao.insertCmt(dto);
				response.sendRedirect("viewProc.fb?seq=" + parent_seq);
			
			// 댓글 수정
			} else if (cmd.contentEquals("/modifyCmt.fbc")) {

				int seq = Integer.parseInt(request.getParameter("seq"));
				String comments = request.getParameter("comments");
				int parent_seq = Integer.parseInt(request.getParameter("parent_seq"));
				
				comments = XSSFilter(comments);
				
				System.out.println(seq + " : " + comments);
				
				int result = cdao.modifyCmt(seq, comments);
				response.sendRedirect("viewProc.fb?seq=" + parent_seq);

			// 댓글 삭제
			} else if(cmd.contentEquals("/deleteCmt.fbc")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				int parent_seq = Integer.parseInt(request.getParameter("parent_seq"));
				
				int result = cdao.deleteCmt(seq);
				response.sendRedirect("viewProc.fb?seq=" + parent_seq);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
