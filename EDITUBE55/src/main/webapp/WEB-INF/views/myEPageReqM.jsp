<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">
<!-- dialog용 태그 -->
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
   <header>
      <jsp:include page="header.jsp"></jsp:include>
   </header>
   <div class="myEPageReqMWrap">
      <aside class="myEPageReqMaside">
         <jsp:include page="myEPage.jsp"></jsp:include>
      </aside>
      <div class="myEPageReqMSection">
         <div class="myEPageReqMTitle">
            <p>전체 내역</p>
         </div>
         <div class="myEPageReqMSearch">
            <p>
               날짜조회 <input type="date" name="reqDatestart"> 부터 <input
                  type="date" name="reqDateend"> 까지 <input type="button"
                  class="reqDateBtn" value="조회">
            </p>
         </div>
         <div class="myEPageReqMContentWrap">
            <div class="myEPageReqMContentTitle">
               <div class="dateMenu">
                  <p>날짜</p>
               </div>
               <div class="contentMenu">
                  <p>내역</p>
               </div>
            </div>
            <div class="myEPageReqMIncontent">
               <c:forEach var="reqItem" items="${reqList}">
                  <div class="inDate">${reqItem.rq_date}</div>
                  <div class="inContent">${reqItem.rq_msg}</div>
                  <div class="reqBtn">
                     <!-- 관리자와의 요청대기중 상태 필요-->

                     <c:if test="${reqItem.rq_mnickname == mb.m_nickname}">
                        <c:if test="${reqItem.rq_status == 1}">
                           <button type="button" class="btnReq1"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 1, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">수락</button>
                           <button type="button" class="btnReq2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 2, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">거절</button>
                        </c:if>
                        <c:if test="${reqItem.rq_status == 2}">
                           <button type="button" class="btnSend1" disabled="disabled">대기중</button>
                           <button type="button" class="btnSend2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 3, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">취소</button>
                        </c:if>
                        <c:if test="${reqItem.rq_status == 3}">
                           <button type="button" class="btnIng1"
                              onclick="goChat('${reqItem.rq_targetnickname}')">1:1문의</button>
                           <button type="button" class="btnIng2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 4, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">취소</button>
                           <button type="button" class="btnIng3" onclick="statusChange('${reqItem.rq_targetnickname}', 5, ${reqItem.rq_num} , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">완료요청</button>
                        </c:if>
                        <c:if test="${reqItem.rq_status == 4}">
                           <button type="button" disabled="disabled">대기중</button>
                        </c:if>
                        <c:if test="${reqItem.rq_status == 5}">
                           <button type="button" class="comReq1"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 6, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">수락</button>
                           <button type="button" class="comReq2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 7, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">거절</button>
                        </c:if>
                        <c:if test="${reqItem.rq_status == 6}">
                           <button type="button" disabled="disabled">대기중</button>
                        </c:if>

                        <c:if test="${reqItem.rq_status == 7}">
                           <!-- 내가 거래 건놈이고 타입이 1 그러므로 내가 유튜버일ㄸ -->
                           <c:if test="${reqItem.rq_type == 1}">
                              <c:if test="${reqItem.rq_chk != 0}">
                                 <input type="button" value="후기남기기 완료" disabled="disabled">
                              </c:if>
                              <c:if test="${reqItem.rq_chk == 0}">
                                 <input type="button"
                                    onclick="document.querySelector('#confirm-rat').showModal()"
                                    class="reqBtn" value="후기 남기기" id="ratModalOpen">
                                 <dialog id="confirm-rat" class="rat">
                                 <form action="InsertRatFrm" method="get" class="InsertRatFrm"
                                    name="InsertRatFrm">
                                    <div class="rat-content">
                                       <h4 class="rat-title">후기를 남겨주세요</h4>
                                       <div class="container">

                                          <div class="rating">
                                             <label> <input type="radio" name="ra_score"
                                                value="1" /> <span class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="2" /> <span class="icon">★</span> <span
                                                class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="3" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="4" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span> <span
                                                class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="5" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span>
                                             </label>
                                          </div>


                                       </div>
                                       <div class="rat-TextWrap">
                                          <input type="text" name="ra_content" class="ra_content"
                                             placeholder="후기를 10자이상 적어주세요">
                                       </div>
                                       <div class="rat-options">
                                          <input type="hidden" name="ra_nickname"
                                             value="${reqItem.rq_targetnickname}"> <input
                                             type="hidden" name="m_nickname"
                                             value="${reqItem.rq_mnickname}"> <input
                                             type="hidden" name="ra_rqnum" value="${reqItem.rq_num}">
                                          <input type="submit" value="수락" id="ratModalOk"> <input
                                             type="button" value="거절"
                                             onclick="document.querySelector('#confirm-rat').close()">
                                       </div>
                                    </div>
                                 </form>
                                 </dialog>
                              </c:if>
                           </c:if>
                        </c:if>
                        <!-- "InsertRat(${reqItem.rq_targetnickname})" -->
                     </c:if>
                     <c:if test="${reqItem.rq_targetnickname == mb.m_nickname}">
                        <c:if test="${reqItem.rq_targetstatus == 1}">
                           <button type="button" class="btnReq1"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 1, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">수락</button>
                           <button type="button" class="btnReq2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 2, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">거절</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 2}">
                           <button type="button" class="btnSend1" disabled="disabled">대기중</button>
                           <button type="button" class="btnSend2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 3, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">취소</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 3}">
                           <button type="button" class="btnIng1"
                              onclick="goChat('${reqItem.rq_mnickname}')">1:1문의</button>
                           <button type="button" class="btnIng2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 4, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">취소</button>
                           <button type="button" class="btnIng3"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 5, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">완료요청</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 4}">
                           <button type="button" disabled="disabled">대기중</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 5}">
                           <button type="button" class="comReq1"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 6, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">수락</button>
                           <button type="button" class="comReq2"
                              onclick="statusChange('${reqItem.rq_targetnickname}', 7, ${reqItem.rq_num}
                        , '${mb.m_nickname}', '${reqItem.rq_mnickname}')">거절</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 6}">
                           <button type="button" disabled="disabled">대기중</button>
                        </c:if>
                        <c:if test="${reqItem.rq_targetstatus == 7}">
                        
                           <c:if test="${reqItem.rq_type == 2}">
                              <c:if test="${reqItem.rq_chk != 0}">
                                 <input type="button" value="후기남기기 완료" disabled="disabled">
                              </c:if>
                              <c:if test="${reqItem.rq_chk == 0}">
                                 <input type="button"
                                    onclick="document.querySelector('#confirm-rat').showModal()"
                                    class="reqBtn" value="후기 남기기" id="ratModalOpen">
                                 <dialog id="confirm-rat" class="rat">
                                 <form action="InsertRatFrm" method="get" class="InsertRatFrm"
                                    name="InsertRatFrm">
                                    <div class="rat-content">
                                       <h4 class="rat-title">후기를 남겨주세요</h4>
                                       <div class="container">

                                          <div class="rating">
                                             <label> <input type="radio" name="ra_score"
                                                value="1" /> <span class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="2" /> <span class="icon">★</span> <span
                                                class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="3" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="4" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span> <span
                                                class="icon">★</span>
                                             </label> <label> <input type="radio" name="ra_score"
                                                value="5" /> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span> <span
                                                class="icon">★</span> <span class="icon">★</span>
                                             </label>
                                          </div>


                                       </div>
                                       <div class="rat-TextWrap">
                                          <input type="text" name="ra_content" class="ra_content"
                                             placeholder="후기를 10자이상 적어주세요">
                                       </div>
                                       <div class="rat-options">
                                          <input type="hidden" name="ra_nickname"
                                             value="${reqItem.rq_targetnickname}"> <input
                                             type="hidden" name="m_nickname"
                                             value="${reqItem.rq_mnickname}"> <input
                                             type="hidden" name="ra_rqnum" value="${reqItem.rq_num}">
                                          <input type="submit" value="수락" id="ratModalOk"> <input
                                             type="button" value="거절"
                                             onclick="document.querySelector('#confirm-rat').close()">
                                       </div>
                                    </div>
                                 </form>
                                 </dialog>
                              </c:if>
                           </c:if>
                        </c:if>
                        
                     </c:if>
                  </div>
               </c:forEach>
            </div>
         </div>
      </div>
   </div>
   <div>
      <jsp:include page="footer.jsp"></jsp:include>
   </div>
</body>
<script type="text/javascript">
$('#ratModalOk').click(function(){
   $('#ratModalOpen').attr("disable");
   $('#ratModalOpen').attr("value","후기를 이미 남기셨습니다.")
});

$(':radio').change(function() {
  console.log('New star rating: ' + this.value);
});
function statusChange(rtnick,snum, rnum, mnick, rnick){
   console.log(rtnick,snum, rnum, mnick, rnick);
   
   var myNum=0;
   var targetNum=0;
   
   if(mnick==rnick){
      if(snum == 1){
         myNum=3;
         targetNum=3;
         var stc = confirm(rnick+"님의 요청을 수락하시겠습니까");
         if(stc == true){
            alert("수락되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 2){
         myNum=8;
         targetNum=8;
         var stc = confirm(rnick+"님의 요청을 거절하시겠습니까");
         if(stc == true){
            alert("수락되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 3){
         myNum=8;
         targetNum=8;
         var stc = confirm("정말로진짜로 '"+rtnick+"'님에게 보낸요청을 취소하시겠습니까?");
         if(stc == true){
            alert("보낸요청이 취소되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 4){
         myNum=6;
         targetNum=6;
         var stc = confirm("정말로진짜로 진행중인 거래를 취소하시겠습니까?");
         if(stc == true){
            alert("취소요청이 완료되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum; 
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 5){
         myNum=4;
         targetNum=5;
         var stc = confirm("거래 완료 요청을 진행하시겠습니까?");
         if(stc == true){
            alert("완료요청이 완료되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 6){
         myNum=7;
         targetNum=7;
         var stc = confirm("거래 완료 요청을 수락하시겠습니까?");
         if(stc == true){
            alert("거래가 완료되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 7){
         myNum=3;
         targetNum=3;
         var stc = confirm("거래 완료 요청을 '거절' 하시겠습니까?");
         if(stc == true){
            alert("완료요청이 '거절' 되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
   }else if(mnick==rtnick){
      alert("11")
      if(snum == 1){
         myNum=3;
         targetNum=3;
         var stc = confirm(rnick+"님의 요청을 수락하시겠습니까");
         if(stc == true){
            alert("수락되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 2){
         myNum=8;
         targetNum=8;
         var stc = confirm(rnick+"님의 요청을 거절하시겠습니까");
         if(stc == true){
            alert("수락되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 3)
      {
         myNum=6;
         targetNum=6;
         var stc = confirm(rnick+"님과의 거래를 취소하시겠습니까");
         if(stc == true){
            alert("취소요청이 완료되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 4){
         myNum=6;
         targetNum=6;
         var stc = confirm("거래취소 요청을 보내시겠습니까?");
         if(stc == true){
            alert("취소 요청이 전송되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 5){
         myNum=5;
         targetNum=4;
         var stc = confirm(rnick+"님에게 거래완료 요청을 보내시겠습니까?");
         if(stc == true){
            alert("완료 요청이 전송되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 6){
         myNum=7;
         targetNum=7;
         var stc = confirm("거래를 완료하시겠습니까?");
         if(stc == true){
            alert("거래서 성공적으로 완료되었습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      
      if(snum == 7){
         myNum=3;
         targetNum=3;
         var stc = confirm("완료요청을 거절하시겠습니까?");
         if(stc == true){
            alert("완료요청을 거절하셨습니다.");
            location.href='./statusChange?rnum=' + rnum + "&myNum=" + myNum + "&rnick=" + rnick +"&targetNum=" + targetNum;
         }
         else{
            alert("취소되었습니다.");
         }
      }
   }
}

function goChat(nick){
   window.open("chating?nick="+nick, "chating", "width=500, height=650, left=100, top=50, location=no, resiznable=no"); 
}


</script>
</html>