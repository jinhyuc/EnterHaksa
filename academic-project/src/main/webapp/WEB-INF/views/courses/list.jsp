<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>강좌목록</title>
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
					<li><a href="#">강좌관리 </a></li>
					<li class="active">강좌목록</li>
				</ol>
			</div>
			<div class="row">
				<div id="div-searchform" class="col-md-8">
					<form class="form-inline">
						<div class="form-group">
							<select name="searchType" class="form-control">
								<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>강좌번호</option>
								<option value="n" <c:out value="${cri.searchType eq 'n'?'selected':''}"/>>강좌명</option>
								<option value="i" <c:out value="${cri.searchType eq 'i'?'selected':''}"/>>담당교수</option>
							</select>
							<input type="text" class="form-control" name="keyword" id="keywordInput" value="${cri.keyword}">
						</div>
						<button type="submit" id="btn-search-course" class="btn btn-info">
							<span class="glyphicon glyphicon-search"> </span> 검색
						</button>
					</form>
				</div>
				<div id="div-reg-course" class="col-md-4">
					<button type="button" id="btn-reg-course" class="btn btn-info pull-right">
						<span class="glyphicon glyphicon-plus"> </span> &nbsp;강좌등록
					</button>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="table-responsive">
					<table class="table table-hover list-table">
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
						<c:forEach var="course" items="${list}">
							<tr class="tr-courses">
								<td id="td-lcode">${course.lcode}</td>
								<td>${course.lname}</td>
								<td>${course.hours} 시간</td>
								<td>${course.room} 호</td>
								<td>${course.pname}</td>
								<td>${course.capacity} 명</td>
								<td>${course.persons} 명</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="div-pagination text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li><a href="list${pageMaker.makeQuery(pageMaker.startPage-1)}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<c:if test="${pageMaker.cri.page == idx}">
							<li class="active"><a href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
						</c:if>
						<c:if test="${pageMaker.cri.page != idx}">
							<li><a href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><a href="list${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
					</c:if>	
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="/resources/js/layerpopup.js"></script>
</body>
<script>
	$(document).ready(function() {
		$("#btn-search-course").on("click", function(event) {
			self.location = "/courses/list" + "${pageMaker.makeQuery(1)}" + "&searchType=" + $("select option:selected").val() + "&keyword=" + $("keywordInput").val();
		});
		
		$("#btn-reg-course").on("click", function(event) {
			self.location = "/courses/create";
		});
		
		$(".tr-courses").on("click", function(){
			var lcode = $(this).find("#td-lcode").html();
			
			self.location="/courses/detail" + "${pageMaker.makeSearch(pageMaker.cri.page)}" + "&lcode=" + lcode;
		});
	});
	
	var result="${result}";
	var $el_alert = $("#alert-pop");
	
	if(result == "CREATE-SUCCESS") {
		layer_popup.alert($el_alert, "강좌 등록이 완료 되었습니다.");
	} else if(result == "CREATE-FAIL") {
		layer_popup.alert($el_alert, "강좌 등록이 실패 하였습니다.");
	} else if(result == "MODIFY-SUCCESS") {
		layer_popup.alert($el_alert, "강좌 정보가 수정 되었습니다.");
	} else if(result == "REMOVE-SUCCESS") {
		layer_popup.alert($el_alert, "강좌 정보가 삭제 되었습니다.");
	}
</script>
</html>