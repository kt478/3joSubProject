package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.BoardConfig;
import dao.BoardCmtDAO;
import dao.BoardDAO;
import dto.BoardCmtDTO;
import dto.BoardDTO;
import dto.PersonDTO;

@WebServlet("*.fb") // *.freeBoard

public class BoardController extends HttpServlet {
	
	private String XSSFilter(String target) {
		if (target != null) {
			target = target.replaceAll("<", "$lt;"); // lt = less than(작다), 기능 escape 해버림
			target = target.replaceAll(">", "$gt;");
			target = target.replaceAll("&", "$amp;");
		}
		return target;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");

		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = requestURI.substring(ctxPath.length());
		System.out.println("요청된 연결 : " + cmd);
		
		try {
			BoardDAO dao = BoardDAO.getInstance();
			BoardCmtDAO cdao = BoardCmtDAO.getInstance();

			// 게시판 첫 화면 게시글 목록 출력
			if (cmd.contentEquals("/listProc.fb")) { 

				String category = request.getParameter("category");
				String keyword = request.getParameter("keyword");
				int cpage = Integer.parseInt(request.getParameter("cpage"));
				System.out.println("현재 페이지 : " + cpage);
				System.out.println("검색 분류 : " + category);
				System.out.println("검색어 : " + keyword);

				int endNum = cpage * (BoardConfig.RECORD_COUNT_PER_PAGE);
				int startNum = endNum - (BoardConfig.RECORD_COUNT_PER_PAGE - 1);

				List<BoardDTO> list;
				if (keyword == null || keyword.contentEquals("")) {
					list = dao.getPageList(startNum, endNum);
				} else {
					list = dao.getPageList(startNum, endNum, category, keyword);
				}
				List<String> pageNavi = dao.getPageNavi(cpage, category, keyword);
				
				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.setAttribute("cpage", cpage);
				request.setAttribute("category", category);
				request.setAttribute("keyword", keyword);

				request.getRequestDispatcher("board/boardList.jsp").forward(request, response);

			// 게시글 작성 
			} else if (cmd.contentEquals("/writeProc.fb")) {

				PersonDTO dto = (PersonDTO) request.getSession().getAttribute("login");
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");

				title = XSSFilter(title);
				contents = XSSFilter(contents);
				
				int result = dao.insert(title, contents, dto.getId());
				request.setAttribute("result", result);
				response.sendRedirect("listProc.fb?cpage=1");

			// 게시글 상세보기
			} else if (cmd.contentEquals("/viewProc.fb")) {
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				BoardDTO dto = dao.view(seq);
				dao.view_countPlus(seq);
				
				List<BoardCmtDTO> commentsList = cdao.getCommentsList(seq);
				request.setAttribute("dto", dto);
				request.setAttribute("clist", commentsList);
				request.getRequestDispatcher("board/boardView.jsp").forward(request, response);

			// 게시글 수정 폼으로 가기
			} else if(cmd.contentEquals("/modiForm.fb")) {

				int seq = Integer.parseInt(request.getParameter("seq"));
				BoardDTO dto =  dao.view(seq);
				
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("board/boardModify.jsp").forward(request, response);
			
			// 게시글 수정 작업
			} else if (cmd.contentEquals("/modifyProc.fb")) {

				int seq = Integer.parseInt(request.getParameter("seq"));
				String uptitle = request.getParameter("title");
				String upcontents = request.getParameter("contents");

				int result = dao.modify(seq, uptitle, upcontents);
				if (result > 0) {
					BoardDTO dto = dao.view(seq);
					request.setAttribute("dto", dto);
					response.sendRedirect("viewProc.fb?seq="+seq);
				}

			// 게시글 삭제 작업
			} else if (cmd.contentEquals("/deleteProc.fb")) {
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				int result = dao.delete(seq);
				
				System.out.println(seq + " : 삭제됨");
				response.sendRedirect("listProc.fb?cpage=1");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error1.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
