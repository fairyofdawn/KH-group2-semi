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
 	<c:set var="list" value="${asklist }"/>
 	 	<table border="1" cellspacing="0">
 	 	 	<tr>
 	 	 	 	<td>
 	 	 	 	 	<form method="post" 
 	 	 	 	 	   action="<%=request.getContextPath() %>/ask_search.do">
 	 	 	 	 	   <span>고객센터</span>
 	 	 	 	 	 	<select name="find_field">
 	 	 	 	 	 	 	<option value="all">전체</option>
 	 	 	 	 	 	 	<option value="delivery">배송</option>
 	 	 	 	 	 	 	<option value="#"></option>
 	 	 	 	 	 	 	<option value="#">도서</option>
 	 	 	 	 	 	</select>
 	 	 	 	 	 	<input type="text" name="find_name"> 	 	
 	 	 				<input type="submit" value="검색">	 	 	 	 	 	
 	 	 	 	 	</form>
 	 	 	 	</td>
 	 	 	</tr>
 	 	 	<c:if test="${!empty list }">
 	 	 	 	<c:forEach items="${list }" var="dto">
 	 	 	 	 	<tr>
 	 	 	 	 	<th>배송관리</th>
 	 	 	 	 	 	<td>
 	 	 	 	 	 	${dto.getCs_title() }
 	 	 	 	 	 	</td>
 	 	 	 	 	</tr>
 	 	 	 	</c:forEach>
 	 	 	</c:if>
 	 	 	<c:if test="${empty list}">
 	 	 	  	<tr>
 	 	 	  	 	<td colspan="2">
 	 	 	  	 	<h3>검색된 결과가 없습니다.</h3>
 	 	 	  	 	</td>
 	 	 	  	</tr>
 	 	 	</c:if>
 	 	</table>
 	</div>
 	
</body>
</html>