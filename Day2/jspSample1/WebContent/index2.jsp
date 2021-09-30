<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 내장 객체 : 동적 할당을 하지 않고 바로 사용(접근)할 수 있는 객체이다.   MyClass cls = new MyClass(); -> 동적할당
// request == 요청 -> JSP
// HttpServletRequest -> Servlet

String name = request.getParameter("name");
String age = request.getParameter("age");

String hobby[] = request.getParameterValues("hobby");

%>

<h3>이름: <%=name %></h3>
<h3>나이: <%=age %></h3>

<%
for(int i =0; i < hobby.length; i++){
%>
   <%=hobby[i] %>
<%
}
%>

</body>
</html>