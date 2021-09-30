package serv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.HumanDto;

public class HelloServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("HelloServlet doGet()");
		
		String name = req.getParameter("name");
		System.out.println(name);
		
		int number = Integer.parseInt(req.getParameter("number"));
		System.out.println(number);
		
		/*
        resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		
		pw.println("<head>");
		pw.println("<title>HelloServletHtml</title>");
	    pw.println("</head>");
		
	    pw.println("<body>");		
	    
	    pw.println("<h3>Hello Servlet</h3>");	
	    
	    pw.println("</body>");		
		
		pw.println("</html>");
		
		pw.close();
		*/
		
		HumanDto human = new HumanDto(name, number);
		req.setAttribute("human", human);  // 짐을 싸는과정
		
		resp.sendRedirect("world");  // servlet으로 이동 // 짐을 두고간다.	
	//	resp.sendRedirect("index.html");  // web으로 이동
		
		
	//	RequestDispatcher rd = req.getRequestDispatcher("world"); // servlet으로 이동
	//	rd.forward(req, resp); // 짐을 들고간다.
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	

}
