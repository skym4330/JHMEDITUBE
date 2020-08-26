<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editube</title>
<!-- 앨범관련입니다 -->
<link href="resources/js/album.js">

<!-- 헤더, 네비게이션 관련 -->
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css?after"
   rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css?after"
   rel="stylesheet">
<link
   href="resources/vendor/simple-line-icons/css/simple-line-icons.css?after"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
   rel="stylesheet" type="text/css">


<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      var mnickname = '${mb.m_nickname}';
      if (mnickname == '${uscript.ub_mnickname}') {

      }

      var status = '${status}';

      if (status == '건별편집') {
         $('.tgl-btn').css('background', '#FF3A19');
         $('.tgl-btn:last-child').css('background', '#55595c');
      } else if (status == '정기편집') {
         $('.tgl-btn').css('background', '#55595c');
         $('.tgl-btn:last-child').css('background', '#FF3A19');
      }
   });
</script>
</head>
<body>
<header>
   <jsp:include page="header.jsp"></jsp:include>
</header>
<div class="myEPageScWrap">
   <aside class="myEPageScaside">
      <jsp:include page="myEPage.jsp"></jsp:include>
   </aside>
   <div class="myEPageScSection">
   <div class="ya">
      <h2 class="yt">찜한 유튜버</h2>
      <!-- 나중에 입력받는걸로 바뀜 -->
      <div class="yb">
         <input class="tgl tgl-flip" id="cb7" name="status1"
            onclick="check('건별편집')" type="checkbox" value="건별"> <label
            class="tgl-btn" for="cb7">건별</label> <input class="tgl tgl-flip"
            id="cb8" name="status2" onclick="check('정기편집')" type="checkbox"
            value="정기"> <label class="tgl-btn" for="cb8">정기</label>

      </div>

      <div class="dropdown">
         <span class="selLabel" id="sort">정렬</span> <input type="hidden"
            name="cd-dropdown">
         <ul class="dropdown-list">
            <li data-value="1"><span onclick="timearry()">작성일순</span></li>
            <li data-value="2"><span onclick="deadarry()">마감일순</span></li>
         </ul>
      </div>

   </div>

   <div class="data-area">
      <div class="title-row">
         <div class="u-name p-15">작성자</div>
         <div class="u-status p-10">모집유형</div>
         <div class="u-title p-50">제목</div>
         <div class="u-price p-15">가격</div>
         <div class="u-resdate p-10">작성일</div>
         <div class="u-findate p-10">마감일</div>
      </div>
      <input type="hidden" name="nickname" id="nickname"
         value="${mb.m_nickname}">

      <c:forEach var="bitem" items="${utList}">
         <div class="data-row">
            <div class="u-name p-15">${bitem.ubnickname}</div>
            <div class="u-status p-10">${bitem.ubstatus}</div>
            <div class="u-title p-50">
               <a href="utcontent?ubnum=${bitem.ubnum}"> ${bitem.ubtitle}</a>
            </div>
            <div class="u-price p-15">${bitem.ubcost}</div>
            <div class="u-date p-10">
               <fmt:formatDate value="${bitem.ubtimepart}" pattern="yyyy-MM-dd" />
            </div>
            <div class="u-date p-10">
               <fmt:formatDate value="${bitem.ubdeadline}" pattern="yyyy-MM-dd" />
            </div>
         </div>
      </c:forEach>
      <c:forEach var="bitem" items="${udList}">
         <div class="data-row">
            <div class="u-name p-15">${bitem.ubnickname}</div>
            <div class="u-status p-10">${bitem.ubstatus}</div>
            <div class="u-title p-50">
               <a href="udcontent?ubnum=${bitem.ubnum}"> ${bitem.ubtitle}</a>
            </div>
            <div class="u-price p-15">${bitem.ubcost}</div>
            <div class="u-date p-10">
               <fmt:formatDate value="${bitem.ubtimepart}" pattern="yyyy-MM-dd" />
            </div>
            <div class="u-date p-10">
               <fmt:formatDate value="${bitem.ubdeadline}" pattern="yyyy-MM-dd" />
            </div>
         </div>
      </c:forEach>
   </div>
   <div class="btn-area">
      <div class="paging">${paging}</div>
   </div>
   </div>
</div>
<footer>
   <jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
<script type="text/javascript">
   function check(status) {
      var cb10 = document.getElementById("cb10");

      if ($("input:checkbox[name=status1]").is(":checked") == true) {
         location.href = './timearryasc?status=' + status;
      } else if ($("input:checkbox[name=status2]").is(":checked") == true) {
         location.href = './timearrybsc?status=' + status;
      } else {
         location.href = './timearry';
      }
   }

   function timearry() {
      location.href = './timearrySc';
   }

   function deadarry() {
      location.href = './deadarrySc';
   }
</script>
</html>