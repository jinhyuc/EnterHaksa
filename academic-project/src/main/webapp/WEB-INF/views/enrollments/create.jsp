<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수강신청 등록</title>
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/stylesheets/style.css?ver=170825_10" rel="stylesheet">
<link href="/resources/stylesheets/enrollments.css?ver=170901" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../include/header.jsp" />
			<div class="row">
				<ol class="breadcrumb">
					<li><a href="#">홈</a></li>
					<li><a href="#">수강신청 관리 </a></li>
					<li class="active">수강신청</li>
				</ol>
			</div>
			<form id="form-create-enroll" role="form" method="post">
				<div class="form-group">
					<label for="select-enrolllcode">강좌번호</label>
					<select id="select-enrolllcode" name="lcode" class="form-control">
						<c:forEach var="cvo" items="${clist}">
							<option value="${cvo.lcode}">${cvo.lcode}: ${cvo.lname}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label for="select-enrollscode">학생번호</label>
					<select id="select-enrollscode" name="scode" class="form-control">
						<c:forEach var="svo" items="${slist}">
							<option value="${svo.scode}">${svo.scode}: ${svo.sname}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>수강신청일</label>
					<div class="form-inline">
						<select id="enroll-year" name="enroll_yy" class="form-control" onChange="setDay()"></select>
							년&nbsp;&nbsp; 
						<select id="enroll-month" name="enroll_mm" class="form-control" onChange="setDay()"></select>
							월&nbsp;&nbsp; 
						<select id="enroll-day" name="enroll_dd" class="form-control"></select>
							일
					</div>
				</div>
				<div class="form-group">
					<label for="input-grade">성적</label>
					<input id="input-grade" type="text" name="grade" class="form-control" placeholder="성적을 입력하세요">
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
<script>
	$(document).ready(function() {
		var frm = document.getElementById('form-create-enroll');
		var curDate = new Date();
		var curYear = curDate.getFullYear();
		var curMonth = eval(curDate.getMonth()) + 1;
		var curDay = eval(curDate.getDate());
		
		var startYear = curYear - 47;
		for(var i=0; i<48; i++) {
			frm['enroll_yy'].options[i] = new Option(startYear+i, startYear+i);
		}
		
		for(var i=0; i<12; i++) {
			frm['enroll_mm'].options[i] = new Option(i+1, i+1);
		}
		
		frm['enroll_yy'].value = curYear;
		frm['enroll_mm'].value = curMonth;
		setDay();
		frm['enroll_dd'].value = curDay;
	});
	
	function setDay() {
		var frm = document.getElementById('form-create-enroll');
		
		var year = frm['enroll_yy'].value;
		var month = frm['enroll_mm'].value;
		var day = frm['enroll_dd'].value;
		var enrollDay = frm['enroll_dd'];
		
		var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
		
		for(var i=enrollDay.length; i>0; i--) {
			enrollDay.remove(enrollDay.selectedIndex);
		}
		
		for(var i=1; i<=arrayMonth[month-1]; i++) {
			enrollDay.options[i-1] = new Option(i, i);
		}
		
		if(day!=null || day!="") {
			if(day > arrayMonth[month-1]) {
				enrollDay.options.selectedIndex = arrayMonth[month-1]-1;
			} else {
				enrollDay.options.selectedIndex = day - 1;
			}
		}
	}
</script>
</html>