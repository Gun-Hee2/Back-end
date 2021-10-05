<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 회원가입 페이지에서 정상적으로 가입하면 데이터를 가지고 넘어오고, 회원가입의 성공여부에 따라 다음 페이지로 넘어가는 페이지, 실제 회원가입이 되는 페이지 -->    
    
<% request.setCharacterEncoding("utf-8"); %> <!-- 받아오는 문자열을 인코딩한다.(한글이 깨질때) -->
    
<%
String id = request.getParameter("id"); // 회원가입 페이지에서 받아온 id값
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
MemberDao dao = MemberDao.getInstance(); // MemberDao.java의 singleton패턴클래스인 MemberDao를 dao로 객체화.

MemberDto dto = new MemberDto(id, pwd, name, email, 0); // MemberDao의 생성자에 회원가입 홈페이지에서 받아온 데이터값들을 대입하여 회원의 데이터값을 DB에 추가하고 추가여부를 객체 dto에 넣는다.

boolean isS = dao.addMember(dto); // MemberDao의 addMember()메소드에 회원가입 홈페이지에서 입력한 데이터값을 가진 객체 dto를 객체 isS에 넣는다. 객체 isS의 값은 0 or 1.
if(isS == true){
%>
   <script type="text/javascript">
   alert("성공적으로 가입되었습니다.");
   location.href = "login.jsp"; // 가입에 성공하면 로그인 페이지인 login.jsp로 이동
   </script>
<% 
}else{
%>	
   <script type="text/javascript">
   alert("다시기입해 주십시오.");
   location.href = "regi.jsp"; // 가입에 실패하면 회원가입 페이지인 regi.jsp로 이동
   </script>
<% 
}
%>


</body>
</html>