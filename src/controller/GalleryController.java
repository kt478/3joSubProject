package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import config.Front_GalleryConfig;
import config.GalleryConfig;
import config.Gallery_ImgConfig;
import dao.CommentsDAO;
import dao.GalleryDAO;
import dao.Gallery_ImgDAO;
import dto.CommentsDTO;
import dto.GalleryDTO;
import dto.Gallery_ImgDTO;
import dto.PersonDTO;


@WebServlet("*.gal")
public class GalleryController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); 

		String requestURI = request.getRequestURI();

		String ctxPath = request.getContextPath();

		String url = requestURI.substring(ctxPath.length());
		System.out.println("url : " + url);

		try {
			GalleryDAO dao = GalleryDAO.getInstance();
			GalleryDTO dto = new GalleryDTO();
			
			Gallery_ImgDTO midto = new Gallery_ImgDTO();
			Gallery_ImgDAO idao = Gallery_ImgDAO.getInstance();

			if(url.contentEquals("/galWrite.gal")) {

				String filesPath = request.getServletContext().getRealPath("files");
				File filesFolder = new File(filesPath);   

				int maxSize = 1024 * 1024 * 10 ;
				
				if(!filesFolder.exists()) filesFolder.mkdir();

				MultipartRequest multi = new MultipartRequest(request, filesPath , Gallery_ImgConfig.uploadMaxSize,"utf8", new DefaultFileRenamePolicy());


				Enumeration files = multi.getFileNames();

				String str = (String)files.nextElement();
				String lostFileRealName = multi.getFilesystemName(str);


				PersonDTO mdto = (PersonDTO)request.getSession().getAttribute("login");

				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				dto.setWriter(mdto.getId()); 


				int seq = dao.getSeq();
				int result = dao.galWrite(seq, title, contents, mdto.getId());

				Set<String> fileNames = multi.getFileNameSet();

				for(String fileName : fileNames) {
					String oriName = multi.getOriginalFileName(fileName);
					String sysName = multi.getFilesystemName(fileName);

					Gallery_ImgDTO idto = new Gallery_ImgDTO(0,oriName, sysName,seq);

					if(oriName!=null) {
						System.out.println("파일 이름" + oriName +"DB에 저장됨.");
						idao.filesInsert(idto);
					}
				}

				List<Gallery_ImgDTO> ilist = idao.selectAll();
				for(Gallery_ImgDTO idto : ilist) {
					System.out.println(idto.getOriName());
				}

				request.getSession().removeAttribute("ingFiles");

				request.setAttribute("ilist", ilist);
				request.getRequestDispatcher("galList.gal?cpage=1").forward(request, response);

				/* response.sendRedirect("galList.gal?cpage=1"); */

			}else if(url.contentEquals("/galList.gal")) {

				int cpage = Integer.parseInt(request.getParameter("cpage"));


				String category = request.getParameter("category");
				String keyword = request.getParameter("keyword");

				System.out.println("현재 페이지 : " + cpage);
				System.out.println("검색 분류 : "+ category);
				System.out.println("검색어 : "+ keyword);

				int endNum = cpage * GalleryConfig.RECORD_COUNT_PER_PAGE;
				int startNum = endNum - (GalleryConfig.RECORD_COUNT_PER_PAGE-1);


				List<GalleryDTO> list;

				if(keyword == null || keyword.contentEquals("")) {
					list = dao.getPageList(startNum, endNum);
				}else {
					list = dao.getPageList(startNum, endNum,category,keyword);
				}

				List<String> pageNavi = dao.getPageNavi(cpage,category,keyword);
				
				for(GalleryDTO gdto : list) {
					Gallery_ImgDTO idto = idao.selectThumbBySeq(gdto.getSeq());
					gdto.setThumbPath(idto.getSysName());
				}

				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.setAttribute("cpage", cpage);
				request.setAttribute("category", category);
				request.setAttribute("keyword", keyword);


				request.getRequestDispatcher("Gallery/gallery_main.jsp").forward(request, response);


			}else if(url.contentEquals("/galDetail.gal")) {

				int seq = Integer.parseInt(request.getParameter("seq"));

				GalleryDTO content = dao.search(seq);

				/* List<Gallery_ImgDTO> Gallery_ImgList = idao.filesBySeq(seq); */	

				CommentsDAO cmt = CommentsDAO.getInstance();

				List<Gallery_ImgDTO> ilist = idao.filesBySeq(seq);
				List<CommentsDTO> list = cmt.list(seq);

				request.setAttribute("list", list);
				request.setAttribute("content", content);
				request.setAttribute("ilist", ilist);
				/* request.setAttribute("GIList", Gallery_ImgList); */
				request.getRequestDispatcher("Gallery/gallery_detail.jsp").forward(request, response);


			}else if(url.contentEquals("/modify.gal")) {

				int seq = Integer.parseInt(request.getParameter("seq"));
				GalleryDTO content = dao.search(seq);

				List<Gallery_ImgDTO> ilist= idao.filesBySeq(seq);

				request.setAttribute("content", content);
				request.setAttribute("ilist", ilist);
				request.getRequestDispatcher("Gallery/gallery_modify.jsp").forward(request, response);

			}else if(url.contentEquals("/modifyCom.gal")) {

				String filesPath = request.getServletContext().getRealPath("files");


				MultipartRequest multi = new MultipartRequest(request, filesPath, Gallery_ImgConfig.uploadMaxSize,"utf8", new DefaultFileRenamePolicy());


				int seq = Integer.parseInt(multi.getParameter("seq"));
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");



				String[] delTargets = multi.getParameterValues("delete");

				/* System.out.println(delTargets.length); */

				if(delTargets != null) {


					for(String target : delTargets) {
						String sysName = idao.getSysName(Integer.parseInt(target));
						File targetFile = new File(filesPath+"/"+sysName);
						boolean result = targetFile.delete();

						if(result) {idao.fileDelete(Integer.parseInt(target));}


					}
				}

				int result = dao.update(seq,title,contents);


				Set<String> fileNames = multi.getFileNameSet();

				for(String fileName : fileNames) {
					String oriName = multi.getOriginalFileName(fileName);
					String sysName = multi.getFilesystemName(fileName);



					Gallery_ImgDTO idto = new Gallery_ImgDTO(0,oriName, sysName,seq);


					if(oriName!=null) {
						System.out.println("파일 이름" + oriName +"DB에 저장됨.");
						idao.filesInsert(idto);

					}
				}


				if(result>0) {
					GalleryDTO mdto = dao.search(seq);
					List<Gallery_ImgDTO> ilist = idao.filesBySeq(seq);
					request.setAttribute("mdto",mdto);
					request.setAttribute("ilist",ilist);
					request.getRequestDispatcher("galDetail.gal").forward(request, response);

				}

			}else if(url.contentEquals("/delete.gal")) {

				String filesPath = request.getServletContext().getRealPath("files");

				int seq = Integer.parseInt(request.getParameter("seq"));

				String oriName = idao.getOriName(seq);
				
				dao.delete(seq);
				
				File targetFile = new File(filesPath+"/"+oriName);
				targetFile.delete();

				idao.fileDelete(seq);

				response.sendRedirect("galList.gal?cpage=1");

			}else if(url.contentEquals("/beforeLogin.gal")) {

				int cpage = Integer.parseInt(request.getParameter("cpage"));

				int endNum = cpage * Front_GalleryConfig.RECORD_COUNT_PER_PAGE;
				int startNum = endNum - (Front_GalleryConfig.RECORD_COUNT_PER_PAGE-1);

				List<GalleryDTO> list;
				
				list = dao.getPageList(startNum, endNum);

				for(GalleryDTO gdto : list) {
					Gallery_ImgDTO idto = idao.selectThumbBySeq(gdto.getSeq());
					
					gdto.setThumbPath(idto.getSysName());
				}


				request.setAttribute("list", list);
				
				request.setAttribute("cpage", cpage);
				


				request.getRequestDispatcher("main.jsp").forward(request, response);


			}else if(url.contentEquals("/afterLogin.gal")) {

				int cpage = Integer.parseInt(request.getParameter("cpage"));

				String category = request.getParameter("category");
				String keyword = request.getParameter("keyword");

				System.out.println("현재 페이지 : " + cpage);
				System.out.println("검색 분류 : "+ category);
				System.out.println("검색어 : "+ keyword);

				int endNum = cpage * Front_GalleryConfig.RECORD_COUNT_PER_PAGE;
				int startNum = endNum - (Front_GalleryConfig.RECORD_COUNT_PER_PAGE-1);


				List<GalleryDTO> list;

				list = dao.getPageList(startNum, endNum);


				List<String> pageNavi = dao.getPageNavi(cpage,category,keyword);

				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.setAttribute("cpage", cpage);
				request.setAttribute("category", category);
				request.setAttribute("keyword", keyword);


				request.getRequestDispatcher("main.jsp").forward(request, response);

			}else if(url.contentEquals("/forGallery.gal")) {

				int cpage = Integer.parseInt(request.getParameter("cpage"));

				int endNum = cpage * Front_GalleryConfig.RECORD_COUNT_PER_PAGE;
				int startNum = endNum - (Front_GalleryConfig.RECORD_COUNT_PER_PAGE-1);


				List<GalleryDTO> list;

				list = dao.getPageList(startNum, endNum);


				for(GalleryDTO gdto : list) {
					Gallery_ImgDTO idto = idao.selectThumbBySeq(gdto.getSeq());
					
					gdto.setThumbPath(idto.getSysName());
				}


				request.setAttribute("list", list);
				
				request.getRequestDispatcher("main.jsp").forward(request, response);
	

			}else if(url.contentEquals("/mainGallery.gal")) {
				
				
				int cpage = Integer.parseInt(request.getParameter("cpage"));

				int endNum = cpage * Front_GalleryConfig.RECORD_COUNT_PER_PAGE;
				int startNum = endNum - (Front_GalleryConfig.RECORD_COUNT_PER_PAGE-1);

				response.setContentType("text/html;charset=utf-8");
				List<GalleryDTO> list;

				list = dao.getPageList(startNum, endNum);
				
				for(GalleryDTO gdto : list) {
					Gallery_ImgDTO idto = idao.selectThumbBySeq(gdto.getSeq());
					
					gdto.setThumbPath(idto.getSysName());
				}
				
				Gson g = new Gson();

				
				list.add(dto);
				
				
				String gallery = g.toJson(list);
				response.getWriter().append(gallery);

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
