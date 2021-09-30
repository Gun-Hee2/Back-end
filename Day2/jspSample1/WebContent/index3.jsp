<%@page import="jspSample1.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

Member mem = new Member("홍두께");

// 짐(데이터)싸기
// request.setAttribute("member", mem); 
session.setAttribute("member", mem);

// 짐(데이터)이동
// sendredirect -> 짐(데이터)을 두고 이동
// forward -> 짐(데이터)를 들고 이동

//request.getRequestDispatcher("index4.jsp").forward(request, response); // 짐을 들고 index4.jsp로 이동
//pageContext.forward("index4.jsp"); // 위와 같다.

//sendredirect
response.sendRedirect("index4.jsp"); //  session을 이용하여 짐(데이터)을 싸면 짐을 들고 이동이 가능하다.

%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>