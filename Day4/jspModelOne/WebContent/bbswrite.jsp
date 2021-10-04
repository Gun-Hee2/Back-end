<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 글을 작성하여 추가하는 페이지 -->    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MemberDto mem = (MemberDto)session.getAttribute("login"); // 세션에서 저장되어있는 로그인 정보를 얻어옴
if(mem == null){ //
%>
	<script type="text/javascript">
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>
<%
}
%>

<h1>글추가</h1>

<div align="center">

<form action="bbswriteAf.jsp" method="post"> <!-- 데이터들을 가지고 bbswriteAf.jsp로 넘어간다. -->

<table border="1">
<col width="200"><col width="400">

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" size="50px" value="<%=mem.getId() %>" readonly="readonly">
		<!-- id는 글을 작성할 때 이미 로그인이 되어있고 글을 작성하는 작성자의 id는 고정이므로 value값으로 id를 넣어주고 읽기만 가능한 readonly를 해준다.-->
	</td>
</tr>

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50px" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" value="글쓰기">
	</td>	
</tr>

</table>

</form>


</div>



</body>
</html>





