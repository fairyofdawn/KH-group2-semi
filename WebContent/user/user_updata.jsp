<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/top.css">
</head>
<body>

 	<jsp:include page="../inculde/top.jsp"/>
 	
 	<div align="center">
 	 <span>회원 정보 수정</span>
 	 	<form method="post" 
 	 	 	action="<%=request.getContextPath() %>/user_updata.do">
 	 	 
 	 	 <c:set var="dto" value="${User }"/>
 	 	 
 	 	  <table border="1" cellspacing="0">
 	 	  <c:if test="${!empty dto }">
 	 	   	<tr>
 	 	   	 	<th>아이디</th>
 	 	   	 	<td><input name="userId" value="${dto.getUser_id() }">
 	 	   	</tr>
 	 	   	<tr>
 	 	   	 	<th>이 름</th>
 	 	   	 	<td><input name="userName" value="${dto.getUser_name() }">
 	 	   	</tr>
 	 	   	<tr>
 	 	   	 	<th>이메일</th>
 	 	   	 	<td><input name="userEmail" value="${dto.getUser_email() }"></td>
 	 	   	</tr>
 	 	   	<tr>
 	 	   	 	<th>주소</th>
 	 	   	 	<td><input name="userAddr" value="${dto.getUser_addr() }"> </td>
 	 	   	</tr>
 	 	   	<tr>
 	 	   	 	<th>핸드폰</th>
 	 	   	 	<td><input name="userPhone" value="${dto.getUser_phone() }"></td>
 	 	   	</tr>
 	 	   	
 	 	   	<tr>
 	 	   	<td colspan="2" align="center">
 	 	   	 	<input type="submit" value="정보수정">
 	 	   	 	<input type="reset" value="다시작성">
 	 	   	</td>
 	 	   	</tr>
 	 	 </c:if>
 	 	 <c:if test="${empty dto }">
 	 	  	<tr>
 	 	  	 	<td colspan="2">
 	 	  	 	 	<h3>검색 된 정보가 없습니다.</h3>
 	 	  	 	</td>
 	 	  	</tr>
 	 	 </c:if>
 	 	 </table>
 	 	</form>
 	</div>

</body>
</html>