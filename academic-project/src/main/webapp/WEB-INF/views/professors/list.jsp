<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>교수목록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/professors.css?ver=170828_2" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
		<!-- <div class="container"> -->
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">교수관리 </a></li>
					<li class="active">교수목록</li>
				</ol>
			</div>
			<div class="row">
				<div id="div-searchform" class="col-md-8">
					<form class="form-inline">
						<div class="form-group">
							<select name="searchType" class="form-control">
								<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>교수번호</option>
								<option value="n" <c:out value="${cri.searchType eq 'n'?'selected':''}"/>>교수이름</option>
								<option value="d" <c:out value="${cri.searchType eq 'd'?'selected':''}"/>>소속학과</option>
							</select>
							<input type="text" class="form-control" name="keyword" id="keywordInput" value="${cri.keyword}">
						</div>
						<button type="submit" id="btn-search-prof" class="btn btn-info">
							<span class="glyphicon glyphicon-search"> </span> 검색
						</button>
					</form>
				</div>
				<div id="div-reg-professor" class="col-md-4">
					<button type="button" id="btn-reg-professor" class="btn btn-info pull-right">
						<span class="glyphicon glyphicon-plus"> </span> &nbsp;교수등록
					</button>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="table-responsive">
					<table class="table table-hover list-table">
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
						<c:forEach var="professor" items="${list}">
							<tr class="tr-professors">
								<td id="td-pcode">${professor.pcode}</td>
								<td>${professor.pname}</td>
								<td>${professor.dept}</td>
								<td>${professor.hireDate}</td>
								<td>${professor.title}</td>
								<td><fmt:formatNumber value="${professor.salary}" pattern="#,### 원"/></td>
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
		$("#btn-search-prof").on("click", function(event) {
			self.location = "/professors/list" + "${pageMaker.makeQuery(1)}" + "&searchType=" + $("select option:selected").val() + "&keyword=" + $("keywordInput").val();
		});
		
		$("#btn-reg-professor").on("click", function(event) {
			self.location = "/professors/create";
		});
		
		$(".tr-professors").on("click", function(){
			var pcode = $(this).find("#td-pcode").html();
			
			self.location="/professors/detail" + "${pageMaker.makeSearch(pageMaker.cri.page)}" + "&pcode=" + pcode;
		});
	});
	
	var result="${result}";
	var $el_alert = $("#alert-pop");
	
	if(result == "CREATE-SUCCESS") {
		layer_popup.alert($el_alert, "교수 등록이 완료 되었습니다.");
	} else if(result == "CREATE-DUPLICATE") {
		layer_popup.alert($el_alert, "동일한 교수번호가 존재합니다.");
	} else if(result == "MODIFY-SUCCESS") {
		layer_popup.alert($el_alert, "교수 정보가 수정 되었습니다.");
	} else if(result == "REMOVE-SUCCESS") {
		layer_popup.alert($el_alert, "교수 정보가 삭제 되었습니다.");
	}
</script>
</html>