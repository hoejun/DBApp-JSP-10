<%@page import="dbcp.DBConnectionMgr"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
%>
<%--DB작업을 위한 객체 생성 --%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>

<%--<form>태그에서 요청한 추가할 사원에 대한 데이터를 dto객체에 담는다. --%>
<jsp:useBean id="dto" class="mybean.SawonDto"/>
<jsp:setProperty property="*" name="dto"/>

<%
	//insert작업 할 메소드 호출
	dao.setSawon(dto);
%>

<h2>직원 정보가 잘 추가 되었습니다.</h2>
<a href="addSawon.jsp">입력화면으로 이동</a>
<a href="index.jsp">메인 화면으로</a>
	    
</body>
</html>