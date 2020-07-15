<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/community_write.css" />
<link rel="stylesheet" href="/resources/css/file-upload.css" />

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

					<form role="form" action="/community/cdims_form_document_update" method="post">
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
									<td>
										<div class="form-group uploadDiv">
								            <input type="file" name='uploadFile' multiple="multiple">
								        </div>
								        
								        <div class='uploadResult'> 
								          <ul>
								          
								          </ul>
								        </div>
									</td>
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
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if (operation === 'remove') {
				formObj.attr("action", "/community/cdims_form_document_delete");
				formObj.submit();
				
			} else if (operation === 'list') {
				//move to list
				formObj.attr("action", "/community/cdims_form_document").attr("method", "get");
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
			} else if(operation === 'modify') {
		        
		        console.log("submit clicked");
		        
		        var str = "";
		        
		        $(".uploadResult ul li").each(function(i, obj){
		          var jobj = $(obj);
		          
		          console.dir(jobj);
		          
		          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		          
		        });
		        formObj.append(str);
	        }
		});
	});
</script>

<script>
	$(document).ready(function() {
		(function() {
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/community/getAttachList", {bno: bno}, function(arr) {
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, attach){
		            var fileCallPath =  encodeURIComponent( attach.uploadPath+"/"+ attach.uuid +"_"+attach.fileName);			      
				      
					str += "<li "
					str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> "+ attach.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
		        });
			      
			      $(".uploadResult ul").html(str);
			      
			      
			}); // end getJson
		})(); // end function
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		  var maxSize = 90242880; //90MB
		  
		  function checkExtension(fileName, fileSize){
		    
		    if(fileSize >= maxSize){
		      alert("파일 사이즈 초과");
		      return false;
		    }
		    
		    if(regex.test(fileName)){
		      alert("해당 종류의 파일은 업로드할 수 없습니다.");
		      return false;
		    }
		    return true;
		  }
		  
		  var csrfHeaderName = "${_csrf.headerName}";
		  var csrfTokenValue = "${_csrf.token}";
		  
		  $("input[type='file']").change(function(e){

		    var formData = new FormData();
		    
		    var inputFile = $("input[name='uploadFile']");
		    
		    var files = inputFile[0].files;
		    
		    for(var i = 0; i < files.length; i++){

		      if(!checkExtension(files[i].name, files[i].size) ){
		        return false;
		      }
		      formData.append("uploadFile", files[i]);
		      
		    }
		    
		    $.ajax({
		      url: '/fd_upload/uploadAjaxAction',
		      processData: false, 
		      contentType: false,
		      beforeSend: function(xhr) { // Ajax로 데이터를 전송할 때 추가적인 헤더를 지정해서 전송
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		      },
		      data: formData,
		      type: 'POST',
		      dataType:'json',
		        success: function(result){
		          console.log(result); 
				  showUploadResult(result); //업로드 결과 처리 함수 

		      }
		    }); //$.ajax
		    
		  });  
		  
		  function showUploadResult(uploadResultArr){
			    
		    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		    
		    var uploadUL = $(".uploadResult ul");
		    
		    var str ="";
		    
		    $(uploadResultArr).each(function(i, obj){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				      
					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
		    	
		    });
		    
		    uploadUL.append(str);
		  }
		  
		  // 업로드된 첨부 파일 삭제
		  $(".uploadResult").on("click", "button", function(e){
			    
			    console.log("delete file");
			    
			    if (confirm("업로드한 파일을 삭제하시겠습니까? ")) {
			    	var targetLi = $(this).closest("li");
			    	targetLi.remove();
			    }
			  });
		
	});
	
</script>

</body>
</html>