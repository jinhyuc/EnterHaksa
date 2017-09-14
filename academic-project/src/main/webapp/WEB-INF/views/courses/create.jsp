<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>강좌등록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/courses.css?ver=170829" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">강좌관리 </a></li>
					<li class="active">강좌등록</li>
				</ol>
			</div>
			<form id="form-create-course" role="form" method="post">
				<div class="form-group">
					<label for="input-lecturecode">강좌번호</label>
					<input id="input-lecturecode" type="text" name="lcode" class="form-control" placeholder="강좌번호를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-lecturename">강좌이름</label>
					<input id="input-lecturename" type="text" name="lname" class="form-control" placeholder="강좌명을 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-hours">강의 시간 수</label>
					<input id="input-hours" type="text" name="hours" class="form-control" placeholder="강의시간 수를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-room">강의실</label>
					<input id="input-room" type="text" name="room" class="form-control" placeholder="강의실을 입력하세요">
				</div>
				<div class="form-group">
					<label for="select-instructor">담당교수</label>
					<select id="select-instructor" name="instructor" class="form-control">
						<c:forEach var="pvo" items="${plist}">
							<option value="${pvo.pcode}">${pvo.pcode}: ${pvo.pname}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label for="input-capacity">최대 수강인원 수</label>
					<input id="input-capacity" type="text" name="capacity" class="form-control" placeholder="최대 수강인원 수를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-persons">수강신청 인원 수</label>
					<input id="input-persons" type="text" name="persons" class="form-control" placeholder="수강신청 인원 수를 입력하세요">
				</div>
				<button type="submit" class="btn btn-success">
					<span class="glyphicon glyphicon-ok"> </span> &nbsp;저장
				</button>
				<button type="reset" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove"> </span> &nbsp;취소
				</button>
			</form>
		</div>

	</div>
	<jsp:include page="../include/footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>