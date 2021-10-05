<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 회원가입 데이터를 입력하는 페이지 -->    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid;
	padding: 10px;	
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

<h2>회원가입</h2>
<p>회원가입을 환영합니다</p>

<div class="center">

<form action="member" method="post"> <!-- 회원가입 버튼이 누르고 정상적으로 회원가입이 성공하면 POST 방식을 사용하여 regiAf.jsp로 이동 -->
<input type="hidden" name="param" value="regiAf">

<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" id="id" size="20"><br>
		<p id="idcheck" style="font-size: 8px"></p>
		<input type="button" id="btn" value="id확인">
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="text" name="pwd" size="20">
	</td>
</tr>
<tr>
	<th>이름</th>
	<td>
		<input type="text" name="name" size="20">
	</td>
</tr>
<tr>
	<th>이메일</th>
	<td>
		<input type="text" name="email" size="20">
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="회원가입">
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#btn").click(function () {
		
		$.ajax({
			url:"member?param=getId", // getId.jsp로 데이터를 전송하고 다시 데이터를 받아옴.
			type:"post",
			data:{ id:$("#id").val() }, // 데이터값을 전송, 입력한 아이디값을 전송
			success:function(resp){ // 받아온 데이터값 resp
			//	alert('success');
			//	alert(resp.msg.trim());
				
				if(resp.msg.trim() == "YES"){ // 받아온 데이터값(공백을 제거한) resp가 "YES"라면 사용한 아이디라고 출력 
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html("이 ID는 사용할 수 있습니다");
				}
				else{ // 받아온 데이터값(공백을 제거한) resp가 "NO"라면 사용중인 아이디라고 출력
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html("사용 중인 ID입니다");
					$("#id").val("");
					$("#id").focus();
				}
			},
			error:function(){
				alert('error');
			}
		});
		
	});
	
});
</script>



</body>
</html>

