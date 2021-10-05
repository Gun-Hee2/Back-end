<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq")); // bbsdetail.jsp에서 seq를 받아온다.
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
 
boolean isS = dao.deleteBbs(seq); // BbsDao의 deleteBbs메소드를 실행하고 실행여부 값을 객체 isS에 넣는다.

if(isS){
%>
   <script type="text/javascript">
   alert('삭제되었습니다');
   location.href = "bbslist.jsp";
   </script>
<%
}else{
%>
   <script type="text/javascript">
   alert('삭제가 되지않았습니다');
   location.href = "bbslist.jsp";
   </script>
<%
}
%>
</body>
</html>







