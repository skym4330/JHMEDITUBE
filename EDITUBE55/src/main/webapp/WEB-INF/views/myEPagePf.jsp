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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
#pfBtnWrap:focus{
	outline: none;
}
</style>
</head>
<body>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<div class="myEPagePfWrap">
<aside class="myEPagePfaside">
<jsp:include page="myEPage.jsp"></jsp:include>
</aside>
<input type="hidden" name="pnickname" value="${mb.m_nickname}">
<div class="myEPagePfSection">
	<c:if test="${port.ptitle == null}">
		<div>
			<div class="pfImageWrap" style="width: 1100px; height: 600px;">
				<img src="resources/images/pf123.png" style="width: 100%; height: 100%;">
			</div>
			<div>
				<button type="button" id="pfBtnWrap" onclick="location.href='./inPortfolio?nick=${mb.m_nickname}'" 
				style="width: 225px; height: 50px; border: none; color: white; background-color: black; border-radius: 30px; float: right;">작성</button>
			</div>
		</div>
	</c:if>
	<c:if test="${port.ptitle != null}">
	<div class="myEPagePfTitle">
		<div class="CashTitleName">
			<p>${port.ptitle}</p>
		</div>
		<div class="myCash">
			<p>금액: ${port.pcost}</p>
		</div>
	</div>
	<div class="UVideoBox">
		<iframe width="880" height="495" src="${port.plink}" 
		frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
		</iframe>
		${port.plink}
	</div>
	<div class="hashTag">
		<p>#${port.pstatus}</p>
	</div>
	<div class="introduceWrap">
		<div class="introduce">
			<p>소개글</p>
		</div>
	</div>
	<div class="introduceContentWrap">
		<div class="introduceContent">
			<p><pre style="white-space: pre-wrap; font-size: 14px;">${port.pcontent}</pre></p>
		</div>
	</div>
	<div class="btnWrap">
		<div class="btnDiv">
			<button type="button" id="update" onclick="location.href='./upPortfolio?nick=${mb.m_nickname}'">수정</button>
			<!-- <button type="button" onclick="location.href='./upPortfolio'">수정</button> -->
			<button type="button" id="write" onclick="location.href='./inPortfolio?nick=${mb.m_nickname}'">작성</button>
			<button type="button" id="date" onclick="dateUp('${mb.m_nickname}')">갱신</button>
			
		</div>
	</div>
	</c:if>
</div>
</div>
</body>
<script type="text/javascript">
function dateUp(pnickname){
	location.href='./dateUp?pnickname='+pnickname;
}
$(document).ready(function() {
	   var title = '${port.ptitle}';
	   
	   //포트폴리오를 쓰지 않았을 때
	   if(title == "") {
	      $('#date').hide();
	      $('#update').hide();
	      $('#write').show();
	   }
	   //포트폴리오를 썼을 때
	   else {
	      $('#date').show();
	      $('#update').show();
	      $('#write').hide();
	   }
	});
</script>
</html>