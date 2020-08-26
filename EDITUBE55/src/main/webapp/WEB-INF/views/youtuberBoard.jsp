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

<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/commuBoard.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/footerStyle.css" rel="stylesheet">
<script	src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<script src="resources/js/select.js"></script>
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
<script type="text/javascript">
$(document).ready(function(){
	var sort = '${sort}';
	console.log(sort);
	$('#sort').html(sort);
	
	var usertype = '${mb.m_usertype}';
	if(usertype == 2){
		$('.cowr-btn').css('display','none');
	}
	else if(usertype == ''){
		$('.cowr-btn').css('display','none');
	}
	var status = '${status}';
	
	if(status == '건별편집'){
		$('.tgl-btn').css('background', '#FF3A19');
		$('.tgl-btn:last-child').css('background', '#55595c');
	}
	else if(status == '정기편집'){
		$('.tgl-btn').css('background', '#55595c');
		$('.tgl-btn:last-child').css('background', '#FF3A19');
	}
	
	var ubpositiontype = '${ubpositiontype}';
	
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
</head>
<body>
<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="all">
		<jsp:include page="youtubeNav.jsp"></jsp:include>
		<div class="ucontent">

			<div class="ya">
				<h2 class="yt">모집게시판</h2>
				<!-- 나중에 입력받는걸로 바뀜 -->
				<div class="yb">
					<input class="tgl tgl-flip" id="cb5" name="status1" onclick="check('${ubpositiontype}','건별편집')" type="checkbox" value="건별편집">
					<label class="tgl-btn" for="cb5">건별</label>	
					<input class="tgl tgl-flip" id="cb6" name="status2" onclick="check('${ubpositiontype}','정기편집')" type="checkbox" value="정기편집">
					<label class="tgl-btn" for="cb6">정기</label>	
					
				</div>

  <div class="dropdown">
    <span class="selLabel" id="sort">정렬</span>
    <input type="hidden" name="cd-dropdown">
    <ul class="dropdown-list">
      <li data-value="1">
        <span onclick="timearry()">작성일순</span>
      </li>
      <li data-value="2">
        <span onclick="deadarry()">마감일순</span>
      </li>
    </ul>
  </div>

			</div>

			<div class="data-area">
				<div class="title-row">
					<div class="u-resdate p-10">작성일</div>
					<div class="u-name p-15">작성자</div>
					<div class="u-status p-10">모집유형</div>
					<div class="u-title p-50">제목</div>
					<div class="u-price p-15">가격</div>
					<div class="u-findate p-10">마감일</div>
				</div>
				<c:forEach var="bitem" items="${utList}">
					<div class="data-row">
						<input type= "hidden" name = "ubpositiontype" value="${bitem.ubpositiontype}">
						<input type= "hidden" name = "status" value="${bitem.ubstatus}">
						<div class="u-date p-10"><fmt:formatDate value="${bitem.ubtimepart}" pattern="yyyy-MM-dd" /></div>
						<div class="u-name p-15">${bitem.ubnickname}</div>
						<div class="u-status p-10">${bitem.ubstatus}</div>
						<div class="u-title p-50"> 
							<a href="utcontent?ubnum=${bitem.ubnum}"> ${bitem.ubtitle}</a>
						</div>
						<div class="u-price p-15">${bitem.ubcost}</div>
						<div class="u-date p-10"><fmt:formatDate value="${bitem.ubdeadline}" pattern="yyyy-MM-dd" /></div>
					</div>
				</c:forEach>
				<c:forEach var="bitem" items="${udList}">
					<div class="data-row">
						<div class="u-date p-10"><fmt:formatDate value="${bitem.ubtimepart}" pattern="yyyy-MM-dd" /></div>
						<div class="u-name p-15">${bitem.ubnickname}</div>
						<div class="u-status p-10">${bitem.ubstatus}</div>
						<div class="u-title p-50">
							<a href="udcontent?ubnum=${bitem.ubnum}"> ${bitem.ubtitle}</a>
						</div>
						<div class="u-price p-15">${bitem.ubcost}</div>
						<div class="u-date p-10"><fmt:formatDate value="${bitem.ubdeadline}" pattern="yyyy-MM-dd" /></div>
					</div>
				</c:forEach>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
				<button class="cowr-btn" onclick="location.href='./writeUFrm'">글쓰기</button>
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
			 location.href="./timearry?ubpositiontype="+ sn;

		 });	
	});
	
      function timearry(){
    	  location.href='./timearry';
      }
      
      function deadarry(){
    	  location.href='./deadarry';
      }
      
      function check(ubpositiontype,status) {
			var cb10 = document.getElementById("cb10");

			if ($("input:checkbox[name=status1]").is(":checked") == true) {
				location.href='./timearrya?ubpositiontype='+ubpositiontype + '&status='+ status;
			}
			else if($("input:checkbox[name=status2]").is(":checked") == true) {
				location.href='./timearryb?ubpositiontype='+ubpositiontype + '&status='+ status;
				}
			else{
				location.href='./timearry';
			}
		}

      </script>      
</html>