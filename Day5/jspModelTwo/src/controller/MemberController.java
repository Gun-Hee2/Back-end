package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BbsDao;
import dao.MemberDao;
import dto.MemberDto;
import dto.bBsDto;
import net.sf.json.JSONObject;

public class MemberController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberController doProcess()");
		req.setCharacterEncoding("utf-8");
		
		String param = req.getParameter("param");
		
		if(param.equals("login")) {
			resp.sendRedirect("login.jsp");
		}else if(param.equals("regi")) {
			resp.sendRedirect("regi.jsp");
		}else if(param.equals("getId")) {
			String id = req.getParameter("id");
			System.out.println("id:" + id);
			
			MemberDao dao = MemberDao.getInstance();
			
			boolean b = dao.getId(id);
			
			String str = "";
			if(b == true){
				str = "NO";	// 회원가입 홈페이지에서 입력한 id값이 DB에 없다면 regi.jsp로 "NO"값을 전송
			}else{
				str = "YES"; // 회원가입 홈페이지에서 입력한 id값이 DB에 있다면 regi.jsp로 "YES"값을 전송
			}    
			
			JSONObject jobj = new JSONObject();
			jobj.put("msg", str);
			
			resp.setContentType("application/x-json; charset=utf-8");
			resp.getWriter().print(jobj);
			
		}else if(param.equals("regiAf")) {
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			// db에 추가
			MemberDao dao = MemberDao.getInstance();
			
			MemberDto dto = new MemberDto(id, pwd, name, email, 0);
			
			boolean isS = dao.addMember(dto);
			
			// 이동
			String msg = "OK";
			if(isS == false) {
				msg = "NO";
			}	
			resp.sendRedirect("message.jsp?msg=" + msg);
			
		}else if(param.equals("loginAf")) {
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto = dao.login(id, pwd);
			
			req.getSession().setAttribute("login", dto);
			req.getSession().setMaxInactiveInterval(60 * 60 * 2);
			
			if(dto != null) {
				resp.sendRedirect("bbs?param=bbslist");
			}else {
				System.out.println("login 정보 확인");
				resp.sendRedirect("member?param=login");
			}
		}else if(param.equals("bbswriteAf")) {
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			BbsDao dao = BbsDao.getInstance();
			
			boolean b = dao.writeBbs(new bBsDto(id, title, content));
			
			String write = "OK";
			if(b == false) {
				write = "NO";
			}	
			resp.sendRedirect("message.jsp?write=" + write);
		}
		
		
	}
	

}






