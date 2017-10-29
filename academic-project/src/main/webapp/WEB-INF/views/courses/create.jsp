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
<link href="/resources/stylesheets/style.css?ver=171012" rel="stylesheet">
<link href="/resources/stylesheets/courses.css?ver=171012" rel="stylesheet">
<link href="/resources/validator/dist/css/bootstrapValidator.css" rel="stylesheet">
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
					<li class="active">강좌등록</li>
				</ol>
			</div>
			<form id="form-create-course" role="form" method="post">
				<div class="form-group">
					<label for="input-lecturecode">강좌번호 <sup class="red"> *</sup></label>
					<input id="input-lecturecode" type="text" name="lcode" class="form-control" placeholder="강좌번호를 입력하세요">
				</div>
				<div class="form-group">
					<label for="input-lecturename">강좌이름 <sup class="red"> *</sup></label>
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
					<label>담당교수 <sup class="red"> *</sup></label>
					<input id="input-instructor" type="text" name="instructor" class="form-control" placeholder="담당교수 선택은 여기를 클릭하세요.." readonly>
				</div>
				<div class="form-group">
					<label for="input-capacity">최대 수강인원 수 <sup class="red"> *</sup></label>
					<input id="input-capacity" type="text" name="capacity" class="form-control" placeholder="최대 수강인원 수를 입력하세요">
				</div>
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

	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<!-- BootstrapValidator -->
	<script src="/resources/validator/dist/js/bootstrapValidator.js"></script>
	<script src="/resources/validator/dist/js/language/ko_KR.js"></script>
</body>
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
var formObj = $("#form-create-course");

$(document).ready(function() {
	$("#form-create-course").bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			lcode: {
				validators: {
					notEmpty: {
						message: '필수 입력 항목입니다.'
					},
					stringLength: {
						fix: 4,
						message: '%s 자리 문자(숫자포함)로 입력 가능합니다.'
					}
				}
			},
			lname: {
				validators: {
					notEmpty: {
						message: '필수 입력 항목입니다.'
					},
					stringLength: {
						max: 50,
						message: '%s 자 이하로 입력 가능합니다.'
					}
				}
			},
			hours: {
				validators: {
					digits: {
						message: '숫자만 입력 가능합니다.'
					}
				}
			},
			room: {
				validators: {
					stringLength: {
						max: 10,
						message: '%s 자 이하로 입력 가능합니다.'
					}
				}
			},
			capacity: {
				validators: {
					notEmpty: {
						message: '필수 입력 항목입니다.'
					},
					digits: {
						message: '숫자만 입력 가능합니다.'
					}
				}
			},
			instructor: {
				trigger: 'change',
				validators: {
					notEmpty: {
						message: '필수 입력 항목입니다.'
					}
				}
			}
		}
	})
	.on('error.validator.bv', function(e, data) {
		data.element
				.data('bv.messages')
				// Hide all the messages
				.find('.help-block[data-bv-for="' + data.field + '"]').hide()
				// Show only message associated with current validator
				.filter('[data-bv-validator="' + data.validator + '"]').show();
	})
	.on('success.form.bv', function(e) {
            // Prevent submit form
            e.preventDefault();
            
            var $form = $(e.target),
            validator = $form.data('bootstrapValidator');

    		var pcode = $("#input-instructor").data("pcode");
    		
    		$("#input-instructor").val(pcode);

    		validator.defaultSubmit();
	});
	
	$("#btn-cancel").on("click", function(event) {
		location.replace("/courses/list");
	});
	
	$("#input-instructor").on("click", function() {
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
		
		$("#input-instructor").val(pname);
		$("#input-instructor").data("pcode", pcode);
		$("#modal-plist").modal('hide');
		$("#input-instructor").change();
	});
	
	$("#modal-plist").on("hidden.bs.modal", function(event) {
		$(this).find('form')[0].reset();
		$("#professorsList").empty();
	});
})

</script>

</html>