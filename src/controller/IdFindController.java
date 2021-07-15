package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PersonDAO;
import dto.PersonDTO;


@WebServlet("*.idf")
public class IdFindController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset =utf-8");
		String requestURI = request.getRequestURI();
		String ctxPath = request.getContextPath();

		String url = requestURI.substring(ctxPath.length());
		System.out.println("요청 URL : " +url);

		try {
			PersonDAO dao = PersonDAO.getInstance();
			
			if(url.contentEquals("/IdFind.idf")) {
				String Name = request.getParameter("userName"); 
				System.out.println(Name);
				String Contact =request.getParameter("userNumber"); 
				System.out.println(Contact);
				String Email = request.getParameter("userEmail");
				System.out.println(Email);


				String  user_id = dao.findId(Name,Email,Contact);
				System.out.println(user_id);
				request.setAttribute("user_id",user_id);
				
				request.getRequestDispatcher("Signup/findidResult.jsp").forward(request, response);

			}

		}catch(Exception e){
			e.printStackTrace();
			response.sendRedirect("error1.jsp");
			}
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
