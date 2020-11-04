<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<html>
<head>
<meta charset="UTF-8">
<title>직원리스트</title>
<!-- ajax -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
<!-- 부트스트랩 JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>
<!-- 주소검색관련 API -->
<!-- JQuery JS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 전용CSS -->
<link href="resources/css/insaListForm.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(
			function() {
				var chk = "${msg}";

				if (chk == "5") {
					alert("정보 삭제 성공!");
				} else if (chk == "6") {
					alert("정보 삭제 실패!");
				}

				$(".datepicker").datepicker();

				//datepicker 기본설정
				$.datepicker.setDefaults({
					dateFormat : 'yy-mm-dd',
					closeText : '닫기', // 닫기 버튼 텍스트 변경
					currentText : '오늘', // 오늘 텍스트 변경
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ], //한글 캘린더중 월 표시를 위한 부분
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ], // 한글 요일 표시 부분
					showButtonPanel : true
				// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
				});

				// 입사일자 & 퇴사일자 "시작일"
				$("#JOIN_DAY").datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#RETIRE_DAY").datepicker("option", "minDate",
									selectedDate);
						});

				// 입사일자 & 퇴사일자 "종료일"
				$('#RETIRE_DAY').datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#JOIN_DAY").datepicker("option", "maxDate",
									selectedDate);
						});
			});
	
/*
	function sabunval() {
		var val = document.getElementById("ssabun").value;

		$("#SABUN").val(val);

		console.log(val);
	}
*/
</script>
</head>
<header>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="/controller">피노소프트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<a class="nav-link" href="/controller/insaInputForm">입력하기</a> <a
					class="nav-link" href="/controller/insaListForm">조회하기</a>
			</div>
		</div>
	</nav>
</header>
<body>
	<br>
	<form action="getInsaList" method="GET">
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="SABUN" class="col-sm-3 col-form-label">사번</label>
					<div class="col-sm-9">
						<input class="form-control" type="text" name="SABUN" id="SABUN"
							value="${iDto.SABUN}" style="text-align: right;">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="NAME" class="col-sm-3 col-form-label">성명</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="NAME" name="NAME"
							value="${iDto.NAME}">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-3 col-form-label">입사구분</label>
					<div class="col-sm-9">
						<select class="form-control form-control-sm" name="JOIN_YN"
							id="JOIN_YN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 6}">
									<c:if test="${iItem.name == iDto.JOIN_YN}">
										<option value="${iDto.JOIN_YN}" selected="selected">${iDto.JOIN_YN}</option>
									</c:if>
									<c:if test="${iItem.name != iDto.JOIN_YN}">
										<option value="${iItem.name}">${iItem.code}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputPassword3" class="col-sm-3 col-form-label">투입여부</label>
					<div class="col-sm-9">
						<select class="form-control form-control-sm" name="PUT_YN"
							id="PUT_YN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 8}">
									<c:if test="${iItem.name == iDto.PUT_YN}">
										<option value="${iDto.PUT_YN}" selected="selected">${iDto.PUT_YN}</option>
									</c:if>
									<c:if test="${iItem.name != iDto.PUT_YN}">
										<option value="${iItem.name}">${iItem.code}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-3 col-form-label">직위</label>
					<div class="col-sm-9">
						<select class="form-control form-control-sm" name="POS_GBN_CODE"
							id="POS_GBN_CODE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 4}">
									<c:if test="${iItem.name == iDto.POS_GBN_CODE}">
										<option value="${iDto.POS_GBN_CODE}" selected="selected">${iDto.POS_GBN_CODE}</option>
									</c:if>
									<c:if test="${iItem.name != iDto.POS_GBN_CODE}">
										<option value="${iItem.name}">${iItem.code}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-3 col-form-label">입사일자</label>
					<div class="col-sm-9">
						<input type="text" class="form-control datepicker" id="JOIN_DAY"
							name="JOIN_DAY">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-3 col-form-label">퇴사일자</label>
					<div class="col-sm-9">
						<input type="text" class="form-control datepicker"
							name="RETIRE_DAY" id="RETIRE_DAY">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="inputPassword3" class="col-sm-3 col-form-label">직종분류</label>
					<div class="col-sm-9">
						<select class="form-control form-control" name="JOB_TYPE"
							id="JOB_TYPE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 2}">
									<c:if test="${iItem.name == iDto.JOB_TYPE}">
										<option value="${iDto.JOB_TYPE}" selected="selected">${iDto.JOB_TYPE}</option>
									</c:if>
									<c:if test="${iItem.name != iDto.JOB_TYPE}">
										<option value="${iItem.name}">${iItem.code}</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="insaSearchWrapBtn">
			<div class="btn-group" id="btn-group" role="group"
				aria-label="Basic example">
				<!--  	<input type="text" name="pageNum" hidden="" value="${pageNum}"> -->
				<button type="submit" class="btn btn-secondary">검색</button>
				<!-- 
				<button type="reset" class="btn btn-secondary">초기화</button>
				 -->
				<button type="button" class="btn btn-secondary" onclick="goback()">이전</button>
			</div>
		</div>
	</form>

	<div class="insaListWrap">
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th scope="col">사번</th>
					<th scope="col">성명</th>
					<th scope="col">주민번호</th>
					<th scope="col">핸드폰번호</th>
					<th scope="col">직위</th>
					<th scope="col">입사일자</th>
					<th scope="col">퇴사일자</th>
					<th scope="col">투입여부</th>
					<th scope="col">연봉</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mList}" var="mItem">
					<tr onclick="location.href='./insaUpdateForm?sabun=${mItem.SABUN}'">
						<th scope="col">${mItem.SABUN}</th>
						<th scope="col">${mItem.NAME}</th>
						<th scope="col">${mItem.REG_NO}</th>
						<th scope="col">${mItem.HP}</th>
						<th scope="col">${mItem.GART_LEVEL}</th>
						<!-- Dto가 String 형식일때 포멧하는 코드 -->
						<th scope="col">${fn:substring(mItem.JOIN_DAY,0,10) }</th>
						<th scope="col">${fn:substring(mItem.RETIRE_DAY,0,10) }</th>
						<!-- Dto가 Date 형식일때 포멧하는 코드
				 <th scope="col">
				 <fmt:formatDate value="${mItem.jday}" pattern="yyyy-MM-dd"/></th>
				 <th scope="col">
				 <fmt:formatDate value="${mItem.rday}" pattern="yyyy-MM-dd"/></th>
				 -->
						<th scope="col">${mItem.PUT_YN}</th>
						<th scope="col">${mItem.SALARY}</th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="paging" style="text-align: center;">
		<ul>${pagingImg}
		</ul>
	</div>
</body>
<script type="text/javascript">
	function goback() {
		window.history.back();
	}
</script>
</html>