package serv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.HumanDto;

public class WorldServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //짐 풀기
		
		HumanDto dto = (HumanDto)req.getAttribute("human");
		
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = resp.getWriter();
		
		pw.println("<html>");
		
		pw.println("<head>");
		pw.println("<title>WorldServletHtml</title>");
	    pw.println("</head>");
		
	    pw.println("<body>");		
	    
	    pw.println("<h3>World Servlet</h3>");	
	    
	    if(dto != null) {
	    	pw.println("<p>" + dto.toString() + "</p>");
	    }
	    
	    pw.println("</body>");		
		
		pw.println("</html>");
		
		pw.close();
	}

}
