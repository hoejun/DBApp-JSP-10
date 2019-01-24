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
<!-- 순서1.add.Sawon.html의 폼태그에서 요청한 추가할 직원정보 받아오기 -->
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//추가할 직원 정보 중 id, name, pw, age, addr, extension, dept 받아오기
	String s_id = request.getParameter("s_id");
	String s_name = request.getParameter("s_name");
	String s_pw = request.getParameter("s_pw");
	String s_age = request.getParameter("s_age");
	String s_addr = request.getParameter("s_addr");
	String s_extension = request.getParameter("s_extension");
	String s_dept = request.getParameter("s_dept");
	
	// System.out.println(s_id);
	// System.out.println(s_name);
	// System.out.println(s_pw);
	// System.out.println(s_age);

	//DB에 전달할 sql명령어 준비
//v2 insert
	String sql = "insert into tblSawon(id, name, pass, age, addr, extension, dept)" +
				"values(?,?,?,?,?,?,?)";
	
	//DB작업을 위한 java.sql패키지에 있는 삼총사 객체 중 2개 DB연결 객체
	Connection con = null;
	//DB연결 후 쿼리 실행객체
	PreparedStatement stmt = null;
	
//v3
	DBConnectionMgr pool = null;
	
	try{
	    
//v3 1.DBCP 풀 객체 위치 알아내기 위해 DBConnectionMgr 객체 반환
		pool = DBConnectionMgr.getInstance();	    

//v3 2.연결된 DB연결 Connection객체 빌려오기
	    con = pool.getConnection();
	    
//v2 3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행할 Statement객체 반환
	    stmt = con.prepareStatement(sql);
	    
//v2 추가부분 ???????에 들어갈 구문 추가
	    stmt.setString(1, s_id);
	    stmt.setString(2, s_name);
	    stmt.setString(3, s_pw);
	    stmt.setInt(4, Integer.parseInt(s_age));
	    stmt.setString(5, s_addr);
	    stmt.setString(6, s_extension);
	    stmt.setString(7, s_dept);
		
	    //DB에 insert쿼리 실행하고 끝낸다.
		stmt.executeUpdate();
%>
<h2>직원 정보가 잘 추가 되었습니다.</h2>
<a href="addSawon.jsp">입력화면으로 이동</a>
<a href="index.jsp">메인 화면으로</a>
	    
<%
	}catch(Exception err){
	    
	    System.out.println("addSawon_proc.jsp에 오류 : " + err);
	    
	}finally{
	    
//v3
	    pool.freeConnection(con, stmt);
	    
	}
%>
</body>
</html>