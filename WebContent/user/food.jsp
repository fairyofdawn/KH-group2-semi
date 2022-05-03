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
 	 <c:set var="dto" value="${productCode }"/>
 	 	<c:if test="${!empty dto }">
 	 	 	<table border="1" cellspacing="0">
 	 	 	 	<tr>
 	 	 	 	 	<td>카테고리</td>
 	 	 	 	</tr>
 	 	 	 	<tr>	 	 	 	 	
 	 	 	 	 <td>
 	 	 	 	  	<div class="line">CATEGORY</div> 
 	 	 	 	  	<div class="img_check">
 	 	 	 	  	<a href="#"><img src="image/사과.png" width="100" height="100">사과</a>
 	 	 	 	  	<a href="#"><img src="image/배.png" width="100" height="100">배</a>
 	 	 	 	  	<a href="#"><img src="image/바나나2.png" width="100" height="100">바나나</a>
 	 	 	 	  	<a href="#"><img src="image/방울토마토4.png" width="100" height="100">방울토마토</a>
 	 	 	 	  	<a href="#"><img src="image/토마토5.png" width="100" height="100">토마토</a>
 	 	 	 	  	</div>
 	 	 	 	 </td>
 	 	 	 	 </tr>	 
 	 	 	 	 <tr>
 	 	 	 	 <td>
 	 	 	 	  	<div class="img_check">
 	 	 	 	  	<a href="#"><img src="image/메론.png" width="100" height="100">메론</a>
 	 	 	 	  	<a href="#"><img src="image/수박1.png" width="100" height="100">수박</a>
 	 	 	 	  	<a href="#"><img src="image/사파이어포도.png" width="100" height="100">사파이어포도</a>
 	 	 	 	  	<a href="#"><img src="image/오렌지3.png" width="100" height="100">오렌지/파인애플</a>
 	 	 	 	  	<a href="#"><img src="image/천혜향한라봉.png" width="100" height="100">감귤류</a>
 	 	 	 	  	</div>
 	 	 	 	 </td>
 	 	 	 	 </tr>	
 	 	 	 	<tr>
 	 	 	 	  <td>과일</td>
 	 	 	 	</tr>
 	 	 	 	<
 	 	 	</table>
 	  	</c:if>
 	 	
 	 	<c:if test="${page > block }">
 	 	 	<a href="paging.do?page=1">◀◀</a>
 	 	 	<a href="paging.do?page=${startBlock -1 }">◀</a>
 	 	</c:if>
 	 	
 	 	<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
 	 	 	<c:if test="${i == page }">
 	 	 	 	<b><a href="paging.do?page=${i }">[${i }]</a></b>
 	 	 	</c:if>
 	 	 	
 	 	 	<c:if test="${i != page }">
 	 	 	 	<a href="paging.do?page=${i }">[${i }]</a>
 	 	 	</c:if>
 	 	</c:forEach>
 	 	
 	 	<c:if test="${endBlock < allPage }">
 	 	 	<a href="paging.do?page=${endBlock + 1 }">▶</a>
 	 	 	<a href="paging.do?page=${allPage}">▶▶</a>
 	 	</c:if>
 	</div>

</body>
</html>