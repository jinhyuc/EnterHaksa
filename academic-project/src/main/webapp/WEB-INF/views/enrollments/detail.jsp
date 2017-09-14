<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수강신청 현황</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/enrollments.css?ver=170901" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
		<!-- <div class="container"> -->
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">수강신청관리</a></li>
					<li class="active">수강신청현황</li>
				</ol>
			</div>
			<div class="row">
				<form role="form" action="/enrollments/modify" method="post">
					<input type="hidden" name="lcode" value="${evo.lcode}">
					<input type="hidden" name="scode" value="${evo.scode}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>강좌정보</th>
								<th>학생정보</th>
								<th>수강신청일</th>
								<th>성적</th>
							</tr>
						</thead>
						<tbody>
							<tr class="active">
								<td>[${evo.lcode}] ${evo.lname}</td>
								<td>[${evo.scode}] ${evo.sname}</td>
								<td>${evo.eDate}</td>
								<td>${evo.grade} 점</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-modify-enroll" class="btn btn-warning">
					<span class="glyphicon  glyphicon-pencil"> </span> &nbsp;수강신청 수정
				</button>
				<button type="button" id="btn-delete-enroll" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove">  </span> &nbsp;수강신청 삭제
				</button>
				<button type="button" id="btn-enrollmentsList" class="btn btn-primary pull-right">
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
		
		$("#btn-enrollmentsList").on("click", function(event) {
			formObj.attr("action", "/enrollments/list");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		$("#btn-modify-enroll").on("click", function(event) {
			formObj.attr("action", "/enrollments/modify");
			formObj.attr("method", "get");
			formObj.submit();
		});
			
		$("#btn-delete-enroll").on("click", function(event) {
			formObj.attr("action", "/enrollments/remove");
			formObj.submit();
		});
	});

</script>

</html>