<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>   <!-- 받아온 데이터값에 대하여 utf-8인코딩을 적용해준다. --> 
    
<%
String id = request.getParameter("id"); // login.jsp에서 받아온 입력받은 id값을 객체 id에 넣는다.
String pwd = request.getParameter("pwd");

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

MemberDto mem = dao.login(id, pwd); 
// MemberDao의 login메소드에 입력받은 id값과 pwd값을 넣어 쿼리문을 실행하고 얻은 MemberDto값을 MemberDto의 객체 mem에 넣는다. 

if(mem != null){ // 입력받은 id와 pwd로 찾은 회원정보가 있을 때
	
	// session에 로그인 정보를 저장
	session.setAttribute("login", mem); // 키값이 login인 세션에 MemberDto 객체 mem의 데이터를 저장한다.
	session.setMaxInactiveInterval(60 * 60 * 2); // 2시간 저장(유효기간)
%>
   <script type="text/javascript">
   alert("안녕하세요 <%=mem.getName() %>님"); /* 로그인이 정상적으로 되었을 때 mem객체에 Name값을 가져오고 다음과 같이 알림창에 출력 */ 
   location.href = "bbslist.jsp"; // 알림창 출력 후 bbslist.jsp(게시판)페이지로 이동한다.
   </script>
<% 
}else{ // 입력받은 id와 pwd로 찾은 회원정보가 없을 때
%>	
   <script type="text/javascript">
   alert("id나 password를 확인하세요."); // 로그인 실패했을 때 다음과 같은 알림창을 출력
   location.href = "login.jsp"; // 로그인이 실패했을 때 다시 로그인 페이지인 login.jsp로 이동한다.
   </script>
<% 
}
%>


</body>
</html>