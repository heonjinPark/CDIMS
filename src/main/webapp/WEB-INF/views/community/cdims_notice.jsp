<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/notice.css" />

<!-- Main -->
<div id="main" class="wrapper style1">
	<div class="container">
		<div class="row">

			<%@include file="../includes/community_sidebar.jsp"%>

			<!-- Content -->
			<div id="content" class="8u skel-cell-important">
				<section>
					<header class="major">
						<h2>공지사항</h2>
					</header>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>

						<c:forEach items="${list }" var="board">
							<tr>
								<td><c:out value="${ board.bno}"></c:out></td>
								<td><a class='move' href='<c:out value="${board.bno }" />'><c:out
											value="${ board.title }" /> </a></td>
								<td><c:out value="${ board.name }"></c:out></td>
								<td><fmt:formatDate value="${ board.regDate }" /></td>
							</tr>
						</c:forEach>
					</table>
					<hr />

					<div>
						<sec:authorize access="hasRole('ROLE_MANAGER')">
							<button id="writeBtn" type="button" class="btn btn-default pull-right">글쓰기</button>
						</sec:authorize>
					</div>

					<div class="row">
						<form id='searchForm' action="/community/cdims_notice" method='get'
							style="display: inline-flex">
							<select name="type">
								<option value=""
									<c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목
									or 내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목
									or 작성자</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }"/>>제목
									or 내용 or 작성자</option>
							</select> 
							<input type="text" name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
							<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }' />
							<input type="hidden" name='amount' value='${pageMaker.cri.amount }' />
							<button class="btn btn-default pull-right" id="writing">Search</button>
						</form>
					</div>

					<hr />

					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="pagination previous"><a
									href="${pageMaker.startPage -1 }">Previous</a></li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage }">
								<li class="pagination ${pageMaker.cri.pageNum == num ? "active" : "" }"><a
									href="${num }">${num }</a></li>
							</c:forEach>

							<c:if test="${pageMaker.next }">
								<li class="pagination next"><a
									href="${pageMaker.endPage + 1 }">Next</a></li>
							</c:if>
						</ul>
					</div>

					<form id="actionForm" action="/community/cdims_notice" method="get">
						<input type="hidden" name='pageNum'
							value='${pageMaker.cri.pageNum }' /> <input type="hidden"
							name='amount' value='${pageMaker.cri.amount }' /> <input
							type="hidden" name='type'
							value='<c:out value="${pageMaker.cri.type }"/>' /> <input
							type="hidden" name='keyword'
							value='<c:out value="${pageMaker.cri.keyword }"/>' />
					</form>

					<!-- Model 추가 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /.modal -->
				</section>
			</div>

		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>

</body>
</html>

<script type="text/javascript">
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		if (result === '' || history.state) {
			return;
		}
		
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		
		/* id=myModal은 현재 hidden 상태에서 0보다 큰 값이 들어오면 보여줌 */
		$("#myModal").modal("show");
	}
	
	$("#writeBtn").on("click", function() {
		self.location ="/community/cdims_notice_write";
	});
	
	/* 페이징 처리에서 페이지 번호 버튼 처리 이벤트 */
	var actionForm = $("#actionForm");
	$(".pagination a").on("click", function(e) {
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "/community/cdims_notice_get");
		actionForm.submit();
	});
	
	/* 검색 처리(search) 버튼 이벤트 */
	var searchForm = $("#searchForm"); 
	$("#searchForm button").on("click", function(e) {
		
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요.");
			return false;
		}
		
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
});

</script>


