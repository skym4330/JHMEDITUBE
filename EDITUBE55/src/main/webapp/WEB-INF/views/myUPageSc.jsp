<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editube</title>
<!-- 앨범관련입니다 -->
<link href="resources/js/album.js">

<!-- 헤더, 네비게이션 관련 -->
<link href="resources/css/editBoard.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">

<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<script src="resources/js/album.js"></script>
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

</head>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<div class="myEPageScWrap">
<aside class="myEPageScaside">
<jsp:include page="myUPage.jsp"></jsp:include>
</aside>
<div class="myEPageScSection">
<div class="mainSection">
   <div class="ya" style="height:60px;">
      <h2 class="yt" style="width: 900px; height: 60px;">찜한 에디터</h2>
        <div class="dropdown">
          <span class="selLabel">정렬</span>
          <input type="hidden" name="cd-dropdown">
          <ul class="dropdown-list">
            <li data-value="1">
              <span onclick="location.href='./plist?pageNum=${pageNum}'">최신순</span>
            </li>
            <li data-value="2">
              <span>거래순</span>
            </li>
            <li data-value="3">
              <span>평점순</span>
            </li>
            <li data-value="4">
              <span onclick="location.href='./sortView?pageNum=${pageNum}'">인기순</span>
            </li>
          </ul>
         </div>
  </div>

 
  <c:forEach var="pitem" items="${pList}">
   <div class="card">
      <input type= "hidden" name = "nickname" value="${mb.m_nickname}">
         <div class="data-area">
         <a href="pcontents?pnum=${pitem.pnum}&pnickname=${pitem.pnickname}">
            <img class="card-image" src="resources/images/${pitem.msysname}" />
       </a>
         <a class="card-description" href="pcontents?pnum=${pitem.pnum}&pnickname=${pitem.pnickname}">
            <div><p>${pitem.ptitle}</p></div>
            <div><p>닉네임 : ${pitem.pnickname}</p></div>
            <hr>
            <div><p>금액 : ${pitem.pcost} 원</p></div>
         </a>
       </div>  
   </div>      
   </c:forEach>    
      <div class="btn-area" style="float:left;">
               <div class="paging">${paging}</div>
      </div>
   </div> 
</div>
</div>
<footer>
    <jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>