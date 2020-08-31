<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글쓰기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var chk = "${check}";
	
	if(chk == "1"){
		alert("글 등록 실패!");
	}
	
	var name = "${mb.m_name}";
	$('#mname').html(name + '님');
	$('.suc').css('display','block');
	$('.bef').css('display','none');
});
</script>
</head>
<body>
<div class="wrap">
	<header>
	<jsp:include page="header.jsp"></jsp:include>
	</header>
	<section>
	<div class="content">
		<form name="writeFrm" action="boardWrite" class="write-form"
			 method="post" enctype="multipart/form-data">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.g_name}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
			<h2 class="login-header">글쓰기</h2>
			<input type="hidden" name="bid" value="${mb.m_id}">
			
			<input type="text" class="write-input"
				name="btitle" autofocus placeholder="제목" required>
			<textarea name="bcontents" rows="15" class="write-input ta"
				placeholder="내용을 적어주세요..."></textarea>
			<div class="filebox"> 
				<label for="file">업로드</label> 
				<input type="file" name="files" id="file"> 
				<input class="upload-name" value="파일선택" readonly>
				<input type="hidden" id="filecheck"	value="0" name="fileCheck">
			</div>
			
			<div class="btn-area">
				<input class="btn-write" type="submit" value="W">
				<input class="btn-write" type="reset" value="C">
				<input class="btn-write" type="button" value="B"
					onclick="location.href='./list?pageNum=${pageNum}'">
			</div>
		</form>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</div>
</body>
<script type="text/javascript">
$("#file").on('change',function(){
	var file = document.getElementById("file");
	console.log(file);
	var filelist = file.files;
	console.log(filelist);
	
	var fileName = $("#file").val();
	$(".upload-name").val(fileName);
	
	if(fileName == ""){
		console.log("empty");
		$("#filecheck").val(0);
	}
	else{
		console.log("not empty");
		$("#filecheck").val(1);
	}
});
</script>
</html>




