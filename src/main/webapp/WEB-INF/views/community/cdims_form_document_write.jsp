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
						<h2>작성</h2>
					</header>
					<div>

						<form role="form" action="/community/cdims_form_document_write" method="post">
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
											placeholder="작성자" value="<sec:authentication property="principal.member.userName"/>" name="name" readonly="readonly" /></td>
									</tr>
									<td>
										<input type="file" name='uploadFile' multiple />
										<div class='uploadResult'>
											<ul>
												
											</ul>
										</div>	
									</td>
								</tbody>
							</table>
							<!-- 글쓰기 -->
							<input type='submit' id="writing_btn"
								class="btn btn-primary pull-right" onclick="return communityWriteCheck()" value="글쓰기" />
						</form>

					</div>
				</section>
			</div>

		</div>
	</div>
</div>

<script>

$(document).ready(function(e) {  
  var formObj = $("form[role='form']");
  
  $("input[type='submit']").on("click", function(e){
    console.log("submit clicked");
    var str = "";
    
    $(".uploadResult ul li").each(function(i, obj){
      var jobj = $(obj);
      
      console.dir(jobj.data("image"));
      console.log("-------------------------");
      console.log(jobj.data("filename"));
      
      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
      
    });

    console.log("str: " + str);
    
    formObj.append(str);
    
  });

  
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
          console.log("result : " + result);
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

  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    var targetFile = $(this).data("file"); 
    var type = $(this).data("type"); 
    
    var targetLi = $(this).closest("li");
    
    $.ajax({
      url: '/fd_upload/deleteFile',
      data: {fileName: targetFile, type:type},
      beforeSend: function(xhr) { // Ajax로 데이터를 전송할 때 추가적인 헤더를 지정해서 전송
    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      dataType:'text',
      type: 'POST',
        success: function(result){
           console.log("result : " + result);
           targetLi.remove();
         }
    }); //$.ajax
   });


  
});

</script>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/community_write_check.js"></script>

</body>
</html>