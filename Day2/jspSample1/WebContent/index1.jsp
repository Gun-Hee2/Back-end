<%@page import="func.UtilClass"%>
<%@page import="jspSample1.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%!
// 선언부 : 전역변수, class, function등 선언
int gl_number = 0;
%>

<%
//코드부
gl_number++;

int number = 0;
number++;

%>

<!-- value -->
전역변수: <%=gl_number %>
<br>
지역변수: <%=number %>

<%!
class Human{
	private String name;
	
	public Human(String name){
		this.name = name;
	}
	public String toString(){
		return this.name;
	}
}
%>

<%
Human h = new Human("홍길동");
System.out.println(h.toString());
%>

<%
Member m = new Member("성춘향");
System.out.println(m.toString()); // 외부에 java파일생성하고 선언하여 사용가능, jspSample1패키지-Member.java
%>

<%!
public int func(int n1, int n2){
	return n1 * n2;
}
%>

<%
System.out.println(func(12,34));
System.out.println(UtilClass.func(56,78));
%>

<%=func(12,34) %>
<%=UtilClass.func(56,78) %>


</body>
</html>






