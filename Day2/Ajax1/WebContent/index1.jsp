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

<p id="demo"></p>
<br>
<button type="button">클릭</button>

<script type="text/javascript">
$(document).ready(function () {
	$("button").click(function () {
		$.ajax({
			////////////////////////////////////// send 출장을 가는부분
			url:"data.jsp" ,    //가려고하는 곳, 행선지
			type: "get",
		//	data:"t1=가나다&t2=DEF", // 생략가능
			data:{ t1:"라마바", t2:"GHI"},
			//////////////////////////////////////
			
			////////////////////////////////////// recv(receive) 출장을 돌아오는 부분
			success:function(data/*, status, xhr*/){ // 성공적으로 다녀왔을 때
			//
			//	  alert("success");
			//    alert(data);
			//    alert(status); //  성공여부
			//    alert(xhr.responseText); 
			
			      $("#demo").html(data); // 성공적으로 가져온 데이터를 html의 형태로 나타내어준다.    
			
			},
			error:function(/*xhr, status, error*/){ // 제대로 다녀오지 못했을 때
				alert("error");
			},
			complete:function(xhr, status){ // success든 error든 완료되었을 때
				//alert("통신종료");
			}
			//////////////////////////////////////
		
		});
		
	});
	
});

</script>

</body>
</html>







