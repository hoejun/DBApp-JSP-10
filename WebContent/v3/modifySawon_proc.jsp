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

	//2. 수정할 직원정보 전달받아 저장
	String no = request.getParameter("no");
	String s_id = request.getParameter("s_id");
	String s_name = request.getParameter("s_name");
	String s_pw = request.getParameter("s_pw");
	String s_age = request.getParameter("s_age");
	String s_addr = request.getParameter("s_addr");
	String s_extension = request.getParameter("s_extension");
	String s_dept = request.getParameter("s_dept");

	//3. hidden으로 넘겨받은 직원번호에 해당하는 직원 정보를 업데이트 하는 sql구문
	String sql = "update tblSawon set id=?, name=?, pass=?, age=?, addr=?, extension=?, dept=? where no=?";

	//4. DB작업을 위한 java.sql 패키지에 있는 삼총사 객체를 담을 준비
	Connection con =null;
	PreparedStatement stmt = null;
	
//v3
	DBConnectionMgr pool = null;

	//6.
	try{
	    
//v3 DBConnectionMgr 풀 객체 반환받기
		pool = DBConnectionMgr.getInstance();

//v3 풀안에 있는 DB연결 객체 빌려오기
		con = pool.getConnection();
		
//v2 3단계 DB에 update쿼리 전달 및 updqte쿼리를 실행할 Statement객체 반환
	    stmt = con.prepareStatement(sql);
	    
	    stmt.setString(1, s_id);
	    stmt.setString(2, s_name);
	    stmt.setString(3, s_pw);
	    stmt.setInt(4, Integer.parseInt(s_age));
	    stmt.setString(5, s_addr);
	    stmt.setString(6, s_extension);
	    stmt.setString(7, s_dept);
	    stmt.setInt(8, Integer.parseInt(no));
	    
	    
//v2 4단계 DB에 update 쿼리 실행하고 끝낸다.
	    stmt.executeUpdate();    
%>
		<script type="text/javascript">
			
			alert(" 잘 수정 되었습니다.");		
			location.href="index.jsp";
	
		</script>
<%    
	}catch(Exception err){
	
	    System.out.println("modifySawon_proc.jsp에서 오류 : " + err);    
	
	}finally{
//v3	 
	    pool.freeConnection(con, stmt);
	    
	}
%>
</body>
</html>