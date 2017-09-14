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
		<jsp:include page="./include/header.jsp" />
		<!-- <div class="container"> -->
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">학생관리</a></li>
					<li class="active">학생현황</li>
				</ol>
			</div>
			<div class="row">
				<form role="form" action="/students/modify" method="post">
					<input type="hidden" name="scode" value="${svo.scode}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>학생번호</th>
								<th>학생이름</th>
								<th>소속학과</th>
								<th>학년</th>
								<th>생년월일</th>	
								<th>지도교수</th>		
							</tr>
						</thead>
						<tbody>
							<tr class="active">
								<td>${svo.scode}</td>
								<td>${svo.sname}</td>
								<td>${svo.dept}</td>
								<td>${svo.year} 학년</td>
								<td>${svo.birthday}</td>
								<td>${svo.advisor}: ${svo.pname}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-modify-student" class="btn btn-warning">
					<span class="glyphicon  glyphicon-pencil"> </span> &nbsp;학생수정
				</button>
				<button type="button" id="btn-delete-student" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove">  </span> &nbsp;학생삭제
				</button>
				<button type="button" id="btn-enroll-student" class="btn btn-info" data-toggle="collapse" data-target="#div-enroll">
					<span class="glyphicon glyphicon-font">  </span> &nbsp;수강신청
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
									<label for="input-course" class="col-xs-2 col-lg-2 control-label">수강신청</label>
									<div class="col-xs-6 col-lg-6">
										<input id="input-enroll" type="text" class="form-control" placeholder="강좌선택은 여기를 클릭하세요..">
									</div>
									<div class="col-xs-2 col-lg-2">
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
							<div id="div-lectureList">
		      							
		      				</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="modal-clist" tabindex="-1" role="dialog" aria-labelledby="cListModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header modal-header-info">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
								<span class="sr-only">Close</span>
							</button>
							<h2><i class="glyphicon glyphicon-book"></i> 강좌 목록</h2>
						</div>
						<div class="modal-body">
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>강좌번호</th>
											<th>강좌명</th>
											<th>강의시간 수</th>
											<th>강의실</th>
											<th>담당교수</th>	
											<th>최대수강 인원 수</th>	
											<th>수강신청 인원 수</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="courses" items="${clist}">
											<tr class="tr-coursesModal" data-lcode="${courses.lcode}" data-lname="${courses.lname}">
												<td>${courses.lcode}</td>
												<td>${courses.lname}</td>
												<td>${courses.hours} 시간</td>
												<td>${courses.room} 호</td>
												<td>${courses.pname}</td>
												<td>${courses.capacity}</td>
												<td>${courses.persons}</td>																				
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="./include/footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</body>
<script id="template-clist" type="text/x-handlebars-template">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>강좌번호</th>
				<th>강좌명</th>
				<th>강의시간 수</th>
				<th>강의실</th>
				<th>담당교수</th>
			</tr>
		</thead>
		<tbody>
		{{#each .}}
			<tr>
				<td>{{lcode}}</td>
				<td>{{lname}}</td>
				<td>{{hours}} 시간</td>
				<td>{{room}} 호</td>
				<td>{{pname}}</td>
			</tr>
		{{/each}}
		</tbody>
	</table>
</script>
<script>
var scode = ${svo.scode};

var printList = function(list, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$("#div-lectureList").html(html);
}

$(document).ready(function() {
	var formObj = $("form[role='form']");
	
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
		formObj.attr("action", "/students/remove");
		formObj.submit();
	});
	
	$("#btn-enroll-student").on("click", getCoursesList());
	
	$("#input-enroll").on("click", function(event) {
		$("#modal-clist").modal();
	});
	
	$(".tr-coursesModal").on("click", function(event) {
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
					alert("수강 신청 되었습니다.");
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

</script>

</html>