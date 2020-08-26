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
         <h1>주의사항</h1>
         <table>
            <tr height="30">
               <td bgcolor="red" align="center">작성자</td>
               <td width="150">관리자</td>
               <!-- ${board.mname} -->
               <td bgcolor="red" align="center">날짜</td>
               <td width="200">비밀~</td>
               <!-- ${board.bdate} -->
            </tr>
            
            <tr height="200">
               <td bgcolor="red" align="center">내용</td>
               <td colspan="5">주의사항 내용입니다.</td>
               <!-- ${board.bcontents} -->
            </tr>
            <tr>
               <td colspan="6" align="right">
                  <button class="btn-primary" id="upbtn"
                     onclick="location.href='./mWarningFrm'">수정</button>
               </td>
            </tr>
         </table>
      </div>
</div>	
</body>
</html>