<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// DB로부터 취득한 데이터라고 가정

String name = "홍길동";
int age = 24;
String birth = "2001/06/17";

String json = "{ \"name\":\"" + name + "\", \"age\":" + age + ", \"birth\":\"" + birth + "\"}";

System.out.println(json);

out.println(json);

%>