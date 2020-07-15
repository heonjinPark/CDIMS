<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/result_report_get.css" />

<!-- Main -->
<div id="main" class="wrapper style1">
	<div class="container">
		<div class="row">

			<%@include file="../includes/apply_record_sidebar.jsp"%>

			<!-- Content -->
			<div id="content" class="8u skel-cell-important">
				<section>
					<header class="major">
						<h2>지원신청서 목록</h2>
					</header>

					<div>
						<label for="year"> 년도 </label><span style="color: red;"> * </span>
						<select id="year" name="year">
							<c:forEach var="item" begin="1990" end="2025" step="1">
								<c:choose>
									<c:when test="${item eq 2020}">
										<option selected="selected">${item}</option>
									</c:when>
									<c:otherwise>
										<option>${item}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<label for="semester">	학기 </label><span style="color: red;"> * </span>
						<select id="semester" name="semester">
							<option>1</option>
							<option>2</option>
						</select>
						<label for="subject_name">	과목명 </label><span style="color: red;"> * </span>
						<select id="subject_name" name="subjectName">
							<!-- 데이터베이스의 과목테이블(subjects_tbl)의 과목명 가져오기 -->
							<c:forEach items="${subname }" var="subject">
								<option><c:out value="${subject.subjectName}"></c:out></option>
							</c:forEach>
						</select>
						<label for="division">	분반 </label><span style="color: red;"> * </span>
						<select id="division" name="division">
							<c:forEach var="item" begin="11" end="15" step="1">
								<c:choose>
									<c:when test="${item eq 11}">
										<option selected="selected">${item}</option>
									</c:when>
									<c:otherwise>
										<option>${item}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<button id="searchBtn" type="button" class='btn btn-default'>검색</button>
					</div>
					
					<form id="actionForm" action="/apply_support/cdims_apply_support_get" method="get">
						<input type="hidden" name="bno" value="" />
						<input type="hidden" name="teamno" value="" />
					</form>
					
					<table class="table table-hover">
						<thead>
							<tr>
								<th>과제명</th>
								<th>팀명</th>
								<th>분반</th>
								<th>담당교수</th>
								<th>승인여부</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					<hr />
					
					<!-- 사용자(학생)만 가능 -->
					<sec:authorize access="hasRole('ROLE_USER')">
						<button class="btn btn-default pull-right" id="writeBtn">글쓰기</button>
					</sec:authorize>
				</section>
			</div>
		</div>
	</div>
</div>
<!-- footer -->
<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/apply-support.js"></script>

<script type="text/javascript">

	function listlink(bno, teamno) {
		console.log("listLink : " + bno, teamno);
		
		var actionForm = $("#actionForm");
		
		actionForm.find("input[name='bno']").val(bno);
		actionForm.find("input[name='teamno']").val(teamno);
		actionForm.submit();
	}

	$(document).ready(function() {
		
		// 과목 조회 버튼 이벤트
		$(document).on('click', '#searchBtn', function() {
			
			var yearValue = document.querySelector('#year').value;
			var semester = document.querySelector('#semester').value;
			var subjectName = document.querySelector('#subject_name').value;
			var division = document.querySelector('#division').value;
			
			console.log(yearValue + ", " + semester + ", " + subjectName + ", " + division);
			
			applySupportService.getList({year:yearValue, semester:semester, subjectname:subjectName, division:division}, 
				function(data) {
				
				console.log("data : " + JSON.stringify(data));
				console.log("data list : " + JSON.stringify(data.length));
				
				if (JSON.stringify(data.length) == 0) {
					alert("조회 결과가 없습니다.");
				} else {
					console.log("bno : " + data[0].bno + ", teamno : " + data[0].teamno);
				}
				
				
				var innerHTML = '';
				for (var i = 0, len = data.length || 0; i < len; i++) {
					innerHTML+='<tr onclick="listlink('+data[i].bno+', '+data[i].teamno+');" style="cursor:pointer;">';
					innerHTML+='<td>'+ data[i].projectTitle+'</td>';
					innerHTML+='<td>'+data[i].teamName+'</td>';
					innerHTML+='<td>'+data[i].division+'</td>';
					innerHTML+='<td>'+data[i].professorCharge+'</td>';
					innerHTML+='<td>'+data[i].approval+'</td>';
					innerHTML+='</tr>';
				}
				
				$('tbody').html(innerHTML);
				
			}); //end function
		});
		
		// 지원 신청 작성 페이지로 이동 이벤트
		$("#writeBtn").on("click", function() {
			self.location ="/apply_support/cdims_apply_support_write";
		});
		
	});
</script>

</body>
</html>



