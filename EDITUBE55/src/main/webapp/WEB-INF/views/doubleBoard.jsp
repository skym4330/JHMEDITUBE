<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link
   href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"
   rel="stylesheet">
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/commuBoard.css?after" rel="stylesheet">
<link href="resources/css/editBoard.css?after" rel="stylesheet">
<link href="resources/css/doubleBoard.css?after" rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
   rel="stylesheet">
   
<script type="text/javascript">
$(document).ready(function(){
   
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
   <div class="double-all">
      <div class="side">
         <jsp:include page="doubleNav.jsp"></jsp:include>
      </div>
      <div id="wrap">
         <div id="accordian">
            <div class="step" id="step1">

               <div class="title">
                  <h3>${ubpositiontype} 편집자 프로필</h3>
               </div>
               <div class="modify"
                  onclick="location.href='./plist?pageNum=${pageNum}'">
                  <i class="fa fa-plus-circle"></i>
               </div>
            </div>
            <div class="content">
                  <c:forEach var="pitem" items="${pList}">
                     <div class="card">
                        <input type="hidden" name="pstatus" value="${pitem.pstatus}">
                        <div class="data-area">
                           <a href="pcontents?pnum=${pitem.pnum}"> <img
                              class="card-image" src="resources/images/${pitem.msysname}" />
                           </a> <a class="card-description"
                              href="pcontents?pnum=${pitem.pnum}">
                              <div><p>${pitem.ptitle}</p></div>
                              <div><p>닉네임 : ${pitem.pnickname}</p></div>
                              <hr>
                              <div><p>금액 : ${pitem.pcost} 원</p></div>
                           </a>
                        </div>
                     </div>
                  </c:forEach>
            </div>
            <div class="step" id="step2">
               <div class="title">
                  <h3>${ubpositiontype} 편집자 구합니다</h3>
               </div>
               <div class="modify">
                  <i class="fa fa-plus-circle" onclick="location.href='timearry'"></i>
               </div>
            </div>
            <div class="content">
               <div class="data-area">
                  <div class="title-row">
                     <div class="u-name p-15">작성자</div>
                     <div class="u-title p-50">제목</div>
                     <div class="u-price p-15">가격</div>
                     <div class="u-resdate p-10">작성일</div>
                     <div class="u-findate p-10">마감일</div>
                  </div>

                  <c:forEach var="bitem" items="${utList}">
                     <div class="data-row">
                        <input type="hidden" name="ubpositiontype"
                           value="${bitem.ubpositiontype}"> <input type="hidden"
                           name="status" value="${bitem.ubstatus}">
                        <div class="u-name p-15">${bitem.ubnickname}</div>
                        <div class="u-title p-50">
                           <a href="utcontent?ubnum=${bitem.ubnum}"> ${bitem.ubtitle}</a>
                        </div>
                        <div class="u-price p-15">${bitem.ubcost}</div>
                        <div class="u-date p-10">
                           <fmt:formatDate value="${bitem.ubtimepart}"
                              pattern="yyyy-MM-dd" />
                        </div>
                        <div class="u-date p-10">
                           <fmt:formatDate value="${bitem.ubdeadline}"
                              pattern="yyyy-MM-dd" />
                        </div>
                     </div>
                  </c:forEach>
               </div>

            </div>

         </div>
      </div>
   </div>
</body>
<script type="text/javascript">
   $(function() {      

       $('.side > a').click( function() {

           var sn = $(this).attr('side-no');
          console.log(sn);
          location.href="./doubleBoard?ubpositiontype="+ sn;

       });   
   });
</script>   
</html>