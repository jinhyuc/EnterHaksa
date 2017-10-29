<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="/resources/js/layerpopup.js"></script>
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<nav class="navbar navbar-fixed-top navbar-default" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle colapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/professors/list">
					<img src="/resources/imgs/enterthese.png" class="img-responsive" alt="EnterThese">
				</a>
			</div>
				
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div id="navbar" class="navbar-collapse collapse">
				<ul id="navbar-menu" class="nav navbar-nav">
					<li><a href="/professors/list" >교수관리</a></li>
					<li><a href="/students/list" >학생관리</a></li>
					<li><a href="/courses/list" >강좌관리</a></li>
					<li><a href="/enrollments/list" >수강신청관리</a></li>
				</ul>
				<ul class="nav navbar-nav pull-right">
					<li class="dropdown">
						<c:choose>
							<c:when test="${!empty login.uid}">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<small><i class="fa fa-user-o"></i> &nbsp; ${login.uid} <span class="caret"></span></small>
								</a>
								<ul class="dropdown-menu">
									<li class="logout"><a>로그아웃</a></li>
								</ul>
							</c:when>
							<c:otherwise>
								<a href="/user/login" >
									<small>로그인 하세요.</small>
								</a>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</div>
		</div>
	</nav>
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
	<script>
		var $el_alert = $("#alert-pop");
		
		$(".logout").on("click", function(event) {
			$.ajax({
				type: "post",
				url: "/user/logout/",
				success: function(result) {
					console.log("enroll result: " + result);
					if(result == "LOGOUT") {
						layer_popup.alert($el_alert, "로그아웃 되었습니다.", function(event) {
							location.reload();
						});
					}
				}
			});
		});
	</script>