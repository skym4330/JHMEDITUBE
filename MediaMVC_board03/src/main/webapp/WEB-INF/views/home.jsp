<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>스프링 게시판 홈</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="resources/css/style.css">
<script type="text/javascript">
$(document).ready(function(){
	var chk = "${msg}";
	
	if(chk != ""){
		alert(chk);
		location.reload(true);
	}
	
    $('.slider').bxSlider({
    	auto: true,
    	slideWidth: 600,
    });
    
    var mql = window.matchMedia("screen and (max-width: 768px)"); 
    mql.addListener(function(e) { 
    	if(!e.matches) { 
    		slider.reloadSlider();
    	}
    });
});
</script>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
	<div class="content-home">
		<div class="slider">
			<div><img src="resources/images/img_5terre.jpg"></div>
			<div><img src="resources/images/img_forest.jpg"></div>
			<div><img src="resources/images/img_lights.jpg"></div>
			<div><img src="resources/images/img_mountains.jpg"></div>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</div>
</body>
</html>






