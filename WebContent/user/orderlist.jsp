<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
 	 	<table border="1" cellspacing="0">
 	 	 	<tr>
 	 	 	 	<td colspan="6">
 	 	 	 	<h3>주문목록</h3>
 	 	 	 	</td>
 	 	 	</tr>
 	 	 	<tr>
 	 	 	 	<th>주문번호</th><th>상품정보</th><th>확인/신청</th>
 	 	 	</tr>
 	 	 <c:set var="list" value="${cartlist }"/>
 	 	 <c:if test="${!empty list }">
 	 	  <c:forEach items="${list }" var="dto">
 	 	   <tr>
 	 	   <td>${dto.getCart_no() }</td>
 	 	   </tr>
 	 	   	<tr>
 	 	   	 <td>
 	 	   	 <img src="<%=request.getContextPath() %>/image/${dto.getCart_pimage()}">
 	 	   	 <ul>
 	 	   	  	<li>${dto.getCart_no() }</li>
 	 	   	  	<li>${dto.getCart_pname() }</li>
 	 	   	  	<li>${dto.getCart_pqty() }</li>
 	 	   	  	<li><b>${dto.getCart_price() }</b>원</li>	 	   	  	
 	 	   	 </ul>
 	 	   	 </td>
 	 	   	</tr>
 	 	  </c:forEach>
 	 	</c:if>
 	 	<c:if test="${empty list }">
 	 	 	<tr>
 	 	 	<td colspan="6"><h3>검색된 결과가 없습니다.</h3></td>
 	 	 	</tr>
 	 	</c:if>
 	 	</table>
 	</div>

</body>
</html>