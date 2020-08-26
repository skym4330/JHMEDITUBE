<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<style type="text/css">
html{
   background-color: #b2c7d9;
}
.chatingWrap{
   width: 100%;
   height:100%;
}

.chatingContentWrap{
   width:100%;
   background-color: #b2c7d9;
}
.chatingContentWrap{   
   width: 100%;
   margin-bottom: 3px;
}

.chatingWrap .chatingContent{
   width:100%;
   height: 80%;
   overflow-y: auto;
   overflow-x: hidden; 
}

.chatingWrap .chatingContent #myId{
   font-weight: 900;
}

.chatingWrap .chatingContent #youId{
   font-weight: 900;
}

.chatingWrap .chatingContent #myCon{
   max-width:100%;
   padding:4px 7px;
   margin: 3px;
   background-color: #ffeb33;
   display:inline-block;
   border-radius: 10px;
   white-space: pre-wrap;
}

.chatingWrap .chatingContent #youCon{
   max-width:100%;
   padding:4px 7px;
   margin: 3px;
   background-color: white;
   display:inline-block;
   border-radius: 10px;
   white-space: normal;
}

.chatingInsertWrap textarea{
   padding:10px;
   border:none;
   width: 80%;
   height: 100px;
   float: left;
   outline:none;
   resize: none;
   overflow: auto;
   position: absolute;
   bottom: 10px;
}
.chatBtnWrap{
   width: 18%;
   height: 100px;
   position: absolute;
   bottom: 10px;
   left: 80%;
   background-color: white;
}

.chatBtnWrap #submit{
   width: 50px;
   height: 30px;
   background-color: #ffeb33;
   border: 1px solid gray;
   position: absolute;
   top: 10px;
   right: 10px;
}
</style>
</head>
<body>
<div class="chatingWrap">
   <div class="chatingContentWrap">
      <div class="chatingContent" id="chatCon">
         <c:forEach var="cItem" items="${cList}">
            <c:if test="${cItem.ch_mnickname == mb.m_nickname}">
               <p id="myId">${cItem.ch_mnickname}<p>
               <p id="myCon">${cItem.ch_content}</p>
            </c:if>
            <c:if test="${cItem.ch_mnickname != mb.m_nickname}">
               <p id="youId">${cItem.ch_mnickname}<p>
               <p id="youCon">${cItem.ch_content}</p>
            </c:if>
         </c:forEach>
      </div>
   </div>
   
    <form action="chating" method="post" name="chating"> 
      <div class="chatingInsertWrap">
         <textarea name="ch_content" autofocus="autofocus" id="textarea" required="required"></textarea>
         <input type="hidden" name="ch_targetnickname" value="${nick}">
         <div class="chatBtnWrap">
         <input type="submit" id="submit" value="전송">
         </div>
      </div>
    </form> 
</div>
</body>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<script type="text/javascript">


var objDiv = document.getElementById("chatCon"); 
objDiv.scrollTop = objDiv.scrollHeight;

$('#textarea').keypress(function(event){
   console.log("zzz");
    if ( event.which == 13 ) {
        $('#submit').click();
        return false;
    }
});


var auto_refresh = setInterval(
   function(){
   var nick = '${nick}';
   var dataObj = {"nick":nick};
   var my = '${mb.m_nickname}';
   console.log(dataObj+"네임"+my);
      
   $.ajax({
      url: "chatingSel",//요청 url(uri)
      type: "post",//전송 방식(get, post)
      data: dataObj,//전송할 데이터
      dataType: "json",//데이터의 형식
      success: function(data){
         //목록 전체를 하나의 문자열로 만들어서
         //한꺼번에 id가 rTable인 태그(요소)의
         //innerHTML에 출력.
         var clist = '';
         var dlist = data.cList;
         console.log("zzzzzzzzz"+dlist);
         console.log(nick)
         for(var i = 0; i < dlist.length; i++){
               if(dlist[i].ch_mnickname == my){
                  clist += '<p id="myId">'+dlist[i].ch_mnickname+'</p>'
                  +'<p id="myCon">'+dlist[i].ch_content+'</p>'
               }else{
                  clist += '<p id="youId">'+dlist[i].ch_mnickname+'</p>'
                  +'<p id="youCon">'+dlist[i].ch_content+'</p>'
               }
         }
         $('#chatCon').html(clist);
      },
      error: function(error){
         alert("망해쓰요");
      }
   });
}, 3000);


// var auto_refresh = setInterval(
// function(data){
//          var clist = '';
//          var dlist = data.cList;
//          for(var i = 0; i < dlist.length; i++){
//             clist += '<p>'+dlist[i].ch_mnickname+'<p>'
//             +'<p>'+dlist[i].ch_content+'</p>'
//          }
//          $('#chatCon').html(clist);
//          console.log("불러오는중");
//       }, 3000);
      
// var auto_refresh = setInterval(   
// var array= cList;
 
//      //$.each()메서드를 선언합니다.
//      $.each(array,function(index,item){
//          //변수를 선언합니다.
//          var output ='';
 
//          output +='<a href="' + item.link + '">';
//          output +='<h1>' + item.name + '</h1>';
//          output += '</a>';
 
//          //집어넣습니다.
//          $('#chatCon').html(output);
//      });
// }, 3000);
</script>
<script type="text/javascript">


// var auto_refresh = setInterval(
//       function () {
//       $('#chatCon').load('chating #chatCon').fadeIn("slow");
//       console.log("ddd")
//       }, 3000);
</script>

</html>