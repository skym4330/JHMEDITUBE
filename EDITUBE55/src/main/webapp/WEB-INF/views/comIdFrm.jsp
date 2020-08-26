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
    <img src="resources/images/logo.png" width="100px" class="logo-center">
        <h1 class="title">아이디 찾기 완료
			<p>고객님의 아이디는 ${mb.m_id} 입니다.</p>			
		</h1>	
        <form>
            <div class="button-container"><button type="button" onclick="location.href='fpw'" style=width:240px;><span>비밀번호 찾기</span></button></div>
            <div class="button-container"><button type="button" onclick="location.href='jo'" style=width:240px;><span>로그인</span></button></div>
        </form>
    </div>
</div>
</div>	
</body>
</html>