<%@page import="dbcp.DBConnectionMgr"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	<%--직원 데이터 삭제 한번 더 물어보는 함수--%>
	function fnDel(no) {
		//메시지 박스에 "예", "아니요" 중에서 선택했을때 true 또는 false 반환
		var result = confirm("데이터를 정말로 삭제 하시겠습니까?");
		
		//"예"이면? delSawon.jsp페이지로 이동!! 이동시 삭제할 직원 넘버를 넘겨 줌.
		if(result == true){
			location.href="delSawon.jsp?no=" + no;
		}
	}
</script>
</head>
<body>

<%
	//<검색기능 form>태그에서 요청받은 파라미터 한글 처리
	request.setCharacterEncoding("UTF-8");//한글 깨짐 방지
	//검색기준값 + 검색어
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
%>

<%--순서1. --%>
<h1>직원 정보 리스트</h1>
<%--직원 추가(회원가입) 페이지로 이동하는 링크 --%>
<a href="addSawon.jsp">직원추가</a>

<%--검색기능 : 검색기준 값 + 검색어 --%>
<form action="index.jsp" method="post">
	<select name="search">
		<option value="id">id</option>
		<option value="addr">근무지</option>
		<option value="dept">부서명</option>
	</select>
	<input type="text" name="searchText"/>
	<input type="submit" value="검색"/>
</form>

<%--직원 정보 리스트 --%>
<table border="1">
	<tr>
		<th>ID</th>
		<th>이름</th>
		<th>나이</th>
		<th>근무지</th>
		<th>부서명</th>
		<th>내선번호</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	

<%--순서2 --%>
<%
	/*DB작업을 위한 java.sql패키지에 있는 삼총사 객체*/
	//DB연결을 위한 객체
	Connection con = null;
	//DB연결 후 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값까지 가져오는 객체
	Statement stmt = null;
	
	/*
	-ResultSet객체-
		DB로부터 실행된 결과값을 임시로 저장하는 객체
		단! 하나의 테이블을 저장할 수 있는 구조
		연결 지향성
		반드시 처음에는 데이터를 가리키는 포인터를 한칸 이동 시켜야함.
	*/
	ResultSet rs = null;
	
	//쿼리를 담을 변수
	String sql="";

//v3 DBCP커넥션 풀 객체의 주소를 저장할 변수 선언
	DBConnectionMgr pool = null;
	
	//순서3. select쿼리 준비 /*검색어가 입력 되었는지? 입력 되어있지 않은지 파악*/
	try{
	    //검색어가 입력되어 있지 않다면?? 모든 직원정보를 모두 검색
	    if(searchText.isEmpty()){
	        sql = "select *from tblSawon";
	    }else{//검색어가 입력되어 있다면?;
	        //기준필드에 해당하는 검색어인 직원정보를 모두 검색
	        sql = "select *from tblSawon where " + search + " like '%" + searchText + "%'";
	    }
	}catch(NullPointerException err){//처음에 검색어가 입력되지 않았을때 모든 직원정보 리스트 뿌려주기 예외처리
	    sql = "select * from tblSawon";
	}
	
	//순서4.
	try{
	    
//v3 
		pool = DBConnectionMgr.getInstance();
		con = pool.getConnection();

	    //3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값까지 가져오는 Statement객체 반환
	    stmt = con.createStatement();
	    //DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값을 ResultSet객체에 담아 ResultSet리턴하여 rs에 저장
	    rs = stmt.executeQuery(sql);
	    
	    //4단계
	    //쿼리 실행 후 테이블 형식으로 담긴 레코드들이 ResultSet객체에 있는 동안 반복해서 하나의 레코드식 정보를 꺼내온다.
	    while(rs.next()){//테이블의 필드명을 포인터를 가리키므로 반드시 한번은 next()해줘야함.
	        
	        /*하나의 직원정보를 꺼내기  */
	        //DB로부터 select한 결과값 중..
	        //ResultSet객체에 저장된 하나의 DB레코드 정보. no값 꺼내와서 저장
	        String s_no = String.valueOf(rs.getInt("no"));
	        //ResultSet객체에 저장된 하나의 DB레코드 정보 중. id값 꺼내와서 저장
	        String s_id = rs.getString(2);//필드명 대신 인덱스 2를 써줘도 된다.
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. name값 꺼내와서 저장
			String s_name = rs.getString("name");
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. pass값 꺼내와서 저장
			String s_pw = rs.getString("pass");
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. age값 꺼내와서 저장	
			int s_age = rs.getInt("age");
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. addr값 꺼내와서 저장
			String s_addr = rs.getString("addr");
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. dept값 꺼내와서 저장
			String s_dept = rs.getString("dept");
			//ResultSet객체에 저장된 하나의 DB레코드 정보 중. extension값 꺼내와서 저장
			String s_extension = rs.getString("extension");	        
%>
	<%--한사람 직원 정보 뿌려주기 --%>	        
	        <tr>
	        	<td><%=s_id %></td> <!-- select한 결과값 중 직원 id 뿌려주기 -->
	        	<td><%=s_name %></td>
	        	<td><%=s_age %></td>
	        	<td><%=s_addr %></td>
	        	<td><%=s_dept %></td>
	        	<td><%=s_extension %></td>
	        	<!-- 직원 수정 페이지로 이동시 수정할 직원 번호를 넘겨준다. -->
	        	<td><a href="modifySawon.jsp?no=<%=s_no%>">직원 정보수정</a></td>
	        	<!-- 직원 삭제 페이지로 이동시 삭제할 직원 번호를 넘겨준다. -->
				<td><a href="javascript:fnDel(<%=s_no%>)">직원 정보삭제</a></td>
	        </tr>
<%	        
	    }
	}catch(Exception err){
	    
	    System.out.println("index.jsp에서 오류 : " + err);
	    
	}finally{
	    
//v3 사용한 DB커넥션 객체 반납(해제)
	pool.freeConnection(con, stmt, rs);

	}
%>

</table>
</body>
</html>