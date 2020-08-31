<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글수정</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
		<form action="boardUpdate" method="post" class="write-form"
			enctype="multipart/form-data">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.g_name}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
			<h2 class="login-header">글수정</h2>
			<input type="hidden" name="bid" value="${mb.m_id}">
			<input type="hidden" name="bnum" value="${board.bnum}">
			<input type="text" name="btitle" class="write-input"
				value="${board.btitle}" required>
			<textarea name="bcontents" rows="10" 
				class="write-input ta">${board.bcontents}</textarea>
			<div class="filebox">
				<div class="befor-file" style="margin-bottom: 10px;">
					<c:if test="${empty bfList}">
						<label style="width: 100%;">파일변경</label>
					</c:if>
					<c:if test="${!empty bfList}">
						<c:forEach var="file" items="${bfList}">
						<label style="width: 100%;"><a href="./download?sysFileName=${file.bf_sysName}">
							${file.bf_oriName}</a></label>
						</c:forEach>
					</c:if>
				</div>
				<label for="file">파일변경</label> 
				<input type="file" name="files" id="file"> 
				<input class="upload-name" value="파일선택" readonly>
				<input type="hidden" id="filecheck"	value="0" name="fileCheck">
			</div>
			<div class="btn-area">
				<input class="btn-write" type="submit" value="U">
				<input class="btn-write" type="reset" value="C">
				<input class="btn-write" type="button" value="B"
					onclick="javascript:history.back();">
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




