<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style type="text/css">
.center{
    margin: auto;
    width: 60%;
    border: 3px solid;
    padding: 10px;
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body>

<h2>Login Page</h2>

<div class="center">

<form action="loginAf.jsp" method="post">

<table border="1">

<tr>
    <th>아이디</th>
    <td>
        <input type="text" id="id" name="id" size="20"><br>
        <input type="checkbox" id="chk_save_id">save id
    </td>
</tr>
<tr>
    <th>패스워드</th>
    <td>
        <input type="password" name="pwd" size="20">
    </td>
</tr>
<tr>
    <td colspan="2">
        <input type="submit" value="login">
        <button type="button" onclick="account()">회원가입</button>
    </td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
function account() { // 회원가입 버튼을 누르면 실행되는 메소드이며, 데이터값을 갖고 regi.jsp로 이동
	location.href = "regi.jsp";
}
/*
    session : Java -> 서버에서 사용, 회원정보를 기억할 때, 방문횟수 = object가 저장
    cookie	: JavaScript -> client id저장할 때 많이 사용 = String
*/

let user_id = $.cookie("userId"); // 객체 user_id에 키값이 "userId"인 쿠키를 생성.
if(user_id != null){ // 저장된 쿠키가 있을 때, 유저가 아이디를 적었을 때
	$("#id").val( user_id );
//	$("#chk_save_id").attr( "checked", "checked" ) // attr(attribute명, attribute값)
    $("#chk_save_id").prop("checked", true);
}    

$("#chk_save_id").click(function () { // save id를 체크했을 때 실행되는 메소드
//	alert("check click");

    if($("#chk_save_id").is(":checked") == true){ // save id가 체크가 되어있을 때
    	if($("#id").val().trim() == ""){ // 공백을 제거한 입력한 id값이 빈칸일때
    		alert("id를 입력해 주십시오"); // 알림창을 다음과 같이 출력
    		$("#chk_save_id").prop("checked", false); // 체크되어있던 save id의 체크를 없앤다.
    	}
    	else{
        	$.cookie("userId", $("#id").val().trim(), {expires:7, path:'./'}); 
        	// 키값이 "userId"이고 키에 대한 value값은 "$("#id").val().trim()"이 된다.  
        	// {expires:7}은 7일간의 유효기간이며, 기간이 지나면 만료된다. {path:'./'}은 전체 사이트에 유효하게 설정해준다.
        }
    }	
    else{
    	$.removeCookie("userId", {path:'./'}); // save id가 체크가 되어있지 않다면 전체 사이트에 유효한 쿠키를 삭제한다.
    }

});


</script>


</body>
</html>









