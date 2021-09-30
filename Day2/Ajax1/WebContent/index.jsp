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

<%-- Ajax : Asynchronous(비동기) JavaScript And Xml(json) --%>

<p id="demo"></p>
<br>
<p id="demo1"></p>
<br>
<p id="demo2"></p>
<br>
<button type="button">클릭</button>

<script type="text/javascript">
$(document).ready(function () {
	$("button").click(function () {
		
		$("#demo").load("data.html"); // data.html에 있는 데이터들을 id가 demo인 <p>태그에 가져온다.
		$("#demo1").load("data.html #data1"); // // data.html에서 id가 data1인 태그의 데이터를 id가 demo인 <p>태그에 가져온다.
		
	    $("#demo2").load("data.jsp", "t1=hi&t2=hello");
		
		
	});
});


</script>


</body>
</html>





