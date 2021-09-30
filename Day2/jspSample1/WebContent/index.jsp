<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <!-- html파일과 비슷하지만 다음과같이 java를 사용할 수 있다 -->
    
<%

// JSP

%>    
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- html 주석문 -->

<%-- jsp 주석문 --%>

<%-- 
     JSP : Java Server Page의 줄임말
           Server(web)을 통해서 Client form을 생성하는 코드
     
              http://localhost:8090/jspSample/index.jsp --> url로 요청
              
                  request(url)    Web Application Server(WAS)
              ------------------>   server      container      
                                                index.jsp
      client        
                                                servlet/jsp                               
              <------------------
                  response
                  
          Servlet은 java코드안에 html을 사용한다.
          JSP는 html과 java를 같이 사용할 수 있다.  JSP는 가독성이 좋은편이 아니다.
          
          scriptlet = script + applet -> java를 쓸 수 있는 영역
          
          내장 객체 : 생성하지 않고 바로 사용 가능한 객체
          String name = request.getParameter("name"); // request   
              
--%>
<h1>Hello JSP</h1>
<h3>h3 tag</h3>
<p>p tag</p> <!-- html 정상적으로 사용가능 -->
<button type="button">button</button>

<% // java area(자바영역) == scriptlet

System.out.println("Hello JSP");

%>

<%
String str = "Hello JSP";
int number = 1024;
%>

<p><%=str %></p> <!-- // <p>태그에 str 문자열값(java)을 넣을 수 있다. -->

<input type="text" size="20" value="<%=number %>"> <!-- 속성값에도 사용할 수 있다. -->

<br>

<%
// out : web에 출력을 할 수 있는 객체

out.println("<h2>" + str + number + "</h2>"); // Servlet, 거의 사용을 하지 않는다.
%>

<h2><%=str %><%=number %></h2> <!-- // Servlet과 다르게 html에 속성값도 바로 추가 가능하다. -->

<%
for(int i =0; i < 10; i++){
%>
    <p>Hello p tag <%=(i + 1) %></p>
<%
}
%>


</body>
</html>










