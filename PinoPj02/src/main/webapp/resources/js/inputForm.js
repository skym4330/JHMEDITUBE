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
	}).focusout(function() {
		var hp = $(this).val();
		if (hp) {
			$.ajax({
				url: '/hrm/hp.ck',
				type: 'POST',
				dataType: 'json',
				data: { hp: hp },
				success: function(result) {
					if (result != 0) {
						alert('이미 사용중인 핸드폰번호입니다.');
						$('#hp').val('');
						$('#hpck').val('N');
						$('#hp').focus();
					} else {
						alert('사용 가능한 핸드폰번호입니다.');
						$('#hpck').val('Y');
					}
				},
				error: function(request, status, error) {
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		} else return;
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

	$('#salary_input').focus(function() {
		let sal = $(this).val();
		sal = sal.replace(/\,/g, "");
		$(this).val(sal);
	}).focusout(function() {
		let sal = $(this).val();
		if (sal != null) {
			$('#salary').val(sal);
		} else {
			$('#salary').val(0);
		}
		sal = addComma(sal);
		$(this).val(sal);
	});

	$('#kosa_reg_yn').change(function() {
		var reg_yn = $(this).val();
		if (reg_yn == '2') {
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

		var wrg_gen = parseInt(reg_no_in.substring(6, 7));
		if (wrg_gen <= 0 || wrg_gen > 4) {
			$(this).val(
				$(this).val()
					.replace(reg_no_in, reg_no_in.substring(0, 6))
			);
		}

		var gen = parseInt(reg_no_in.substring(7, 8));
		if (gen % 2 == 0) {
			$('#sex').val('2');
		} else if (gen % 2 == 1) {
			$('#sex').val('1');
		} else {
			$('#sex').val('0');
		}

		if (reg_no_in.length >= 8) {
			var birth_year = parseInt(reg_no_in.substring(0, 2));
			if (birth_year >= 50 && gen > 2) {
				$(this).val(
					$(this).val()
						.replace(reg_no_in, reg_no_in.substring(0, 6))
				);
			}
			var today = new Date();
			var today_year = today.getFullYear();
			if (gen <= 2) {
				birth_year = birth_year + 1900;
			} else {
				birth_year = birth_year + 2000;
			}

			var gap = today_year - birth_year + 1;
			$('#years').val(gap);
		}
	}).focusout(function() {
		$(this).val(
			$(this).val().replace(/(?<=.{8})./g, '*')
		);
	});

	$('#name').keyup(function() {
		$(this).val(
			$(this).val()
				.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g, '')
		);
	});

	$('#eng_name').keyup(function() {
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

	$('#id').keyup(function() {
		$(this).val(
			$(this).val()
				.replace(/^[^a-zA-z]+\W+$/gi, '')
		);
	}).focusout(function() {
		var id = $(this).val();
		if (id) {
			$.ajax({
				url: '/hrm/id.ck',
				type: 'POST',
				dataType: 'json',
				data: {
					id: id
				},
				success: function(data) {
					var cnt = data;
					if (cnt == 0) {
						$('#idck').val('Y');
						alert('사용 가능한 ID 입니다.');
					} else {
						$('#idck').val('N');
						alert('이미 등록된 ID입니다.')
						$('#id').val('');
						$('#id').focus();
					}
				},
				error: function(request, status, error) {
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		} else {
			$('#idck').val('N');
			return;
		}
	});

	$('#regEmp').click(function() {
		var idck = $('#idck').val();
		var pwd = $('#pwd').val();
		var pwdck = $('#pwd_ck').val();
		var mail = $('#mail').val();
		var domain = $('#domain').val();
		var email = $('#email').val();
		var hp = $('#hp').val();
		var hpck = $('#hpck').val();
		var join_day = $('#join_day').val();

		if (idck == 'N') {
			alert('아이디를 확인해주세요.');
			$('#id').focus();
			return;
		}

		if (pwd != pwdck || pwd == null || pwd.length == 0 || pwdck == null || pwdck.length == 0) {
			alert('비밀번호를 확인해주세요.');
			$('#pwd').focus();
			return;
		}

		if (mail == null || mail.length == 0 || domain == null || domain.length == 0) {
			alert('이메일을 확인해주세요.');
			$('#mail').focus();
			return;
		}

		if (hp == null || hp.length == 0 || hpck == 'N') {
			alert('핸드폰번호를 확인해주세요.');
			$('#hp').focus();
			return;
		}

		if (join_day == null || join_day.length == 0) {
			alert('입사일자를 확인해주세요.');
			$('#join_day').focus();
			return;
		}

		email = mail + '@' + domain;
		$('#email').val(email);

		alert('등록 성공');
		$('#frm').submit();
	});
});
