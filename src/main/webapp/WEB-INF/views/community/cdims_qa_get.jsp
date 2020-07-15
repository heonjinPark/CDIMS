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
								<tr>
								<td>
									<button data-oper='list' class="btn btn-primary pull-right">목록</button>
									
									<sec:authentication property="principal" var="pinfo"/>
									<sec:authorize access="isAuthenticated()">
										<c:if test="${pinfo.username eq board.writer }">
											<button data-oper='modify' class="btn btn_default pull-right">수정</button>		
										</c:if>
									</sec:authorize>
								</td>
								</tr>
							</tbody>
						</table>
						
						<form id="operForm" action="/community/cdims_qa_update" method="get">
							<input type='hidden' id='bno' name='bno'
								value='<c:out value="${board.bno}"/>'> <input
								type="hidden" name='pageNum'
								value='<c:out value="${cri.pageNum }"/>' /> <input
								type="hidden" name='amount'
								value='<c:out value="${cri.amount }"/>' /> <input type="hidden"
								name='keyword' value='<c:out value="${cri.keyword }"/>' /> <input
								type="hidden" name='type' value='<c:out value="${cri.type }"/>' />
						</form>
						
						<!-- Reply -->
						<div class="col-lg-14">
							<div class="panel panel-default">
								<div class="panel-heading">
									<i class="fa fa-comments fa-fw"></i> Reply
									<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
								</div>
								
								<!-- /.panel-heading -->
								<div class="panel-body">
									<ul class="chat">
										<!-- start reply -->
										<p>댓글이 없습니다.</p>
										<!-- end reply -->
									</ul>
									<!-- end ul -->
								</div>
								<!-- /.panel .chat-panel -->
								<div class="panel-footer">
									
								</div>
							</div>
							
						</div>
						<!-- Reply End -->
					</div>

				</section>
				
			</div>

		</div>
	</div>
</div>

	<!-- Reply Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>댓글</label>
						<input class="form-control" name='reply' value='New Reply' />
					</div>
						<input class="form-control" type="hidden" name='writer' value='writer' readonly="readonly" />
						<input type="hidden" name='replyer' value='replyer' />
				</div>
				
				<div class="modal-footer">
					<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">작성</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
				</div>
			</div>
		</div>
	</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var bnoValue = '<c:out value="${board.bno}" />';
		var replyUL = $(".chat");
		
		showList(1);
		
		// 댓글 리스트
		function showList(page) {
			console.log("show List : " + page);
			
			replyService.getList({bno:bnoValue, page:page || 1}, function(replyCnt, list) {
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				console.log(list);
				
				if (page == -1) {
					pageNum = Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";
				if (list == null || list.length == 0) {
					str = "댓글이 없습니다.";
					replyUL.html(str);
					
					showReplyPage(replyCnt);
					
				}
				
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "	<div><div class='header'><strong class='primary-font'>[" + list[i].rno + "] " + list[i].writer + "</strong>";
					str += "	<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "	<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			}); //end function
		}
		
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		// 댓글 리스트 페이징 처리
		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			
			if (endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			if (prev) {
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
			}
			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";
				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			if (next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		
		}
		
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		
		//modal
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputWriter = modal.find("input[name='writer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		//댓글 작성자
		var replyer = null;
		var writer = null;
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
			writer = '<sec:authentication property="principal.member.userName"/>';
		</sec:authorize>
		
		// 댓글 작성 모달창
		$("#addReplyBtn").on("click", function(e) {
			modal.find("input").val("");
			modalInputReplyer.val(replyer);
			modal.find("input[name='writer']").val(writer); // principal.username으로 가져온 작성자 데이터 출력
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide(); 
			
			modalRegisterBtn.show(); 
			
			$(".modal").modal("show"); 
		});
		
		//CSRF 토큰 처리
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		//Ajax spring security header
		//ajaxSned()는 Ajax 전송 시(매번) SCRF 토큰을 같이 전송하도록 세팅함
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		// 댓글 작성 처리
		modalRegisterBtn.on("click", function(e) {
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					writer : modalInputWriter.val(),
					bno : bnoValue
			};
			replyService.add(reply, function(result) {
				console.log("RESULT : " + result);
				
				modal.find("input").val("");
				modal.modal("hide"); 
				
				showList(-1); //목록 다시 보여주기
			});
		});
		
		// 댓글 수정 처리
		modalModBtn.on("click", function(e) {
			var originalReplyer = modalInputReplyer.val();
			
			var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val(),
					replyer : originalReplyer};
			
			// 비로그인 시 알람창 호출 처리 
			if (!replyer) {
				alert("로그인후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			console.log("modify Original Replyer : " + originalReplyer);
			
			// 로그인한 아이디와 작성자가 일치 하는 지 확인
			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.update(reply, function(result) {
				alert('댓글이 수정되었습니다.');
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		// 댓글 삭제 처리
		modalRemoveBtn.on("click", function(e) {
			var rno = modal.data("rno");
			
			console.log("RNO : " + rno);
			console.log("REPLYER : " + replyer);
			
			// 비로그인 시 알람창 호출 처리 
			if (!replyer) {
				alert("로그인후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = modalInputReplyer.val(); // 댓글의 원래 작성자
			console.log("remove Original Replyer : " + originalReplyer); 
			
			// 로그인한 아이디와 작성자가 일치 하는 지 확인
			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result) {
				alert('댓글이 삭제되었습니다.');
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		// 댓글 수정, 삭제 모달창 처리
		$(".chat").on("click", "li", function(e) {
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
	});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/community/cdims_qa_update").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/community/cdims_qa");
			operForm.submit();
		});
	});
</script>

</body>
</html>