<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="top-bar">
		<div class="content">
			<img class="top-left logo" src="resources/images/r-logo.jpg" 
				onclick="gohome();">
			<h2 class="top-left">JIP Board</h2>
			<nav class="top-right">
				<ul>
					<li class="suc" id="mname">테스트님</li>
					<li class="suc"><a href="./logout">Logout</a></li>
					<li class="bef"><a href="./loginFrm">Login</a></li>
					<li class="bef"><a href="./joinFrm">Register</a></li>
				</ul>
			</nav>
		</div>
	</div>
	
<script>
function gohome(){
	var id = '${mb.m_id}';
	
	if(id == ''){
		location.href='./';
	}
	else if(id != ''){
		location.href='./list';
	}
}
</script>