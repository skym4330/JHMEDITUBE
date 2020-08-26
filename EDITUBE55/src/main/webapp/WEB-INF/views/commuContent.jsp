<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>commuContent</title>

<link
   href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css"
   rel="stylesheet" />

<link href="resources/css/sideBar.css?after" rel="stylesheet">
<link href="resources/css/writeCommuFrm.css?after" rel="stylesheet">
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/footerStyle.css" rel="stylesheet">
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
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="resources/js/sideBar.js"></script>

<script type="text/javascript">

$(document).ready(function(){
   $('#upbtn').hide();
   $('#delbtn').hide();
   
   var status = '${cbstatus}'
   var mnickname = '${mb.m_nickname}';
   var cbmnickname = '${cboard.cbnickname}';
   
   if(mnickname==''){
      $('#rin').attr("disabled");
   }
   else{
      $('#rin').removeAttr("disabled");
   }
   if(mnickname==cbmnickname){
      $('#upbtn').show();
      $('#delbtn').show();
   }
   if(mnickname=="관리자"){
      $('#delbtn').show();
      if(status==1){
         $('#upbtn').show();
      }
   }
   
      var chk = "${check}";
      
      if(chk=="1"){
         alert("본인의 글만 수정 가능합니다.");
         location.reload(true);
      }
      if(chk=="2"){
         alert("수정을 완료했습니다.");
         location.reload(true);
      }
      if(chk=="3"){
         alert("수정을 실패했습니다.");
         location.reload(true);
      }
      if(chk=="4"){
         alert("삭제 실패");
         location.reload(true);
      }
      switch('${cbstatus}'){
      case '1':
         $('#s1').addClass('current');
         break;
      case '2':
         $('#s2').addClass('current');
         break;
      case '3':
         $('#s3').addClass('current');
         break;
      case '4':
         $('#s4').addClass('current');
         break;
      }
      $("#ctype").html('${cbname}');
   });
   
</script>
</head>
<body>
   <jsp:include page="header.jsp"></jsp:include>
   <div class="all">
      <jsp:include page="commuNav.jsp"></jsp:include>
      <div id="page-wrapper" class="clearfix">

         <h2>${cboard.cbtitle}</h2>
         <p />
         <div class="infomation">
            <div class="info_img">
               <img class="user-profile" src="resources/images/${cboard.msysName}">
            </div>
            <div class="info_nick">
               <p>${cboard.cbnickname}</p>
            </div>
            <div class="info_date">
               <p>작성일 : ${cboard.cbdate}</p>
            </div>
         </div>
         <hr>
         <div class="info_con">
         
         <p ><pre style="white-space: pre-wrap;">${cboard.cbcontent}</pre></p>
         </div>

         <hr>
         <div class="btn_Frm">
         <button class="btn-sub"
            onclick="location.href='./commuBoard?cbstatus=${cbstatus}'">목록</button>
         <button class="btn-sub" id="upbtn"
            onclick="location.href='./upConmmuFrm?cbstatus=${cbstatus}&cbnum=${cboard.cbnum}'">수정</button>
         <button class="btn-sub" id="delbtn"
            onclick="goCBDelete(${cbstatus}, ${cboard.cbnum},'${mb.m_nickname}','${cboard.cbnickname}')">삭제</button>
         </div>
         <hr>



         <div class="write-form">
            <div class="comments-container">
               <ul id="rTable" class="comments-list">
                  <c:forEach var="r" items="${rList}">
                     <li>
                        <div class="comment-main-level">
                           <div class="comment-avatar">
                              <img class="user-profile" src="resources/images/${r.m_sysName}" alt="">
                           </div>

                           <div class="comment-box">
                              <div class="comment-head">
                                 <h6 class="comment-name by-author">
                                    <a>${r.r_nickname}</a>
                                 </h6>
                                 <span>${r.r_date}</span>
                                 <c:if test="${r.r_nickname == mb.m_nickname}">
                                    <a href="#" class="delreply"
                                       onclick="delReplyGo(${r.r_num},${cboard.cbnum})">[삭제]</a>
                                 </c:if>

                              </div>
                              <div class="comment-content">
                                 <pre style="white-space: pre-wrap;">${r.r_content}</pre>
                              </div>
                           </div>
                        </div>
                     </li>
                  </c:forEach>
               </ul>
            </div>
            <form name="rFrm" id="rFrm" class="write-form">
               <textarea class="rebox" name="r_content" id="comment"
                  placeholder="댓글을 적어주세요"></textarea>
               <input class="btn-write" id="rin" type="button" value="댓글전송"
                  onclick="replyInsert(${cboard.cbnum})" style="">
            </form>
         </div>
      </div>
   </div>
   <!-- Footer -->
</body>
   <footer>
    <jsp:include page="footer.jsp"></jsp:include>
</footer>
<script src="resources/js/jquery.serializeObject.js"></script>
<script type="text/javascript">

   $(function() {
       $('.side > a').click( function() {

        var sn = $(this).attr('side-no');
       console.log(sn);
       location.href="./commuBoard?cbstatus="+sn;          
       });   
   });

function goCBDelete(cbstatus, cbnum, mnickname, cbnickname){
   if(mnickname != cbnickname){
      alert("본인이 작성한 글이 아닐 경우 삭제가 불가능합니다.");
      return;
   }
   var del=confirm('게시글을 삭제 하시겠습니까?');
   if(del==true){
      location.href='./delCBoard?cbstatus='+${cbstatus}+'&cbnum='+${cboard.cbnum};
   }
   else{
      alert("취소되었습니다.");
   }
}

function replyInsert(cbnum) {
   var replyFrm = $('#rFrm').serializeObject();
   replyFrm.r_cbnum=cbnum;
   replyFrm.r_nickname='${mb.m_nickname}';
//    replyFrm.r_sysname='${mb.m_sysName}';
   console.log(replyFrm);
   
   var nick = '${mb.m_nickname}';
   
   $.ajax({
      url: "replyInsert",
      type:"post",
      data: replyFrm,
      dataType:"json",
      success:function(data){
         var rlist='';
         var dlist=data.rList;
         for(var i=0; i<dlist.length; i++){
            rlist+=      
            '<li><div class="comment-main-level"><div class="comment-avatar"><img class="user-profile" src="resources/images/'+dlist[i].m_sysName+'" alt=""></div><div class="comment-box"><div class="comment-head"><h6 class="comment-name by-author"><a>'+dlist[i].r_nickname+'</a></h6>'
            +'<span>'+dlist[i].r_date+'</span>';
            if(nick == dlist[i].r_nickname){
               rlist += '<a href="#" id="delreply" onclick="delReplyGo('+dlist[i].r_num+',${cboard.cbnum})">[삭제]</a>';
            }
            rlist += '</div><div class="comment-content"><pre style="white-space: pre-wrap;">'+dlist[i].r_content+'</pre></div></div></div></li>'         
         }
         $('#rTable').html(rlist);
      },
      error: function(error){
         alert("댓글 입력 실패");
      }
   });
   $('#comment').val('');
}
function delReplyGo(num,cbnum) {
   var msg= confirm("댓글을 삭제합니다.");
   var nick= '${mb.m_nickname}';
   if(msg==true){
      var replyFrm = new Object();
      replyFrm.r_num=num;
      replyFrm.r_cbnum=cbnum;
      console.log(replyFrm);
      $.ajax({
         url: "replyDelete",
         type:"post",
         data: replyFrm,
         dataType:"json",
         success:function(data){
            var rlist='';
            var dlist=data.rList;
            for(var i=0; i<dlist.length; i++){
               rlist+=      
               '<li><div class="comment-main-level"><div class="comment-avatar"><img class="user-profile" src="resources/images/'+dlist[i].m_sysName+'" alt=""></div><div class="comment-box"><div class="comment-head"><h6 class="comment-name by-author"><a>'+dlist[i].r_nickname+'</a></h6>'
               +'<span>'+dlist[i].r_date+'</span>';
               if(nick==dlist[i].r_nickname){
               rlist+='<a href="#" id="delreply" onclick="delReplyGo('+dlist[i].r_num+',${cboard.cbnum})">[삭제]</a>'
               }
               rlist+='</div><div class="comment-content"><pre style="white-space: pre-wrap;">'+dlist[i].r_content+'</pre></div></div></div></li>'         
               }
            $('#rTable').html(rlist);
         }
         });
      }
      else{
         alert("취소되었습니다.")
         }
   }

   </script>
</html>