function goPopup() {
	var pop = window.open(
		"/hrm/popup/jusoPopup.jsp",
		"pop",
		"width=570,height=420,scrollbars=yes,resizable=yes"
	);
}

function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
	$("input#zip").val(zipNo);
	$("input#addr1").val(roadAddrPart1);
	$("input#addr2").val(addrDetail);
}

function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

$(document).ready(function() {
	$("#hp").keyup(function() {
		$(this).val(
			$(this).val().replace(/[^0-9]/g, "")
			.replace(/(^02|^0505|^1\d{3}|^0\d{2})(\d+)?(\d{4})$/, "$1-$2-$3")
			.replace("--", "-")
		);
	});
	
	$("#phone").keyup(function() {
		$(this).val(
			$(this).val()
			.replace(/[^0-9]/g, "")
			.replace(/(^02|^0505|^1\d{3}|^0\d{2})(\d+)?(\d{4})$/, "$1-$2-$3")
			.replace("--", "-")
		);
	});
	
	$("#cmp_reg_no").keyup(function() {
		$(this).val(
			$(this).val()
			.replace(/[^0-9]/g, "")
			.replace(/(^\d{3})(\d{2})(\d{5})$/, "$1-$2-$3")
			.replace("--", "-")
		);
	});

	$('#salary_input').focus(function(){
		let sal = $(this).val();
		sal = sal.replace(/\,/g, "");
		$(this).val(sal);
	}).focusout(function(){
		let sal = $(this).val();
		if(sal != null) {
			$('#salary').val(sal);
		} else {
			$('#salary').val(0);
		}
		sal = addComma(sal);
		$(this).val(sal);
	});
	
	$('#kosa_reg_yn').change(function(){
		var reg_yn = $(this).val();
		if(reg_yn == '2') {
			$('#kosa_class_code').attr('disabled', false);
		} else {
			$('#kosa_class_code').attr('disabled', true);
		}
	});

	$('#reg_no_input').keyup(function() {
		$(this).val(
			$(this).val()
			.replace(/[^0-9]/g, "")
			.replace(/(^\d{6})([1-4]{1})(\d{1,6})?/, "$1-$2$3")
		);
		var reg_no_in = $(this).val();
		$('#reg_no').val(reg_no_in);
				
		var wrg_gen = parseInt(reg_no_in.substring(6,7));
		if(wrg_gen <= 0 || wrg_gen > 4) {
			$(this).val(
				$(this).val()
				.replace(reg_no_in, reg_no_in.substring(0,6))
				);
			}
		
		var gen = parseInt(reg_no_in.substring(7,8));
		if(gen % 2 == 0) {
			$('#sex').val('2');
		} else if(gen % 2 == 1) {
			$('#sex').val('1');
		} else {
			$('#sex').val('0');
		}
		
		if(reg_no_in.length >= 8) {
			var birth_year = parseInt(reg_no_in.substring(0,2));
			if(birth_year >= 50 && gen > 2) {
			$(this).val(
				$(this).val()
				.replace(reg_no_in, reg_no_in.substring(0,6))
				);
			}
			var today = new Date();
			var today_year = today.getFullYear();
			if(gen <= 2) {
				birth_year = birth_year + 1900;
			} else {
				birth_year = birth_year + 2000;
			}
			
			var gap = today_year - birth_year + 1;
			$('#years').val(gap);
		}
	}).focusout(function(){
		$(this).val(
			$(this).val().replace(/(?<=.{8})./g, '*')
		);
	});

	$('#name').keyup(function() {
		$(this).val(
			$(this).val()
			.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g,'')
		);
	});

	$('#eng_name').keyup(function(){
		$(this).val(
			$(this).val()
			.replace(/^[^a-zA-z]+$/gi, '')
		);
	});

	$('#profileimg').change(function(e) {
		var vfile = URL.createObjectURL(e.target.files[0]);
		$('#profilef').attr('src', vfile);
	});
	
	$('#cmp_reg_img').change(function(e) {
		var rname = $(this).val();
		rname = rname.substring(rname.lastIndexOf('\\') + 1);
		$('#ori_cmp_reg_img').val(rname);
		var rfile = URL.createObjectURL(e.target.files[0]);
		$('#preview_cmp_reg').attr('src', rfile);
	});
	
	$('#resume_img').change(function(e) {
		var cname = $(this).val();
		cname = cname.substring(cname.lastIndexOf('\\') + 1);
		$('#resume').val(cname);
		var cfile = URL.createObjectURL(e.target.files[0]);
		$('#preview_carrier').attr('src', cfile);
	});
	
	$('#show_cmp_reg_img').click(function() {
		$('#cmp_modal_header').removeClass('dnone');
		$('#preview_cmp_reg').removeClass('dnone');
		$('#carrier_modal_header').addClass('dnone');
		$('#preview_carrier').addClass('dnone');
		$('#preview_modal').modal();
	});
	
	$('#show_resume_img').click(function() {
		$('#carrier_modal_header').removeClass('dnone');
		$('#preview_carrier').removeClass('dnone');
		$('#cmp_modal_header').addClass('dnone');
		$('#preview_cmp_reg').addClass('dnone');
		$('#preview_modal').modal();
	});
	
	$('#id').keyup(function(){
		$(this).val(
			$(this).val()
			.replace(/^[^a-zA-z]+\W+$/gi, '')
		);
	});
	
	$('#editEmp').click(function(){
		alert('수정 완료');
		$('#frm').attr('action', '/hrm/insaUpdateProc.do');
		$('#frm').submit();
	});
	
	$('#delEmp').click(function(){
		var sabun = $('#sabun').val();
		var name = $('#name').val();
		var txt = "사번:" + sabun + " | 이름:" + name + " 사원의 정보를 삭제하시겠습니까?"
		var bool = confirm(txt);
		if(bool == true) {
			$('#frm').attr('action', '/hrm/insaDeleteProc.do');
			$('#frm').submit();
		}
	});
});
