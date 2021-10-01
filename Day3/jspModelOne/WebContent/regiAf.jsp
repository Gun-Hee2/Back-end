<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %> <!-- 받아오는 문자열을 인코딩한다.(한글이 깨질때) -->
    
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String name = request.getParameter("name");
String email = request.getParameter("email");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MemberDao dao = MemberDao.getInstance();

MemberDto dto = new MemberDto(id, pwd, name, email, 0);

boolean isS = dao.addMember(dto);
if(isS == true){
%>
   <script type="text/javascript">
   alert("성공적으로 가입되었습니다.");
   location.href = "login.jsp";
   </script>
<% 
}else{
%>	
   <script type="text/javascript">
   alert("다시기입해 주십시오.");
   location.href = "regi.jsp";
   </script>
<% 
}
%>


</body>
</html>