<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>학생수정</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/students.css?ver=170831" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">학생관리 </a></li>
					<li class="active">학생수정</li>
				</ol>
			</div>
			<form id="form-modify-student" action="/students/modify" role="form" method="post">
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
				<input type="hidden" name="searchType" value="${cri.searchType}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
				
				<div class="form-group">
					<label for="input-studentcode">학생번호</label>
					<input id="input-studentcode" type="text" name="scode" class="form-control" value="${svo.scode}" readonly>
				</div>
				<div class="form-group">
					<label for="input-studentname">학생이름</label>
					<input id="input-studentname" type="text" name="sname" class="form-control" value="${svo.sname}">
				</div>
				<div class="form-group">
					<label>소속학과</label>
					<input id="input-studentdept" type="text" name="dept" class="form-control" value="${svo.dept}" readonly>
				</div>
				<div class="form-group">
					<label for="select-studentyear">학년</label>
					<select id="select-studentyear" name="year" class="form-control">
						<option value="1" <c:out value="${svo.year eq '1'?'selected':''}"/>>1 학년</option>
						<option value="2" <c:out value="${svo.year eq '2'?'selected':''}"/>>2 학년</option>
						<option value="3" <c:out value="${svo.year eq '3'?'selected':''}"/>>3 학년</option>
						<option value="4" <c:out value="${svo.year eq '4'?'selected':''}"/>>4 학년</option>
					</select>
				</div>
				<div class="form-group">
					<label>생년월일</label>
					<input id="input-birthday" type="text" name="birthday" class="form-control" value="${svo.birthday}" readonly>
				</div>
				<div class="form-group">
					<label>지도교수</label>
					<input id="input-advisor" type="text" name="advisor" class="form-control" value="${svo.pname}" data-pcode="${svo.advisor}" readonly>
				</div>
				<div class="row add-picture">
					<div class="col-md-6 col-sm-8">
						<label>사진첨부</label>
						<div class="input-group form-inline">
							<input type="text" class="form-control image-preview-filename" disabled="disabled">
							<span class="input-group-btn">
								<div class="btn btn-default picture-input">
									<span class="glyphicon glyphicon-folder-open"></span>
									<span class="picture-input-title"> </span>
									<input id="input-pic-file" type="file" accept="image/png, image/jpeg, image/gif" name="input-file-preview">
								</div>
							</span>
							<div class="tooltip-wrapper">
								<button id="btn-addPicture" type="button" class="btn btn-default pull-right">
									<span class="glyphicon glyphicon-plus"> </span> &nbsp;사진등록
								</button>
							</div>
						</div>
					</div>
				</div>
				<ul class="picture-attachments clearfix uploadedList">
					
				</ul>
				
				<button type="submit" class="btn btn-success">
					<span class="glyphicon glyphicon-ok"> </span> &nbsp;저장
				</button>
				<button id="btn-cancel" type="button" class="btn btn-danger">
					<span class="glyphicon glyphicon-remove"> </span> &nbsp;취소
				</button>
			</form>
		</div>

	</div>
	<jsp:include page="../include/footer.jsp" />
	<!-- Departments Modal -->
	<div class="modal fade" id="modal-dlist" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-info">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<h2><i class="glyphicon glyphicon-book"></i> 학과 목록</h2>
				</div>
				<div id="div-departmentList" class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<div class="col-md-6 col-lg-6">
								<select id="select-college" class="form-control">
									<option selected="" disabled="" hidden="" value=""> 대학 분류를 선택해주세요. </option>
									<option value="인문대학">인문대학</option>
									<option value="사회과학대학">사회과학대학</option>
									<option value="자연과학대학">자연과학대학</option>
									<option value="간호대학">간호대학</option>
									<option value="경영대학">경영대학</option>
									<option value="공과대학">공과대학</option>
									<option value="농업생명과학대학">농업생명과학대학</option>
									<option value="미술대학">미술대학</option>
									<option value="법과대학">법과대학</option>
									<option value="사범대학">사범대학</option>
									<option value="생활과학대학">생활과학대학</option>
									<option value="수의과대학">수의과대학</option>
									<option value="약학대학">약학대학</option>
									<option value="음악대학">음악대학</option>
									<option value="의과대학">의과대학</option>
								</select>
							</div>
						</div>
					</form>
					<div class="modal-list">
                    	<ul id="departmentsList" class="list-group">
                    
                    	</ul>
                    </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"> </span> &nbsp;닫기
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Professors Modal -->
	<div class="modal fade" id="modal-plist" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-info">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<h2><i class="glyphicon glyphicon-book"></i> 교수 목록</h2>
				</div>
				<div id="div-professorsList" class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<div class="col-md-5 col-lg-5 left-select">
								<select id="select-college-p" class="form-control">
									<option selected="" disabled="" hidden="" value=""> 대학 분류를 선택해주세요. </option>
									<option value="인문대학">인문대학</option>
									<option value="사회과학대학">사회과학대학</option>
									<option value="자연과학대학">자연과학대학</option>
									<option value="간호대학">간호대학</option>
									<option value="경영대학">경영대학</option>
									<option value="공과대학">공과대학</option>
									<option value="농업생명과학대학">농업생명과학대학</option>
									<option value="미술대학">미술대학</option>
									<option value="법과대학">법과대학</option>
									<option value="사범대학">사범대학</option>
									<option value="생활과학대학">생활과학대학</option>
									<option value="수의과대학">수의과대학</option>
									<option value="약학대학">약학대학</option>
									<option value="음악대학">음악대학</option>
									<option value="의과대학">의과대학</option>
								</select>
							</div>
							<div class="col-md-7 col-lg-7 right-select">
								<select id="select-dept" class="form-control">
								
								</select>
							</div>
						</div>
					</form>
					<div class="modal-list">
                    	<ul id="professorsList" class="list-group">
                    
                    	</ul>
                    </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"> </span> &nbsp;닫기
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js"></script>
</body>
<script id="template-pic" type="text/x-handlebars-template">
<li>
	<span class="picture-attachment-icon has-img">
		<img src="{{imgsrc}}" alt="Picture">
	</span>
	<div class="picture-attachment-info">
		<a href="{{getLink}}" class="picture-attachment-name">{{fileName}}</a>
		<button type="button" data-fullname="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
			<span class="glyphicon glyphicon-remove"> </span>
		</button>
	</div>
</li>
</script>

<script id="template-departments" type="text/x-handlebars-template">
{{#each .}}
	<li class="list-group-item">{{dname}}</li>
{{/each}}
</script>

<script id="template-dept-options" type="text/x-handlebars-template">
<option selected="" disabled="" hidden="" value=""> 학과를 선택해주세요. </option>
{{#each .}}
	<option value="{{dname}}">{{dname}}</option>
{{/each}}
</script>

<script id="template-professors" type="text/x-handlebars-template">
{{#each .}}
	<li class="list-group-item" data-pcode="{{pcode}}">{{pname}}</li>
{{/each}}
</script>

<script>
var formObj = $("#form-modify-student");
var template = Handlebars.compile($("#template-pic").html());
var $scode = "${svo.scode}";
	
$(document).ready(function() {
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전',
		nextText: '다음',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '년'
	};
	
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	$("#input-birthday").datepicker();
	
	loadPicture();
	
	$("#btn-cancel").on("click", function(event) {
		formObj.attr("action", "/students/detail");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#input-studentdept").on("click", function(event) {
		$("#modal-dlist").modal();
	});
	
	$("#departmentsList").on("click", "li", function(event) {
		var dptname = $(this).text();
		
		$("#input-studentdept").val(dptname);
		$("#modal-dlist").modal('hide');
	});
	
	$("#modal-dlist").on("hidden.bs.modal", function(event) {
		$(this).find('form')[0].reset();
		$("#departmentsList").empty();
	});
	
	$("#select-college").change(function(event) {
		var dpt_template = Handlebars.compile($("#template-departments").html());
		var college = $("#select-college").val();
		
		$.getJSON("/departments/" + college, function(list) {
			var html = dpt_template(list);
			
			$("#departmentsList").html(html);
		});
	});
	
	$("#input-advisor").on("click", function() {
		$("#modal-plist").modal();
	});
	
	$("#select-college-p").change(function(event) {
		var dept_opt_template = Handlebars.compile($("#template-dept-options").html());
		var college_p = $(this).val();
		
		$.getJSON("/departments/" + college_p, function(list) {
			var html = dept_opt_template(list);
			
			$("#select-dept").html(html);
		});
	});
	
	$("#select-dept").change(function(event) {
		var prof_template = Handlebars.compile($("#template-professors").html());
		var dept = $(this).val();
		
		$.getJSON("/professors/" + dept, function(list) {
			var html = prof_template(list);
			
			$("#professorsList").html(html);
		});
	});
	
	$("#professorsList").on("click", "li", function(event) {
		var pcode = $(this).data("pcode");
		var pname = $(this).text();
		
		$("#input-advisor").val(pname);
		$("#input-advisor").data("pcode", pcode);
		$("#modal-plist").modal('hide');
	});
	
	$("#modal-plist").on("hidden.bs.modal", function(event) {
		$(this).find('form')[0].reset();
		$("#professorsList").empty();
	});
	
	$("#form-modify-student").submit(function(event) {
		event.preventDefault();
		
		var $this = $(this);
		var pcode = $("#input-advisor").data("pcode");
		
		$("#input-advisor").val(pcode);
		
		$this.get(0).submit();
	});
	
	$(".picture-input input:file").change(function (){  
		var file = this.files[0];
		console.log("picture input changed");
		console.log("filename :" + file.name);
		
		$(".image-preview-filename").val(file.name);
	});
	
	$("#btn-addPicture").on("click", function(event) {
		var file = $(".picture-input input:file").prop("files")[0];
		var formData = new FormData();
		
		formData.append("file", file);
		
		$.ajax({
			url: "/uploadPicture",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			type: "POST",
			success: function(data) {
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				
				$(".uploadedList").empty();
				$(".uploadedList").append(html);
				$("#btn-addPicture").attr("disabled", true);
				$(".tooltip-wrapper").tooltip({title: "사진 변경을 위해서는 등록된 사진을 먼저 삭제해 주세요", placement: "auto bottom"});
				
				$.ajax({
					url: "/students/addPicture",
					type: "POST",
					data: {fileName: data, scode: $scode},
					dataType: "text"
				});
			}
		});
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
		console.log("del button clicked");
		console.log($(this).data("fullname"));

		var $this = $(this);
		var $fileName = $this.data("fullname");
		
		$.ajax({
			url: "/deletePicture",
			type: "POST",
			data: {fileName: $this.data("fullname")},
			dataType: "text",
			success: function(result) {
				if(result == "deleted") {
					$this.parent().parent("li").remove();
					$("#input-pic-file").val("");
					$(".image-preview-filename").val("");
					$("#btn-addPicture").attr("disabled", false);
					$(".tooltip-wrapper").tooltip('destroy');
					
					$.ajax({
						url: "/students/deletePicture",
						type: "POST",
						data: {fileName: $fileName},
						dataType: "text"
					});
				}
			}
		});
	});
});
	
function loadPicture() {
	var picture = "${svo.picture}"
	
	if(picture) {
		var fileInfo = getFileInfo(picture);
		var html = template(fileInfo);
		
		$(".uploadedList").empty();
		$(".uploadedList").append(html);
		
		$(".image-preview-filename").val(fileInfo.fileName);
		$("#btn-addPicture").attr("disabled", true);
		$(".tooltip-wrapper").tooltip({title: "사진 변경을 위해서는 등록된 사진을 먼저 삭제해 주세요", placement: "auto bottom"});
	}
}
</script>
</html>