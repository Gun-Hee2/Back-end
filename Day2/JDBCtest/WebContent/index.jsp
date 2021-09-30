<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
Class.forName("oracle.jdbc.driver.OracleDriver");

String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "HR";
String password = "HR";

Connection conn = DriverManager.getConnection(url, user, password);

String sql = "SELECT TNAME FROM TAB";

PreparedStatement psmt = conn.prepareStatement(sql);

ResultSet rs = psmt.executeQuery();

while(rs.next()){
	
	System.out.println(rs.getString(1));
}

%>

</body>
</html>