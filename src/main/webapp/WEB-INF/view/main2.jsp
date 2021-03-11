<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>
<script src='http://code.jquery.com/jquery-3.5.1.min.js'></script>
<script>

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
				<button type='button' class='btn btn-primary w-24'>
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