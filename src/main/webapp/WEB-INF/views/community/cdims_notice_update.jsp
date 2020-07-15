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

					<form role="form" action="/community/cdims_notice_update" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" name='pageNum'
							value="<c:out value="${cri.pageNum }"/>" /> <input type="hidden"
							name='amount' value="<c:out value="${cri.amount }"/>" /> <input
							type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>' /> <input type="hidden"
							name='type' value='<c:out value="${cri.type }"/>' />
						<div>
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd">
								<tbody>
									<tr>
										<td><input class="form-control" name='bno'
											value="<c:out value="${board.bno }" />" readonly="readonly" /></td>
									</tr>
									<tr>
										<td><input class="form-control" name='title' id="title"
											value="<c:out value="${board.title }" />" /></td>
									</tr>
									<tr>
										<td><textarea class="form-control" rows="3" id="contents"
												name='content' maxlength="2048" style="height: 350px;"><c:out
													value="${board.content }" /></textarea></td>
									</tr>
									<tr>
										<td><input class="form-control"
											value="<c:out value="${board.name }" />" name='name'
											readonly="readonly" /></td>
									</tr>
									<input type="hidden" value="${board.writer }" name="writer"/>
								</tbody>
							</table>
							
							
							<button type="submit" data-oper='list' class="btn btn-default pull-right">목록</button>
							<sec:authentication property="principal" var="pinfo"/>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username eq board.writer }">
									<button type="submit" data-oper='remove' class="btn btn-danger pull-right">삭제</button>
									<button type="submit" data-oper='modify' class="btn btn-default pull-right"
										onclick="return communityWriteCheck()">수정</button>
								</c:if>
							</sec:authorize>
						</div>
					</form>
				</section>
			</div>

		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/community_write_check.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");
		
		$('button').on("click", function(e) {
			/* e.preventDefault(); //button의 submit으로 동작하는 것을 막는다 (나중에 submit을 직접 수행함) */
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if (operation === 'remove') {
				formObj.attr("action", "/community/cdims_notice_delete");
				formObj.submit();
				
			} else if (operation === 'list') {
				//move to list
				formObj.attr("action", "/community/cdims_notice").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty(); //전달하는 form태그의 데이터를 모두 지움
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				formObj.submit();
			}
		});
	});
</script>

</body>
</html>