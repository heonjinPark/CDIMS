<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
						<h2>결과보고서 작성</h2>
					</header>
					<form role='form' name="frm" id="reg_frm" action="/result_report/cdims_result_report_write" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						
						<!-- 유형 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">과목</caption>
							<tr>
								<td>
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
								</td>
							</tr>
						</table>
						<br> <br> <br>
						
						<table class="table table-bordered">
							<caption class="cap">유형</caption>
							<tr>
								<td><label for="assignType"> 과제유형 </label><span style="color: red;"> * </span> 
								<input type="text" id="assigntype" name="assignType"> <br> 
								<label for="projectTitle"> 과제명 </label><span style="color: red;"> * </span> 
								<input type="text" id="projectTitle" name="projectTitle"> <br>
								<label for="teamName"> 팀명 </label><span style="color: red;"> * </span> 
								<input type="text" id="teamName" name="teamName"> <br>
								<label for="applyFee"> 지원신청금액 </label><span style="color: red;"> * </span> 
								<input type="text" id="applyFee" name="applyFee"> <br>
								<label for="writer"> 작성자 </label><span style="color: red;"> * </span> 
								<input type="text" id="writer" name="writer" value="<sec:authentication property="principal.username"/>" 
										readonly style="background-color: #cccccc;"> <br>
								</td>
							</tr>
						</table>
						<br> <br> <br>

						<!-- 팀원 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">팀원</caption>
							<button type="button" id="team_add_btn"
								class="btn btn-default pull-right" name="team_add_btn">팀원 추가</button>
							<tr>
								<td><label for="name"> 소속학과 </label><span
									style="color: red;"> * </span></td>
								<td><label for="name"> 학번 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 학년 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 성명 </label><span style="color: red;">
										* </span></td>
								<td><label for="name"> 전화번호 </label><span
									style="color: red;"> * </span></td>
								<td><label for="name"> 이메일 </label><span
									style="color: red;"> * </span></td>
								<td></td>
							</tr>
							<tr name="trStaff">
								<td><input type="text" id="department0" name="teamList[0].department"><br></td>
								<td><input type="text" id="studentId0" name="teamList[0].studentId"> <br></td>
								<td><input type="text" id="grade0" name="teamList[0].grade"> <br></td>
								<td><input type="text" id="name0" name="teamList[0].name"> <br></td>
								<td><input type="text" id="phoneNumber0" name="teamList[0].phoneNumber"> <br></td>
								<td><input type="text" id="email0" name="teamList[0].email"> <br></td>
								<td></td>
							</tr>
						</table>
						<br> <br> <br>

						<!-- 기업연계/지역협력 입력 폼 테이블-->
						<table class="table table-bordered">
							<caption class="cap">기업연계/지역협력 (* 있을 시에만 작성)</caption>
							<tr>
								<td>
								<label for="type"> 연계형태 </label>
								<input type="text" id="type" name="type"> <br> 
								<label for="company"> 기관명 </label> 
								<input type="text" id="company" name="company"> <br>

									<label for="ceo"> 대표자 </label> <input type="text" id="ceo"
									name="ceo"> <br> <label for="license">
										사업자등록번호 </label> <input type="text" id="license" name="license">
									<br> <label for="business"> 업종/종목 </label> <input type="text"
									id="business" name="business"> <br> <label for="postcode">
										우편번호 </label> <input type="text" id="postcode" name="postcode"> <br>
									<label for="address"> 주소 </label> <input type="text" id="address"
									name="address"> <br></td>
							</tr>
						</table>
						<table class="table table-bordered">
							<caption class="cap">첨부 파일을 제출하세요.</caption>
							<td>
								<input type='file' name='uploadFile' multiple />
								<div class='uploadResult'>
									<ul>
										
									</ul>
								</div>	
							</td>
						</table>
						<button type="submit" id="completed_btn"
							class="btn btn-default pull-right" name="completed_btn" onclick="return writeCheck()">작성 완료</button>
					</form>

				</section>
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<%@ include file="../includes/footer.jsp"%>
</body>

<script>
	var cnt = 0;
	
	//추가 버튼
	$(document).on("click","button[name=team_add_btn]", function() {
		cnt++;
		console.log(cnt);
		var addStaffText = '<tr name="trStaff">'
				+ '   <td><input type="text" id="department' + cnt + '" name="teamList[' + cnt + '].department"> <br></td>'
				+ '   <td><input type="text" id="studentId' + cnt + '" name="teamList[' + cnt + '].studentId"> <br></td>'
				+ '	<td><input type="text" id="grade' + cnt + '" name="teamList[' + cnt + '].grade"> <br></td>'
				+ '	<td><input type="text" id="name' + cnt + '" name="teamList[' + cnt + '].name"> <br></td>'
				+ '	<td><input type="text" id="phoneNumber' + cnt + '" name="teamList[' + cnt + '].phoneNumber"> <br></td>'
				+ '	<td><input type="text" id="email' + cnt + '" name="teamList[' + cnt + '].email"> <br></td>'
				+ '	<td><button type="submit" id="team_del_btn" class="btn btn-primary pull-right" name="team_del_btn">팀원 삭제</button>'
				+ '   </td>' + '</tr>';
	
		var trHtml = $("tr[name=trStaff]:last");
		trHtml.after(addStaffText);
	});

	//삭제 버튼
	$(document).on("click", "button[name=team_del_btn]", function() {
		cnt--;
		console.log(cnt);
		var trHtml = $(this).parent().parent();
		trHtml.remove();
	});

</script>

<script type="text/javascript" src="/resources/js/writecheck.js"></script>

<script>

$(document).ready(function(e) {  
  var formObj = $("form[role='form']");
  
  $("button[type='submit']").on("click", function(e){
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
      url: '/rr_upload/uploadAjaxAction',
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
      url: '/rr_upload/deleteFile',
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
</html>