<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/writeCommuFrm.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var chk="${check}";
	
	if(chk=="1"){
		alert("글 등록 실패!");
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
		<div id="page-wrapper" class="clearfix">
			<h1>Write</h1>

			<form name="writeCommuFrm" action="writeCom" method="post" enctype="multipart/form-data"
				id="file-form">
				<input type="hidden" name="cbnickname" value="${mb.m_nickname}">
				<input type="hidden" name="cbstatus" value="${cbstatus}">
				<div class="field">
					<input type="text" name="cbtitle" id="filename" autofocus
						placeholder="제목을 입력하세요." required>
				</div>
				<div class="field">
					<textarea name="cbcontent" id="content" placeholder="내용을 입력하세요."></textarea>
				</div>
				<div class="btn-field">
					<button type="button" id=cancel
						onclick="cBoardGo()">취소</button>
					<button type="submit">저장</button>

				</div>
			</form>
		</div>
	</div>

</body>
<script type="text/javascript">
 	$(function() {
 		 $('.side > a').click( function() {

		 	 var sn = $(this).attr('side-no');
			 console.log(sn);
			 location.href="./commuBoard?cbstatus="+sn; 			
 		 });	
 	});
 	function cBoardGo() {
 		location.href="./commuBoard?cbstatus="+${cbstatus}; 
	}
</script>
</html>