<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 회원가입 페이지에서 id확인을 눌렀을 때 넘어오는 페이지, DB에서 가져온 ID값의 유무(true(1)/false(0))를 받고 true이면 "YES"값을 전송,
false이면 "NO"값을 회원가입 홈페이지로 전송  -->


<%
String id = request.getParameter("id"); // 회원가입 홈페이지에서 입력한 id값
System.out.println("id:" + id); // 입력받은 id값을 콘솔창에 출력.

MemberDao dao = MemberDao.getInstance(); // MemberDao.java의 singleton패턴클래스인 MemberDao를 dao로 객체화.  
boolean b = dao.getId(id); // MemberDao의 getId()메소드에 회원가입 홈페이지에서 입력한 id값을 넣고 받은 값을 객체 b에 넣는다. 객체 b의 값은 0 or 1.

if(b == true){
	out.println("NO");	// 회원가입 홈페이지에서 입력한 id값이 DB에 없다면 regi.jsp로 "NO"값을 전송
}else{
	out.println("YES"); // 회원가입 홈페이지에서 입력한 id값이 DB에 있다면 regi.jsp로 "YES"값을 전송
}    
%>