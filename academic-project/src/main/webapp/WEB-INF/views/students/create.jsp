<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>학생등록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/students.css?ver=170831" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">학생관리 </a></li>
					<li class="active">학생등록</li>
				</ol>
			</div>
			<form id="form-create-student" role="form" method="post">
				<div class="form-group">
					<label for="input-studentcode">학생번호</label>
					<input id="input-studentcode" type="text" name="scode" class="form-control" placeholder="학생번호를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-studentname">학생이름</label>
					<input id="input-studentname" type="text" name="sname" class="form-control" placeholder="학생이름을 입력하세요">
				</div>
				<div class="form-group">
					<label for="select-studentdept">소속학과</label>
					<select id="select-studentdept" name="dept" class="form-control">
						<option value="전산">전산</option>
						<option value="전자">전자</option>
						<option value="건축">건축</option>
					</select>
				</div>
				<div class="form-group">
					<label for="select-studentyear">학년</label>
					<select id="select-studentyear" name="year" class="form-control">
						<option value="1">1 학년</option>
						<option value="2">2 학년</option>
						<option value="3">3 학년</option>
						<option value="4">4 학년</option>
					</select>
				</div>
				<div class="form-group">
					<label>생년월일</label>
					<div class="form-inline">
						<select id="student-year" name="birth_yy" class="form-control" onChange="setDay()"></select>
							년&nbsp;&nbsp; 
						<select id="student-month" name="birth_mm" class="form-control" onChange="setDay()"></select>
							월&nbsp;&nbsp; 
						<select id="student-day" name="birth_dd" class="form-control"></select>
							일
					</div>
				</div>
				<div class="form-group">
					<label for="select-advisor">지도교수</label>
					<select id="select-advisor" name="advisor" class="form-control">
						<c:forEach var="pvo" items="${plist}">
							<option value="${pvo.pcode}">${pvo.pcode}: ${pvo.pname}</option>
						</c:forEach>
					</select>
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
<script id="template" type="text/x-handlebars-template">
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
$(document).ready(function() {
	var frm = document.getElementById('form-create-student');
	var curDate = new Date();
	var curYear = curDate.getFullYear();
	var curMonth = eval(curDate.getMonth()) + 1;
	var curDay = eval(curDate.getDate());
	
	var startYear = curYear - 47;
	for(var i=0; i<48; i++) {
		frm['birth_yy'].options[i] = new Option(startYear+i, startYear+i);
	}
	
	for(var i=0; i<12; i++) {
		frm['birth_mm'].options[i] = new Option(i+1, i+1);
	}
	
	frm['birth_yy'].value = curYear;
	frm['birth_mm'].value = curMonth;
	setDay();
	frm['birth_dd'].value = curDay;
	
	$(".picture-input input:file").change(function (){          
		var file = this.files[0];
		
		$(".image-preview-filename").val(file.name);
	});

	var template = Handlebars.compile($("#template").html());

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
			}
		});
		
	});

	$(".uploadedList").on("click", ".delbtn", function(event) {
		console.log("del button clicked");
		console.log($(this).data("fullname"));

		var $this = $(this);
		
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
				}
			}
		});
	});
	
	$("#form-create-student").submit(function(event) {
		event.preventDefault();
		
		var $this = $(this);
		var str = "";
		
		str += "<input type='hidden' name='picture' value='" + $(".uploadedList .delbtn").data("fullname") + "'>";
		
		$this.append(str);
		
		$this.get(0).submit();
	});
});

function setDay() {
	var frm = document.getElementById('form-create-student');
	
	var year = frm['birth_yy'].value;
	var month = frm['birth_mm'].value;
	var day = frm['birth_dd'].value;
	var birthDay = frm['birth_dd'];
	
	var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
	
	for(var i=birthDay.length; i>0; i--) {
		birthDay.remove(birthDay.selectedIndex);
	}
	
	for(var i=1; i<=arrayMonth[month-1]; i++) {
		birthDay.options[i-1] = new Option(i, i);
	}
	
	if(day!=null || day!="") {
		if(day > arrayMonth[month-1]) {
			birthDay.options.selectedIndex = arrayMonth[month-1]-1;
		} else {
			birthDay.options.selectedIndex = day - 1;
		}
	}
}
</script>
</html>