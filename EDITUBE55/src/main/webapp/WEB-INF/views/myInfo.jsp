<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EDITUBE</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
</head>
<body>
<div class="wrap">
<div class="container">
    <div class="card"></div>
    <div class="card">
       <img src="resources/images/logo.png" width="100px" class="logo-center" onclick="gohome();">
        <h1 class="title">비밀번호 확인</h1>
        <form action="Infopwcheck" method="post">
            <div class="input-container"><input type="password" name="m_password" required><label>비밀번호 확인</label>
                <div class="bar"></div>
            </div>
            <div class="button-container"><input type="submit" value="확인" class="bts" style=width:240px;></div>
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