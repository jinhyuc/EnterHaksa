<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>강좌현황</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=171012" rel="stylesheet">
<link href="/resources/stylesheets/courses.css?ver=171012" rel="stylesheet">
<link href="/resources/bootstrap/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">강좌관리</a></li>
					<li class="active">강좌현황</li>
				</ol>
			</div>
			<div class="row">
				<form role="form" action="/courses/modify" method="post">
					<input type="hidden" name="lcode" value="${cvo.lcode}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h2 class="panel-title">강좌 정보</h2>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3 col-lg-3">
								<img id="course-picture" src="/resources/imgs/book.png" alt="Course picture" class="img-responsive">
							</div>
							<div class="col-md-9 col-lg-9">
								<table class="table table-course-information">
									<tbody>
										<tr>
											<td class="col-md-2"><strong>강좌번호 :</strong></td>
											<td>${cvo.lcode}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>강좌명 :</strong></td>
											<td>${cvo.lname}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>강의시간 수 :</strong></td>
											<td>${cvo.hours} 시간</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>강의실 :</strong></td>
											<td>${cvo.room} 호</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>담당교수 :</strong></td>
											<td>${cvo.pname} [${cvo.instructor}]</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>최대수강 인원 수 :</strong></td>
											<td>${cvo.capacity} 명</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>수강신청 인원 수 :</strong></td>
											<td>${cvo.persons} 명</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<button type="button" id="btn-modify-course" class="btn btn-warning">
							<i class="glyphicon  glyphicon-edit"> </i> &nbsp;수정
						</button>
						<button type="button" id="btn-delete-course" class="btn btn-danger">
							<i class="glyphicon glyphicon-remove"> </i> &nbsp;삭제
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-studentList" class="btn btn-primary" data-toggle="collapse" data-target="#div-student">
					<span class="glyphicon glyphicon-chevron-down">  </span> &nbsp;수강학생 목록
				</button>
				<button type="button" id="btn-courseList" class="btn btn-primary pull-right">
					<span class="glyphicon glyphicon-list">  </span> &nbsp;목록으로
				</button>
			</div>
			<div class="row">
				<div id="div-student" class="collapse">
					<div id="box-studentList" class="box box-warning">
						<div class="box-header">
							<h3 class="box-title">수강학생 목록</h3>
						</div>
						<div class="box-body">
							<div id="div-studentlList">
		      							
		      				</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
	
	<!-- Layer popup -->
	<div class="layer confirm-layer">
		<div class="layer-bg">
		</div>
		<div id="confirm-pop" class="pop-layer">
			<div class="pop-container">
				<div class="pop-contents">
					<div class="row div-popmsg">
						<h4 class="col-md-1">
							<span class="glyphicon glyphicon-warning-sign red"> </span>
						</h4>
						<h4 class="col-md-11 message">
						
						</h4>
					</div>
					
					<div class="div-popbtn">
							<button type="button" class="btn btn-default ok">
								<span class="glyphicon glyphicon-ok"> </span> &nbsp;확인
							</button>
							<button type="button" class="btn btn-default cancel">
								<span class="glyphicon glyphicon-remove"> </span> &nbsp;취소
							</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</body>
<script id="template-stlist" type="text/x-handlebars-template">
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">학생번호</th>
				<th class="text-center">학생이름</th>
				<th class="text-center">소속학과</th>
				<th class="text-center">학년</th>
				<th class="text-center">지도교수</th>
				<th class="text-center">성적</th>
			</tr>
		</thead>
		<tbody>
		{{#each .}}
			<tr>
				<td class="text-center">{{scode}}</td>
				<td class="text-center">{{sname}}</td>
				<td class="text-center">{{dept}}</td>
				<td class="text-center">{{year}} 학년</td>
				<td class="text-center">{{pname}}</td>
				<td class="text-center">{{grade}}</td>
			</tr>
		{{/each}}
		</tbody>
	</table>
</script>
<script>
var lcode = "${cvo.lcode}";
var login_id = "${login.uid}";

var printList = function(list, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$("#div-studentlList").html(html);
}

$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$("#btn-courseList").on("click", function(event) {
		formObj.attr("action", "/courses/list");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#btn-modify-course").on("click", function(event) {
		formObj.attr("action", "/courses/modify");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#btn-grade-course").on("click", function(event) {
		formObj.attr("action", "/courses/grade");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#btn-delete-course").on("click", function(event) {
		var $el_confirm = $("#confirm-pop");
		
		$.getJSON("/enrollments/countByCourse/" + lcode, function(data) {
			console.log(data.count);
			
			if(data.count > 0) {
				layer_popup.alert($el_alert, "수강신청에 등록된 강좌는 삭제할 수 없습니다.");
			} else if(!login_id) {
				layer_popup.alert($el_alert, "로그인이 필요한 서비스 입니다.");
			} else {
				layer_popup.confirm($el_confirm, "강좌 정보를 삭제하시겠습니까?", function() {
					formObj.attr("action", "/courses/remove");
					formObj.submit();
				});
			}
		});
	});
	
	$("#btn-studentList").on("click", function(event) {
		getStudentsList(lcode);
	});
});

function getStudentsList(lcode) {
	console.log(lcode);
	
	$.getJSON("/students/listByCourse/" + lcode, function(data) {
		console.log(data.list.length);
		console.log(data.list);
		
		printList(data.list, $('#template-stlist'));
	});
}
</script>
</html>