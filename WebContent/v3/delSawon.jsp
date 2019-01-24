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

delete from tblSawon where no = no;

<%
	//1.index.jsp에서 받아온 삭제할 직원번호 받아오기
	String no =request.getParameter("no");

	//2.받아온 삭제할 직원번호에 해당하는 직원레코드 삭제 쿼리 만들기
	String sql ="delete from tblSawon where no =? ";
	
	//3.직원 레코드 삭제 DB작업을 위한 java.sql 패키지에 있는 객체를 담을 준비
	Connection con = null;
	PreparedStatement stmt = null;
	
//v3
	DBConnectionMgr pool = null;
	
	//5.DB연결 및 delete쿼리 실행
	try{
//v3	    
	    pool = DBConnectionMgr.getInstance();
	    con = pool.getConnection();
	    
//v2 3단계 DB에 update쿼리 전달 및 update쿼리를 실행 할 Statement객체 반환
	    stmt = con.prepareStatement(sql);
	    stmt.setInt(1, Integer.parseInt(no));
	    
//v2 4단계 delete 쿼리 실행
	    stmt.executeUpdate();
	    
%>
		<script type="text/javascript">
			alert("삭제되었습니다.");
			location.href="index.jsp";
		</script>
<%
	}catch(Exception err){
	    
	    System.out.println("delSawon_proc.jsp에서 오류 : " + err);
	    
	}finally{
	    
	    if(stmt != null) stmt.close();
	    if(con != null) con.close();
	    
	}
%>
</body>
</html>