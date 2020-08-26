<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Editube</title>

  <!-- Bootstrap core CSS -->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css?after" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="resources/vendor/fontawesome-free/css/all.min.css?after" rel="stylesheet">
  <link href="resources/vendor/simple-line-icons/css/simple-line-icons.css?after" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template -->
  <link href="resources/css/landing-page.min.css?after" rel="stylesheet">
  
  <link href="resources/css/headerstyle.css" rel="stylesheet">
    <link href="resources/css/footerStyle.css" rel="stylesheet">

</head>
<body>
<header>
 	<jsp:include page="header.jsp"></jsp:include>
</header>
  <!-- 중앙 이미지-->
  <header class="masthead text-white text-center">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-xl-9 mx-auto">
          <h1 class="mb-5">유튜버와 편집자의 편리한 만남!</h1>
           <h1 class="mb-5" style="font-size: 100px">EDITUBE</h1>
        </div>

      </div>
    </div>
  </header>

  <!-- 아이콘  -->
  <section class="features-icons bg-light text-center">
    <div class="container">
      <div class="row">
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
            <div class="features-icons-icon d-flex" >
              <i class="icon-screen-desktop m-auto text-primary" onclick="location.href='./plist'"></i>
            </div>
            <h3>에디터 프로필</h3>
            <p class="lead mb-0">편집자들의 편집실력을 <br> 확인하고 싶은가요?</p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
            <div class="features-icons-icon d-flex">
              <i class="icon-layers m-auto text-primary" onclick="location.href='./timearry'"></i>
            </div>
            <h3>편집자 모집유형 </h3>
            <p class="lead mb-0">건별 편집? 정기 편집?<br>여건에 맞게 편집자를 찾는다!</p>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-0 mb-lg-3">
            <div class="features-icons-icon d-flex">
              <i class="icon-check m-auto text-primary" onclick="location.href='./commuBoard'"></i>
            </div>
            <h3>커뮤니티</h3>
            <p class="lead mb-0">구독자를 더 늘릴 방법은?<br>커뮤니티에서 찾아보자!</p>
          </div>
        </div>
      </div>
    </div>
  </section>



</body>

</html>

<footer>
 	<jsp:include page="footer.jsp"></jsp:include>
</footer>




