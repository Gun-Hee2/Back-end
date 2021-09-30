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

<div id="demo"></div>

<button type="button">버튼</button>

<script type="text/javascript">
$(document).ready(function () {
	$("button").click(function () {
		
		$.ajax({
			url:"hello",
			type:"get",
			data:{ id:"abc", pwd:"123"},
			
			success:function(data){
			//	  alert('success');
			//    alert(data);
			//    alert(JSON.stringify(data));
			
			//      $("#demo").html(data.str);
			
			//      alert(JSON.stringify(data));
			
			//      alert(data.list[0].name);
			      
			      let str = '';
			      for(i = 0; i < data.list.length; i++){
			    	  str += data.list[i].name + " ";
			    	  str += data.list[i].number + "<br>";
			    	  
			      }
			      
			      $("#demo").html(str);
			
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