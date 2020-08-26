<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EDITUBE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/myInfoUp.css">
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="resources/js/myInfoUp.js"></script>
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
            <img src="resources/images/logo.png" width="100px"
               class="logo-center" onclick="gohome();">
            <div>
               <img id="imgurl" class="user-profile" src="resources/images/${mb.m_sysName}">
            </div>
            <div class="button-container">
               <form id="fileUp">
               <label class="btn btn-default btn-file" style="width: 200px">파일수정
                  <input id="file" type="file"  name="file"
                     style="width: 200px;display:none;">
               </label>
               </form>
               <input id="filedel" type="button" value="사진 삭제" onclick="filedel()"
                  style="width: 200px;">
            </div>
            <div class="input-container">
               <p>아이디:${mb.m_id}</p>
            </div>
            <div class="input-container">
               <p>이름:${mb.m_name}</p>
            </div>
            <div class="input-container">
               <p>생년월일:${mb.m_birth}</p>
            </div>
            <div class="input-container">
               <p>닉네임:${mb.m_nickname}</p>
            </div>

            <form name="myInfoUp" action="passcheck" method="post"
               onsubmit="return check()">
               <div class="input-container">
                  <input type="password" name="m_password" id="pw1"/><label>비밀번호
                     변경</label>
                  <div class="bar"></div>
               </div>
               <div class="input-container">
                  <input type="password" name="cpassword" id="pw2"/><label>비밀번호
                     확인</label>
                  <div class="bar"></div>
               </div>
               <div class="button-container">
                  <input id="Storage" type="submit" value="변경내용 저장"
                     style="width: 240px;">
               </div>

            </form>
            <div class="button-container">
               <a href="#layer" class="btn-example" style="width: 240px;">회원탈퇴</a>
            </div>
            <div class="dim-layer">
               <div class="dimBg"></div>
               <div id="layer" class="pop-layer">
                  <div class="pop-container">
                     <div class="pop-conts">
                        <!--content //-->
                        <h2 class="title">회원 탈퇴</h2>
                        <div class="popc">
                           <div class="s_title">탈퇴 회원 설문 조사</div>
                           <div class="agree">
                              <ul>
                                 <li><input type="checkbox" id="a2" name="전체동의" /> <label
                                    for="a2"><span>사이트의 필요성을 못 느껴서</span></label></li>
                                 <li><input type="checkbox" id="a3" name="전체동의" /> <label
                                    for="a3"><span>다른 아이디로 가입하려고</span></label></li>

                                 <li><input type="checkbox" id="a4" name="전체동의" /> <label
                                    for="a4"><span>회원이 너무 적어서</span></label></li>
                              </ul>
                           </div>
                           <p2 style="font-weight:bold; font-size:20px;">기타</p2>
                           <div class="field">
                              <textarea name="content" id="content" placeholder="내용을 입력하세요."></textarea>
                           </div>
                        </div>

                        <div class="button-container">
                           <input id="Storage" type="button" value="회원 탈퇴"
                              onclick="goDelete('${mb.m_nickname}')" style="width: 240px;">
                        </div>

                        <div class="btn-r">
                           <a href="#" class="btn-layerClose">Close</a>
                        </div>
                        <!--// content-->
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

</body>
<script type="text/javascript">

function filedel(){
   
   $.ajax({
      type : 'POST',
      url : 'filedel',
      success:function(data){
         $('#imgurl').attr("src",data);
      },
      error: function(error){
         console.log(error);
      }
   });
};

$("#file").on('change',function(){
   //Form 전체를 넘겨주는 방식
   var formData = new FormData();
   formData.append("file",$("#file")[0].files[0]);
   console.log(formData);
      $.ajax({
         type : 'POST',
         url :'fileup',
         processData : false, //필수
         contentType:false, //필수
         data : formData,
         success:function(data){
         console.log(data);
         $('#imgurl').attr("src",data);
         },
      error: function(error){
      console.log(error);
      }
      });
});

function check(){
   var pass1=$('#pw1').val();
   console.log(pass1);
   var pass2=$('#pw2').val();
   console.log(pass2);
   if(pass1 == "" 
        || pass2 == null){
      return true;
   }
   else{
      if(pass1==pass2){
         return true;
      }else{
         alert('비밀번호가 일치하지 않습니다')
         return false;
      }
   }
}


   function gohome() {
      var id = '${mb.m_id}';

      if (id == '') {
         location.href = './';
      } else if (id != '') {
         location.href = './';
      }
   }

   $('.btn-example').click(function() {
      var $href = $(this).attr('href');
      layer_popup($href);
   });
   function layer_popup(el) {

      var $el = $(el); //레이어의 id를 $el 변수에 저장
      var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

      isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

      var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el.outerHeight()), docWidth = $(
            document).width(), docHeight = $(document).height();

      // 화면의 중앙에 레이어를 띄운다.
      if ($elHeight < docHeight || $elWidth < docWidth) {
         $el.css({
            marginTop : -$elHeight / 2,
            marginLeft : -$elWidth / 2
         })
      } else {
         $el.css({
            top : 0,
            left : 0
         });
      }
   

      $el.find('a.btn-layerClose').click(function() {
         isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
         return false;
      });

      $('.layer .dimBg').click(function() {
         $('.dim-layer').fadeOut();
         return false;
      });
   }
      
      function goDelete(nk){
         var del = confirm("정말로 탈퇴 하시겠습니까?");
         if(del == true){
            location.href='./delete?nk='+nk;
         }
         else{
            alert("취소되었습니다.");
         }
      }
      


</script>
</html>