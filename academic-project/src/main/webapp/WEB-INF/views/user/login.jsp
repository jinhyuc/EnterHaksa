<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Enter 학사관리 로그인</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=171012" rel="stylesheet">
<link href="/resources/stylesheets/user.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<div class="container">
			<div class="loginbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
				<div class="logo">
					<img src="/resources/imgs/enterthese.png" class="img-responsive center-block" alt="EnterThese">
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">
							로그인
						</div>
					</div>
					<div class="panel-body" >
						<div id="login-alert" class="alert alert-danger alert-dismissable" style="display:none">
							<button type="button" class="close" aria-hidden="true">×</button>
							<p>로그인 정보가 잘못되었습니다!</p>
						</div>
						<form id="form-login" action="/user/loginPOST" method="post" role="form" style="display: block;">
							<div class="login-id input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input type="text" name="uid" id="login-uid" class="form-control" placeholder="ID">
							</div>
							<div class="login-passwd input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
								<input type="password" name="upw" id="login-upw" class="form-control" placeholder="Password">
							</div>
							<div class="input-group">
								<div class="checkbox">
									<label>
										<input id="login-remember" type="checkbox" name="useCookie"> 로그인 상태 유지
									</label>
								</div>
							</div>
							<div class="login-btn form-group">
								<button id="btn-login" type="submit" class="btn btn-success">
									<span class="glyphicon glyphicon-ok"> </span> &nbsp;로그인
								</button>
							</div>
							<div class="form-group">
								<div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
									사용자 계정이 없으면, 
									<a href="/user/register"> &nbsp;여기</a>
									를 눌러 계정을 등록하세요.
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	<div class="layer alert-layer">
		<div class="layer-bg">
		</div>
		<div id="alert-pop" class="pop-layer">
			<div class="pop-container">
				<div class="pop-contents">
					<div class="row div-popmsg">
						<h4 class="col-md-1">
							<span class="glyphicon glyphicon-info-sign"> </span>
						</h4>
						<h4 class="col-md-11 message">
						
						</h4>
					</div>
					
					<div class="div-popbtn">
						<button type="button" class="btn btn-default ok">
							<span class="glyphicon glyphicon-ok"> </span> &nbsp;확인
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="/resources/js/layerpopup.js"></script>

</body>
<script>
var formObj = $("#form-login");

$(document).ready(function(event) {
	$("#btn-login").on("click", function(event) {
		var id = $("#login-uid").val();
		var passwd = $("#login-upw").val();
		
		event.preventDefault();
		
		$.ajax({
			type: "post",
			url: "/user/logincheck/",
			dataType: "text",
			data: { 'id' : id, 'passwd' : passwd },
			success: function(result) {
				console.log("result: " + result);
				
				if(result == "SUCCESS") {
					formObj.submit();			
				} else if(result == "FAIL") {
					$("#login-alert").show();
				}
			}
		});
	});
	
	$("button.close").on("click", function(event) {
		$("#login-alert").hide();
	})
});

var result="${result}";
var $el_alert = $("#alert-pop");

console.log("result : " + result);

if(result == "CREATE-SUCCESS") {
	layer_popup.alert($el_alert, "사용자 등록 되었습니다.");
}
</script>
</html>