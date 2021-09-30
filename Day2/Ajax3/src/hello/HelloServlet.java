package hello;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.HumanDto;
import net.sf.json.JSONObject;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HelloServlet doGet()");
		
		// 받는 데이터
		// id, pwd
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		
		System.out.println("id:" + id + " pw:" + pwd);
		
		// 보내는 데이터
		// 1개
/*		String str = "World";
		
		JSONObject jobj = new JSONObject();
		jobj.put("str", str);
*/		
		
		// object(다수)
		// number, name
		List<HumanDto> list = new ArrayList<HumanDto>();
		list.add(new HumanDto(101, "성춘향"));
		list.add(new HumanDto(102, "이몽룡"));
		
		JSONObject jobj = new JSONObject();
		jobj.put("list", list);
		
		
		resp.setContentType("application/x-json; charset=utf-8");
		resp.getWriter().print(jobj);
		
	}
	
}
