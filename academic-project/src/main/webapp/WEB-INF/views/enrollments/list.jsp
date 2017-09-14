<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수강신청 목록</title>
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
					<li><a href="#">수강신청관리 </a></li>
					<li class="active">수강신청목록</li>
				</ol>
			</div>
			<div class="row">
				<div id="div-searchform" class="col-md-8">
					<form class="form-inline">
						<div class="form-group">
							<select name="searchType" class="form-control">
								<option value="lc" <c:out value="${cri.searchType eq 'lc'?'selected':''}"/>>강좌번호</option>
								<option value="sc" <c:out value="${cri.searchType eq 'sc'?'selected':''}"/>>학생번호</option>
								<option value="ln" <c:out value="${cri.searchType eq 'ln'?'selected':''}"/>>강좌명</option>
								<option value="sn" <c:out value="${cri.searchType eq 'sn'?'selected':''}"/>>학생이름</option>
							</select>
							<input type="text" class="form-control" name="keyword" id="keywordInput" value="${cri.keyword}">
						</div>
						<button type="submit" id="btn-search-enroll" class="btn btn-info">
							<span class="glyphicon glyphicon-search"> </span> 검색
						</button>
					</form>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="table-responsive">
					<table class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>강좌번호</th>
								<th>강좌명</th>
								<th>학생번호</th>
								<th>학생이름</th>
								<th>수강신청일</th>	
								<th>성적</th>	
							</tr>
						</thead>
						<c:forEach var="enroll" items="${list}">
							<tr class="tr-enrollments">
								<td id="td-lcode">${enroll.lcode}</td>
								<td>${enroll.lname}</td>
								<td id="td-scode">${enroll.scode}</td>
								<td>${enroll.sname}</td>
								<td>${enroll.eDate}</td>
								<td>${enroll.grade} 점</td>
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
<script>
	$(document).ready(function() {
		$("#btn-search-enroll").on("click", function(event) {
			self.location = "/enrollments/list" + "${pageMaker.makeQuery(1)}" + "&searchType=" + $("select option:selected").val() + "&keyword=" + $("keywordInput").val();
		});
		
		$("#btn-reg-enroll").on("click", function(event) {
			self.location = "/enrollments/create";
		});
		
		$(".tr-enrollments").on("click", function() {
			var lcode = $(this).find("#td-lcode").html();
			var scode = $(this).find("#td-scode").html();
			
			self.location="/enrollments/detail" + "${pageMaker.makeSearch(pageMaker.cri.page)}" + "&lcode=" + lcode + "&scode=" + scode;
		});
	});
	
	var result="${result}";

	if(result == "MODIFY-SUCCESS") {
		alert("수강신청 수정이 완료 되었습니다.");
	} else if(result == "REMOVE-SUCCESS") {
		alert("수강신청 삭제가 완료 되었습니다.");
	}
</script>
</html>