<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사관리시스템</title>
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
<!-- 전용CSS -->
<link href="resources/css/insaInputForm.css" rel="stylesheet">
<!-- 주소검색관련 API -->
<!-- JQuery JS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var chk = "${msg}";

				console.log(chk);

				if (chk == "1") {
					alert("글 등록 성공!");
				} else if (chk == "2") {
					alert("글 등록 실패!");
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

				// 입영일자 & 전역일자 "시작일"
				$('#MIL_STARTDATE').datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#MIL_ENDDATE").datepicker("option", "minDate",
									selectedDate);
						});

				// 입영일자 & 전역일자 "종료일"
				$('#MIL_ENDDATE').datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#MIL_STARTDATE").datepicker("option", "maxDate",
									selectedDate);
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

	//opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
	//document.domain = "abc.go.kr";

	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("popup/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		$("input#ZIP").val(zipNo);
		$("input#roadAddrPart1").val(roadAddrPart1);
		$("input#addrDetail").val(addrDetail);
	}

	function inputPhoneNumber(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}
		obj.value = phone;
	}
	
	function saup(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 2);
			phone += "-";
			phone += number.substr(5);
		}
		obj.value = phone;
	}
	
	function inputtaxNumber(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}
		obj.value = phone;
	}
	
	function inputjumin(obj) {
		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else {
			phone += number.substr(0, 6);
			phone += "-";
			phone += number.substr(6);
		}
		obj.value = phone;
	}

	function autoInput() {

		var number = document.getElementById("REG_NO").value;

		console.log(number);
		var num1 = number.substr(0, 2);
		console.log(num1);
		var num2 = number.substr(7, 1);
		console.log(num2);

		var num3 = Number(num1);
		var num4 = Number(num2);

		var age = 0;
		if (num4 == 3 || num4 == 4) {
			age = num3 + 21
		} else {
			age = 100 - num3 + 21
		}
		console.log(age);

		$("#YEARS").val(age);
		var sex = '';
		if (num4 == 1 || num4 == 3) {
			sex = '남';
		} else {
			sex = '여';
		}
		console.log(sex);

		$("#SEX").val(sex);
	}

	function mildisabled() {

		var type = document.getElementById("MIL_YN").value;

		console.log(type);

		if (type == 'N') {
			$("#MIL_TYPE").attr("disabled", true);
			$("#MIL_LEVEL").attr("disabled", true);
			$("#MIL_STARTDATE").attr("disabled", true);
			$("#MIL_ENDDATE").attr("disabled", true);

			$("#MIL_TYPE").val("");
			$("#MIL_LEVEL").val("");
			$("#MIL_STARTDATE").val("");
			$("#MIL_ENDDATE").val("");
		} else {
			$("#MIL_TYPE").attr("disabled", false);
			$("#MIL_LEVEL").attr("disabled", false);
			$("#MIL_STARTDATE").attr("disabled", false);
			$("#MIL_ENDDATE").attr("disabled", false);
		}
	}

	function pwdCInput() {
		var str = document.getElementById("pwdInput").value;
		var pwd = document.getElementById("PWD").value;
		var lastStr = str.substr(str.length - 1, 1);
		var changeStr = '';
		console.log(pwd);
		console.log(lastStr);

		pwd += lastStr;
		console.log(pwd);

		for (var i = 1; i < str.length; i++) {
			changeStr += '*';
		}
		changeStr += lastStr;
		console.log(changeStr);

		$("#pwdInput").val(changeStr);
		$("#PWD").val(pwd);
	}

	function pwdChkInput() {
		var str = document.getElementById("PWDCHKINPUT").value;
		var pwd = document.getElementById("PWDCHK").value;
		var lastStr = str.substr(str.length - 1, 1);
		var changeStr = '';
		console.log(pwd);
		console.log(lastStr);

		pwd += lastStr;
		console.log(pwd);

		for (var i = 1; i < str.length; i++) {
			changeStr += '*';
		}
		changeStr += lastStr;
		console.log(changeStr);

		$("#PWDCHKINPUT").val(changeStr);
		$("#PWDCHK").val(pwd);
	}
	
	function SALARYINPUTFRM(){
		var sal = document.getElementById("SALARYINPUT").value;
		
		console.log(sal);
		$("#SALARY").val(sal);
		var csal = addComma(sal);
		console.log(csal);
		$("#SALARYINPUT").val(csal);
	}
	
	
	function addComma(num) {
		  var regexp = /\B(?=(\d{3})+(?!\d))/g;
		  return num.toString().replace(regexp, ',');
		}
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
<body style="padding-left: 30px; padding-right: 30px;">
	<form action="MemberInsert" method="POST" enctype="multipart/form-data">
		<div class="banner">
			<h1>직원 상세 정보</h1>
			<button type="submit" class="btn btn-outline-secondary">등록</button>
			<button type="button" class="btn btn-outline-secondary"
				onclick="goback()">전화면</button>
		</div>
		<br>
		<div class="imageUpload"
			style="position: absolute; top: 170px; left: 100px;">
			<div class="uploadResult">
				<img id="profilef" src="resources/img/no-image-icon-md.png"
					style="width: 300px; height: 250px; margin-bottom: 30px;"
					class="img-frm" />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="SABUN" class="col-sm-4 col-form-label">*사번</label>
					<div class="col-sm-8">
						<input type="text" disabled="disabled" required="required"
							class="form-control">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="NAME" class="col-sm-4 col-form-label">*한글성명</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" required="required"
							name="NAME" id="NAME">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="ENG_NAME" class="col-sm-4 col-form-label">영문성명</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="ENG_NAME"
							id="ENG_NAME">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="ID" class="col-sm-4 col-form-label">*아이디</label>
					<div class="col-sm-8">
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="ID" name="ID"
								required="required">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button"
									id="button-addon2" onclick="idChk()">중복확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="PWD" class="col-sm-4 col-form-label">*패스워드</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="PWD" id="PWD" hidden>
						<input type="text" class="form-control" name="pwdInput"
							id="pwdInput" required="required" maxlength="20" minlength="6"
							onkeyup="pwdCInput()">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="PWDCHK" class="col-sm-4 col-form-label"
						style="padding-right: 0px; padding-left: 0px;">*패스워드확인</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="PWDCHKINPUT"
							onblur="pwdchk()" required="required" id="PWDCHKINPUT"
							onkeyup="pwdChkInput()"> <input type="text"
							class="form-control" name="PWDCHK" id="PWDCHK" hidden>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="PHONE" class="col-sm-4 col-form-label">전화번호</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="PHONE" id="PHONE"
						onkeyup="inputtaxNumber(this)" maxlength="13">
						
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="HP" class="col-sm-4 col-form-label">*핸드폰번호</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" required="required"
							onkeyup="inputPhoneNumber(this)" name="HP" id="HP" maxlength="13">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="REG_NO" class="col-sm-4 col-form-label">*주민번호</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="REG_NO" id="REG_NO"
							required="required" onkeyup="inputjumin(this)" maxlength="14"
							onblur="autoInput()">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="YEARS" class="col-sm-4 col-form-label">연령</label>
					<div class="col-sm-8">
						<input type="number" class="form-control" name="YEARS" id="YEARS"
							value="0">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="EMAIL" class="col-sm-3 col-form-label">*이메일</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" required="required"
							name="EMAIL" id="EMAIL">
					</div>
					<div class="col-sm-5">
						<select class="form-control form-control" name="DOMAIN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 1}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="row">
					<div class="col">
						<div class="form-group row">
							<label for="JOB_TYPE" class="col-sm-4 col-form-label"
								style="padding: 0px; text-align: center; padding-top: 5px;">직종체크</label>
							<div class="col-sm-8">
								<select class="form-control form-control" name="JOB_TYPE"
									id="JOB_TYPE">
									<c:forEach items="${iList}" var="iItem">
										<c:if test="${iItem.gubun == 2}">
											<option value="${iItem.name}">${iItem.code}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="form-group row">
							<label for="SEX" class="col-sm-4 col-form-label"
								style="padding: 0px; text-align: center; padding-top: 5px;">성별</label>
							<div class="col-sm-8">
								<select class="form-control form-control" name="SEX" id="SEX">
									<c:forEach items="${iList}" var="iItem">
										<c:if test="${iItem.gubun == 3}">
											<option value="${iItem.name}">${iItem.code}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="ZIP" class="col-sm-4 col-form-label">주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="ZIP" id="ZIP"
							readonly="readonly">
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-outline-secondary"
							onclick="goPopup();">주소검색</button>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="row">
					<div class="col">
						<input type="text" class="form-control" placeholder="주소"
							name="ADDR1" id="roadAddrPart1">
					</div>
					<div class="col">
						<input type="text" class="form-control" placeholder="세부주소"
							name="ADDR2" id="addrDetail">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<label for="PROFILE_IMAGE_FILE" class="w-100"> <span
					id="REG_PROFILE_IMAGE" class="btn btn-outline-secondary"
					style="margin-left: 180px;"> 사진올리기 </span>
				</label> <input type="file" name="PROFILE_IMAGE_FILE"
					id="PROFILE_IMAGE_FILE" onchange="pro_miri(event);" hidden="hidden"
					accept="image/*"> <input type="hidden" id="PROFILE_IMAGE"
					name="PROFILE_IMAGE">
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="POS_GBN_CODE" class="col-sm-4 col-form-label">직위</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="POS_GBN_CODE"
							id="POS_GBN_CODE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 4}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="DEPT_CODE" class="col-sm-4 col-form-label">부서</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="DEPT_CODE"
							id="DEPT_CODE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 5}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="SALARY" class="col-sm-4 col-form-label">연봉(만원)</label>
					<div class="col-sm-8">					
						<input type="text" class="form-control" placeholder="(만원)" style="text-align: right;"
							name="SALARYINPUT" id="SALARYINPUT" onblur="SALARYINPUTFRM()">					
						<input type="number" class="form-control" placeholder="(만원)"
							name="SALARY" id="SALARY" value="0" hidden="">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="JOIN_YN" class="col-sm-4 col-form-label">입사구분</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="JOIN_YN"
							id="JOIN_YN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 6}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="GART_LEVEL" class="col-sm-4 col-form-label">등급</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="GART_LEVEL"
							id="GART_LEVEL">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 7}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="PUT_YN" class="col-sm-4 col-form-label">투입여부</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="PUT_YN"
							id="PUT_YN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 8}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="mil_yn" class="col-sm-4 col-form-label">군필여부</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="MIL_YN"
							id="MIL_YN" onblur="mildisabled()">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 9}">
									<option value="${iItem.name}">${iItem.code}</option>
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
					<label for="MIL_TYPE" class="col-sm-4 col-form-label">군별</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="MIL_TYPE"
							id="MIL_TYPE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 10}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="MIL_LEVEL" class="col-sm-4 col-form-label">계급</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="MIL_LEVEL"
							id="MIL_LEVEL">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 11}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="MIL_STARTDATE" class="col-sm-4 col-form-label">입영일자</label>
					<div class="col-sm-8">
						<input type="text" class="form-control datepicker milForm"
							name="MIL_STARTDATE" id="MIL_STARTDATE">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="MIL_ENDDATE" class="col-sm-4 col-form-label">전역일자</label>
					<div class="col-sm-8">
						<input type="text" class="form-control datepicker milForm"
							name="MIL_ENDDATE" id="MIL_ENDDATE">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="KOSA_REG_YN" class="col-sm-4 col-form-label">KOSA등록</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm" name="KOSA_REG_YN"
							id="KOSA_REG_YN">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 12}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="KOSA_CLASS_CODE" class="col-sm-4 col-form-label">KOSA등급</label>
					<div class="col-sm-8">
						<select class="form-control form-control-sm"
							name="KOSA_CLASS_CODE" id="KOSA_CLASS_CODE">
							<c:forEach items="${iList}" var="iItem">
								<c:if test="${iItem.gubun == 13}">
									<option value="${iItem.name}">${iItem.code}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="JOIN_DAY" class="col-sm-4 col-form-label">*입사일자</label>
					<div class="col-sm-8">
						<input type="text" class="form-control datepicker" name="JOIN_DAY"
							id="JOIN_DAY" required="required" >
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="RETIRE_DAY" class="col-sm-4 col-form-label">퇴사일자</label>
					<div class="col-sm-8">
						<input type="text" class="form-control datepicker"
							name="RETIRE_DAY" id="RETIRE_DAY">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="CMP_REG_NO" class="col-sm-4 col-form-label">사업자번호</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="CMP_REG_NO"
							id="CMP_REG_NO" maxlength="12" onkeyup="saup(this)">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="CRM_NAME" class="col-sm-4 col-form-label">업체명</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="CRM_NAME"
							id="CRM_NAME">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="customFile" class="col-sm-4 col-form-label">사업자등록증</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="CMP_REG_IMAGE"
							name="CMP_REG_IMAGE" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="row">
					<div class="col-sm-6">
						<label for="CMP_REG_IMAGE_FILE" class="w-100"> <span
							id="REG_CMP_REG_IMAGES"
							class="btn btn-outline-secondary btn-block">등록</span>
						</label> <input type="file" name="CMP_REG_IMAGE_FILE"
							id="CMP_REG_IMAGE_FILE" hidden="hidden" accept="image/*"
							onchange="cmp_miri(event);" />
						<!-- Button trigger modal -->
					</div>
					<div class="col-sm-6">
						<button type="button" class="btn btn-outline-secondary btn-block"
							data-toggle="modal" data-target="#exampleModal">미리보기</button>
					</div>
				</div>


				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">미리보기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body" id="miribogi-one">
								<img src="#" id="image_section" width="100%">
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group row">
					<label for="SELF_INTRO" class="col-sm-2 col-form-label">자기소개</label>
					<div class="col-sm-10">
						<textarea class="form-control" id="SELF_INTRO" rows="1"
							name="SELF_INTRO"></textarea>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group row">
					<label for="customFile" class="col-sm-4 col-form-label">이력서</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="CARRIER_IMAGE"
							name="CARRIER_IMAGE" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="row">
					<div class="col-sm-6">
						<label for="CARRIER_IMAGE_FILE" class="w-100"> <span
							id="REG_CARRIER_IMAGES"
							class="btn btn-outline-secondary btn-block">등록</span>
						</label> <input type="file" name="CARRIER_IMAGE_FILE"
							id="CARRIER_IMAGE_FILE" hidden="hidden" accept="image/*"
							onchange="car_miri(event);" />
						<!-- Button trigger modal -->
					</div>
					<div class="col-sm-6">
						<button type="button" class="btn btn-outline-secondary btn-block"
							data-toggle="modal" data-target="#exampleModal2">미리보기</button>
					</div>
				</div>


				<!-- Modal -->
				<div class="modal fade" id="exampleModal2" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">미리보기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body" id="miribogi-two">
								<img src="#" id="carrier_img_miri" width="100%">
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	function idChk() {
		var id = $('#ID').val();
		if (id == "") {
			alert("아이디를 입력하세요.");
			$('#ID').focus();
			return;
		}
		var ckObj = {
			"id" : id
		};
		console.log(ckObj);

		$.ajax({
			url : "idChk",
			type : "get",
			data : ckObj,
			success : function(data) {
				if (data == "success") {
					alert('ID 사용 가능');
				} else {
					alert('사용할 수 없는 ID');
					$('#ID').val('');//입력 초기화
					$('#ID').focus();//ID 부분에 포커스 주기
				}
			},
			error : function(error) {
				console.log(error);
			}
		});
	}

	$("#CMP_REG_IMAGE_FILE").on('change', function() {
		var file = document.getElementById("CMP_REG_IMAGE_FILE");
		console.log(file);
		var filelist = file.files;
		console.log(filelist);

		var fileName = $("#CMP_REG_IMAGE_FILE").val();
		$("#CMP_REG_IMAGE").val(fileName);

		$("#miribogi-one").src(fileName);
	});

	$("#CARRIER_IMAGE_FILE").on('change', function() {
		var file = document.getElementById("CARRIER_IMAGE_FILE");
		console.log(file);
		var filelist = file.files;
		console.log(filelist);
		var fileName = $("#CARRIER_IMAGE_FILE").val();
		console.log(fileName);
		$("#CARRIER_IMAGE").val(fileName);

		$("#carrier_img_miri").attr("src", fileName);
	});

	$("#PROFILE_IMAGE_FILE").on('change', function() {
		var file = document.getElementById("PROFILE_IMAGE_FILE");

		$("#PROFILE_IMAGE").val(file);
	});

	function car_miri(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			$('#carrier_img_miri').attr("src", event.target.result);
		};
		reader.readAsDataURL(event.target.files[0]);
		console.log(img);
	}

	function cmp_miri(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			$('#image_section').attr("src", event.target.result);
		};
		reader.readAsDataURL(event.target.files[0]);
		console.log(img);
	}

	function pro_miri(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			$('#profilef').attr("src", event.target.result);
		};
		reader.readAsDataURL(event.target.files[0]);
		console.log(img);
	}

	function goback() {
		location.href='./';
	}

	function pwdchk() {
		var pwd = document.getElementById("PWD").value;
		var pwdchk = document.getElementById("PWDCHK").value;
		console.log("비밀번호매칭" + pwd + " AND " + pwdchk);

		if (pwd != pwdchk) {
			alert("입력한 비밀번호가 다릅니다.");
			$('#PWDCHKINPUT').val("");
			$('#PWDCHK').val("");
			$('#PWD').val("");
			$('#pwdInput').val("");
		}
	}
</script>
</html>