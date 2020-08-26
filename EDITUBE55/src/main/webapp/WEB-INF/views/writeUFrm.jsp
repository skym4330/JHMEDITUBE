<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

<link href="resources/css/sideBar.css" rel="stylesheet">
<link href="resources/css/writeCommuFrm.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">


<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>


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
<!-- calendar -->

</head>
<script type="text/javascript">
$(document).ready(function(){

  	var ubpositiontype = '${ubpositiontype}';
   	$('#s1').addClass('current');
   	switch(ubpositiontype){
   	case '게임 방송':
   		$('#s1').addClass('current');	
   	break;
   	case '먹방':
   		$('#s2').addClass('current');	
   		break;
   	case '뷰티':
   		$('#s3').addClass('current');	
   		break;
   	case '브이로그':
   		$('#s4').addClass('current');	
   		break;
   	case '음악방송':
   		$('#s5').addClass('current');	
   		break;
   	case '기타':
   		$('#s6').addClass('current');	
   	}
});
</script>
<body>
<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="all">
		<jsp:include page="youtubeNav.jsp"></jsp:include>
		<div id="page-wrapper" class="clearfix">

			<h1>Write</h1>

			<form action="uboardWrite" method="POST" id="file-form" enctype="multipart/form-data">
			<input type="hidden" name="ubnickname" value="${mb.m_nickname}">
			<input type="hidden" name="msysname" value="${mb.m_sysName}">
			<input type="hidden" name="moriname" value="${mb.m_oriName}">
				<!-- POST로 나중에 바꾸기 -->
				<div class="field">
					<input type="text" name="ubtitle" id="filename"
						placeholder="제목을 입력하세요.">
				</div>
				<div class="opt">
					<div id="type">
						<input class="tgl tgl-flip" id="cb10" name="status" type="checkbox" onclick="check()"/>
						<label class="tgl-btn" data-tg-off="건별" data-tg-on="정기" for="cb10"></label>
						<input type="hidden" name="ubstatus" id="ubstatus" value="건별편집">
					</div>
				
					<div id="pri">
						금액: <input type="number" name="ubcost" id="price"
							placeholder="금액을 입력하세요.">
					</div>
					<div id="date">
						마감일: <input name="ubdeadline" type="date">
					</div>
				</div>
				<div class="checkBox">
				<div class="cpack">
					<input class="ckb" id="check1" type="radio" name="ubpositiontype" value="게임 방송" checked
						> <label id="che" for="check1">게임 방송</label>
				</div>
				<div class="cpack">
					<input class="ckb" id="check2" type="radio" name="ubpositiontype" value="먹방"
						> <label id="che" for="check2">먹방</label>
				</div>
				<div class="cpack">
					<input class="ckb" id="check3" type="radio" name="ubpositiontype" value="브이로그"
						> <label id="che" for="check3">브이로그</label>
				</div>
				<div class="cpack">
					<input class="ckb" id="check4" type="radio" name="ubpositiontype" value="뷰티"
						> <label id="che" for="check4">뷰티</label>
				</div>
				<div class="cpack">
					<input class="ckb" id="check5" type="radio" name="ubpositiontype" value="음악 방송"
						> <label id="che" for="check5">음악 방송</label>
				</div>
				<div class="cpack">
					<input class="ckb" id="check6" type="radio" name="ubpositiontype" value="기타"
						> <label id="che" for="check6">기타</label>
				</div>
				</div>
				<div class="field">
					<textarea name="ubcontent" id="content" placeholder="내용을 입력하세요."></textarea>
				</div>
				<div class="btn-field">
					<button type="button" id=cancel
						onclick="location.href='./timearry'">취소</button>
					<button type="submit" id="submit">저장</button>
					<div id="messages"></div>
				</div>
			</form>
		</div>
	</div>

</body>
<script src="resources/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript">
      $(document).ready(function () {
        $('#submit').click(function () {
          // getter
          var radioVal = $('input[name="positiontype"]:checked').val();
          $(".ubpositiontype").val(radioVal);
        });

      });
					
      function check() {
			var cb10 = document.getElementById("cb10");
			var a = '정기편집';
			var b = '건별편집';
			var status = $("#ch10").val();
			$("#ubstatus").val(status);

			if ($("input:checkbox[name=status]").is(":checked") == true) {
				$("#ubstatus").val(a);
			} else {
				$("#ubstatus").val(b);
			}
		}
	</script>
</html>