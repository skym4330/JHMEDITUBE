<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>EDITUBE</title>

<link
   href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
   rel="stylesheet" />
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/editContent.css?after" rel="stylesheet">
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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

<!-- Custom styles for this template -->
<link href="resources/css/landing-page.min.css?after" rel="stylesheet">

</head>
<body>
   <header>
      <jsp:include page="header.jsp"></jsp:include>
   </header>
   <div id="top" class="wrapper">
      <div>
         <input type="hidden" name="pnickname" value="${mb.m_nickname}">
         <input type="hidden" name="m_usertype" value="${mb.m_usertype}">
         <input type="hidden" name="pusertype" value="1">
         <h1>'${port.pnickname}님의 편집자 게시물'</h1>
         <img class="user-profile " src="resources/images/star.png"
            style="width: 25px; height: 10px;"> ${sum} 점입니다
         <div class="video">
            <iframe width="1280" height="720" src="${port.plink}" width="640"
               height="360" frameborder="0"></iframe>
            <c:url value="https://www.youtube.com/embed/eERSahizuuc" var="name" />
         </div>
         <table class="4input" id="intro">
            <tr style="background-color: #FAFAFA;">
               <td style="background-color: #FAFAFA;"><a href="#intro"
                  class="button"
                  style="width: 240px; border: 1px solid; padding: 10px 20px;">편집자
                     소개</a></td>
               <td style="background-color: #FAFAFA;"><a href="#list"
                  class="button"
                  style="width: 240px; border: 1px solid; padding: 10px 20px;">Q&A</a></td>
               <td style="background-color: #FAFAFA;"><a href="#qna"
                  class="button"
                  style="width: 240px; border: 1px solid; padding: 10px 20px;">평가</a></td>
               <td style="background-color: #FAFAFA;"><a href="#notice"
                  class="button"
                  style="width: 240px; border: 1px solid; padding: 10px 20px;">취소
                     및 환불 규정</a></td>
            </tr>
         </table>
         <div class="table-users">
            <div class="titleheader">편집자 소개</div>
            <table>
               <tr height="200">
                  <td width="938">${port.pcontent}</td>
               </tr>
            </table>
            <div class="titlefoot"
               style="background-color: #E6E6E6; color: black; font-size: 30px; text-align: center;">금액:
               ${port.pcost}</div>
         </div>
         <table class="4input" id="intro" style="margin: 0 auto">
            <tr>
               <td style="background-color: #FAFAFA;">
              	    <input type="button" class="reqBtn" id="reqBtn" value="요청" class="buttons" onclick="goReq('${port.pnickname}')">
               </td>
               <td style="background-color: #FAFAFA;">
               		<button type="button" class="buttons" id="renew" onclick="reDate('${port.pnum}')">갱신</button>
               </td>
               <td style="background-color: #FAFAFA;">
               		<button type="button" class="buttons" id="scrap" onclick="pscript(${port.pnum},'${mb.m_nickname}','2')">찜하기</button>
               </td>
               <td style="background-color: #FAFAFA;">
                    <button type="button" class="buttons" id="scrapdel" onclick="pscriptdel(${port.pnum}, '${mb.m_nickname}')">찜취소</button>
               </td>
            </tr>
         </table>
         <div class="econtent">
            <div>
               <div class="titleheader">Q&A</div>
            </div>
            <div class="data-area">
               <div class="title-row">
                  <div class="t-bnum p-10">번호</div>
                  <div class="t-name p-13">닉네임</div>
                  <div class="t-title p-60">Q&A</div>
                  <div class="t-date p-13">등록일</div>
               </div>
               <div id="qnatot">
                  <c:forEach var="qnaitem" items="${qnaList}">
                     <div class="data-row" id="qnalist">
                        <div class="u-bnum p-10">${qnaitem.q_num}</div>
                        <div class="u-name p-13">${qnaitem.q_nickname}</div>
                        <div class="u-title p-60">
                           <a>${qnaitem.q_content}</a>
                        </div>
                        <div class="u-date p-13">${qnaitem.q_date}</div>
                     </div>
                  </c:forEach>
               </div>
               <div>
                  <input type="hidden" name="page" id="page" value="${page}" />
                  <button class="evalmore" id="qna" onclick="moreQna()">
                     Q&A 더보기</button>
               </div>
               <div>
                  <a href="#layer" class="btn" id="btnsw"
                     style="text-decoration: none; color: black;">작성</a>
               </div>
            </div>
         </div>

         <div class="dim-layer">
            <form action="qInsert" method="post" enctype="multipart/form-data">
               <div class="dimBg"></div>
               <div id="layer" class="pop-layer">
                  <div class="pop-container">
                     <div class="pop-conts">
                        <div class="popc">
                           <input type="hidden" name="q_nickname" value="${mb.m_nickname}">
                           <input type="hidden" name="q_pnum" value="${port.pnum}">
                           <p2 style="font-weight:bold; font-size:20px;">Q&A 등록</p2>
                           <div class="field">
                              <textarea name="q_content" id="content"
                                 placeholder="내용을 입력하세요.">${qna.q_content }</textarea>
                           </div>
                        </div>
                        <div class="button-container">
                           <input id="Storage" type="submit" value="작성 완료"
                              style="width: 240px;">
                        </div>

                        <div class="btn-r">
                           <a href="#" class="btn-layerClose">Close</a>
                        </div>
                        <!--// content-->

                     </div>
                  </div>
               </div>
            </form>
         </div>


         <div class="econtent">
            <div>
               <div id="eval" class="titleheader">평가</div>
               <!-- 나중에 입력받는걸로 바뀜 -->
            </div>
            <div class="data-area">
               <div class="title-row">
                  <div class="t-bnum p-10">번호</div>
                  <div class="t-name p-13">닉네임</div>
                  <div class="t-title p-60">후기</div>
                  <div class="t-date p-13">평점</div>
               </div>
               <div>
                  <c:forEach var="rateitem" items="${rateList}">
                     <div class="data-row" id="rate">
                        <div class="u-bnum p-10">${rateitem.ra_num}</div>
                        <div class="u-name p-13">${rateitem.m_nickname}</div>
                        <div class="u-title p-60">
                           <a>${rateitem.ra_content} </a>
                        </div>
                        <div class="u-date p-13">${rateitem.ra_score}</div>
                     </div>
                  </c:forEach>
               </div>
               <div>
                  <button class="evalmore" id="ratetot" onclick="moreRate()">평가
                     더보기</button>
               </div>
            </div>
         </div>



         <div class="table-users">
            <div id="notice" class="titleheader">취소 및 환불 규정</div>
            <img alt="" src="resources/images/www123.png"
               style="width: 100%; height: 100%">
         </div>
      </div>
   </div>
   <a href="#top"><img src="resources/images/up.png" class="up"></a>
   <script src="resources/js/jquery.serializeObject.js"></script>
   <script type="text/javascript">

$(document).ready(function(){
   var chk = '${port.chk}';
   if(chk == 1){
          $('.reqBtn').attr('disabled','disabled');
          $('.reqBtn').val('거래중');
      }
   var mnickname = '${mb.m_nickname}';
   var usertype = '${mb.m_usertype}';
   var pscriptlist ='${pscriptlist.sc_pnum}'
   var scnum = '${pscript.sc_pnum}';
   var pnum = '${port.pnum}';
   
   //글 작성자가 본인 일 때
   if(mnickname == '${port.pnickname}') {
      $('#reqBtn').css('display','none');
      $('#list').css('display','block');
      $('#renew').css('display','block');
      $('#scrap').css('display','none');
      $('#scrapdel').css('display','none');
      
      
      //작성자가 유튜버일 때
      if(usertype == 1) {
         $('#reqBtn').css('display','none');
         $('#list').css('display','block');
         $('#renew').css('display','block');
         $('#scrap').css('display','none');
         $('#scrapdel').css('display','none');
      }
      //작성자가 편집자일 때
      else {
         $('#reqBtn').css('display','none');
         $('#list').css('display','block');
         $('#renew').css('display','block');
         $('#scrap').css('display','none');
         $('#scrapdel').css('display','none');
      }
   }
   //글 작성자가 본인이 아닐 때
   else if(mnickname != '${port.pnickname}')  {
      //유저가 비회원일 때
      if(usertype == '') {
         $('#reqBtn').css('display','none');
         $('#list').css('display','block');
         $('#renew').css('display','none');
         $('#scrap').css('display','none');
         $('#scrapdel').css('display','none');
      }
      //유저가 유튜버일 때
      else if(usertype == 1) {
         $('#reqBtn').css('display','block');
         $('#list').css('display','block');
         $('#renew').css('display','none');
         if(scnum == pnum){
               $('#scrap').css('display','none');
               $('#scrapdel').css('display','block');
            }
            else if(pscriptlist == pnum){
               $('#scrap').css('display','none');
               $('#scrapdel').css('display','block');
            }
            else{
            $('#scrap').css('display','block');
            $('#scrapdel').css('display','none');
            }
      }
      //유저가 편집자일 때
      else {
         $('#reqBtn').css('display','none');
         $('#list').css('display','block');
         $('#renew').css('display','none');
         $('#scrap').css('display','none');
         $('#scrapdel').css('display','none');
      }
   }
   
});

function goReq(nick){
    var del = confirm(nick + "님에게 거래를 요청 하시겠습니까?");
    var bnum = 0;
    console.log("zdflasnfkbmadskfbnm" + bnum + nick);
    if(del == true){
       location.href='./goReq?bnum='+bnum+'&nick='+nick;
       alert("요청이 완료되었습니다");
       $(".req").attr("disabled");
    }
    else{
       alert("취소되었습니다.");
    }
 
}


function reDate(pnum){
   location.href='./reDate?pnum='+pnum;
}


$('.btn').click(function() {
    var $href = $(this).attr('href');
    layer_popup($href);
 });
 function layer_popup(el) {

    var $el = $(el); //레이어의 id를 $el 변수에 저장
    var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

    isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

    var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el.outerHeight()), docWidth = $(
          document).width(), docHeight = $(document).height();

    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
       $el.css({
          marginTop : -$elHeight / 2,
          marginLeft : -$elWidth / 2
       })
    } else {
       $el.css({
          top : 0,
          left : 0
       });
    }
 
    $el.find('a.btn-layerClose').click(function() {
       isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
       return false;
    });

    $('.layer .dimBg').click(function() {
       $('.dim-layer').fadeOut();
       return false;
    });
 }



var p=1; 
function moreQna() {
   p++;
   var pnum = ${port.pnum};
   var qnaObj = {"qnaNum": p, "q_pnum" : pnum};
   console.log(qnaObj);
   $.ajax({
   url: "qna",
   type: "post",
   data: qnaObj,
   success: function(data){
         var qlist = '';
         var dlist = data.qList;
         console.log(dlist);
         for(var i = 0; i < dlist.length; i++){
            qlist += 
            '<div class="data-row" id="qnalist">' +   
            '<div class="u-bnum p-10">' + dlist[i].q_num + '</div>'
            + '<div class="u-name p-13">' + dlist[i].q_nickname + '</div>'
            + '<div class="u-title p-60">' 
            + dlist[i].q_content + '</a>'
            + '</div>' +
            '<div class="u-date p-13">' + dlist[i].q_date + '</div>'
            + '</div>'
         }
         console.log(qlist);
         $('#qnatot').append(qlist);
      },
      error: function(error){
         alert("데이터가 없습니다.");
      }
   });
}
var q =1;
function moreRate() {
   q++;
   var pnickname = ${port.pnickname};
   var rateObj = {"rateNum": q, "ra_nickname" : pnickname};
   console.log(rateObj);
   $.ajax({
   url: "rate",
   type: "post",
   data: rateObj,
   success: function(data){
         var rlist = '';
         var dalist = data.rList;
         console.log(dalist);
         for(var i = 0; i < dalist.length; i++){
            rlist += 
               '<div class="data-row" id="rate">' +   
               '<div class="u-bnum p-10">' + dalist[i].ra_num
               +'</div>'
               + '<div class="u-name p-13">' + dalist[i].ra_nickname 
               +'</div>'
               +'<div class="u-title p-60">'
               + dalist[i].ra_content
               + '</a>' 
               +'</div>' 
               + '<div class="u-date p-13">' + dalist[i].ra_score 
               +'</div>'
               +'</div>'
         }
         console.log(rlist);
         $('#ratetot').append(rlist);
      },
      error: function(error){
         alert("데이터가 없습니다.");
      }
   });
   
}
function pscript(pnum, nickname, usertype){
    var script = confirm("게시물을 찜하시겠습니까?")
    
    if(script == true){
       location.href='./pscript?pnum=' + pnum +'&nickname=' + nickname+'&usertype=' + usertype;
       alert("찜이 완료되었습니다");
    }
    else{
       alert("취소되었습니다.");
    }
 }
 function pscriptdel(pnum, nickname){
    var script = confirm("찜을 취소하시겠습니까?")
    
    if(script == true){
       location.href='./pscriptdel?pnum=' + pnum + '&nickname=' + nickname;
    }
    else{
       alert("취소되었습니다.");
    }
 }
</script>
</body>
</html>