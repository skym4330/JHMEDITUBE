<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
   var mnickname = '${mb.m_nickname}';
   if(mnickname == '') {
   $('#suc').css('display','none');
   $('#bef').css('display','block');
   }
   else if(mnickname != '') {
   $('#suc').css('display','block');
   $('#bef').css('display','none');
}
});

function goAlertPage(){
   
   if('${mb.m_usertype==1}'){
      location.href("./myUPageReqM");
   }else{
      location.href("./myEPageReqM");
   }
}
</script>
<div class="header">
   <div class="headerWidth">
      <div class="header-left">

         <!-- 메뉴창  -->

         <!-- start header -->
         <div class="hmenu">
            <div id="h2menu">
               <div class="container">
                  <nav id="Hmenu">

                     <input type="checkbox" id="toggle-nav" /> 
                     <label id="toggle-nav-label" for="toggle-nav">
                        <img id="xicon" src="resources/images/xicon.png">
                     </label>
                     <div class="box">

                        <ul>
                           <li class="h3menu"><a class="h4menu"
                              href='./plist?pageNum=${pageNum}'> <img
                                 src="resources/images/moni.png"
                                 style="margin-right: 10px; width: 30px;"> Editer
                           </a></li>
                           <ul class="sumenuicon">
                              <li><a href="./doubleBoard?ubpositiontype=게임 방송">Game</a></li>
                              <li><a href="./doubleBoard?ubpositiontype=먹방">Eating Show</a></li>
                              <li><a href="./doubleBoard?ubpositiontype=뷰티">Beauty</a></li>
                              <li><a href="./doubleBoard?ubpositiontype=브이로그">V Log</a></li>
                              <li><a href="./doubleBoard?ubpositiontype=음악 방송">music</a></li>
                              <li><a href="./doubleBoard?ubpositiontype=기타">Etc</a></li>
                           </ul>

                           <li class="h3menu"><a class="h4menu"
                              href="./timearry"> <img
                                 src="resources/images/utubeicon.png"
                                 style="margin-right: 10px; width: 30px;"> Youtuber
                           </a></li>

                           <ul class="sumenuicon">
                              <li><a href="./timearrya?ubpositiontype=게임 방송&status=건별편집">One-off</a></li>
                              <li><a href="./timearrya?ubpositiontype=게임 방송&status=정기편집">Regular</a></li>
                           </ul>

                           <li class="h3menu"><a class="h4menu" href="./commuBoard">
                                 <img src="resources/images/gigu.png"
                                 style="margin-right: 8px; width: 30px;"> Community
                           </a></li>

                           <ul class="sumenuicon">
                              <li><a href="./commuBoard?cbstatus=1">Notice</a></li>
                              <li><a href="./commuBoard?cbstatus=2">Free Board</a></li>
                              <li><a href="./commuBoard?cbstatus=3">Together</a></li>
                              <li><a href="./commuBoard?cbstatus=4">Casting</a></li>
                           </ul>
                        </ul>
                     </div>
                  </nav>
               </div>
            </div>
         </div>

         <!-- 메뉴창 -->
         <svg id="hmicon" xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24" fill="none" stroke="currentColor"
            stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
            style="width: 35px;">
    <path d="M3 12h18M3 6h18M3 18h18" /></svg>
         <div class="headerlogo">
            <img class="top-left logo" src="resources/images/logo.png"
               onclick="gohome();">
         </div>
      </div>


      <form action="https://www.youtube.com/results" method="get" class="search-bar">
      <div class="search-bar">
         <input name="search_query" type="text" placeholder="Search..."/>
      </div>
      </form>

      <div id="bef">
         <div>
            <a href="./loginFrm">Login</a> &nbsp; / &nbsp; <a href="./signPageFrm">Sign Up</a>
         </div>
      </div>
      
         
      <div class="user-settings" id="suc">
         
       <a href="#" id="cart">  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
            fill="currentColor" stroke="currentColor" stroke-width="1.5"
            stroke-linecap="round" stroke-linejoin="round" style="width: 35px; float: left;">
            
            <img src="resources/images/bell.png" alt="" style="width: 35px; float: left;">
            
         </svg>
       </a>
       
<div class="container">
  <div class="shopping-cart">
    <div class="shopping-cart-header">
      <a href="#" id="toggle1"> 
             <span id="badge1">알림</span>
        </a>
        <a href="#" id="toggle2"> 
             <span id="badge2">1:1문의</span>
        </a>
    </div>
    <div id="ajaxWrap">
     <div class="mesege">
          <ul class="shopping-cart-items">
            <li class="clearfix">
             <p class="item-price">총 ${one}건의 미수락 거래요청이 있습니다.</p>
              <p class="item-price">총 ${five}건의 미수락 완료요청이 있습니다.</p>

   <c:if test="${mb.m_usertype == 1}">
      <c:if test="${mb.m_nickname != '관리자'}">
       <a href="./myUPageReqM" class="button">확인하러 가기</a>      
      </c:if>
      <c:if test="${mb.m_nickname == '관리자'}">
         <a href="./mDeal" class="button">확인하러 가기</a>
      </c:if>
   </c:if>
   <c:if test="${mb.m_usertype == 2}">
       <a href="./myEPageReqM" class="button">확인하러 가기</a>
   </c:if>
             </li>
          </ul>
    
   </div><!-- mesege end -->
   
   
   <div class="mesege2">
  
    <ul class="shopping-cart-items">
       <c:forEach var="chatItem" items="${chatList}">
        <c:if test="${chatItem.ch_mnickname != mb.m_nickname}">
          <li class="clearfix">
           <img src="resources/images/chating.png" onclick="goChat('${chatItem.ch_mnickname}')"> 
                 <div id="chatingLogoWrap">
                 </div>
                 <p>
                    ${chatItem.ch_mnickname}님과의 진행중인 대화가 있습니다.
                 </p>
         </li>
              </c:if>
       </c:forEach>
    </ul>
    
   </div><!-- mesege end -->
   </div>
  </div> <!--end shopping-cart -->
</div> <!--end container -->
       
         <nav class="t_nav">
            <ul id="userDrop">
               <li class="headerdrop">
                  <a href="#" class="headerbtn">
                     <img class="user-profile " src="resources/images/${mb.m_sysName}">
               </a>
               <div class="dcont">
               <input type="hidden" name="nickname" id="nickname" value="${mb.m_nickname}">
                    <a onclick ="mypage()" class="headerdropbox"> My Page</a> 
                    <a href="./myInfo"> 계정설정</a>
                    <a href="./logout"> Logout</a>
                </div>
               </li>
            </ul>
         </nav>
      </div>
</div>
</div>

   <script>
   function goChat(nick){
      window.open("chating?nick="+nick, "chating", "width=500, height=650, left=100, top=50, location=no, resiznable=no"); 
   }
   
      function gohome() {
         var id = '${mb.m_id}';
         if (id == '') {
            location.href = './';
         } else if (id != '') {
            location.href = './';
         }
      }
      function mypage() {
         var nickname = "${mb.m_nickname}";
         var usertype = "${mb.m_usertype}";         
         
         if(usertype == 1){
            if(nickname == '관리자'){
               location.href = './mDeal'
            }
            else{
               location.href = './myUPageSc'
            }
         }
         if(usertype == 2){
            location.href = './timearrySc'
         }
      }
      
      
      (function(){
         $("#cart").on("click", function() {
           $(".shopping-cart").fadeToggle("fast");
         })
         
       })();
      
      
      
      (function(){
         $("#toggle1").on("click", function() {
           $(".mesege").fadeIn();
           $("#badge1").css("background-color", "#0a4bd3");
           $("#badge2").css("background-color", "#6394f8");
         });
         
       })();
      
      
      (function(){
         $("#toggle2").on("click", function() {
           $(".mesege2").fadeIn();
           $("#badge1").css("background-color", "#6394f8");
           $("#badge2").css("background-color", "#0a4bd3");
         });
         
       })();
      
      
      (function(){
         $("#toggle2").on("click", function() {
           $(".mesege").hide();
         });
         
       })();
      
      
      (function(){
         $("#toggle1").on("click", function() {
           $(".mesege2").hide();
         });
         
       })();
      
      
           
      
      
       
   </script>