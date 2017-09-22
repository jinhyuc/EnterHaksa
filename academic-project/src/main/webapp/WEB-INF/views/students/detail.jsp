<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>학생현황</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/students.css?ver=170831" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
		<!-- <div class="container"> -->
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">학생관리</a></li>
					<li class="active">학생현황</li>
				</ol>
			</div>
			<div class="row">
				<form id="modifyfrm" role="form" action="/students/modify" method="post">
					<input type="hidden" name="scode" value="${svo.scode}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h2 class="panel-title">학생 정보</h2>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3 col-lg-3">
								<img id="st-picture" alt="Student picture" class="img-responsive">
							</div>
							<div class="col-md-9 col-lg-9">
								<table class="table table-student-information">
									<tbody>
										<tr>
											<td class="col-md-2"><strong>학생번호:</strong></td>
											<td>${svo.scode}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>학생이름:</strong></td>
											<td>${svo.sname}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>소속학과:</strong></td>
											<td>${svo.dept}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>학년:</strong></td>
											<td>${svo.year} 학년</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>생년월일:</strong></td>
											<td>${svo.birthday}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>지도교수:</strong></td>
											<td>${svo.pname}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<button type="button" id="btn-modify-student" class="btn btn-warning">
							<i class="glyphicon  glyphicon-edit"> </i> &nbsp;수정
						</button>
						<button type="button" id="btn-delete-student" class="btn btn-danger">
							<i class="glyphicon glyphicon-remove"> </i> &nbsp;삭제
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-enroll-student" class="btn btn-primary" data-toggle="collapse" data-target="#div-enroll">
					<span class="glyphicon glyphicon-chevron-down">  </span> &nbsp;수강신청
				</button>
				<button type="button" id="btn-studentsList" class="btn btn-primary pull-right">
					<span class="glyphicon glyphicon-list">  </span> &nbsp;목록으로
				</button>
			</div>
			<div class="row">
				<div id="div-enroll" class="collapse">
					<div class="panel panel-default">
						<div class="panel-body">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label for="input-course" class="col-md-2 col-lg-2 control-label">수강신청</label>
									<div class="col-md-6 col-lg-6">
										<input id="input-enroll" type="text" class="form-control" placeholder="강좌선택은 여기를 클릭하세요..">
									</div>
									<div class="col-md-2 col-lg-2">
										<button id="btn-submit-enroll" type="button" class="btn btn-success">
											<span class="glyphicon glyphicon-ok"> </span> &nbsp;신청
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div id="box-enrollList" class="box box-warning">
						<div class="box-header">
							<h3 class="box-title">수강신청 목록</h3>
						</div>
						<div class="box-body">
							<div id="div-enrollList">
		      							
		      				</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="modal-clist" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header modal-header-info">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
								<span class="sr-only">Close</span>
							</button>
							<h2><i class="glyphicon glyphicon-book"></i> 강좌 목록</h2>
						</div>
						<div id="div-coursesList" class="modal-body">
							
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								<span class="glyphicon glyphicon-remove"> </span> &nbsp;닫기
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
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
	<div class="layer alert-layer">
		<div class="layer-bg">
		</div>
		<div id="alert-pop" class="pop-layer">
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
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js"></script>
	<script src="/resources/js/layerpopup.js"></script>
</body>
<script id="template-clist" type="text/x-handlebars-template">
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">강좌번호</th>
				<th class="text-center">강좌명</th>
				<th class="text-center">강의시간 수</th>
				<th class="text-center">강의실</th>
				<th class="text-center">담당교수</th>
				<th class="text-center">최대수강 인원 수</th>
				<th class="text-center">수강신청 인원 수</th>
			</tr>
		</thead>
		<tbody>
		{{#each .}}
			<tr class="tr-coursesModal" data-lcode="{{lcode}}" data-lname="{{lname}}">
				<td class="text-center">{{lcode}}</td>
				<td class="text-center">{{lname}}</td>
				<td class="text-center">{{hours}} 시간</td>
				<td class="text-center">{{room}} 호</td>
				<td class="text-center">{{pname}}</td>
				<td class="text-center">{{capacity}} 명</td>
				<td class="text-center">{{persons}} 명</td>
			</tr>
		{{/each}}
		</tbody>
	</table>
</script>
<script>
var scode = "${svo.scode}";
var $el_confirm = $("#confirm-pop");
var $el_alert = $("#alert-pop");

var printList = function(list, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$("#div-enrollList").html(html);
}

var printModalList = function(list, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$("#div-coursesList").html(html);
}

$(document).ready(function() {
	var formObj = $("#modifyfrm");
	
	initPicture();
	
	$("#btn-studentsList").on("click", function(event) {
		formObj.attr("action", "/students/list");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#btn-modify-student").on("click", function(event) {
		formObj.attr("action", "/students/modify");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#btn-delete-student").on("click", function(event) {		
		$.getJSON("/enrollments/countByStudent/" + scode, function(data) {
			console.log(data.count);
			
			if(data.count > 0) {
				layer_popup.alert($el_alert, "수강신청을 한 학생은 삭제할 수 없습니다.");
			} else {
				layer_popup.confirm($el_confirm, "학생 정보를 삭제하시겠습니까?", function() {
					deletePicture();
					formObj.attr("action", "/students/remove");
					formObj.submit();
				});
			}
		});		
	});
	
	$("#btn-enroll-student").on("click", getCoursesList());
	
	$("#input-enroll").on("click", function(event) {
		$.getJSON("/courses/listAll", function(data) {
			console.log(data.list.length);
			console.log(data.list);
			printModalList(data.list, $('#template-clist'));
		});
		$("#modal-clist").modal();
	});
	
	$("#div-coursesList").on("click", ".tr-coursesModal", function(event) {
		var lcode = $(this).data("lcode");
		var lname = $(this).data("lname");
		console.log(lcode);
		
		$("#input-enroll").val(lcode + ": " + lname);
		$("#input-enroll").data("lcode", lcode);
		
		$("#modal-clist").modal('hide');
	});
	
	$("#btn-submit-enroll").on("click", function() {
		var lcode = $("#input-enroll").data("lcode");
		
		$.ajax({
			type: "post",
			url: "/enrollments/register/",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST" },
			dataType: "text",
			data: JSON.stringify({
				lcode:lcode,
				scode:scode
			}),
			success: function(result) {
				console.log("enroll result: " + result);
				if(result == "SUCCESS") {
					layer_popup.alert($el_alert, "수강신청 되었습니다.");
					getCoursesList();
				}
			}
		});
	});
});

function getCoursesList() {
	console.log(scode);
	
	$.getJSON("/courses/listByStudent/" + scode, function(data) {
		console.log(data.list.length);
		console.log(data.list);
		printList(data.list, $('#template-clist'));
	});
}

function initPicture() {
	
	$.getJSON("/students/getPicture/" + scode, function(data) {
		console.log(data.picture);
		var getLink;
		
		if(data.picture == null) {
			getLink = "/resources/imgs/default_person.jpg";
		} else {
			var fullname = data.picture;
			var front = fullname.substr(0, 12);
			var end = fullname.substr(14);
			getLink = "/displayPicture?fileName=" + front + end;
		}
		
		$("#st-picture").attr("src", getLink);
		
	});
}

function deletePicture() {
	var picture = "${svo.picture}";
	
	if(picture) {
		$.ajax({
			url: "/deletePicture",
			type: "POST",
			data: {fileName: picture},
			dataType: "text"
		});
	}
}
</script>
</html>