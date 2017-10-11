<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>교수현황</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/professors.css?ver=170828_1" rel="stylesheet">
<link href="/resources/bootstrap/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">교수관리</a></li>
					<li class="active">교수현황</li>
				</ol>
			</div>
			<div class="row">
				<form id="modifyfrm" role="form" action="/professors/modify" method="post">
					<input type="hidden" name="pcode" value="${pvo.pcode}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h2 class="panel-title">교수 정보</h2>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3 col-lg-3">
								<img id="prof-picture" alt="Professor picture" class="img-responsive">
							</div>
							<div class="col-md-9 col-lg-9">
								<table class="table table-professor-information">
									<tbody>
										<tr>
											<td class="col-md-2"><strong>교수번호 :</strong></td>
											<td>${pvo.pcode}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>교수이름 :</strong></td>
											<td>${pvo.pname}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>소속학과 :</strong></td>
											<td>${pvo.dept}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>임용일자 :</strong></td>
											<td>${pvo.hireDate}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>직급 :</strong></td>
											<td>${pvo.title}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>E-Mail :</strong></td>
											<td>${pvo.email}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>휴대전화 :</strong></td>
											<td>${pvo.mobile}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>급여 :</strong></td>
											<td><fmt:formatNumber value="${pvo.salary}" pattern="#,### 원"/></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<button type="button" id="btn-modify-prof" class="btn btn-warning">
							<i class="glyphicon  glyphicon-edit"> </i> &nbsp;수정
						</button>
						<button type="button" id="btn-delete-prof" class="btn btn-danger">
							<i class="glyphicon glyphicon-remove"> </i> &nbsp;삭제
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-enroll-prof" class="btn btn-primary" data-toggle="collapse" data-target="#div-lecture">
					<span class="glyphicon glyphicon-chevron-down">  </span> &nbsp;성적입력
				</button>
				<button type="button" id="btn-profList" class="btn btn-primary pull-right">
					<span class="glyphicon glyphicon-list">  </span> &nbsp;목록으로
				</button>
			</div>
			<div class="row">
				<div id="div-lecture" class="collapse">
					<div class="panel panel-default">
						<div class="panel-body">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label class="col-md-2 col-lg-2 control-label">담당강좌</label>
									<div class="col-md-6 col-lg-6">
										<select id="select-lectureList" class="form-control">
												<option selected="" disabled="" hidden="" value="">담당강좌를 선택해주세요.</option>
												<c:forEach items="${clistByProf}" var="cvo" varStatus="status">
													<option value="${cvo.lcode}"> ${cvo.lcode} : ${cvo.lname}</option>
												</c:forEach>
										</select>
									</div>
									<div class="col-md-2 col-lg-2">
										<button id="btn-studentList" type="button" class="btn btn-success">
											<span class="glyphicon glyphicon-ok"> </span> &nbsp;학생목록
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
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
	<!-- Modal -->
	<div class="modal fade" id="modal-grade" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-success">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<h2><i class="glyphicon glyphicon-info-sign"></i> 성적입력</h2>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label id="label-grade" for="input-grade"></label>
						<input type="text" class="form-control" id="input-grade" placeholder="성적을 입력하세요">
					</div>
				</div>
				<div class="modal-footer">
					<button id="btn-grade-ok" type="button" class="btn btn-default">
						<span class="glyphicon glyphicon-ok"> </span> &nbsp;확인
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"> </span> &nbsp;취소
					</button>
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
<script id="template-stlist" type="text/x-handlebars-template">
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">학생번호</th>
				<th class="text-center">학생이름</th>
				<th class="text-center">소속학과</th>
				<th class="text-center">학년</th>
				<th class="text-center">지도교수</th>
				<th class="text-center">성적입력</th>
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
				<td class="col-md-1">
					<input type="text" data-scode="{{scode}}" data-sname="{{sname}}" class="student-grade form-control" value="{{grade}}" readonly>
				</td>
			</tr>
		{{/each}}
		</tbody>
	</table>
</script>
<script>
var pcode = "${pvo.pcode}";
var $lcode;

var printList = function(list, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$("#div-studentlList").html(html);
}

$(document).ready(function() {
	var formObj = $("#modifyfrm");
	
	initPicture();
		
	$("#btn-profList").on("click", function(event) {
		formObj.attr("action", "/professors/list");
		formObj.attr("method", "get");
		formObj.submit();
	});
		
	$("#btn-modify-prof").on("click", function(event) {
		formObj.attr("action", "/professors/modify");
		formObj.attr("method", "get");
		formObj.submit();
	});
		
	$("#btn-delete-prof").on("click", function(event) {
		var $el_confirm = $("#confirm-pop");
		var $el_alert = $("#alert-pop");
		
		$.getJSON("/courses/countByProf/" + pcode, function(data) {
			console.log(data.count);
			
			if(data.count > 0) {
				layer_popup.alert($el_alert, "강좌 담당교수로 등록되어 있는 교수는 삭제할 수 없습니다.");
			} else {
				$.getJSON("/students/countByProf/" + pcode, function(data) {
					console.log(data.count);
					
					if(data.count > 0) {
						layer_popup.alert($el_alert, "지도교수로 등록되어 있는 교수는 삭제할 수 없습니다.");
					} else {
						layer_popup.confirm($el_confirm, "교수 정보를 삭제하시겠습니까?", function() {
							deletePicture();
							formObj.attr("action", "/professors/remove");
							formObj.submit();
						});
					}
				});
			}
		});
	});
	
	$("#btn-studentList").on("click", function(event) {
		$lcode = $("#select-lectureList option:selected").val();
		console.log($lcode);
		
		if($lcode) {
			getStudentsList($lcode);
		}
	});
	
	$("#div-studentlList").on("click", ".student-grade", function(event) {
		var label = $(this).data("scode") + " - " + $(this).data("sname");
		var grade = $(this).val();
		
		$("#label-grade").html(label);
		$("#input-grade").val(grade);
		$("#btn-grade-ok").data("scode", $(this).data("scode"));
		$("#btn-grade-ok").data("lcode", $lcode);
		
		$("#modal-grade").modal();
	});
	
	$("#btn-grade-ok").on("click", function(event) {
		var scode = $(this).data("scode");
		var lcode = $(this).data("lcode");
		var grade = $("#input-grade").val();
		
		$.ajax({
			type: "post",
			url: "/enrollments/grade/",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST" },
			dataType: "text",
			data: JSON.stringify({
				lcode:lcode,
				scode:scode,
				grade:grade
			}),
			success: function(result) {
				console.log("grade result: " + result);
				if(result == "SUCCESS") {
					getStudentsList(lcode);
					$("#modal-grade").modal('hide');
				}
			}
		});
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

function initPicture() {
	$.getJSON("/professors/getPicture/" + pcode, function(data) {
		var getLink;
		
		if(data.picture == null) {
			getLink = "/resources/imgs/default_person.jpg";
		} else {
			var fullname = data.picture;
			var front = fullname.substr(0, 12);
			var end = fullname.substr(14);
			getLink = "/displayPicture?fileName=" + front + end;
		}
		
		$("#prof-picture").attr("src", getLink);
		
	});
}

function deletePicture() {
	var picture = "${pvo.picture}";
	
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