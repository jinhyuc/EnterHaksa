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
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/courses.css?ver=170829" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
		<!-- <div class="container"> -->
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
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>강좌번호</th>
								<th>강좌명</th>
								<th>강의시간 수</th>
								<th>강의실</th>
								<th>담당교수</th>	
								<th>최대 수강인원 수</th>	
								<th>수강신청 인원 수</th>	
							</tr>
						</thead>
						<tbody>
							<tr class="active">
								<td>${cvo.lcode}</td>
								<td>${cvo.lname}</td>
								<td>${cvo.hours} 시간</td>
								<td>${cvo.room} 호</td>
								<td>${cvo.instructor}: ${cvo.pname}</td>
								<td>${cvo.capacity} 명</td>
								<td>${cvo.persons} 명</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-modify-course" class="btn btn-warning">
					<span class="glyphicon  glyphicon-pencil"> </span> &nbsp;강좌수정
				</button>
				<button type="button" id="btn-delete-course" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove">  </span> &nbsp;강좌삭제
				</button>
				<button type="button" id="btn-grade-course" class="btn btn-info">
					<span class="glyphicon glyphicon-font">  </span> &nbsp;성적입력
				</button>
				<button type="button" id="btn-courseList" class="btn btn-primary pull-right">
					<span class="glyphicon glyphicon-list">  </span> &nbsp;목록으로
				</button>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
<script>
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
			formObj.attr("action", "/courses/remove");
			formObj.submit();
		});
	});

</script>

</html>