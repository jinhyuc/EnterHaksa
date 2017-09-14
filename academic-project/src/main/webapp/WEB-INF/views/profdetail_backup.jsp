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
		<jsp:include page="./include/header.jsp" />
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
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>교수번호</th>
								<th>교수이름</th>
								<th>소속학과</th>
								<th>임용일자</th>
								<th>직급</th>	
								<th>급여</th>	
							</tr>
						</thead>
						<tbody>
							<tr class="active">
								<td>${pvo.pcode}</td>
								<td>${pvo.pname}</td>
								<td>${pvo.dept}</td>
								<td>${pvo.hireDate}</td>
								<td>${pvo.title}</td>
								<td><fmt:formatNumber value="${pvo.salary}" pattern="#,### 원"/></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<button type="button" id="btn-modify-prof" class="btn btn-warning">
					<span class="glyphicon  glyphicon-pencil"> </span> &nbsp;교수수정
				</button>
				<button type="button" id="btn-delete-prof" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove">  </span> &nbsp;교수삭제
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
						<ul id="ul-clistByProf" class="list-group">
	      					<c:forEach items="${clistByProf}" var="cvo" varStatus="status">
	      						<li class="list-group-item">
	      							<a class="collapse-toggle" data-toggle="collapse" data-parent="#ul-clistByProf" href="#${cvo.lcode}" onclick="getStudentsList('${cvo.lcode}')">[${cvo.lcode}] ${cvo.lname}</a>
	      						</li>
	      						<ul id="${cvo.lcode}">
	      							
                    			</ul>
	      					</c:forEach>
                		</ul>
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
<script id="template-stlist" type="text/x-handlebars-template">
	{{#each .}}
	<li class="list-group-item studentsLi" data-scode={{scode}}>
		<div>
			{{sname}}
		</div>
	</li>
	{{/each}}
</script>
<script>
var printList = function(list, target, templateObj) {
	var template = Handlebars.compile(templateObj.html());
	var html = template(list);
	
	$(".studentsLi").remove();
	target.append(html);
}

$(document).ready(function() {
	var formObj = $("form[role='form']");
		
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
		formObj.attr("action", "/professors/remove");
		formObj.submit();
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
</script>

</html>