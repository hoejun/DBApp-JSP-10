<%@page import="dbcp.DBConnectionMgr"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
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
<%--DB작업 할 SawonDao클래ㅡㅅ에 대한 객체 생성 --%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>

<%
	request.setCharacterEncoding("UTF-8");
	
	//index.jsp 페이지에서 받아온 삭제할 직원번호 받아오기
	int no = Integer.parseInt(request.getParameter("no"));
	
	//DB삭제작업 메소드 호출
	dao.delSawon(no);
%>
		<script type="text/javascript">
			alert("삭제되었습니다.");
			location.href="index.jsp";
		</script>
</body>
</html>