<%@page import="dbcp.DBConnectionMgr"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
	//1.index.jsp 페이지에서 받아온 수정할 직원번호 받아오기
	String no = request.getParameter("no");

	//2.받아온 수정할 직원번호에 해당하는 직원 레코드 검색 select
	String sql ="select *from tblSawon where no=?";
	
	//3.DB작업을 위한 java.sql패키지에 있는
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
//v3
	DBConnectionMgr pool = null;

	//5.select후 수정할 직원 정보를 담을 변수들
	String s_id = null, s_name = null, s_pw = null, s_age=null, s_addr = null, s_extension = null, s_dept = null;
	
	//6
	try{
	    
//v3 DBConnectionMgr 풀 객체 반환받기
	    pool = DBConnectionMgr.getInstance();
	   	
//v3 풀안에 있는 DB연결 객체 빌려오기
	   	con = pool.getConnection();
	   	
//v2 3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값까지 가져오는 Statement객체 반환
	    stmt = con.prepareStatement(sql);
	    stmt.setInt(1, Integer.parseInt(no));
	    
//v2 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값을 ResultSet객체에 담아 ResultSet리턴하여 rs에 저장
	    rs = stmt.executeQuery();
	    
	    //DB로부터 수정할 직원 한명 레코드 정보 가져와서 저장
	    if(rs.next()){
	        
	        s_id = rs.getString("id");
	        s_name = rs.getString("name");
	        s_pw = rs.getString("pass");
	        s_age = String.valueOf(rs.getInt("age"));
	        s_addr = rs.getString("addr");
	        s_extension = rs.getString("extension");
	        s_dept = rs.getString("dept");
	        
	    }
	}catch(Exception err){
	    
	    System.out.println("modifySawon.jsp에서 오류 : " + err);
	    
	}finally{
//v3	    
	    pool.freeConnection(con, stmt, rs);
	    
	}
%>
<%--
	수정할 직원정보 뿌려주면서, 수정할 정보가 있으면 입력 후 실제 직원정보 수정을 위한 DB작업을 할 modifySawon_proc.jsp
	페이지에 요청!!
 --%>

<form action="modifySawon_proc.jsp" method="post">

<%--직원번호는 hidden으로 보이지 않게 감춰서 전달 --%>
<input type="hidden" name="no" value="<%=no%>"/>

<div align="center">
	<h1>직원 수정</h1>
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="s_id" value="<%=s_id%>"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="s_name" value="<%=s_name%>"></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="text" name="s_pw" value="<%=s_pw%>"></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><input type="text" name="s_age" value="<%=s_age%>"></td>
		</tr>
		<tr>
			<th>근무지</th>
			<td>
				<select name="s_addr">
					<option value="서울" <%if(s_addr.equals("서울")){%>selected<%}%>>서울</option>
					<option value="경기" <%if(s_addr.equals("경기")){%>selected<%}%>>경기</option>
					<option value="인천" <%if(s_addr.equals("인천")){%>selected<%}%>>인천</option>
					<option value="수원" <%if(s_addr.equals("수원")){%>selected<%}%>>수원</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>내선번호</th>
			<td><input type="text" name="s_extension" value="<%=s_extension%>"></td>
		</tr>
		<tr>
			<th>부서명</th>
			<td>
				<select name="s_dept">
					<option	value="영업" <%if(s_dept.equals("영업")){%>selected<%}%> >영업</option>
 					<option	value="기술" <%if(s_dept.equals("기술")){%>selected<%}%> >기술</option>
 					<option	value="기획" <%if(s_dept.equals("기획")){%>selected<%}%> >기획</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정"/>&nbsp;&nbsp;&nbsp;&nbsp;
 				<input type="reset" value="취소"/>
			</td>
		</tr>
	</table>
</div>
</form>
</body>
</html>