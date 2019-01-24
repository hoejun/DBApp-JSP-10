<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>DB연결 테스트</h1>
<%
	/*
		1단계 (JDBC 드라이버 로딩)
		MYSQL회사에서 제공해주는 드라이버를 프로그램에 로딩.
	*/
	Class.forName("com.mysql.jdbc.Driver");

	/*
		2단계 DB연결
		DriverManager클래스 getConnection()메소드를 이용하여,
		JDBC프로그램에게 Mysql_DBMS의 DB에 연결을 요청함.
		DB연결 Connection객체를 얻어온다.
	*/
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspbeginner", "jspid", "jsppass");

	if(con != null){
	    out.println("연결 성공");
	}else{
	    out.println("연결 실패");
	}
%>
</body>
</html>