<%@page import="dto.bBsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<%
String sseq = request.getParameter("seq"); // 게시물의 seq를 bbsupdate.jsp로부터 받아온다.
int seq = Integer.parseInt(sseq); // 정수형으로 파싱

String title = request.getParameter("updatetitle"); // 수정된 제목을 bbsupdate.jsp로부터 받아온다.
String content = request.getParameter("updatecontent"); // 수정된 내용을 bbsupdate.jsp로부터 받아온다.
%>

<%
BbsDao dao = BbsDao.getInstance();
boolean isS = dao.updateBbs(new bBsDto(seq, title, content));
if(isS){
%>
	<script type="text/javascript">
	alert("글 수정 성공!");
	location.href = "bbslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("글 수정을 다시 해 주세요");
	location.href = "bbsupdate.jsp";
	</script>
<%
}
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