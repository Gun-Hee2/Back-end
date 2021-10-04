<%@page import="dto.MemberDto"%>
<%@page import="dto.bBsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 작성한 글들이 나열되는 게시판 페이지 -->

<%
// 아래에서 보내준 choice값과 search값을 받아온다.
String choice = request.getParameter("choice"); 
String search = request.getParameter("search");
if(choice == null){ // 목록을 고르지 않았을 때 null값을 가진다.
	choice = "";
}
if(search == null){ // 검색창에 검색어를 입력하지 않았을 때 null값을 가진다.
	search = "";
}


BbsDao dao = BbsDao.getInstance(); 

//List<bBsDto> list = dao.getBbsList(); // BbsDao의 getBbsList메소드를 실행한 list값을 bBsDto의 리스트값으로 객체 list 생성.
List<bBsDto> list = dao.getBbsSearchList(choice, search);

%>    

<%!
// 댓글 깊이와 image를 추가하는 함수
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0; i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0 ? "":ts + rs;
	
}
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

<h2>게시판</h2>

<div align="center">

<table border="1">
<col width="70px"><col width="500px"><col width="100px">
<tr>
    <th>번호</th><th>제목</th><th>정보</th><th>작성자</th>
</tr>

<%
if(list == null || list.size() == 0){ // 쿼리문을 조회한 값이 담겨있는 리스트가 없거나 리스트가 비어있을 때
%>
    <tr>
        <td colspan="3">작성된 글이 없습니다</td>
    </tr>
<%
}else{ // 쿼리문을 조회한 값이 담겨있는 리스트가 존재할 때
	for(int i = 0; i < list.size(); i++){ 
		bBsDto bbs = list.get(i); // ArrayList안의 각각의 인덱스번호에 해당되는 데이터들을 차례대로 가져온다.
%>
        <tr>
            <th><%=(i + 1) %></th> <!-- 게시물의 번호, 번호는 1번부터 시작 -->
            <td>
                <%=arrow( bbs.getDepth() ) %> <!-- 추가되는 답글의 제목앞에 arrow.png그림을 추가하는 메소드 -->
                <%-- <%=bbs.getTitle() %> --%> <!-- 첫번째 게시물 부터 차례대로 제목을 출력 -->
                <a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a> 
                <!-- bbsdetail.jsp로 seq값과 title값을 가져간다. -->
            </td>
            <td><%=bbs.getRef() %>-<%=bbs.getStep() %>-<%=bbs.getDepth() %></td> <!-- 글들의 REF, STEP과 DEPTH의 값을 나타낸다. -->
            <td>
                <%=bbs.getId() %> <!-- 첫번째 게시물 부터 차례대로 작성자의 id을 출력 -->
            </td>
        </tr>
<%
	}
}
%>

</table>

<br>

<div align="center">

<select id="choice">
    <option value="title">제목</option>
    <option value="content">내용</option>
    <option value="id">작성자</option>
</select>

<input type="text" id="search" value="">

<button type="button" onclick="searchBbs()">검색</button>



</div>



<br>

    <a href="bbswrite.jsp">글쓰기</a> <!-- 글쓰기 링크를 누르면 글을 작성하는 페이지인 bbswrite.jsp로 이동한다. -->

</div>

<!-- 검색 버튼을 눌렀을 때 실행하는 함수 searchBbs() -->
<script type="text/javascript"> 
function searchBbs() {
	let choice = document.getElementById("choice").value; // 선택한 <select>의 value값을 가져온다.
	let search = document.getElementById("search").value; // 입력한 <input>의 value값을 가져온다.
	
//	alert(choice);
//	alert(search);
    location.href = "bbslist.jsp?choice=" + choice + "&search=" + search; 
    // 현재 페이지와 같은 페이지로 이동되어 새로고침과 같지만 위와 같이 value값들로 검색한 글들을 보고 위해 데이터값을 가지고 이동한다.

}


</script>

</body>
</html>











