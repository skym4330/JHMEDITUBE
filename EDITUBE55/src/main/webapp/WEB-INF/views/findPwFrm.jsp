<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>EDITUBE</title>
<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		console.log(msg);
		if (msg != "") {
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
        <h1 class="title">비밀번호 찾기</h1>
        <form name="pwfind" action="pwfind" method="post">
            <div id = right-btn>   
            <span class="button-container">
            	<input class="buttons" id="emailCheck" type="button" value="인증번호" onclick="emailSend()" style=width:60px;>
            	<input id="certificationBtn" class="buttons" type="button" value="인증하기" onclick="emailCertification()" style=width:60px;float:right;margin-right:57px;margin-top:60px;>
            </span> 
            </div>
            <div class="input-container"><input type="text" id="m_id" name="mid" required/><label>이메일 아이디</label>
                <span class="bar"></span>
            </div>              
            <div class="input-container"><input type="text" id="emailcheck" required/><label>인증번호</label>
                <div class="bar"></div>
                
            </div>
            <div class="input-container"><input type="text" name="name"required/><label>이름</label>
                <div class="bar"></div>
            </div>
            <div class="button-container"><button type="submit" id="findpw" disabled value="" style=width:240px;><span>비밀번호 찾기</span></button></div>    
        </form>
    </div>
</div>
</div>	
</body>
<script type="text/javascript">
var dice

function emailCertification(){
	var emailcheck=$('#emailcheck').val();
		console.log(emailcheck);
	if(emailcheck==dice){
		alert("인증에 성공하였습니다.")
		$("#findpw").removeAttr("disabled");
	}
	else{
		alert("인증에 실패하였습니다.")
	}
}

function emailSend(){
	
	var email = $('#m_id').val();
		console.log(email);
	var objdata={"email":email};

	console.log('입력 이메일' + objdata);
		
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