<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/myEPageStyle.css?after" rel="stylesheet">
<link href="resources/css/mWarning.css" rel="stylesheet"> 
</head>
<body>
<header>
<jsp:include page="header.jsp"></jsp:include>
</header>
<div class="myEPageReqMWrap">
<aside class="myEPageReqMaside">
<jsp:include page="mMypageNav.jsp"></jsp:include>
</aside>
<div id="page-wrapper" class="clearfix">
         <h1>주의사항 글 수정</h1>
         <textarea name="bcontents" rows="10" class="write-input-ta">${board.bcontents}</textarea>
         <button class="btn-primary" id="upbtn"
                     onclick="location.href='./mWarning'">저장</button>
</div>

</div>
</body>
</html>