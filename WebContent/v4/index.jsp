<%@page import="mybean.SawonDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mybean.SawonDao"%>
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

<%--v4 DB작업을 위한 메소드를 호출용 객체생성 --%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>

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

<%--v4 한 사람 직원 정보 뿌려주기 --%>
<%
	ArrayList list = dao.getList(search, searchText);
	
	for(int i=0; i<list.size(); i++){
	    
	    //ArrayList 객체배열에 담겨있는 하나의 사원DTO객체 꺼내오기
	    SawonDto dto = (SawonDto)list.get(i);
%>
	    <tr>
	    	<td><%=dto.getId() %></td><!-- select한 결과값 중 직원 id뿌려주기 -->
	    	<td><%=dto.getName() %></td><!-- select한 결과값 중 직원 이름 뿌려주기 -->
	    	<td><%=dto.getAge() %></td><!-- select한 결과값 중 직원 나이 뿌려주기 -->
	    	<td><%=dto.getAddr() %></td><!-- select한 결과값 중 직원 주소 뿌려주기 -->
	    	<td><%=dto.getDept() %></td><!-- select한 결과값 중 직원 부서정보 뿌려주기 -->
	    	<td><%=dto.getExtension() %></td><!-- select한 결과값 중 직원 뿌려주기 -->
	    	<!-- 직원 수정 페이지로 이동 시 수정할 직원 번호를 넘겨준다. -->
	    	<td><a href="modifySawon.jsp?no=<%=dto.getNo()%>">직원정보수정</a></td>
	    	<!-- 직원 삭제 페이지로 이동 시 삭제할 직원 번호를 넘겨준다. -->
	    	<td><a href="javascript:fnDel(<%=dto.getNo()%>)">직원정보삭제</a></td>
	    </tr>
<%
	}
%>

</table>
</body>
</html>