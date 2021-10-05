<%@page import="dto.MemberDto"%>
<%@page import="dto.bBsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<%
        String sseq = request.getParameter("seq"); // bbsdetail.jsp에서 받아온 게시물의 seq
                int seq = Integer.parseInt(sseq); // 정수형으로 파싱
        %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login"); // 저장했던 키값이 "login"인 세션을 받아와서 MemberDto객체인 mem에 넣는다.
if(mem == null){ // 로그인 정보 세션값이 존재하지 않을 때
%>
   <script type="text/javascript">
   alert("로그인을 해주십시오.");  // 다음과 같은 알림창이 출력된다.
   location.href = "login.jsp"; // 로그인정보의 세션값이 존재하지 않기 때문에 다시 로그인 페이지인 login.jsp로 이동한다.
   </script>
<%
}
%>

<%
BbsDao dao = BbsDao.getInstance();

dao.readcount(seq); //readcount를 증가

bBsDto dto = dao.getBbs(seq); // seq로 dto취득
%>
<h2>글 수정</h2>

<div align="center">

<form action="bbsupdateAf.jsp" method="post">

<input type="hidden" name="seq" size="50px" value="<%=dto.getSeq() %>" > 
<!-- 웹페이지에서는 히든타입으로 보이지 않지만 데이터는 전달가능하다. -->

<table border="1">
<col width="200px"><col width="400px">

<tr>
    <th>작성자</th>
    <td><%=dto.getId() %></td>
</tr>

<tr>
    <th>제목</th>
    <td>
        <input type="text" name="updatetitle" size="50px">
    </td>
</tr>

<tr>
    <th>작성일</th>
    <td>
        <%=dto.getWdate() %>
    </td>
</tr>

<tr>
    <th>조회수</th>
    <td>
        <%=dto.getReadcount() %>
    </td>
</tr>

<tr>
    <th>정보</th>
    <td>
        <%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %> <!-- ref = seq, step = 다음칸, depth = 깊이 -->
    </td>
</tr>

<tr>
    <th>내용</th>
    <td>
        <textarea rows="15" cols="90" name="updatecontent"></textarea>
    </td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" value="수정하기">
	</td>	
</tr>

</table>
</form>
</div>

</body>
</html>