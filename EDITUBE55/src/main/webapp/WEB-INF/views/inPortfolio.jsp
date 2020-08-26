<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/headerstyle.css?after" rel="stylesheet">
<link href="resources/css/myEPageNav.css?after" rel="stylesheet">
<link href="resources/css/writeCommuFrm.css?after" rel="stylesheet">

</head>
<body>
   <header>
      <jsp:include page="header.jsp"></jsp:include>
   </header>
   <div class="all">
       <aside class="upPfaside"> 
         <jsp:include page="myEPage.jsp"></jsp:include>
       </aside>
      <div id="page-wrapper" class="clearfix">
         <form action="portInsert" method="post" enctype="multipart/form-data">
      <h1>Write</h1>
            <input type="hidden" name="pnickname" value="${mb.m_nickname}">
            <input type="hidden" name="pnum" value="${port.pnum}">

            <div class="field">
               <input type="text" name="ptitle" id="filename"
                  placeholder="제목을 입력하세요." required>
            </div>
            <div class="linkboxWrap">
               <div class="link">
                  <p id="linka">영상 링크주소 :</p>
                  <textarea class="linkAdress" name="plink" id="plink" placeholder="포트폴리오 홍보영상 공유링크주소">${port.plink}</textarea>
                  <p onclick="preview()">미리보기</p>
               </div>
               <div class="ifrm">
                  <iframe id="pre" width="640" height="360" src=""
                     frameborder="0"
                     allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                     allowfullscreen> </iframe>
               </div>
            </div>
            <div class="opt" id="pri">
               금액: <input type="number" name="pcost" id="price"
                  placeholder="금액을 입력하세요." required>
            </div>

            <div class="checkBox">
               <div class="cpack">
                  <input class="ckb" id="check1" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="게임 방송" checked> <label
                     id="che" for="check1">게임 방송</label>
               </div>
               <div class="cpack">
                  <input class="ckb" id="check2" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="먹방"> <label id="che"
                     for="check2">먹방</label>
               </div>
               <div class="cpack">
                  <input class="ckb" id="check3" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="브이로그"> <label
                     id="che" for="check3">브이로그</label>
               </div>
               <div class="cpack">
                  <input class="ckb" id="check4" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="뷰티"> <label id="che"
                     for="check4">뷰티</label>
               </div>
               <div class="cpack">
                  <input class="ckb" id="check5" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="음악 방송"> <label
                     id="che" for="check5">음악 방송</label>
               </div>
               <div class="cpack">
                  <input class="ckb" id="check6" type="radio" name="pstatus"
                     onclick="CountChecked(this)" value="기타"> <label id="che"
                     for="check6">기타</label>
               </div>
            </div>
            <div class="field">
               <textarea name="pcontent" id="content" placeholder="내용을 입력하세요."
                  required style="height: 500px"></textarea>
            </div>
            <div class="btn-field">
               <button type="reset">취소</button>
               <button type="submit" id="submit">저장</button>
               <div id="messages"></div>
            </div>
         </form>
      </div>
   </div>
</body>
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      $('#submit').click(function() {
         // getter
         var radioVal = $('input[name="pstatus"]:checked').val();
         var pstatus = '${port.pstatus}';
      });
      
   });
   function preview(){
      console.log('호출됨');
      var plink=$('#plink').val();
      console.log(plink);
      $('#pre').attr('src',plink);
   }
   
</script>
</html>