<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>

<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/content.css?after" rel="stylesheet">
<link href="resources/css/commuBoard.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/footerStyle.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
	
      var chk = '${uboard.chk}'
          if(chk == 1){
             $('#reqBtn').attr('disabled','disabled');
             $('#reqBtn').val('거래중');
          }
   
   var mnickname = '${mb.m_nickname}';
   var usertype = '${mb.m_usertype}';
   var scnumlist = '${uscriptlist.sc_ubnum}';
   var scnum = '${uscript.sc_ubnum}';
   var ubnum = '${uboard.ubnum}';
   
   if(mnickname == '${uboard.ubnickname}') {
      $('.btn4').css('display','block');
      $('.btn1').css('display','none');
      $('.btn6').css('display','none');
      $('.btn7').css('display','none');
      $('.btn5').css('display','block');
      $('.btn3').css('display','none');

   }
   else if(mnickname == '관리자') {
      $('.btn4').css('display','none');
      $('.btn1').css('display','none');
      $('.btn6').css('display','block');
      $('.btn7').css('display','none');
      $('.btn5').css('display','block');
      $('.btn3').css('display','none');

   }
   else if(mnickname != '${uboard.ubnickname}') {
      if(usertype == 1 || usertype == ''){
           $('.btn1').css('display','none');
            $('.btn3').css('display','none');
            $('.btn4').css('display','none');
            $('.btn5').css('display','none');
            $('.btn6').css('display','block');
            $('.btn7').css('display','block');
         }  
      else{
            $('.btn4').css('display','none');
            $('.btn1').css('display','block');
            $('.btn5').css('display','none'); //삭제
            $('.btn6').css('display','none');
            $('.btn7').css('display','none');
               if(scnum == ubnum){
                  $('.btn8').css('display','block');
                  $('.btn3').css('display','none');
               }
               else if(scnumlist == ubnum){
                  $('.btn8').css('display','block');
                  $('.btn3').css('display','none');
               }
               else{
                  $('.btn8').css('display','none');
                  $('.btn3').css('display','block');
               }
         }
   }
   
     var ubpositiontype = '${uboard.ubpositiontype}';
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
<div class="uContentWrap">
   <aside class="uContentAside">
      <jsp:include page="youtubeNav.jsp"></jsp:include>
   </aside>
   <input type="hidden" name="ubnum" value="${uboard.ubnum}">
   <input type="hidden" name="ubnickname" value="${uboard.ubnickname}">
   <input type="hidden" name="nickname" value="${mb.m_nickname}">
   <input type="hidden" name="ubusertype" value="1">
   <div class="mainSectionWrap">
      <div class="mainSectionWrap-top">
         <div class="pfImageBox">
            <img src="resources/images/${uboard.msysname}">
         </div>
         <div class="pfInfoWrap">
            <div class="pfInfoOne">[${uboard.ubstatus}]<h2>#${uboard.ubpositiontype}</h2></div>
            <div class="pfInfoTwo"><h1><span>${uboard.ubnickname}</span>님의 편집자를 구합니다</h1></div>
            <div class="pfInfoThree"><p>마감기한 : <span><fmt:formatDate value="${uboard.ubdeadline}" pattern="yyyy-MM-dd" /></span> 까지</p></div>
            <div class="pfInfoFour"><h2>${uboard.ubcost}원</h2></div>
            <div class="pfInfoFive">
               <input type="button" id="reqBtn" class="btn1" onclick="goReq(${uboard.ubnum},'${uboard.ubnickname}')" value="요청하기">
               <button type="button" class="btn6">편집자만 이용 가능</button>
               <button type="button" class="btn4" onclick="location.href='./updateUFrm?ubnum=${uboard.ubnum}'">수정하기</button>
               <button type="button" class="btn2" onclick="location.href='./timearry?ubpositiontype=${uboard.ubpositiontype}'">목록으로</button>
               <button type="button" class="btn3" onclick="uscript(${uboard.ubnum},'${mb.m_nickname}','1')">찜하기</button>
               <button type="button" class="btn8" onclick="uscriptdel(${uboard.ubnum}, '${mb.m_nickname}')">찜취소</button>
               <button type="button" class="btn5" onclick="goDelete(${uboard.ubnum},'${mb.m_nickname}','${uboard.ubnickname}')">삭제하기</button>
               <button type="button" class="btn7">편집자만 이용 가능</button>
            </div>
         </div>
      </div>
      <div class="mainSectionWrap-bottom">
         <div class="uContentTitleWrap">
            <div class="uContentTitle">
               <h2>${uboard.ubtitle}</h2>
               <img alt="포인트" src="resources/images/point01.png">
            </div>
         </div>
         <div class="uContentContentWrap">
            <div class="uContentContent">
               <p>${uboard.ubcontent}</p>
            </div>
         </div>
      </div>
   </div>
</div>
<footer>
    <jsp:include page="footer.jsp"></jsp:include>
</footer>
<script type="text/javascript">

$(function() {      

    $('.side > a').click( function() {

        var sn = $(this).attr('side-no');
       console.log(sn);
       location.href="./timearry?ubpositiontype="+ sn;

    });   
});

function uscript(ubnum, nickname, usertype){
   var script = confirm("게시물을 찜하시겠습니까?")
   
   if(script == true){
      location.href='./uscript?ubnum=' + ubnum +'&nickname=' + nickname +'&usertype=' + usertype;
   }
   else{
      alert("취소되었습니다.");
   }
}
function uscriptdel(ubnum, nickname){
   var script = confirm("찜을 취소하시겠습니까?")
   
   if(script == true){
      location.href='./uscriptdel?ubnum=' + ubnum + '&nickname=' + nickname;
   }
   else{
      alert("취소되었습니다.");
   }
}

function goDelete(ubnum, lnick, ubnick){
   var del = confirm("정말로 삭제 하시겠습니까?");
   if(del == true){
      location.href='./udelete?ubnum=' + ubnum;
   }
   
   if(lnick != ubnick){
      if(lnick == "관리자"){
         if(del == true){
            location.href='./udelete?ubnum=' + ubnum;
         }
      }
      else{
      alert("본인이 작성한 글이 아니면 삭제할 수 없습니다.");
      }
      return;
   }
   else{
      alert("취소되었습니다.");
   }
}

function goReq(bnum, nick){
      var del = confirm(nick + "님에게 거래를 요청 하시겠습니까?");
      if(del == true){
         location.href='./goReq?bnum='+bnum+'&nick='+nick;
         alert("요청이 완료되었습니다");
         $("#reqBtn").attr("disabled");
      }
      else{
         alert("취소되었습니다.");
      }
   
}
</script>
</body>
</html>