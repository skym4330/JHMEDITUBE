<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세 보기</title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#upbtn').hide();
	$('#delbtn').hide();
	$('#fdelbtn').hide();
	
	var mid = '${mb.m_id}';
	var bid = '${board.bid}';

	if(mid == bid){
		$('#upbtn').show();
		$('#delbtn').show();
		$('#fdelbtn').show();
	}
	
	var chk = '${check}';
	
	if(chk == '1'){
		alert("자신의 글이 아니면 수정할 수 없습니다.");
		location.reload(true);
	}
	if(chk == '2'){
		alert("수정되었습니다.");
		location.reload(true);
	}
	if(chk == '3'){
		alert("수정을 실패하였습니다.");
		location.reload(true);
	}
	if(chk == '4'){
		alert("삭제를 실패하였습니다.");
		location.reload(true);
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
		<div class="write-form">
			<div class="user-info">
				<div class="user-info-sub">
					<p class="grade">등급 [${mb.g_name}]</p>
					<p class="point">POINT [${mb.m_point}]</p>
				</div>
			</div>
			<h2 class="login-header">상세 보기</h2>
			<table>
				<tr height="30">
					<td width="100" bgcolor="pink" align="center">NUM</td>
					<td colspan="5">${board.bnum}</td>
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">WRITER</td>
					<td width="150">${board.mname}</td>
					<td bgcolor="pink" align="center">DATE</td>
					<td width="200">${board.bdate}</td>
					<td bgcolor="pink" align="center">VIEWS</td>
					<td width="100">${board.bviews}</td>
				</tr>
				<tr height="30">
					<td bgcolor="pink" align="center">TITLE</td>
					<td colspan="5">${board.btitle}</td>
				</tr>
				<tr height="200">
					<td bgcolor="pink" align="center">CONTENTS</td>
					<td colspan="5">${board.bcontents}</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="5" id="farea">
						<c:if test="${empty bfList}">
							첨부된 파일이 없습니다.
						</c:if>
						<c:if test="${!empty bfList}">
							<c:forEach var="file" items="${bfList}">
							<c:set var="fsname" value="${file.bf_sysName}"/>
							<a href="./download?sysFileName=${file.bf_sysName}">${file.bf_oriName}</a>
							<button id="fdelbtn" onclick="fileDel()">삭제</button>
							</c:forEach>
						</c:if>	
					</td>
				</tr>
				<c:if test="${!empty bfList}">
				<tr id="fview">
					<c:forEach var="f" items="${bfList}">
					<c:if test="${fn:contains(f.bf_sysName, '.jpg')}">
					<td colspan="6">
						<img src="resources/upload/${f.bf_sysName}" width="100">
					</td>
					</c:if>
					</c:forEach>
				</tr>
				</c:if>
				<tr>
					<td colspan="6" align="right">
						<button class="btn-write" id="upbtn" onclick="location.href='./updateFrm?bnum=${board.bnum}'">U</button>
						<button class="btn-write" id="delbtn" onclick="goDelete(${board.bnum},'${mb.m_id}','${board.bid}')">D</button>
						<button class="btn-sub" onclick="location.href='./list?pageNum=${pageNum}'">B</button>
					</td>
				</tr>
			</table>
			
			<form name="rFrm" id="rFrm" class="write-form">
				<textarea rows="3" class="write-input ta" 
					name="r_contents" id="comment" placeholder="댓글을 적어주세요~"></textarea>
				<input class="btn-write" type="button" value="댓글전송"
					onclick="replyInsert(${board.bnum})" style="width:100%;margin-bottom:30px;">
			</form>
			<div class="write-form">
				<table style="width: 100%">
					<tr bgcolor="pink" align="center" height="30">
						<td width="20%">WRITER</td>
						<td width="50%">CONTENTS</td>
						<td width="30%">DATE</td>
					</tr>
				</table> <!-- rTable에 댓글 리스트만 Ajax로 처리위해 -->
				<table id="rTable" style="width: 100%">	
				<c:forEach var="r" items="${rList}">
					<tr height="25" align="center">
						<td width="20%">${r.r_id}</td>
						<td width="50%">${r.r_contents}</td>
						<td width="30%">${r.r_date}</td>
					</tr>
				</c:forEach>
				</table>
			</div>
		</div>
	</div>
	</section>
	<footer>
	<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</div>
</body>
<script src="resources/js/jquery.serializeObject.js"></script>
<!-- 
resources 경로의 사용
MemberController와 연결되는 jsp에서는
src="resources/하위폴더나 파일...",
BoardController와 연결되는 jsp에서는
src="../resources/하위폴더나 파일..."로 작성.
 -->
<script type="text/javascript">
function replyInsert(bnum){
	//form의 데이터를 가져와서 json으로 변환
	var replyFrm = $('#rFrm').serializeObject();
	//추가 데이터 : 게시글번호, 작성자(로그인) id
	replyFrm.r_bnum = bnum;
	//세션에 저장한 로그인 회원 정보에서 id 추출
	replyFrm.r_id = '${mb.m_id}';
	console.log(replyFrm);
	
	$.ajax({
		url: "replyInsert",//요청 url(uri)
		type: "post",//전송 방식(get, post)
		data: replyFrm,//전송할 데이터
		dataType: "json",//데이터의 형식
		success: function(data){
			//목록 전체를 하나의 문자열로 만들어서
			//한꺼번에 id가 rTable인 태그(요소)의
			//innerHTML에 출력.
			var rlist = '';
			var dlist = data.rList;
			for(var i = 0; i < dlist.length; i++){
				rlist += '<tr height="25" align="center">'
				+'<td width="20%">'+ dlist[i].r_id +'</td>'
				+'<td width="50%">'+ dlist[i].r_contents +'</td>'
				+'<td width="30%">'+ dlist[i].r_date +'</td></tr>'
			}
			$('#rTable').html(rlist);
		},
		error: function(error){
			alert("댓글 입력 실패");
		}
	});
	
	$('#comment').val('');//댓글창 지우기
}

function goDelete(bnum, lid, bid){
	if(lid != bid){
		alert("본인이 작성한 글이 아니면 삭제할 수 없습니다.");
		return;
	}
	var del = confirm("정말로 삭제 하시겠습니까?");
	if(del == true){
		location.href='./delete?bnum=' + bnum;
	}
	else{
		alert("취소되었습니다.");
	}
}

function fileDel() {
	var ok = confirm('첨부파일을 삭제하겠습니까?');
	
	if(ok == true){
		var fname = '${fsname}';
		console.log(fname);
		
		var fnObj = {"fname": fname};
		console.log(fnObj);
		
		$.ajax({
			url: "fdelete",
			type: "get",
			data: fnObj,
			success: function(data){
				if(data == "success"){
					$('#farea').html('첨부된 파일이 없습니다.');
					$('#fview').html('');
				}
				else{
					alert('삭제 실패');					
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	}
}
</script>
</html>






