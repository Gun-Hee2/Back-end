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

이름:<input type="text" id="name"></input>
<br>
나이:<input type="text" id="age"></input>
<br>
생년월일:<input type="text" id="birth"></input>
<br>
<button type="button">클릭</button>


<script type="text/javascript">
$(document).ready(function () {
	$("button").click(function () {
		$.ajax({
			url:"data.jsp",
			type: "get",
			
			success:function(data){
			//	alert('success');
			//	alert(data.trim());
			
				let json = JSON.parse(data);
			//	alert(json);
			    $("#name").val(json.name);
			    $("#age").val(json.age);
			    $("#birth").val(json.birth);
			
			    
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