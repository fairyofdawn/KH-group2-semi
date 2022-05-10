<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 선언  -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">



$(document).ready(function(){
	
   // 여러 ajax에서 동일하게 사용되는 속성 설정
   $.ajaxSetup({
      // ajax에서 한글 깨짐 문제 해결
      ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
      type :"post"
   });

	
	//종합정보(가격,배송비,포인트 등)
	setTotalInfo();
	

	$(".hidden_cart_checkbox").on("click", setTotalInfo);
	
	$(".all_cart_checkbox").on("click", allCheck);
	

	$(".hidden_cart_checkbox").on("click", partCheck);

	$(".amtBtn").on("click", qtyBtn);
	
	$("input[name='checkedDelete']").on("click", checkedDelete);
	
	$("input[name='ChangeAmtBtn']").on("click", ChangeAmtBtn);
	
	
});

/* 수량 변경 ajax */
function ChangeAmtBtn(){
		

		let qty = parseInt($(this).parent().prevAll("input[name='quantity']").val());

		var cartNum = $(this).next().val();
		
		var userId = $(this).siblings("input[name=userId]").val();
		

		$.ajax({
			url : "<c:url value='/user_Cart_QtyChange.do'/>", //c:url = getContextPath()
			datatype : "json",			//key, value 로 넘기는게 json 방식
			data : {
				aJaxCartQty : qty,
				aJaxCartNum : cartNum,
				aJaxUserId : userId
			},
			success : function(data){
				
				if(data>0){
					
					alert('변경되었습니다.');
					/* location.replace("<c:url value='/user_cart_list.do'/>"); */
				
				}else if (data == 0){
					
					alert('수량은 1개 이상 선택해주세요.');
					location.replace("<c:url value='/user_cart_list.do'/>");
					
				}else {
					alert('재고 수량보다 많은 수량을 입력하셨습니다.');
					location.replace("<c:url value='/user_cart_list.do'/>");
				}
			},
			error : function(){
				alert('통신 오류 발생');
			}
		
		});	
		
}

/* 결제 */
function goBuy(){
		 
	/* 현재문서. form(name) . action  */
	document.frm.action = "<%=request.getContextPath() %>/user_order.do";
	
	/* user_cart_add.do로 폼을 전달함 */
	document.frm.submit();
	
}


/* 선택 상품 삭제 버튼 클릭시 */
function checkedDelete() {
	
 	var checkBoxArr = new Array;
	
	var checkList = $("input[name='checkBox']"); 
	
	for(let i=0; i<checkList.length; i++){   
		
		if(checkList[i].checked){   
			
			checkBoxArr.push(checkList[i].value);
		
			console.log(checkBoxArr);
			
		}
	} 

	if(checkBoxArr.length == 0){
		
		alert("선택된 상품이 없습니다.");
	
	}else{ 
		
		if(confirm("정말 삭제하시겠습니까?")){
		
		 	$.ajax({
				url : "<c:url value='/user_cart_checkedDelete.do'/>", 
				type :"post",
				datatype : "json",			
				traditional : true,			
				data : {
					
					string : checkBoxArr
				},
				success : function(data){
					if(data>0){
						
						alert('삭제되었습니다.');
						
						location.replace("<c:url value='/user_cart_list.do'/>");
					
					}else{
						
						alert('삭제에 실패했습니다.');
					
					}
				},
				error : function(){
					alert('통신 오류 발생');
				}
			
			});	
	 	
		}else{
			
			alert("취소하였습니다.");
		
		}; //confirm문 end
	}//else문 end

}

//수량 +- 버튼
function qtyBtn(){
	
	  var nowAmt = parseInt($(this).parent().prev().val());
	   
	   $(this).val() === "+"? $(this).parent().prev().val( nowAmt +1)
			   						:  $(this).parent().prev().val( nowAmt -1);

}



function partCheck(){
	
	const checkBox = document.querySelectorAll('input[name="checkBox"]');

	const checkedBox = document.querySelectorAll('input[name="checkBox"]:checked');
	
	if(checkedBox.length === checkBox.length){
		$(".all_cart_checkbox").prop("checked", true);
	}else {
		$(".all_cart_checkbox").prop("checked", false);
	}
	
	setTotalInfo();
	
}


function allCheck(){
	
	if( $(".all_cart_checkbox").is(':checked') ){
        $(".hidden_cart_checkbox").prop("checked", true);
     	
	}else{
        $(".hidden_cart_checkbox").prop("checked", false);
    }
	
	setTotalInfo();

	
}

function setTotalInfo() {
	
	let totalPrice = 0;			//총 가격
	let totalCount = 0;			//총 갯수
	let totalPoint = 0;			//총 포인트
	let shippingPrice = 0;		//배송비
	let allTotalPrice = 0; 		//최종 가격
	
	
	
	$(".cart_info_td").each(function(index, element) {
	

		if($(element).find(".hidden_cart_checkbox").is(":checked") === true){
			
			//총 가격	
			totalPrice += parseInt($(element).find(".hidden_cart_totalPrice").val());
			//총 갯수
			totalCount += parseInt($(element).find(".quantity").val());
			//총 포인트
			totalPoint +=  parseInt($(element).find(".hidden_cart_point").val());
	
		}	
	});
	
	//배송비
	if(totalPrice >= 50000){
		shippingPrice = 0;
	}else if(totalPrice == 0){
		shippingPrice = 0;
	}else {
		shippingPrice = 4000;
	}
	
	//전체금액
	allTotalPrice = totalPrice + shippingPrice; 

	// 총 가격
	$(".totalPrice_span").text(totalPrice.toLocaleString());
	// 총 갯수
	$(".totalCount_span").text(totalCount);
	// 총 포인트
	$(".totalPoint_span").text(totalPoint.toLocaleString());
	// 배송비
	$(".shippingPrice_span").text(shippingPrice);	
	// 최종 가격(총 가격 + 배송비)
	$(".allTotalPrice_span").text(allTotalPrice.toLocaleString());
	

	
}


</script>
<style>

#cTable {
	
	margin-top: 100px;
	border-collapse: collapse;
	
	
}

#c2Table {
	
	border-collapse: collapse;
	border-color:  F3F3F3;
}

#cTitle{
	padding : 20px;
	
	
}

.csTitle{
	padding : 20px 0px;
	background-color: F3F3F3;
}


</style>

</head>
<body>
	
	<jsp:include page="../include/user_top.jsp"/>
	<form method="post" name="frm">
	
	<table style="border-bottom: 0"  width="1000" align="center" id="cTable"> 
		<tr>
			<td colspan="9" class="center" align="center" id="cTitle" >
				<h3>장바구니</h3>
			</td> 
		</tr>
	</table>
	
	<table border="1"  width="1000" align="center" id="c2Table"> 
		
		<tr class="thTitle" bgcolor="F3F3F3" style="border: none;"> 
			<th width="5%" class="csTitle">
				<div class="all_check_input_div">
					<input type="checkbox" class="all_cart_checkbox" checked="checked" id="allCheck"  >
					<span class="all_chcek_span"></span>
				</div>
			</th>
			<th width="10%" class="csTitle">번  호</th> 
			<th width="10%" class="csTitle">이미지</th>  
			<th width="15%" class="csTitle">상품명</th> 
			<th width="12%" class="csTitle">판매가</th>  
			<th width="15%" class="csTitle">수  량</th> 
			<th width="15%" class="csTitle">포인트</th>  
			<th width="10%" class="csTitle">합  계</th> 
			<th width="10%" class="csTitle">선  택</th> 
		</tr>
		
		
		<c:set var="list" value="${cartList }" />
		<c:set var="cnt" value="1"/>
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="dto" varStatus="status">
				<c:set var="price" value="${dto.getCart_price() }" />
				<c:set var="amount" value="${dto.getCart_pqty() }" />
				<tr align="center" name = "cart_num" style="border: 0px;" >
					<td class="cart_info_td" style="border-right: 0px;">
						<%-- 체크박스에 cart_num()을 value로 설정 --%>																							 
						<input type="checkbox" class="hidden_cart_checkbox" checked="checked" name="checkBox" value="${dto.getCart_num() }" style="border-left: none;">
						<input type="hidden" class="hidden_cart_num" name="checkNum" value="${dto.getCart_num() }" >
						<input type="hidden" class="hidden_cart_price" value="${dto.getCart_price() }">
						<input type="hidden" class="hidden_cart_pqty" value="${dto.getCart_pqty() }">
						<input type="hidden" class="hidden_cart_totalPrice" value="${price * amount }">
						<input type="hidden" class="hidden_cart_point" value="${price * amount  * 0.01 }">
						<input type="hidden" class="hidden_cart_seller" value="${dto.getCart_seller() }">
						
					</td>
				
					<td class="center" style="border-left: 0px; border-right: 0px;" >${fn:length(list) - status.index }</td>
					
					<td class="center" style="border-left: 0px; border-right: 0px;">
						<img src="<%=request.getContextPath() %>/upload/${dto.getCart_pimage() }"
							width="100" height="100">
					</td>
					<td class="center" style="border-left: 0px; border-right: 0px;">${dto.getCart_pname() }</td>
					<td class="center" >
						<fmt:formatNumber value="${dto.getCart_price() }" />원
					</td>
					
					
					<td class="center" align="center">
						<input type="text" name="quantity" value="${amount }" style="width:50px; text-align:center;" >
						<div>
							<input type="button" class="amtBtn" name="plus_btn" value="+">
							<input type="button" class="amtBtn" name="minus_btn" value="-">
						</div>
						<div>
							<input type="button" name="ChangeAmtBtn" value="변경">
							<input type="hidden" name="amtCartNum" value="${dto.getCart_num() }">
							<%-- sesseion.setAttribute로 설정한  ("userId", dto.getUser_id()); 를 가져옴 --%>
							<input type="hidden" name="userId" value="${userId }">
							<input type="hidden" name="price" value="${dto.getCart_price() }" >
						</div>
					</td>
					
					<td class="center">
						
						<fmt:formatNumber value="${price * amount  * 0.01 }" />원
					</td>
					<td class="center">
						<fmt:formatNumber value="${price * amount }"/>원
					</td>
					
					<td class="center">
						<input type="button" value="삭  제"
						onclick="if(confirm('삭제하시겠습니까?')){
							location.href='user_cart_delete.do?num=${dto.getCart_num() }'
						}">
					</td>
					
					<c:set var="total" value="${total + (price * amount) }"/>
					
					
				</tr>
				
			</c:forEach>
		</c:if>
		
		<c:if test="${empty list }">
			<tr style="border: 0px;">
				<td colspan="9" class="center" align="center" style="padding: 100px; ">
					<h3>장바구니가 비어있습니다.</h3>
				</td> 
			</tr>
		</c:if>
	</table>
	
	
	<table style="border: 0; width: 1000px; margin-top: 20px;" align="center">
		<tr>
			<td align="left">
				<input type="button" name = "checkedDelete" value ="선택 상품 삭제">
			</td>
		</tr>
	</table>
	
	<c:if test="${!empty list }">		
		<table style="border: 0; width: 1000px; margin-top: 30px;" align="center"> 
			<colgroup>
				<col width="60%">
				<col width="20%">
				<col width="20%">
			</colgroup> 
			<tr>
				<td rowspan="5">
					<img src="<%=request.getContextPath() %>/uploadFile/img.jpg" height="180px" width="620px" style="padding: 0px; margin: 0;">
				</td>
				<td align="right">
					<b>총 상품가격 :</b>
				</td>
				<td align="right">
					<span class="totalPrice_span"></span>원
				</td>
			</tr>
			<tr>
				
				<td align="right">
					<b>배송비 : </b>
				</td>
				<td align="right">
					<span class="shippingPrice_span"></span>원
				</td>
			</tr>
			<tr>
				
				<td align="right">
					<b>총 결제 예정 금액  : </b>
				</td>
				<td align="right">
					<span class="allTotalPrice_span"></span>원
				</td>
			</tr>
			<tr>
				<td align="right">
					<b>적립 예정 포인트  : </b>
				</td>
				<td align="right">
					<span class="totalPoint_span"></span>원
				</td>
			</tr>
			
			
			<tr>
				<td colspan="2" class="center" align="right" style="padding-top: 30px;">
					<a href="javascript:goBuy();" >
						<img src="<%=request.getContextPath() %>/uploadFile/order.jpg" border="0">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:history.back());">
						<img src="<%=request.getContextPath() %>/uploadFile/keepShop.jpg" border="0">
					</a>
				</td>
			</tr>
		</table>
	</c:if>
	

</form>
	
</body>
</html>
