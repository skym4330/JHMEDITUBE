<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EDITUBE</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/login.css">
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
<style type="text/css">
input {
autocomplete:nope;
}
</style>
</head>
<body>
<div class="wrap">
<div class="container">
    <div class="card"></div>
    <div class="card">
       <img src="resources/images/logo.png" width="100px" class="logo-center" onclick="gohome();">
        <h1 class="title">로그인</h1>
        <form action="access" method="post">
            <div class="input-container"><input autocomplete="off" type="text" id="id" name="m_id" required autofocus><label>아이디</label>
                <div class="bar"></div>
            </div>
            <div class="input-container"><input type="password" name="m_password" required><label>비밀번호</label>
                <div class="bar"></div>
            </div>
            <div class="button-container"><input type="submit" class="bt" value="로그인" style=width:240px;></div>
            <div class="footer">
            <a href="./findIdFrm">ID</a>&nbsp;/
            <a href="./findPwFrm">비밀번호 찾기</a>
            </div>
            <div class="button-container">
            <button type="button" onclick="location.href='signPageFrm'" style=width:240px;><span>회원가입</span></button>
            </div>
            <div>
            <span><br></span>
            </div>
        </form>
    </div>
</div>
</div>    
</body>
<script>
function gohome(){
   var id = '${mb.m_id}';
   
   if(id == ''){
      location.href='./';
   }
   else if(id != ''){
      location.href='./';
   }
}
</script>
</html>