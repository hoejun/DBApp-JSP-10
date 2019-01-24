<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
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
	//insert
	String sql = "insert into tblSawon(id, name, pass, age, addr, extension, dept)" +
				"values('"+s_id+"', '"+s_name+"', '"+s_pw+"', '"+s_age+"', '"+s_addr+"', '"+s_extension+"', '"+s_dept+"')";
	
	//DB작업을 위한 java.sql패키지에 있는 삼총사 객체 중 2개 DB연결 객체
	Connection con = null;
	//DB연결 후 쿼리 실행객체
	Statement stmt = null;
	
	//연결할 DB주소, DB주소 id, DB접속 pw
	String url = "jdbc:mysql://localhost:3306/jspbeginner";
	String id = "jspid", pw = "jsppass";
	
	try{
	    
	    //DB연결
	    //1단계 JDBC드라이버 로딩
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    //2단계 DB연결 시도 (DB접속)
	    con = DriverManager.getConnection(url, id, pw);
	    
	    //3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행할 Statement객체 반환
	    stmt = con.createStatement();
	    
	    //4단계 DB에 insert쿼리 실행하고 끝낸다.
	    stmt.executeUpdate(sql);
%>
<h2>직원 정보가 잘 추가 되었습니다.</h2>
<a href="addSawon.jsp">입력화면으로 이동</a>
<a href="index.jsp">메인 화면으로</a>
	    
<%
	}catch(Exception err){
	    
	    System.out.println("addSawon_proc.jsp에 오류 : " + err);
	    
	}finally{
	    
	    if(stmt != null)stmt.close();
	    if(con != null)con.close();
	    
	}
%>
</body>
</html>