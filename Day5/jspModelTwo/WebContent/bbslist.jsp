<%@page import="dto.MemberDto"%>
<%@page import="dto.bBsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
BbsDao dao = BbsDao.getInstance();
List<bBsDto> list = dao.getBbsList();
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>
   <script type="text/javascript">
   alert("로그인을 해주십시오.");
   location.href = "login.jsp";
   </script>
<%
}
%>

<h2>게시판</h2>

<div align="center">

<table border="1">
<col width="70px"><col width="500px"><col width="100px">
<tr>
    <th>번호</th><th>제목</th><th>작성자</th>
</tr>

<%
if(list == null || list.size() == 0){
%>
    <tr>
        <td colspan="3">작성된 글이 없습니다</td>
    </tr>
<%
}else{
	for(int i = 0; i < list.size(); i++){
		bBsDto bbs = list.get(i);
%>
        <tr>
            <th><%=(i + 1) %></th>
            <td>
                <%=bbs.getTitle() %>
            </td>
            <td>
                <%=bbs.getId() %>
            </td>
        </tr>
<%
	}
}
%>

</table>
<br>

    <a href="bbswrite.jsp">글쓰기</a>

</div>


</body>
</html>