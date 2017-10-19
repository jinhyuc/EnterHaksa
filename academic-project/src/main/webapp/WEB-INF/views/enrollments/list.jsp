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
<link href="/resources/stylesheets/style.css?ver=171012" rel="stylesheet">
<link href="/resources/stylesheets/enrollments.css?ver=171012" rel="stylesheet">
<link href="/resources/bootstrap/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container-fluid">
		<div class="container">
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
					<table id="tbl-enroll" class="table list-table">
						<thead>
							<tr>
								<th><input type="checkbox" id="checkall"></th>
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
								<td><input type="checkbox" data-lcode="${enroll.lcode}" data-scode="${enroll.scode}"></td>
								<td>${enroll.lcode}</td>
								<td>${enroll.lname}</td>
								<td>${enroll.scode}</td>
								<td>${enroll.sname}</td>
								<td>${enroll.eDate}</td>
								<td>
									<c:if test="${enroll.grade != null}">
										${enroll.grade} 점
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div>
					<button type="button" id="btn-del-enroll" class="btn btn-danger">
						<span class="glyphicon glyphicon-trash"> </span> &nbsp;삭제
					</button>
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

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="/resources/js/layerpopup.js"></script>
</body>
<script>
var $el_alert = $("#alert-pop");
var $el_confirm = $("#confirm-pop");

$(document).ready(function() {
	$("#btn-search-enroll").on("click", function(event) {
		self.location = "/enrollments/list" + "${pageMaker.makeQuery(1)}" + "&searchType=" + $("select option:selected").val() + "&keyword=" + $("keywordInput").val();
	});
	
	$("#checkall").on("click", function(event) {
		if($("#checkall").is(":checked")) {
			$("#tbl-enroll input[type=checkbox]").each(function () {
                $(this).prop("checked", true);
            });
		} else {
			$("#tbl-enroll input[type=checkbox]").each(function () {
                $(this).prop("checked", false);
            });
		}
	});
	
	$("#btn-del-enroll").on("click", function(event) {
		var checked_count = 0;
		var enrollArray = new Array();
		var checkedEnrollJson = new Object();
		
		$("#tbl-enroll td>input[type=checkbox]").each(function() {
			var lcode = $(this).data("lcode");
			var scode = $(this).data("scode");
			
			if($(this).is(":checked")) {
				var enrollObj = new Object();
				
				enrollObj.lcode = lcode;
				enrollObj.scode = scode;
				
				enrollArray.push(enrollObj);
				
				console.log("lcode : " + lcode);
				console.log("scode : " + scode);
				
				checked_count++;
			}	
		});
		
		if(checked_count == 0) {
			layer_popup.alert($el_alert, "선택된 항목이 없습니다.");
		} else {
			layer_popup.confirm($el_confirm, "선택된 항목들을 삭제하시겠습니까?", function(event) {
				checkedEnrollJson = JSON.stringify(enrollArray);
				
				console.log("checked_count : " + checked_count);
				
				$.ajax({
					type: "delete",
					url: "/enrollments/delete",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "DELETE" },
					data: checkedEnrollJson,
					dataType: "text",
					success: function(result) {
						console.log("enroll delete result : " + result);
						if(result == "SUCCESS") {					
							 location.reload();
						}
					}
				});
			});
		}
	});
});
</script>
</html>