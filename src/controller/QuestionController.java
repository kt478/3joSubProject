package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QuestionDAO;
import dto.BoardCmtDTO;
import dto.BoardDTO;
import dto.QuestionDTO;

@WebServlet("*.ask")
public class QuestionController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");

		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = requestURI.substring(ctxPath.length());
		System.out.println("요청된 연결 : " + cmd);

		try {
			QuestionDAO dao = QuestionDAO.getInstance();

			if (cmd.contentEquals("/questionList.ask")) {
				
				String category = request.getParameter("category");
				String keyword = request.getParameter("keyword");
				int cpage = Integer.parseInt(request.getParameter("cpage"));
				System.out.println("현재 페이지 : " + cpage);
				System.out.println("검색 분류 : " + category);
				System.out.println("검색어 : " + keyword);

				int endNum = cpage * 10;
				int startNum = endNum - 9;

				List<QuestionDTO> list;
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

				request.getRequestDispatcher("admin/questionList.jsp").forward(request, response);
				
			} else if(cmd.contentEquals("/questionWrite.ask")) { // 해결
				
				String type = request.getParameter("type");
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String contents = request.getParameter("contents");
				
				int result = dao.insert(type, name, email, contents);
				request.setAttribute("result", result);
				response.sendRedirect("main.jsp");
			
			} else if (cmd.contentEquals("/questionView.ask")) {

				int seq = Integer.parseInt(request.getParameter("seq"));
				List<QuestionDTO> qlist = dao.getQuestionList();
				request.setAttribute("qlist", qlist);
				request.getRequestDispatcher("admin/questionView.jsp").forward(request, response);

				
			} else if(cmd.contentEquals("/questionDelete.ask")) {
				
				int seq = Integer.parseInt(request.getParameter("seq"));
				int result = dao.delete(seq);
				response.sendRedirect("questionList.ask?cpage=1");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
