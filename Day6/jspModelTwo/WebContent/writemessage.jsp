<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String write = request.getParameter("write");
%>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if(write.equals("OK")){
%>
  <script type="text/javascript">
  alert("글 쓰기 성공!");
  location.href = 'bbs?param=bbslist';
  </script>
<%	
}else{
%>
  <script type="text/javascript">
  alert("글쓰기 실패. 다시 작성해 주세요.");
  location.href = 'member?param=bbswrite';
  </script>
<%
}
%>

</body>
</html>