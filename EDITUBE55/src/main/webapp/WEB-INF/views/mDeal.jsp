<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">
<link href="resources/css/mDealReason.css?after" rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
<div class="myEPageReqMWrap">
<aside class="myEPageReqMaside">
<jsp:include page="mMypageNav.jsp"></jsp:include>
</aside>
<div class="myEPageReqMSection">
	<div class="myEPageReqMTitle">
		<p>전체 내역</p>
	</div>
	<div class="myEPageReqMSearch">
		<p>
		날짜조회 
		<input type="date" name="reqDatestart"> 부터
		<input type="date" name="reqDateend"> 까지 
		<input type="button" class="reqDateBtn" value="조회">
		</p>
	</div>
	<div class="myEPageReqMContentWrap">
		<div class="myEPageReqMContentTitle">
			<div class="dateMenu"><p>날짜</p></div>
			<div class="contentMenu" style=width:600px;><p>내역</p></div>
			<div class="statusMenu"><p>상태</p></div>
		</div>
		<c:forEach var="mRItem" items="${rMList}">
			<dialog id="confirm-modal" class="modal">
			  <div class="modal-content">
			    <h4 class="modal-title">거래 취소 요청</h4>
			    <p>'위즈덤'님의 취소 요청입니다. </p>
			    <article class="modal-description">
			      <div class="container">
			        <p>거래 조건이 맞지 않아서 취소 요청합니다.</p>
			      </div>
			    </article>
			    <div class="modal-options">
			      <input type="button"
			        value="수락"
			       type="button"
			        onclick="cancelOk(${mRItem.rq_num},1)"
			      >
			      <input type="button"
			             value="거절"
			        onclick="cancelOk(${mRItem.rq_num},2)"
			      >
			      <input type="button"
			             value="취소"
			        onclick="document.querySelector('#confirm-modal').close()"
			      >
			    </div>
			  </div>
			</dialog>
			<div class="myEPageReqMIncontent">
				<div class="inDate">
					<p>${mRItem.rq_date}</p>			
				</div>
				<div class="inContent" style="width:600px; height: 100px;">
					<c:if test="${mRItem.rq_status == 6}">
						<p>${mRItem.rq_mnickname}님과 ${mRItem.rq_targetnickname} 님간의 거래취소 요청이 도착했습니다. </p>
						<div class="inBtn">
							<input type="button" onclick="document.querySelector('#confirm-modal').showModal()" class="statusbtn" value="상세내역"
							style="float: right; position: relative; bottom: 40px; left: 165px; ">
						</div>
					</c:if>
					<c:if test="${mRItem.rq_status == 8}">
						<p>${mRItem.rq_mnickname}님과 ${mRItem.rq_targetnickname} 님간의 거래가 취소되었습니다. </p>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</div>

</body>
<script type="text/javascript">
function cancelOk(rnum,conNum){
	location.href="./cancelOk?rnum=" + rnum +"&conNum=" + conNum;
}
</script>
</html>