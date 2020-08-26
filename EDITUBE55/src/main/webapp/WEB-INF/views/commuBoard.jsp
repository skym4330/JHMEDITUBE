<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>EDITUBE</title>

<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
	rel="stylesheet" />
<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/commuBoard.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/footerStyle.css" rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet">
<link
	href="resources/vendor/simple-line-icons/css/simple-line-icons.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">	
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var status = '${cbstatus}'
	var mnickname = '${mb.m_nickname}';
	
	if(mnickname ==''){
		$('.cowr-btn').hide();
	}
	
	if(status==1 && mnickname !="관리자"){
		$('.cowr-btn').hide();
	}
	
	var chk = "${check}";

	if(chk=="2"){
		alert("글 등록 성공!");
		location.reload(true);
	}
	if(chk=="3"){
		alert("글 삭제 성공!");
		location.reload(true);
	}
	switch('${cbstatus}'){
	case '1':
		$('#s1').addClass('current');
		break;
	case '2':
		$('#s2').addClass('current');
		break;
	case '3':
		$('#s3').addClass('current');
		break;
	case '4':
		$('#s4').addClass('current');
		break;
	}
	$("#ctype").html('${cbname}');
});

</script>

</head>
<body>
<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
	<div class="all">
		<jsp:include page="commuNav.jsp"></jsp:include>
		<div class="ucontent">
			<div>
				<h2 id="ctype">공지사항</h2>
				<!-- 나중에 입력받는걸로 바뀜 -->
			</div>
			<div class="data-area">
				<div class="title-row">
					<div class="t-bnum p-10">글번호</div>
					<div class="t-title p-60">제목</div>
					<div class="t-name p-15">작성자</div>
					<div class="t-date p-15">작성일</div>
				</div>
				<c:forEach var="cbitem" items="${cbList}">
					<div class="data-row">
					<input type= "hidden" name = "cbstatus" value="${cbitem.cbstatus}">
						<div class="u-bnum p-10">${cbitem.ronum}</div>
						<div class="u-title p-60">
							<a href="commuContent?cbstatus=${cbitem.cbstatus}&cbnum=${cbitem.cbnum}"> ${cbitem.cbtitle}</a>
						</div>
						<div class="u-name p-15">${cbitem.cbnickname}</div>
						<div class="u-date p-15"><fmt:formatDate value="${cbitem.cbdate}" pattern="yyyy-MM-dd" /></div>
					</div>
				</c:forEach>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				
				<button class="cowr-btn" onclick="cbWriteFrmGo()">글쓰기</button>
			</div>
		</div>
	</div>
	<footer>
 	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
<script type="text/javascript">
 	$(function() {
 		 $('.side > a').click( function() {

		 	 var sn = $(this).attr('side-no');
			 console.log(sn);
			 location.href="./commuBoard?cbstatus="+sn; 			
 		 });	
 	});
 	function cbWriteFrmGo() {
 		location.href="./writeCommuFrm?cbstatus="+${cbstatus}; 
	}
</script>
</html>