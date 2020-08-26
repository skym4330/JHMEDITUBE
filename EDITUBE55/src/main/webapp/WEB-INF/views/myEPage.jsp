<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="MyPagenavwrap">
	<div class="profileimagebox">
		<figure class="snip0067 red">
	  		<img src="resources/images/${mb.m_sysName}" alt="sample8" />
	 		<figcaption>
	    		<h2>${mb.m_nickname}</h2>
	  			<p>프로필사진을 변경하시겠습니까?</p>
	    		<div class="icons">
					<a href="./myInfo"><i class="ion-ios-home"><img alt="수정" src="../resources/images/연필.png"></i></a>
	    		</div>
	  		</figcaption>
	  		<div class="position">${mb.m_nickname}</div>
		</figure>
	</div>

	<aside class="sidebar">
    	<nav class="nav">
     		<ul>
				<li class="active"><a onclick="typechangee()" style="cursor: pointer; color: black;">유튜버모드로 변경</a></li>
				<li><a href="./timearrySc">찜한 유튜버</a></li>
				<li class="MnavMain"><a>요청관리</a>
					<ul class="MnavSub">
						<li><a href="./myEPageReqM">전체내역</a></li>
						<li><a onclick="revReq(1)">받은요청</a></li>
						<li><a onclick="revReq(2)">보낸요청</a></li>
						<li><a onclick="revReq(3)">진행 중</a></li>
						<li><a onclick="revReq(7)">완료</a></li>
						<li><a onclick="revReq(8)">거절 내역</a></li>
					</ul>
				</li>
				<li><a href="./cashList">캐시 관리</a></li>
				<li><a href="./myEPagePf?nick=${mb.m_nickname}">포트폴리오</a></li>
			</ul>
    	</nav>
  	</aside>
</div>


<script type="text/javascript">
function revReq(num){
 	location.href='./myEPageReqM?status=' + num;
 }
 
function typechangee() {
    var usertype = "${mb.m_usertype}";
    var nickname = "${mb.m_nickname}";
    console.log(usertype);
    
    if(usertype == 2){
          location.href = './typechangee?nick='+nickname;
       }
 }
</script>