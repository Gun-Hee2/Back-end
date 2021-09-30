<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
/* request.setCharacterEncoding("utf-8"); */
String id = (String)request.getAttribute("id");
String pw = (String)request.getAttribute("pw");
String[] hobby = (String[])request.getAttribute("hobby");
String age = (String)request.getAttribute("age");
String word = (String)request.getAttribute("word");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>전송된 정보</h1>

아이디:<%=id %>
<br>

패스워드:<%=pw %>
<br>

취미:
<%
for(int i = 0; i < hobby.length; i++){
%>
   <%=hobby[i] %>
<%
}
%>
<br>

나이:<%=age %>
<br>

상세내역:<%=word %> 


</body>
</html>