<%@page import="jspSample1.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 짐(데이터)풀기
//Member mem = (Member)request.getAttribute("member");
Member mem = (Member)session.getAttribute("member");
%>    
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>index4</h1>
<%
if(mem != null){
%>
<%=mem.toString() %>
<%
}
%>


</body>
</html>