<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
		location.reload(true);
	}
});
</script>

<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="myEPageCashWrap">
	
	<c:if test="${mb.m_usertype == 2}">
		<aside class="myEPageCashaside">
			<jsp:include page="myEPage.jsp"></jsp:include>
		</aside>
	</c:if>
	
	<c:if test="${mb.m_usertype == 1}">
		<aside class="myEPageCashaside">
			<jsp:include page="myUPage.jsp"></jsp:include>
		</aside>
	</c:if>
	
	<div class="myEPageCashSection">
	<div class="myEPageCashTitle">
		<div class="CashTitleName">
			<p>캐쉬 관리</p>
		</div>
		<div class="myCash">
			<p id="cash">${mb.m_mycash}원</p>
			<p>보유 캐쉬</p>
		</div>
		</div>
		
	<div class="myEPageCashSearch">
	<form action="cashSearch" method="get">
		<p> 날짜조회 
			<input type="date" name="sDate"> 부터
			<input type="date" name="eDate"> 까지 
		
			<button type="submit" class="CashDateBtn">조회</button>
		</p>
		
	</form>
		<div>
		 
			<input type="button" onclick="location.href='./chargeCash'" class="CashCharge" value="캐시충전">
			<input type="button" onclick="location.href='./cashTransform'" class="CashCharge" value="캐시환전">
		</div>
	</div>
	<div class="myEPageCashContentWrap">
		<div class="myEPageCashContentTitle">
			<div class="CashdateMenu"><p>날짜</p></div>
			<div class="CashcontentMenu"><p>내역</p></div>
		</div>
					
		<div class="myEPageCashIncontent">	
	
			
			<div class="CashinDate">
			<c:forEach var="cashItem" items="${cashList}">
				<div class="inDate">${cashItem.ca_date}</div>
			</c:forEach>
			</div>
			
			<div class="CashinContent">
			<c:forEach var="cashItem" items="${cashList}">
			
				<c:if test="${cashItem.ca_type == 1}">
					<div class="cashRe">${cashItem.ca_incash}원을 충전하였습니다.</div>
				</c:if>
					
				<c:if test="${cashItem.ca_type == 2}">
					<div class="cashRe">${cashItem.ca_outcash}원을 환전하였습니다.</div>
				</c:if>
				
				<c:if test="${cashItem.ca_type == 3}">
					<div class="cashRe">거래가 수락되어 ${cashItem.ca_outcash}원을 관리자에게 결제했습니다.</div>
				</c:if>
				
				<c:if test="${cashItem.ca_type == 4}">
					<div class="cashRe">거래가 최종 완료되어 ${cashItem.ca_incash}원을 받았습니다.</div>
				</c:if>
				
				<c:if test="${cashItem.ca_type == 5}">
					<div class="cashRe">거래가 취소되어 ${cashItem.ca_incash}원이 환불됐습니다.</div>
				</c:if>
				
					
			</c:forEach>
			</div>
			
			
		</div>
		</div>	

</div>
</div>
</body>
</html>  