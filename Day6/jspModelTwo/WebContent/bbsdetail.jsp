<%@page import="dto.MemberDto"%>
<%@page import="dto.bBsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- bbslist.jsp에서 글을 고르고 제목을 눌렀을 때 작성된 글들의 세부 정보를 보여주는 bbsdetail.jsp(페이지)이다.  -->
    
<%
    // bbslist.jsp에서 다음과 같이 문자열 seq값을 얻어오고 객체 seq에 정수형으로 파싱하여 넣는다. 
        String sseq = request.getParameter("seq");
        int seq = Integer.parseInt(sseq);
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

dao.readcount(seq); // BbsDao의 readcount()메소드에 seq를 넣고 실행하여 readcount를 증가

bBsDto dto = dao.getBbs(seq); // seq로 dto취득
%>
<h2>상세 글 보기</h2>

<div align="center">

<table border="1">
<col width="200px"><col width="400px">

<tr>
    <th>작성자</th>
    <td><%=dto.getId() %></td>
</tr>

<tr>
    <th>제목</th>
    <td>
        <input type="text" value="<%=dto.getTitle().replaceAll("\"", "&#34;") %>" size="50">
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
        <%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %>
    </td>
</tr>

<tr>
    <th>내용</th>
    <td>
        <textarea rows="15" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
    </td>
</tr>

</table>
</div>

<br>

<button type="button" onclick="location.href='bbs?param=bbslist'">글목록</button>
<button type="button" onclick="answerbbs(<%=dto.getSeq() %>)">답글</button>

<%
if(dto.getId().equals(mem.getId())){ // 세션에 저장되어 있는 로그인정보의 아이디와 글을 작성한 작성자의 아이디가 같을 때만 아래의 버튼이 보인다.
	%>
	<button type="button" onclick="updatebbs(<%=dto.getSeq() %>)">수정</button>
	<button type="button" onclick="deletebbs(<%=dto.getSeq() %>)">삭제</button>
	
	<% 
}
%>

<script type="text/javascript">
function answerbbs(seq) {
	location.href = "bbs?param=bbsanswer&seq=" + seq; // 답글 버튼을 눌렀을 때 실행되는 함수, bbsanswer.jsp로 seq값을 가지고 이동
}
function updatebbs(seq) {
	location.href = "bbs?param=bbsupdate&seq=" + seq; // 수정 버튼을 눌렀을 때 실행되는 함수, bbsupdate.jsp로 seq값을 가지고 이동
}
function deletebbs(seq) {
	location.href = "bbs?param=bbsdelete&seq=" + seq; // 삭제 버튼을 눌렀을 때 실행되는 함수, bbsdelete.jsp로 seq값을 가지고 이동
}


</script>


</body>
</html>









