<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/signPageFrm.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   var msg = "${msg}";
   console.log(msg);
   if(msg != ""){
      alert(msg);
      location.reload(true);
   }
});
</script>
</head>
<body>
<div class="wrap">
   <div class="container">
    <div class="card"></div>
    <div class="card">
   <img src="resources/images/logo.png" width="100px" class="logo-center" onclick="gohome();">
        <h1 class="title">회원가입</h1>
        <form name="signPageFrm" action="memInsert" method="post" onsubmit="return check()">
            <div id = right-button>   
            <span class="button-container">
               <input class="buttons" type="button" value="중복확인" onclick="idcheck()" style=width:60px;>
               <input class="buttons" id="emailCheck" type="button" value="인증번호" onclick="emailSend()" style=width:60px;>
            </span> 
            </div>
            <div class="input-container"><input autocomplete="nope" type="text" id="mid" name="m_id" required/><label>이메일 아이디</label>
                <span class="bar"></span>
            </div> 
            <div id = right-button>
            <span class="button-container">
            <input id="certificationBtn" class="buttons" type="button" value="인증하기" onclick="emailCertification()" style=width:60px;float:right;margin-right:15px;>
                </span> 
                </div> 
            <div class="input-container"><input type="text" id="emailcheck" required/><label>인증번호</label>
            
                <span class="bar"></span>
            </div>
            <div class="input-container"><input type="password" name="m_password" required/><label>비밀번호</label>
                <div class="bar"></div>
            </div>
            <div class="input-container"><input type="password" required/><label>비밀번호 확인</label>
                <div class="bar"></div>
            </div>
            <div class="input-container"><input autocomplete="nope" type="text" name="m_name" required/><label>이름</label>
                <div class="bar"></div>
            </div>
            <div class="input-container"><input autocomplete="nope" type="text" name="m_birth" required/><label>생년월일</label>
                <div class="bar"></div>
            </div>
            <div id="right-btn">
            <span class="button-container">
               <input class="buttons" type="button" value="중복확인" onclick="nickcheck()" style=width:60px;>
            </span>
            </div>     
            <div class="input-container"><input autocomplete="nope" type="text" name="m_nickname" id="mnickname" required/><label>닉네임</label>
                <div class="bar"></div>
            </div>
            <div class="input-container"><input autocomplete="nope" type="text" name="m_phonenum" required/><label>휴대폰 번호</label>
                <div class="bar"></div>
            </div>
            <div class="button-container"><input id="join" class="buttons" type="submit" disabled value="회원가입"style=width:240px;></div>    
        </form>
    </div>
</div>


</div>
</body>
<script type="text/javascript">
var dice
var ones
var twos
var hi
function emailSend(){
   
   var email=$('#mid').val();
      console.log(email);
   var objdata={"email":email};
   console.log('입력 이메일' + objdata);
      if(hi==1){
      $.ajax({
         type:"POST",
         url:"email",
         data:objdata,
         success : function(data){
            alert(data.result);
            dice = data.dice;
         },error : function(e){
            alert('오류입니다. 잠시 후 다시 시도해주세요.');
         }
      });
      }else{
         alert('중복 확인 먼저 확인해주세요')
      }
}
function emailCertification(){
   var emailcheck=$('#emailcheck').val();
      console.log(emailcheck);
   if(emailcheck==dice){
      alert("인증에 성공하였습니다.")
      ones=1;
      if(twos==1&&ones==1){
          $("#join").removeAttr("disabled");
          }
   }
   else{
      alert("인증에 실패하였습니다.")
   }
}
function check(){
   //form 태그의 내용을 전부 가져오기
   var frm = document.signPageFrm;
   
   //submit 버튼을 뺀 나머지 input태그의 개수
   var length = frm.length - 1;
   
   //input 태그 중에 입력이 안된 요소를 확인
   for(var i = 0; i < length; i++){
      if(frm[i].value == "" 
            || frm[i].value == null){
         alert(frm[i].title + " 입력!");
         frm[i].focus();
         return false;//action이 실행 안됨.
      }
   }
   //모든 input에 입력이 다 되었을 경우.
   return true;//action이 실행됨.
}
//아이디 중복 여부 확인 함수
//이 함수의 ajax를 실행하기 위해서 
//인터셉터 대상에서 제외해야 함.
//servlet-context.xml에 exclude-mapping을 처리.
function idcheck(){
   var id = $('#mid').val();
   if(id == ""){
      alert("아이디를 입력하세요.");
      $('#mid').focus();
      return;
   }
   var ckObj = {"mid": id};
   console.log(ckObj);
   
   var email=document.getElementById("mid").value;
   var exptext=/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
   if(exptext.test(email)==false){
      alert("이 메일형식이 올바르지 않습니다.");
   }
   else{
   
   $.ajax({
      url: "idCheck",
      type: "get",
      data: ckObj,
      success: function(data){
         if(data == "success"){
            alert('사용 가능한 ID입니다.');
            hi=1;
         }
         else{
            alert('이미 등록된 ID입니다.');
            $('#mid').val('');//입력 초기화
            $('#mid').focus();//ID 부분에 포커스 주기
         }
      },
      error: function(error){
         console.log(error);
      }
   });
   }
}
function nickcheck(){
   var nickname = $('#mnickname').val();
   if(nickname == ""){
      alert("닉네임을 입력하세요.");
      $('#mnickname').focus();
      return;
   }
   var ckObj = {"mnickname": nickname};
   console.log(ckObj);
   
   $.ajax({
      url: "nickCheck",
      type: "get",
      data: ckObj,
      success: function(data){
         if(data == "success"){
            alert('사용 가능한 닉네임입니다.');
            twos=1;
            if(twos==1&&ones==1){
            $("#join").removeAttr("disabled");
            }
         }
         else{
            alert('이미 등록된 닉네임입니다.');
            $('#mnickname').val('');//입력 초기화
            $('#mnickname').focus();//ID 부분에 포커스 주기
         }
      },
      error: function(error){
         console.log(error);
      }
   });
}
      function gohome() {
         var id = '${mb.m_id}';
         if (id == '') {
            location.href = './';
         } else if (id != '') {
            location.href = './';
         }
      }
   </script>
</html>