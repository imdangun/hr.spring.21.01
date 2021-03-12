<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<title>HR</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='http://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css'>
<script>
function alert(msg, isSuccess) {	
	if(isSuccess) $('#alert').removeClass('alert-danger').addClass('alert-success');
	else $('#alert').removeClass('alert-success').addClass('alert-danger');
	
	if(isSuccess) msg = '[ 성공 ] ' + msg;
	else msg = '[ 실패 ] ' + msg;
	
	$('#msg').text(msg);
	$('#alert').show();
}

function closeAlert() {
	$('#alert').hide();
}

function initField(field) {
	$(field).val('');
	
	$(field).css({
		borderColor: '#ced4da',
		borderStyle: 'solid'
	});
}

function isVal(field){
	let check = false;	
	let fieldName;
	
	if(field.length) {
		if(field.val()) check = true;
		else {
			field.css({
				borderColor: 'red',
				borderStyle: 'dotted'
			});			
			
			switch(field.get(0).id) {
			case 'empName': fieldName = '사원명'; break;
			case 'hireDate': fieldName = '입사일'; 
			}
		}
	} else fieldName = '사번';
	
	if(!check) alert(fieldName + '을 입력하세요.', false);
	
	return check;
}

function init() {
	closeAlert();
	$('#closeAlertBtn').click(() => closeAlert());
	
	$('#empName').focus(function() {initField(this)});
	$('#hireDate').focus(function() {initField(this)});
	
	//사원 목록
	$('#listEmpBtn').click(() => {
		$('#empList').empty();
		
		$.ajax('emp/list')
			.done(emps => {				
				if(emps.length) {
					let empList = [];
				
					$.each(emps, (idx, emp) => {					
						empList.unshift(
							`<tr>
								<th></th>
								<th>
									<div class='form-check form-check-inline'>
										<input type='radio' class='form-check-input' 
											value='\${emp.empId}' name='empId' id='empId' />
										<label class='form-check-label' for='empId'>&nbsp; \${emp.empId}</label>
									</div>
								</th>
								<td>\${emp.empName}</td>
								<td>\${emp.hireDate}</td>
							</tr>`
						);
					});
					
					$('#empList').append(empList.join(''));
				} else {
					$('#empList').append('<tr><td colspan=4 class=text-center>사원이 없습니다.</td></tr>');
				}
			});			
	});
	
	//사원 추가
	$('#addEmpBtn').click(() => {
		if(isVal($('#empName')) && isVal($('#hireDate'))) {
			let emp = {				
				empName: $('#empName').val(),
				hireDate: $('#hireDate').val()
			};
			
			$.ajax({
				url: 'emp/add',
				method: 'post',
				data: emp
			}).done(cnt => {
				alert('사원 ' + cnt + '명을 추가했습니다.', cnt > 0);
				$('#listEmpBtn').click();
			}).fail(err => alert('사원을 추가하지 못했습니다.', false));		
		} 
	});
	
	//사원 수정
	$('#fixEmpBtn').click(() => {
		if(isVal($('#empId:checked')) && isVal($('#empName')) && isVal($('#hireDate'))) {
			
			$.ajax({
				url: 'emp/fix',
				method: 'put',
				data: JSON.stringify({
					empId: $('#empId:checked').val(),
					empName: $('#empName').val(),
					hireDate: $('#hireDate').val()
				}),
				contentType: 'application/json'
			}).done(cnt => {
				alert('사원 ' + cnt + '명을 수정했습니다.', cnt > 0);
				$('#listEmpBtn').click();
			}).fail(err => alert('사원을 수정하지 못했습니다.', false));
		}
	});
	
	//사원 삭제
	$('#delEmpBtn').click(() => {
		if(isVal($('#empId:checked'))) {
			$('#delEmpModal').modal();
		}
	});
	
	$('#delEmpOkBtn').click(() => {
		$.ajax({
			url: `emp/del/\${$('#empId:checked').val()}`,
			method: 'delete'
		}).done(cnt => {
				alert('사원 ' + cnt + '명을 삭제했습니다.', cnt > 0);
				$('#listEmpBtn').click();
			}			
		).fail(err => alert('사원을 삭제하지 못했습니다.', false));
		
		$('#delEmpModal').modal('hide');
	});
	
	$('#empList').on({
		change() {
			let emp = $(this).parents('tr').find('td');
			
			$('#empName').val(emp.eq(0).text());
			$('#hireDate').val(emp.eq(1).text());
		}
	}, '#empId');
}

$(init);
</script>

<style>
.jumbotron {
  padding: 1rem; 
}

.w-24 {
	width: 24.5%;
}
</style>

<div class='container'>
	<div class='row'>
		<div class='col'>
			<header class='jumbotron'>
				<h1 class='text-center'>HR</h1>					
			</header>
		</div>
	</div>	
	
	<div class='row mb-3'>
		<div class='col'>
			<nav>
				<button type='button' class='btn btn-primary w-24' id='listEmpBtn'>
					<i class='fas fa-align-justify'></i> 목록
				</button>
				<button type='button' class='btn btn-success w-24' id='addEmpBtn'>
					<i class='fas fa-plus'></i> 추가
				</button>
				<button type='button' class='btn btn-info w-24' id='fixEmpBtn'>
					<i class='fas fa-edit'></i> 수정
				</button>
				<button type='button' class='btn btn-warning w-24' id='delEmpBtn'>
					<i class='fas fa-trash-alt'></i> 삭제
				</button>
			</nav>
		</div>
	</div>

	<div class='row mb-3'>					
		<div class='col-2'>
			<input type='text' class='form-control' name='empName' id='empName' placeholder='사원명'>			
		</div>
		<div class='col-4'>
			<input type='date' class='form-control' name='hireDate' id='hireDate' placeholder='입사일'>			
		</div>
		<div class='col'>
			<div id='alert' class='alert alert-dismissible fade show p-1 pl-4 mb-1'>				
				<p class='m-0' id='msg'></p>
				<button type='button' class='p-0 close' tabindex='-1' id='closeAlertBtn'>
					<span>&times;</span>
				</button>		
			</div>		
		</div>			
	</div>
	<div class='row'>
		<div class='col'>
			<table class='table'>
				<thead>
					<tr>
						<th></th>
						<th>사번</th>
						<th>이름</th>
						<th>입사일</th>
					</tr>
				</thead>
				<tbody id='empList'>
					<tr><td colspan='4' class='text-center'>사원이 없습니다.</td></tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id='delEmpModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>			
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body'>
				<p>사원을 삭제하시겠습니까?</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
				<button type='button' class='btn btn-primary' id='delEmpOkBtn'>예</button>
			</div>
		</div>
	</div>
</div>