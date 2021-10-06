<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String answer = request.getParameter("answer");
%>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(answer.equals("OK")){
%>
  <script type="text/javascript">
  alert("답글 쓰기 성공!");
  location.href = 'bbs?param=bbslist';
  </script>
<%	
}else{
%>
  <script type="text/javascript">
  alert("답글쓰기 실패. 다시 작성해 주세요.");
  location.href = 'member?param=bbsanswer';
  </script>
<%
}
%>

</body>
</html>