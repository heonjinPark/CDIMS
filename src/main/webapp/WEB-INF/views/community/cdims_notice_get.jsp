<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/community_write.css" />

<!-- Main -->
<div id="main" class="wrapper style1">
	<div class="container">
		<div class="row">

			<%@include file="../includes/community_sidebar.jsp"%>

			<!-- Content -->
			<div id="content" class="8u skel-cell-important">
				<section>
					<header class="major">
						<h2>게시글</h2>
					</header>

					<div>
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<tbody>
								<tr>
									<td><input class="form-control" name='bno'
										value="<c:out value="${board.bno }" />" readonly="readonly" /></td>
								</tr>
								<tr>
									<td><input class="form-control" name='title'
										value="<c:out value="${board.title }" />" readonly="readonly" /></td>
								</tr>
								<tr>
									<td><textarea class="form-control" rows="3" name='content' 
										 	maxlength="2048" style="height: 350px;" readonly="readonly"><c:out value="${board.content }" /></textarea></td>
								</tr>
								<tr>
									<td><input class="form-control"
										value="<c:out value="${board.name }" />" name='writer'
										readonly="readonly" /></td>
								</tr>
							</tbody>
						</table>
						
						<button data-oper='list' class="btn btn-primary pull-right">목록</button>
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq board.writer }">
								<button data-oper='modify' class="btn btn_default pull-right">수정</button>		
							</c:if>
						</sec:authorize>

						<form id="operForm" action="/community/cdims_notice_update" method="get">
							<input type='hidden' id='bno' name='bno'
								value='<c:out value="${board.bno}"/>'> <input
								type="hidden" name='pageNum'
								value='<c:out value="${cri.pageNum }"/>' /> <input
								type="hidden" name='amount'
								value='<c:out value="${cri.amount }"/>' /> <input type="hidden"
								name='keyword' value='<c:out value="${cri.keyword }"/>' /> <input
								type="hidden" name='type' value='<c:out value="${cri.type }"/>' />
						</form>
					</div>
				</section>
			</div>

		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/community/cdims_notice_update").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/community/cdims_notice");
			operForm.submit();
		});
	});
</script>

</body>
</html>