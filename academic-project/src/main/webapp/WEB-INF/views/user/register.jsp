<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Enter 학사관리 사용자등록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=171012" rel="stylesheet">
<link href="/resources/stylesheets/user.css" rel="stylesheet">
<link href="/resources/bootstrap/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<div class="container">
			<div class="registerbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
				<div class="logo">
					<img src="/resources/imgs/enterthese.png" class="img-responsive center-block" alt="EnterThese">
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">
							사용자 등록
						</div>
					</div>
					<div class="panel-body" >
						<form id="register-form" class="form-horizontal" action="/user/register" method="post" role="form">
							<input type="hidden" id="isChecked" value="N">
							<div id="reg-alert" style="display:none" class="alert alert-danger">
								
							</div>
							<div class="form-group">
								<label for="reg-uid" class="col-md-2 control-label">아이디</label>
								<div class="col-md-8 id-input icon-addon">
									<input id="reg-uid" type="text" class="form-control" name="uid">
									<label for="reg-uid" class="fa fa-user"></label>
									<small class="help-block" style="display: none;"> </small>
									<i class="form-control-feedback glyphicon" style="display: none;"></i>
								</div>
								<div class="col-md-2 dup-check">
									<button id="btn-check" type="button" class="btn btn-warning">
										중복확인
									</button>
								</div>
							</div>
							<div class="form-group">
								<label for="reg-upw" class="col-md-2 control-label">패스워드</label>
								<div class="col-md-10 icon-addon">
									<input type="password" id="reg-upw" name="upw" class="form-control">
									<label for="reg-upw" class="fa fa-lock"></label>
								</div>
							</div>
							<div class="form-group">
								<label for="reg-uname" class="col-md-2 control-label">이름</label>
								<div class="col-md-10 icon-addon">
									<input type="text" id="reg-uname" name="uname" class="form-control">
									<label for="reg-uid" class="fa fa-pencil"></label>
								</div>
							</div>
							<div class="form-group">
								<label for="reg-email" class="col-md-2 control-label">E-Mail</label>
								<div class="col-md-10 icon-addon">
									<input type="text" id="reg-email" name="email" class="form-control">
									<label for="reg-uid" class="fa fa-envelope"></label>
								</div>
							</div>
							<div class="form-group reg-btn">
								<div class="col-md-offset-2 col-md-10">
									<button type="submit" class="btn btn-success">
										<span class="glyphicon glyphicon-ok"> </span> &nbsp;등록
									</button>
								</div>
							</div>
							
						</form>
						<div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
									사용자 계정이 있다면, 
									<a href="/user/login"> &nbsp;여기</a>
									를 눌러 로그인 하세요.
								</div>
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
$(document).ready(function() {
	$("#btn-check").on("click", function(event) {
		var id = $("#reg-uid").val();
		console.log(id);
		
		$.ajax({
			type: "post",
			url: "/user/isValidId/",
			dataType: "text",
			data: {'id' : id},
			success: function(result) {
				console.log("result: " + result);
				if(result == "SUCCESS") {
					var target = $("#reg-uid");
					var message = "사용 가능한 아이디 입니다.";
					chk_success(target, message);					
				} else if(result == "EXIST") {
					var target = $("#reg-uid");
					var message = "동일한 아이디가 존재합니다.";
					chk_error(target, message);
				}
			}
		});
	});
	
	$("#reg-uid").on("change paste cut keyup", function(event) {
		var target = $("#reg-uid");
		chk_remove(target);
	});
	
	$("#register-form").submit(function(event) {
		var ischecked = $("#isChecked").val();
		
		if(ischecked == "N") {
			event.preventDefault();
			$("#reg-alert").html("<p>아이디 중복 확인을 해주세요!</p>");
			$("#reg-alert").show();
		}
	});
});

function chk_success(target, message) {
	chk_remove(target);
	$("#isChecked").val("Y");
	target.parent().addClass("has-success");
	target.siblings("i").addClass("glyphicon-ok").show();
	target.siblings("small").html(message).show();
	$("#reg-alert").hide();
}

function chk_error(target, message) {
	chk_remove(target);
	target.parent().addClass("has-error");
	target.siblings("i").addClass("glyphicon-remove").show();
	target.siblings("small").html(message).show();
}

function chk_remove(target) {
	$("#isChecked").val("N");
	target.parent().removeClass("has-success has-error");
	target.siblings("i").removeClass("glyphicon-ok glyphicon-remove").hide();
	target.siblings("small").empty();
	$("#reg-alert").hide();
}

</script>
</html>