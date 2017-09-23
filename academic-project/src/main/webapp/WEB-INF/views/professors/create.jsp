<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>교수등록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/professors.css?ver=170828_2" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">교수관리 </a></li>
					<li class="active">교수등록</li>
				</ol>
			</div>
			<form id="form-create-prof" role="form" method="post">
				<div class="form-group">
					<label for="input-profcode">교수번호</label>
					<input id="input-profcode" type="text" name="pcode" class="form-control" placeholder="교수번호를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-profname">교수이름</label>
					<input id="input-profname" type="text" name="pname" class="form-control" placeholder="교수이름을 입력하세요">
				</div>
				<div class="form-group">
					<label>소속학과</label>
					<input id="input-profdept" type="text" name="dept" class="form-control" placeholder="학과선택은 여기를 클릭하세요.." readonly>
				</div>
				<div class="form-group">
					<label>임용일자</label>
					<div class="icon-addon">
						<input id="input-hiredate" type="text" name="hireDate" class="form-control" placeholder="임용일자 설정은 여기를 클릭하세요.."readonly>
						<label for="input-hiredate" class="glyphicon glyphicon-calendar"></label>
					</div>
				</div>
				<div class="form-group">
					<label>직급</label>
					<div class="form-inline">
						<label class="radio-inline">
							<input type="radio" value="정교수" name="title" checked> 정교수
						</label>
						<label class="radio-inline">
							<input type="radio" value="부교수" name="title">부교수
						</label>
						<label class="radio-inline">
							<input type="radio" value="조교수" name="title">조교수
						</label>
					</div>
				</div>
				<div class="form-group">
					<label for="input-email">E-Mail 주소</label>
					<div class="icon-addon">
						<input id="input-email" type="text" name="email" class="form-control" placeholder="Email 주소를 입력하세요.">
						<label for="input-email" class="glyphicon glyphicon-envelope"></label>
					</div>
				</div>
				<div class="form-group">
					<label for="input-mobile">휴대전화</label>
					<div class="icon-addon">
						<input id="input-mobile" type="text" name="mobile" class="form-control" placeholder="전화번호를 입력하세요.">
						<label for="input-mobile" class="glyphicon glyphicon-phone"></label>
					</div>
				</div>
				<div class="form-group">
					<label for="input-profsalary">급여</label>
					<div class="icon-addon">
						<input id="input-profsalary" type="text" name="salary" class="form-control" placeholder="급여를 입력하세요">
						<label for="input-profsalary" class="glyphicon glyphicon-usd"></label>
					</div>
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
									<input id="input-pic-file" type="file" accept="image/png, image/jpeg, image/gif">
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
				<div class="div-submit-btn">
					<button type="submit" class="btn btn-success">
						<span class="glyphicon glyphicon-ok"> </span> &nbsp;저장
					</button>
					<button id="btn-cancel" type="button" class="btn btn-danger">
						<span class="glyphicon glyphicon-remove"> </span> &nbsp;취소
					</button>
				</div>
			</form>
		</div>

	</div>
	<jsp:include page="../include/footer.jsp" />
	<!-- Modal -->
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

<script>
var formObj = $("#form-create-prof");

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
		dateFormat: 'yy-mm-dd',
		showMonthAfterYear: true,
		changeMonth: true,
		changeYear: true,
		yearSuffix: '년'
	};
		
	$.datepicker.setDefaults($.datepicker.regional['ko']);
		
	$("#input-hiredate").datepicker();
	
	$("#btn-cancel").on("click", function(event) {
		formObj.attr("action", "/professors/list");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#input-profdept").on("click", function(event) {
		$("#modal-dlist").modal();
	});
	
	var template = Handlebars.compile($("#template-pic").html());
	
	$(".picture-input input:file").change(function (event){          
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
			}
		});
		
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
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
	
	$("#form-create-prof").submit(function(event) {
		event.preventDefault();
		
		var $this = $(this);
		var str = "";
		var fullname = $(".uploadedList .delbtn").data("fullname");
		
		if(fullname) {
			str += "<input type='hidden' name='picture' value='" + fullname + "'>";
			
			$this.append(str);
		}
		console.log($this);
		
		$this.get(0).submit();
	});
	
	$("#departmentsList").on("click", "li", function(event) {
		var dptname = $(this).text();
		
		$("#input-profdept").val(dptname);
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
});
</script>
</html>