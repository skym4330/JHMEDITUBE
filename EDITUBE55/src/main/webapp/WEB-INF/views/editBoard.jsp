<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>편집자 게시판</title>


<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/editBoard.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">

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
<style type="text/css">
.side {
   position: relative;
}
.card {
   display:inline-block;
}
</style>
<script type="text/javascript">

$(document).ready(function(){
   
   switch('${pstatus}'){
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
   <jsp:include page="editNav.jsp"></jsp:include>
<div class="econtent">
   <div class="ya" style="height:60px; ">
      <h2 class="yt">${pitem.ptitle}편집자 프로필</h2>
        <div class="dropdown">
          <span class="selLabel" id="sort2">정렬</span>
          <input type="hidden" name="cd-dropdown">
          <ul class="dropdown-list">
            <li data-value="1">
              <span onclick="location.href='./plist?pageNum=${pageNum}'">최신순</span>
            </li>
            <li data-value="4">
              <span onclick="location.href='./sortView?pageNum=${pageNum}'">인기순</span>
            </li>
          </ul>
         </div>
  </div>

 <div style="height: 1000px;">
 <div style="height: 950px;">
  <c:forEach var="pitem" items="${pList}">
   <div class="card">
      <input type= "hidden" name = "pstatus" value="${pitem.pstatus}">
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
   </div>    
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
<script type="text/javascript">
   $(function() {
       $('.side > a').click( function() {

           var sn = $(this).attr('side-no');
          console.log(sn);
          location.href="./plist?pstatus="+ sn;          
       });   
   });
</script>
</html>