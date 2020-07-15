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
						<h2>작성</h2>
					</header>
					<div>

						<form id="frm" role="form" action="/community/cdims_qa_write"
							method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<input type="hidden" value="<sec:authentication property="principal.username"/>" name="writer" />
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd">
								<tbody>
									<tr>
										<td><input type="text" class="form-control"
											placeholder="글 제목" id="title" name="title" maxlength="50" /></td>
									</tr>
									<tr>
										<td><textarea class="form-control" placeholder="글 내용"
												id="contents" name="content" maxlength="2048" style="height: 350px;"></textarea></td>
									</tr>
									<tr>
										<td><input type="text" class="form-control"
											placeholder="작성자" id="writer" value="<sec:authentication property="principal.member.userName"/>" name="name" readonly="readonly"/></td>
									</tr>
								</tbody>
							</table>
							<!-- 글쓰기 -->
							<input type="submit" id="writing_btn"
								class="btn btn-primary pull-right" onclick="return communityWriteCheck()" value="글쓰기" />
						</form>
					</div>
				</section>
			</div>

		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/community_write_check.js"></script>

</body>
</html>