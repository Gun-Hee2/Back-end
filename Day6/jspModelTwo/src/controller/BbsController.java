package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dto.bBsDto;


public class BbsController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}	
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//System.out.println("BbsController doProcess()");		
		req.setCharacterEncoding("utf-8");
		
		String param = req.getParameter("param");
		
		if(param.equals("bbslist")) {
			System.out.println("BbsController bbslist");
			
			String choice = req.getParameter("choice");	// 제목, 내용, 작성자
			String search = req.getParameter("search"); // 검색어
			if(search == null || choice == null || search.equals("")){
				search = "";
				choice = "";
			}
			
			// 현재 페이지
			String spageNumber = req.getParameter("pageNumber");
			int pageNumber = 0;
			if(spageNumber != null){
				pageNumber = Integer.parseInt(spageNumber);
			}
			
			BbsDao dao = BbsDao.getInstance();
			
			// 글의 총수 
			int len = dao.getAllBbs(choice, search);
			System.out.println("글의 총수:" + len);

			// 페이지 수
			Integer bbsPage = len / 10;		// 29 / 10 -> 2
			if((len % 10) > 0){
				bbsPage = bbsPage + 1;
			}
			
			// 게시판 목록
			List<bBsDto> list = dao.getBbsPagingList(choice, search, pageNumber);
			
			/*
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			map.put("choice", choice);
			map.put("bbsPage", bbsPage);
			map.put("list", list);
			*/
			// 짐싸!
			// req.setAttribute("map", map);
			
			// search
			req.setAttribute("search", search);
			// choice
			req.setAttribute("choice", choice);
			// bbsPage
			req.setAttribute("bbsPage", bbsPage);
			// pageNumber
			req.setAttribute("pageNumber", pageNumber);
			// list
			req.setAttribute("list", list);
						
			// 갖고 이동해야 합니다 -> 			
			forward("bbslist.jsp", req, resp);
			
		//	RequestDispatcher dispatcher = req.getRequestDispatcher("bbslist.jsp"); 
		//	dispatcher.forward(req, resp);
			
		}else if(param.equals("bbswrite")) {
			resp.sendRedirect("bbswrite.jsp");
		}else if(param.equals("bbswriteAf")) {
			System.out.println("MemberController bbswriteAf");
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			BbsDao dao = BbsDao.getInstance();
			
			boolean b = dao.writeBbs(new bBsDto(id, title, content));
			
			String write = "OK";
			if(b == false) {
				write = "NO";
			}	
			resp.sendRedirect("writemessage.jsp?write=" + write);
		}else if(param.equals("bbsdetail")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			BbsDao dao = BbsDao.getInstance();
			
			dao.readcount(seq);		// 조회수 늘리기			
			bBsDto dto = dao.getBbs(seq);			
			
			req.setAttribute("bbs", dto);			
			forward("bbsdetail.jsp", req, resp);
			
		}else if(param.equals("bbsanswer")) {
			int seq = Integer.parseInt( req.getParameter("seq") );

	        BbsDao dao = BbsDao.getInstance();
	        bBsDto bbs = dao.getBbs(seq);  // 부모글의 정보를 얻어옴
	        req.setAttribute("seq", seq);
	        req.setAttribute("bbs", bbs);
			
	        forward("bbsanswer.jsp", req, resp);
		}else if(param.equals("bbsanswerAf")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));

			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			BbsDao dao = BbsDao.getInstance();

			boolean b = dao.answer(seq, new bBsDto(id, title, content));
			
			String answer = "OK";
			if(b == false) {
				answer = "NO";
			}	
			resp.sendRedirect("answermessage.jsp?answer=" + answer);
		}else if(param.equals("bbsupdate")) {
			String sseq = req.getParameter("seq"); // bbsdetail.jsp에서 받아온 게시물의 seq
            //int seq = Integer.parseInt(sseq); // 정수형으로 파싱
            
            req.setAttribute("sseq", sseq);
            
            forward("bbsupdate.jsp", req, resp);
		}else if(param.equals("bbsupdateAf")) {
			String sseq = req.getParameter("seq"); // 게시물의 seq를 bbsupdate.jsp로부터 받아온다.
			int seq = Integer.parseInt(sseq); // 정수형으로 파싱

			String title = req.getParameter("updatetitle"); // 수정된 제목을 bbsupdate.jsp로부터 받아온다.
			String content = req.getParameter("updatecontent"); // 수정된 내용을 bbsupdate.jsp로부터 받아온다.
			
			BbsDao dao = BbsDao.getInstance();
			boolean b = dao.updateBbs(new bBsDto(seq, title, content));
			
			String update = "OK";
			if(b == false) {
				update = "NO";
			}	
			resp.sendRedirect("updatemessage.jsp?update=" + update);
		}else if(param.equals("bbsdelete")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			req.setAttribute("seq", seq);
			
			forward("bbsdelete.jsp", req, resp);
		}
	}
	
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher(arg); 
		dispatcher.forward(req, resp);
	}

}
