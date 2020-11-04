$(document).ready(function() {
	if($('#ssabun').val() == 0) {
		$('#ssabun').val('');
	}

	$('#searchEmp').click(function(){
		var sabun = $('#ssabun').val();
		$('#nowPage').val(1);

		if(sabun == '') {
			$('#sabun').val(0);
		} else {
			$('#sabun').val(sabun);
		}

		$('#frmsch').attr('action', '/hrm/insaListForm.do');
		$('#frmsch').submit();
	});
	
	$('.pbtn').click(function(){
		var pagebtn = $(this).text();
		var startPage = parseInt($('#startPage').val());
		var endPage = parseInt($('#endPage').val());
		
		if(pagebtn == 'PRE') {
			$('#nowPage').val(startPage - 1);
		} else if(pagebtn == 'NEXT') {
			$('#nowPage').val(endPage + 1);
		} else {
			$('#nowPage').val(pagebtn);
		}
		
		$('#frmsch').attr('action', '/hrm/insaListForm.do');
		$('#frmsch').submit();
	});
	
	$('.content').click(function(){
		var sabun = $(this).attr('id');
		$('#eno').val(sabun);

		$('#frminfo').attr('action', '/hrm/insaUpdateForm.do');
		$('#frminfo').submit();
	});

	$('#rstbtn').click(function(){
		$('#ssabun').val('');
		$('#sabun').val('');
		$('#pos_gbn_code').val('');
		$('#name').val('');
		$('#join_day').val('');
		$('#join_yn').val('');
		$('#retire_day').val('');
		$('#put_yn').val('');
		$('#join_gbn_code').val('');
	});
});
