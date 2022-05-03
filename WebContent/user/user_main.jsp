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
 	 <c:set var="list" value="${ksproduct }"/>
 	 <table border="1" cellspacing="0">
 	  <c:if test="${!empty list }">
 	   	<tr>
 	   	 	<td></td>
 	   	</tr>
 	  </c:if>
 	  
 	  <c:if test="${empty list }">
 	   	<tr>
 	   	 	<td>
 	   	 	 	<h3>제품 목록이 없습니다.</h3>
 	   	 	</td>
 	   	</tr>
 	  </c:if>
 	 </table>
 	</div>

</body>
</html>