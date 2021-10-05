<%@page import="dto.bBsDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 작성한 글들이 나열되는 게시판 페이지 -->    

<%
//아래에서 보내준 choice값과 search값을 받아온다.
String choice = request.getParameter("choice");
String search = request.getParameter("search");
// search null이거나 search이 빈문자일때 다시 세팅해라
if(search == null || choice == null || search.equals("")){ // 검색창에 검색어를 입력하지 않았을 때 null값을 가진다.
   choice = "";
   search = "";
}
// getBbsList();  넘겨줘야됌

BbsDao dao = BbsDao.getInstance();


//------------------------------------------- page 부분
// 글의 총수
int len = dao.getAllBbs(choice, search);
System.out.println("글의 총수:" + len);

// 페이지 수
int bbsPage = len / 10;      // 29 / 10 -> 2
if((len % 10) > 0) {
   bbsPage = bbsPage + 1;   // 나머지 9개의 글
}

// 현재 페이지
String spageNumber = request.getParameter("pageNumber");    // 처음에 null 값
int pageNumber = 0;   
if(spageNumber != null){      
   pageNumber = Integer.parseInt(spageNumber);
}

// List<BbsDto> list = dao.getBbsList(); // BbsDao의 getBbsList메소드를 실행한 list값을 bBsDto의 리스트값으로 객체 list 생성.
// List<BbsDto> list = dao.getBbsSearchList(choice, search);
List<bBsDto> list = dao.getBbsPagingList(choice, search, pageNumber);
%>    


<%!
// 댓글 깊이와 image를 추가하는 함수
public String arrow(int depth){
   String rs = "<img src='./image/arrow.png' width='20px' height='20px'>";
   String nbsp = "&nbsp&nbsp&nbsp&nbsp";   // 띄어쓰기
   
   String ts = "";
   for(int i = 0; i<depth; i++){
      ts += nbsp;
   }
   // 0이면 빈칸, 0이아니면 이미지
   return depth==0 ? "":ts + rs;
}

// 제목에 문자열의 길이가 30자를 넘을 때 ... 으로 표현
public String dot3(String title) {
   String str = "";
   if(title.length() >= 30){   // 30보다 크거나 같을 때
      str = title.substring(0, 30); // 0 ~ 29
   } else{
      str = title;      
   }
   return str;
}

%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 검색 후 페이징  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   // 검색어가 있는 경우
   let search = "<%=search %>";
   if(search == "") return;
   
   // select 처리
   let obj = document.getElementById("choice");
   obj.value = "<%=choice %>";
   obj.setAttribute("selected", "selected");   
});
</script>



</head>
<body>

<%
// 공용
MemberDto mem = (MemberDto)session.getAttribute("login"); 
// 저장했던 키값이 "login"인 세션을 받아와서 MemberDto객체인 mem에 넣는다.

if(mem == null){ // 로그인 정보 세션값이 존재하지 않을 때
%>
   <script type="text/javascript">
   alert("로그인 해 주십시오"); // 다음과 같은 알림창이 출력된다.
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
   
   for(int i = 0;i < list.size(); i++){
	   bBsDto bbs = list.get(i); // ArrayList안의 각각의 인덱스번호에 해당되는 데이터들을 차례대로 가져온다.
%>
      <tr>
         <th><%=(i + 1) %></th> <!-- 게시물의 번호, 번호는 1번부터 시작 -->
         <td>
            <%
            if(bbs.getDel() == 0){
               %>
               <%=arrow( bbs.getDepth() ) %> <!-- 추가되는 답글의 제목앞에 arrow.png그림을 추가하는 메소드 -->
         
               <%-- <!-- <%=bbs.getTitle() %> --> --%> <!-- 첫번째 게시물 부터 차례대로 제목을 출력 -->
               <a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>"><%=dot3(bbs.getTitle() )%></a> 
                <!-- bbsdetail.jsp로 seq값과 title값(30자가 넘어가는 제목은 점3개로 표시하는 함수에 넣은값)을 가져간다. -->
               <%
            }else {   
               %>
               <font color="#ff0000">***이 글은 작성자에 의해서 삭제되었습니다***</font>
            <%
            }
            %>
            
         </td>
         <td><%=bbs.getRef() %>-<%=bbs.getStep() %>-<%=bbs.getDepth() %></td>
         <!-- 글들의 REF, STEP과 DEPTH의 값을 나타낸다. -->
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
<%-- 1 [2] [3] --%>
<%
for(int i = 0; i < bbsPage; i++){
   if(pageNumber == i) {   // 현재 페이지 1 [2] [3]
      %>
      <span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
         <%=i + 1 %>   
      </span>&nbsp;
      <%
   }
   else {                // 현재 페이지를 제외한 페이지들
      %>
      <a href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)"
         style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
         [<%=i + 1 %>]
      </a>&nbsp;
      <%
   }
}
%>
<br><br>

<div align="center">

<select id="choice">
   <option value="title">제목</option>
   <option value="content">내용</option>
   <option value="id">작성자</option>
</select>

<input type="text" id="search" value="<%=search %>">

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
   
//   alert(choice);
//   alert(search);
   location.href = "bbslist.jsp?choice=" + choice + "&search=" + search; 
   // 현재 페이지와 같은 페이지로 이동되어 새로고침과 같지만 위와 같이 value값들로 검색한 글들을 보고 위해 데이터값을 가지고 이동한다.
}

function goPage( pageNum ) {
   let choice = document.getElementById("choice").value; // 선택한 <select>의 value값을 가져온다.
   let search = document.getElementById("search").value; // 입력한 <input>의 value값을 가져온다.
   
   // 검색과 페이징은 같이 가야된다.
   location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>

</body>
</html>








