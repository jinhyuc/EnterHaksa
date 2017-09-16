<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>교수수정</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/professors.css?ver=170828_2" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">교수관리 </a></li>
					<li class="active">교수수정</li>
				</ol>
			</div>
			<form id="form-modify-prof" action="/professors/modify" role="form" method="post">
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
				<input type="hidden" name="searchType" value="${cri.searchType}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
				
				<div class="form-group">
					<label for="input-profcode">교수번호</label>
					<input id="input-profcode" type="text" name="pcode" class="form-control" value="${pvo.pcode}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="input-profname">교수이름</label>
					<input id="input-profname" type="text" name="pname" class="form-control" value="${pvo.pname}">
				</div>
				<div class="form-group">
					<label for="select-profdept">소속학과</label>
					<select id="select-profdept" name="dept" class="form-control">
						<option value="전산" <c:out value="${pvo.dept eq '전산'?'selected':''}"/>>전산</option>
						<option value="전자" <c:out value="${pvo.dept eq '전자'?'selected':''}"/>>전자</option>
						<option value="건축" <c:out value="${pvo.dept eq '건축'?'selected':''}"/>>건축</option>
					</select>
				</div>
				<div class="form-group">
					<label>임용일자</label>
					<div class="form-inline">
						<select id="prof-year" name="hire_yy" class="form-control" onChange="setDay()"></select>
							년&nbsp;&nbsp; 
						<select id="prof-month" name="hire_mm" class="form-control" onChange="setDay()"></select>
							월&nbsp;&nbsp; 
						<select id="prof-day" name="hire_dd" class="form-control"></select>
							일
					</div>
				</div>
				<div class="form-group">
					<label>직급</label>
					<div class="form-inline">
						<label class="radio-inline">
							<input type="radio" value="정교수" name="title" <c:out value="${pvo.title eq '정교수'?'checked':''}"/>> 정교수
						</label>
						<label class="radio-inline">
							<input type="radio" value="부교수" name="title" <c:out value="${pvo.title eq '부교수'?'checked':''}"/>>부교수
						</label>
						<label class="radio-inline">
							<input type="radio" value="조교수" name="title" <c:out value="${pvo.title eq '조교수'?'checked':''}"/>>조교수
						</label>
					</div>
				</div>
				<div class="form-group">
					<label for="input-profsalary">급여</label>
					<input id="input-profsalary" type="text" name="salary" class="form-control" value="${pvo.salary}">
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js"></script>
</body>
<%
	String yy = request.getAttribute("yy").toString();
	String mm = request.getAttribute("mm").toString();
	String dd = request.getAttribute("dd").toString();
%>
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
<script>
var template = Handlebars.compile($("#template-pic").html());
var $pcode = "${pvo.pcode}";

$(document).ready(function() {
	var frm = document.getElementById('form-modify-prof');
	var curDate = new Date();
	var curYear = curDate.getFullYear();
	var curMonth = eval(curDate.getMonth()) + 1;
	var curDay = eval(curDate.getDate());
	
	var startYear = curYear - 47;
	for(var i=0; i<48; i++) {
		frm['hire_yy'].options[i] = new Option(startYear+i, startYear+i);
	}
	
	for(var i=0; i<12; i++) {
		frm['hire_mm'].options[i] = new Option(i+1, i+1);
	}
	
	frm['hire_yy'].value = <%= yy%>;
	frm['hire_mm'].value = <%= mm%>;
	setDay();
	frm['hire_dd'].value = <%= dd%>;
	
	loadPicture();
	
	$(".picture-input input:file").change(function (){  
		var file = this.files[0];
		
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
					url: "/professors/addPicture",
					type: "POST",
					data: {fileName: data, pcode: $pcode},
					dataType: "text"
				});
			}
		});
		
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
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
						url: "/professors/deletePicture",
						type: "POST",
						data: {fileName: $fileName},
						dataType: "text"
					});
				}
			}
		});
	});
});
	
function setDay() {
	var frm = document.getElementById('form-modify-prof');
	
	var year = frm['hire_yy'].value;
	var month = frm['hire_mm'].value;
	var day = frm['hire_dd'].value;
	var hireDay = frm['hire_dd'];
	
	var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
	
	for(var i=hireDay.length; i>0; i--) {
		hireDay.remove(hireDay.selectedIndex);
	}
	
	for(var i=1; i<=arrayMonth[month-1]; i++) {
		hireDay.options[i-1] = new Option(i, i);
	}
	
	if(day!=null || day!="") {
		if(day > arrayMonth[month-1]) {
			hireDay.options.selectedIndex = arrayMonth[month-1]-1;
		} else {
			hireDay.options.selectedIndex = day - 1;
		}
	}
}

function loadPicture() {
	var picture = "${pvo.picture}"
	
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