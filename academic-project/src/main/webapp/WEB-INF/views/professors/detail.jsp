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
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
		<!-- <div class="container"> -->
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">교수관리</a></li>
					<li class="active">교수현황</li>
				</ol>
			</div>
			<div class="row">
				<form role="form" action="/professors/modify" method="post">
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
							<div class="col-md-3 col-lg-3" align="center">
								<img id="prof-picture" alt="Professor picture" class="img-responsive">
							</div>
							<div class="col-md-9 col-lg-9">
								<table class="table table-professor-information">
									<tbody>
										<tr>
											<td class="col-md-2"><strong>교수번호:</strong></td>
											<td>${pvo.pcode}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>교수이름:</strong></td>
											<td>${pvo.pname}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>소속학과:</strong></td>
											<td>${pvo.dept}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>임용일자:</strong></td>
											<td>${pvo.hireDate}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>직급:</strong></td>
											<td>${pvo.title}</td>
										</tr>
										<tr>
											<td class="col-md-2"><strong>급여:</strong></td>
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
				<button type="button" id="btn-enroll-prof" class="btn btn-primary" data-toggle="collapse" data-target="#div-enroll">
					<span class="glyphicon glyphicon-chevron-down">  </span> &nbsp;담당강좌
				</button>
				<button type="button" id="btn-profList" class="btn btn-primary pull-right">
					<span class="glyphicon glyphicon-list">  </span> &nbsp;목록으로
				</button>
			</div>
			<div class="row">
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">담당강좌 목록</h3>
					</div>
					<div class="box-body">
						<div class="panel-group" id="accordion">
	      					<c:forEach items="${clistByProf}" var="cvo" varStatus="status">
	      						<div class="panel panel-default">
	      							<div class="panel-heading">
	      								<h4 class="panel-title">
	      									<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#${cvo.lcode}" onclick="getStudentsList('${cvo.lcode}')">
	      										[${cvo.lcode}] ${cvo.lname}
	      									</a>
	      								</h4>
	      							</div>
	      							<div id="${cvo.lcode}" class="panel-collapse collapse">
	      							
	      							</div>
	      						</div>
	      					</c:forEach>
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js"></script>
	<script src="/resources/js/layerpopup.js"></script>
</body>
<script id="template-stlist" type="text/x-handlebars-template">
	<div class="panel-body studentsDiv">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>학생번호</th>
					<th>학생이름</th>
					<th>소속학과</th>
					<th>학년</th>
					<th>지도교수</th>
					<th>성적입력</th>
				</tr>
			</thead>
			<tbody>
			{{#each .}}
				<tr>
					<td>{{scode}}</td>
					<td>{{sname}}</td>
					<td>{{dept}}</td>
					<td>{{year}}</td>
					<td>{{pname}}</td>
					<td>
						<button type="button" class="btn btn-danger">
							<span class="glyphicon glyphicon-pencil"> </span>
						</button>
					</td>
				</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</script>
<script>
var pcode = "${pvo.pcode}";

var printList = function(list, target, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$(".studentsDiv").remove();
	target.after(html);
}

$(document).ready(function() {
	var formObj = $("form[role='form']");
	
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
		
		layer_popup.confirm($el_confirm, "교수 정보를 삭제하시겠습니까?", function() {
			deletePicture();
			formObj.attr("action", "/professors/remove");
			formObj.submit();
		})
	});
});
	
function getStudentsList(lcode) {
	console.log(lcode);
	var target = "#" + lcode;
	
	$.getJSON("/students/listByCourse/" + lcode, function(data) {
		console.log(data.list.length);
		console.log(data.list);
		printList(data.list, $(target), $('#template-stlist'));
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