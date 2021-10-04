<%@page import="dto.bBsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 글 작성이 완료되면 글목록 페이지로 넘어가는 페이지 -->    

<% request.setCharacterEncoding("utf-8"); %>

<%
// bbswrite.jsp에서 보내준 데이터들을 받는다.
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
BbsDao dao = BbsDao.getInstance();

boolean isS = dao.writeBbs(new bBsDto(id, title, content)); 
// BbsDao의 writeBbs메소드 실행하고 실행여부를(true.false) 객체 isS에 가져온다.
if(isS){
%>
	<script type="text/javascript">
	alert("글쓰기 성공!");
	location.href = "bbslist.jsp"; // 글 작성을 성공하면 작성한 글들이 있는 목록의 페이지인 bbslist.jsp로 넘어간다.
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("글입력을 다시 해 주세요");
	location.href = "bbswrite.jsp";
	</script>
<%
}
%>



</body>
</html>







