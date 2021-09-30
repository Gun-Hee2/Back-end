<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<!-- <form action="insertAf1.jsp"> -->
<form id="frm">
아이디<input type="text" name="id" id="id">
<br>

패스워드<input type="password" name="pwd" id="pwd">
<br><br>

취미
<br>
<input type="checkbox" name="hobby" value="sleep">잠자기
<input type="checkbox" name="hobby" value="sing">노래하기
<input type="checkbox" name="hobby" value="game">게임하기
<br><br>

연령대
<br>
<input type="radio" name="age" value="10" checked="checked">10대
<input type="radio" name="age" value="20">20대
<input type="radio" name="age" value="30">30대
<input type="radio" name="age" value="40">40대
<input type="radio" name="age" value="50">50대
<input type="radio" name="age" value="60">60대이상
<br><br>

기타하고싶은말
<br>
<textarea rows="10" cols="30" name="text"></textarea>
<br>

<!-- <input type="submit" value="전송">  -->
<button type="button" id="send">전송</button> 
<input type="reset" value="취소"> 

</form>

<script type="text/javascript">
$(document).ready(function () {
	$("#send").click(function () { 
//		alert('send');
		if($("#id").val().trim() == ''){ // id값이 null값이면 실행
			alert('id를 입력해 주십시오');
			$("#id").focus();
			return;
		}
		
//		location.href = "insertAf1.jsp?id"
		$("#frm").attr("action", "insertAf1.jsp").submit(); // <form>의 데이터들을 가지고 insertAf1.jsp로 넘어간다.
	});
});


</script>

</body>
</html>





