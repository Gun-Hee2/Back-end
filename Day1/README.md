# Day1

## Servlet

Servlet은 기본적으로 다음과 같은 과정을 거칩니다

1. 프로젝트/WebContent/xx.html 파일에서 호출명을 web.xml 파일로 호출합니다

2. 프로젝트/WebContent/WEB-INF/web.xml 파일에서 호출명을 받고 mapping 한 클래스(Servlet)으로 데이터를 보냅니다

3. 프로젝트/src의 mapping된 클래스(Servlet)에서는 데이터를 받고 데이터 가공, 출력, 데이터전달, 페이지 이동 등을 할 수 있습니다.
<br>



호출하는 html은 WebContent안에 존재하고, 연결하는 web.xml은 WebContent/WEB-INF 안에, 연결되는 서블릿 자바 클래스는 WebContent의 외부 src 안에 존재 하게 됩니다.
<br>


web.xml파일이나 서블릿 클래스 파일 변경후 적용할 때는 서버를 재시작 해주는게 안정적입니다.
<br>


프로젝트가 바뀌지 않는 한 web.xml 파일은 한개만 존재하므로 web.xml은 게시판 진행에 따라 servlet연결을 누적시키면서 진행합니다.
<br><br>


### web.xml 기본 설정

web application의 설정을 위한 deployment descriptor이다.

Deploy할 때 Servlet의 정보를 설정해준다.

브라우저가 Java Servlet에 접근하기 위해서는 WAS(ex. tomcat)에 필요한 정보를 알려줘야 해당하는 Servlet을 호출할 수 있다.
<br><br>

우선적으로 Servlet을 호출하기위한 웹페이지를 만든다.

* index.html

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="location" method="get"> 
    <!-- method 속성은 속성값으로는 GET과 POST 두 가지 중 하나를 선택할 수 있다. -->
    <!-- <form> 태그의 method 속성은 폼 데이터(form data)가 서버로 제출될 때 사용되는 HTTP 메소드를 명시 -->
    <!-- get방식은 <form>의 데이터를 브라우저 url에 캐시되어 저장된다. 따라서 보안상 취약점이 존재 -->
    <!-- post방식은 <form>의 데이터를 브라우저 url에 캐시되지 않는다. 중요한 데이터가 있을때는 post방식 사용 -->
name:<input type="text" name="name">
<br><br>
age:<select name="age">
<option>10대</option>
<option>20대</option>
<option>30대</option>
<option>40대</option>
<option>50대</option>
</select>
<br><br>
gender:<input type="radio" name="gender" value="남성">남성
<input type="radio" name="gender" value="여성">여성
<br><br>
hobby:<input type="checkbox" name="hobby" value="음악감상">음악감상
<input type="checkbox" name="hobby" value="영화감상">영화감상
<input type="checkbox" name="hobby" value="운동">운동
<br><br>
<input type="submit" value="get">


</body>
</html>
```

<br><br>
* web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://xmlns.jcp.org/xml/ns/javaee" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd" version="4.0">
  <display-name>ServletWork</display-name>
<servlet> <!-- 서블릿 이름을 실제 서블릿 클래스에 연결 -->
    <servlet-name>hello</servlet-name>
    <!-- 아래 매핑 설정에서의 servlet-name은 반드시 같아야 한다. -->
    <servlet-class>serv.HelloServlet</servlet-class>
    <!-- 개발자에 의해 작성된 실제 클래스 이름으로 설정해야 한다. ex) (패키지 이름).(서블릿 클래스 이름) -->

</servlet>

<servlet-mapping> <!-- URL을 서블릿 이름에 연결 -->
    <servlet-name>hello</servlet-name>
    <url-pattern>/location</url-pattern>
    <!-- 클라이언트(browser)의 요청 URL에서 <form>의 action값으로, 슬래시('/')로 시작해야 한다. -->

</servlet-mapping>  

<servlet>
    <servlet-name>world</servlet-name>
    <servlet-class>serv.WorldServlet</servlet-class>

</servlet>

<servlet-mapping>
    <servlet-name>world</servlet-name>
    <url-pattern>/world</url-pattern>

</servlet-mapping>
</web-app>
```
<br><br>


index.html의  innerHTML값과 value값을 받아올 Dto를 생성해준다.

* HumanDto.java

```java
package dto;

import java.util.Arrays;

public class HumanDto {
	private String name; // 이름
	private String age; // 연령대
	private String gender; // 성별
	private String hobby[]; // 취미 

	public HumanDto() {
		
	}

	public HumanDto(String name, String age, String gender, String hobby[]) {
		super();
		this.name = name; // 이름 text의 value값
		this.age = age; // 연령대 select의 value값
		this.gender = gender;// 성별 radio의 value값
		this.hobby = hobby; // 취미 checkbox의 value값
	}

	@Override
	public String toString() {
		return "HumanDto [name=" + name + ", age=" + age + ", gender=" + gender + ", hobby="
				+ Arrays.toString(hobby) + "]";
	}
}
```
<br><br>


서블릿으로 설정할 자바 파일 생성(패키지명과 클래스명은 web.xml의 sevlet-class와 동일, 패키지명은 serv, 클래스명은 HelloServlet)

* HelloServlet.java(HumanDto.java의 dto를 불러오고 데이터값을 다시 가지고  WorldServlet.java에 데이터를 전달해주는  서블릿)

```java
package serv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.HumanDto;

public class HelloServlet extends HttpServlet{ // HttpServlet를 상속

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("HelloServlet doGet()");
        String name = req.getParameter("name");
        String age = req.getParameter("age");
        String gender = req.getParameter("gender");
        String hobby[] = req.getParameterValues("hobby");
        
        HumanDto human = new HumanDto(name, age, gender, hobby);

		req.setAttribute("human", human); // 짐(HumanDto의 데이터)을 싸는 과정
		
		RequestDispatcher rd = req.getRequestDispatcher("world"); 
         // Servlet-name이 "world"인 WorldServlet.java로 이동
		rd.forward(req, resp);
         // 짐(HumanDto의 데이터)을 들고간다.
		
	//	resp.sendRedirect("world"); 
        // 위와 동일하게 Servlet-name이 "world"인 WorldServlet.java로 이동하지만 짐(HumanDto의 데이터)은 두고간다.
	}
}
```
<br><br>


서블릿으로 설정할 자바 파일 생성(패키지명과 클래스명은 web.xml의 sevlet-class와 동일, 패키지명은 serv, 클래스명은 WorldServlet)

* WorldServlet.java

```java
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
        //HelloServlet.java에서 가져온 짐(HumanDto의 데이터) 풀기
		
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
```

