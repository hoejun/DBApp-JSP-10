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
	//1. 전달받은 직원 수정 데이터 한글처리
	request.setCharacterEncoding("UTF-8");
%>
<%--DB작업을 위한 객체 생성 --%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>

<jsp:useBean id="dto" class="mybean.SawonDto"/>
<jsp:setProperty property="*" name="dto"/>

<script type="text/javascript">
			
			alert(" 잘 수정 되었습니다.");		
			location.href="index.jsp";
	
</script>

<%	
	//사원 수정 메소드 호출시 dto객체 전달
	dao.modifySawon(dto);
%>
</body>
</html>