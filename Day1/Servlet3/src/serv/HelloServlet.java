package serv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HelloServlet doGet()"); // doGet()방식은 모든 정보를 공개해도 될때 사용한다.
		
		String name = req.getParameter("name"); // index.html에서 가져온 name의 파라미터를 문자열 name에 가져온다. 
		System.out.println(name);
		
		String hobby[] = req.getParameterValues("hobby"); // index.html에서 가져온 name의 파라미터를 문자열 name에 가져온다. 
		
		
		
		 resp.setContentType("text/html; charset=utf-8");
		 
		 PrintWriter pw = resp.getWriter();
		 
		 pw.println("<html>");
		 
		 pw.println("<head>"); pw.println("<title>HelloServletHtml</title>");
		 pw.println("</head>");
		 
		 pw.println("<body>");
		 
		 pw.println("<h3>Hello Servlet</h3>");
		 
		 pw.println("<p>이름:" + name + "</p>");
		 
		 if(hobby != null) { for(int i = 0; i < hobby.length; i++) {
		 pw.println("<p>취미:" + hobby[i] + "</p>"); } }
		 
		 pw.println("</body>");
		 
		 pw.println("</html>");
		 
		 pw.close();
		 
		
		
		/*
		   Servlet -> Java(html를 같이 쓸 수 있음)
		   JSP -> html(Java를 같이 쓸 수 있음)
		 */
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HelloServlet doPost()"); // doPost()방식은 로그인이나 공개하면 안될 때 사용한다.
		
		req.setCharacterEncoding("utf-8"); // post방식을 사용할때 req의 문자열을 utf-8로 인코딩해준다. -> 한글도 정상적으로 출력
		
		String name = req.getParameter("name");  
		System.out.println(name);
		
        resp.setContentType("text/html; charset=utf-8");
		 
		PrintWriter pw = resp.getWriter();
		 
		pw.println("<html>");
		 
		pw.println("<head>"); pw.println("<title>HelloServletHtml</title>");
		pw.println("</head>");
		 
		pw.println("<body>");
		 
		pw.println("<h3>Hello Servlet</h3>");
		 
		pw.println("<p>이름:" + name + "</p>");
		 
		pw.println("</body>");
		 
		pw.println("</html>");
		 
		pw.close();
	}
	

}
