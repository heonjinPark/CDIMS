<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/result_report_get.css" />
<link rel="stylesheet" href="/resources/css/file-upload.css" />

<!-- Main -->
<div id="main" class="wrapper style1">
	<div class="container">
		<div class="row">

			<%@include file="../includes/apply_record_sidebar.jsp"%>
			
			<!-- Content -->
			<div id="content" class="8u skel-cell-important">
				<section>
					<header class="major">
						<h2>결과보고서</h2>
					</header>
					<table class="table table-striped table-bordered table-hover">
						<caption class="cap">과목</caption>
						<tr>
							<td class="success">년도</td>
							<td colspan="2"><c:out value="${resultvo.year }"></c:out></td>
							<td class="success">학기</td>
							<td colspan="2"><c:out value="${resultvo.semester }"></c:out></td>
						</tr>
						<tr>
							<td class="success">과목명</td>
							<td colspan="2"><c:out value="${resultvo.subjectName }"></c:out></td>
							<td class="success">분반</td>
							<td colspan="2"><c:out value="${resultvo.division }"></c:out></td>
						</tr>
						<tr>
							<td class="success">승인상태</td>
							<td colspan="5" id="approval_status" style="color: green; font-weight: bolder;"><c:out value="${resultvo.approval }"></c:out></td>
						</tr>
					</table>
					<br />
					
					<table class="table table-striped table-bordered table-hover">
						<caption class="cap">유형</caption>
						<tr>
		
							<td class="success">과제유형</td>
							<td colspan="5"><c:out value="${resultvo.assignType }"></c:out></td>
						</tr>
						<tr>
							<td class="success">과제명</td>
							<td colspan="5"><c:out value="${resultvo.projectTitle }"></c:out></td>
						</tr>
						<tr>
							<td class="success">팀명</td>
							<td colspan="2"><c:out value="${resultvo.teamName }"></c:out></td>
							<td class="success">지원신청금액</td>
							<td colspan="2"><c:out value="${resultvo.applyFee }"></c:out></td>
						</tr>
					</table>
					<br />
					
					<table class="table table-striped table-bordered table-hover">
						<caption class="cap">팀원</caption>
						<thead>
							<tr class="success">
								<th colspan="3">소속학과</th>
								<th colspan="3">학번</th>
								<th colspan="1">학년</th>
								<th colspan="2">성명</th>
								<th colspan="3">전화번호</th>
								<th colspan="4">이메일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="team" items="${teamList }">
								<tr>
									<td colspan="3"><c:out value="${team.department }"></c:out></td>
									<td colspan="3"><c:out value="${team.studentId }"></c:out></td>
									<td colspan="1"><c:out value="${team.grade }"></c:out></td>
									<td colspan="2"><c:out value="${team.name }"></c:out></td>
									<td colspan="3"><c:out value="${team.phoneNumber }"></c:out></td>
									<td colspan="4"><c:out value="${team.email }"></c:out></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br />
					
					<table class="table table-striped table-bordered table-hover">
						<caption class="cap">기업연계/지역협력</caption>
						<tr>
							<td class="success">연계형태</td>
							<td colspan="5"><c:out value="${resultvo.type }"></c:out></td>
						</tr>
						<tr>
							<td class="success">기관명</td>
							<td colspan="2"><c:out value="${resultvo.company }"></c:out></td>
							<td class="success">대표자</td>
							<td colspan="2"><c:out value="${resultvo.ceo }"></c:out></td>
						</tr>
						<tr>
							<td class="success">사업자등록번호</td>
							<td colspan="2"><c:out value="${resultvo.license }"></c:out></td>
							<td class="success">업종/종목</td>
							<td colspan="2"><c:out value="${resultvo.business }"></c:out></td>
						</tr>
						<tr>
							<td class="success">우편번호</td>
							<td colspan="5"><c:out value="${resultvo.postcode }"></c:out></td>
						</tr>
						<tr>
							<td class="success">주소</td>
							<td colspan="5"><c:out value="${resultvo.address }"></c:out></td>
						</tr>
					</table>
					<br />
					
					<table class="table table-striped table-bordered table-hover">
						<caption class="cap">첨부파일</caption>
						<td>
							<div class="panel-body">
								<div class='uploadResult'>
									<ul>
									
									</ul>
								</div>
							</div>
						</td>
					</table>
				</section>
				
				<button data-oper='list' id="list_btn"
							class="btn btn-default pull-right">목록</button>
				
				<!-- 작성자만 수정, 삭제 가능 -->							
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq resultvo.writer }">
						<button data-oper='delete' id="delete_btn"
							class="btn btn-default pull-right">삭제</button>
							
						<button data-oper='modify' id="modify_btn"
									class="btn btn-default pull-right">수정</button>		
					</c:if>
				</sec:authorize>
				
				<!-- 과목 담당교수만 승인, 취소 가능 -->
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq resultvo.userid }">
						<button data-oper='approval_cancel' id="approval_cancel_btn"
							class="btn btn-default pull-right">승인 취소</button>
							
					<button data-oper='approval' id="approval_btn"
								class="btn btn-default pull-right">승인</button>	
					</c:if>
				</sec:authorize>
		
				<form id="frm" action="cdims_result_report_delete" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="hidden" name="bno" value="${resultvo.bno }" />
					<input type="hidden" name="teamno" value="${resultvo.teamno }" />
					<input type="hidden" name="writer" value="${resultvo.writer }" />
				</form>
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
</body>
<script type="text/javascript" src="/resources/js/result-report.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var teamno = "<c:out value="${resultvo.teamno}"/>";
		
		var frm = $("#frm");
		
		var approvalStat = $("#approval_status");
		
		//CSRF 토큰 처리
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		//Ajax spring security header
		//ajaxSned()는 Ajax 전송 시(매번) SCRF 토큰을 같이 전송하도록 세팅함
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		// 작성자
		var writer = null;
		<sec:authorize access="isAuthenticated()">
			writer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		/* 승인취소버튼 */
		$("button[data-oper='approval_cancel']").on("click", function(e) {
			console.log("승인취소 클릭");
			var approvalStatus = {teamno : teamno, approval : "대기"};
			
			resultreportService.update(approvalStatus, function(result) {
				if (result == "success") {
					alert('승인취소되었습니다.');
					approvalStat.html("'<td colspan='5' id='approval_status' style='color: green;'>" + approvalStatus.approval + "</td>");
				}
			});
		});
		
		/* 승인버튼 */
		$("button[data-oper='approval']").on("click", function(e) {
			console.log("승인버튼 클릭");
			var approvalStatus = {teamno : teamno, approval : "승인"};
			
			resultreportService.update(approvalStatus, function(result) {
				if (result == "success") {
					alert('승인완료되었습니다.');
					approvalStat.html("'<td colspan='5' id='approval_status' style='color: green;'>" + approvalStatus.approval + "</td>");
				}
			});
		});
		
		/* 삭제버튼 */
		$("button[data-oper='delete']").on("click", function(e) {
			frm.submit();
		});
		
		/* 수정버튼 */
		$("button[data-oper='modify']").on("click", function(e) {
			frm.attr("action", "/result_report/cdims_result_report_update");
			frm.attr("method", "get");
			frm.submit();
		});
		
		/* 목록버튼 */
		$("button[data-oper='list']").on("click", function(e) {
			self.location = "/result_report/cdims_result_report";
		});
	});

</script>


<script>
	$(document).ready(function() {
			(function() {
				var teamno = "<c:out value="${resultvo.teamno}"/>";
				
				$.getJSON("/result_report/getAttachList", {teamno: teamno}, function(arr) {
					console.log(arr);
					
					var str = "";
					$(arr).each(function(i, attach) {
						
						//image type
						if (attach.fileType == 1) {
							
							str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
							str += "<img src='/resources/img/attach.png'>";
							str += "</div>";
							str += "</li>";
						} else {
							str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
							str += "<span> " + attach.fileName + "</span><br/>";
							str += "<img src='/resources/img/attach.png'>";
							str += "</div>";
							str += "</li>";
						}
						
					});
					$(".uploadResult ul").html(str);
					
			}); // end getJson
		})(); 
			
		$(".uploadResult").on("click","li", function(e){
		      
		    console.log("view image");
		    
		    var liObj = $(this);
		    
		    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		    
	      	//download 
	   	    self.location ="/rr_upload/download?fileName="+path
		    
		  });
	});
	
	
	
	
</script>
</html>