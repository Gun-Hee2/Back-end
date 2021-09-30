<%@page import="dto.Humandto"%>
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
String id = request.getParameter("id");
String password = request.getParameter("pw");
String hobby[] = request.getParameterValues("hobby");
String age = request.getParameter("age");
String word = request.getParameter("word");

Humandto human = new Humandto(id, password, hobby, age, word);
request.setAttribute("human", human);
request.setAttribute("id", id);
request.setAttribute("pw", password);
request.setAttribute("hobby", hobby);
request.setAttribute("age", age);
request.setAttribute("word", word);
pageContext.forward("insertAf.jsp");

%>

</body>
</html>