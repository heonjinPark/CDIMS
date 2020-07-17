# 캡스톤디자인 통합 관리 시스템
## 개요
- SpringFramework를 이용한 학과 문서 관리 웹 프로젝트

#### 만든 목적
- 오프라인으로 진행되던 서류작업을 온라인화
- 서류작업 기능을 동적으로 구현하여 추후에도 관리 가능

#### 일정
- 20.05.16 ~ 20.07.05
- 참여도 : 100% (개인 프로젝트)

## 사용 기술 및 개발 환경
- O/S : macOS 10.15.1 (Catalina)
- Server : Apache Tomcat 8.5
- DB : Oracle11g R2 (RDB)
- Framework/Flatform : Spring MVC, SpringSecurity, MyBatis, Bootstrap, jQuery, Docker 2.3.0.3
- Language : JAVA, Javascript, HTML5, CSS3
- Tool : Eclipse, GitHub, Git(SourceTree), SQL Developer

## 내용
#### 구현 기능
- 구현

- 로그인 (교수(조교), 학생) <br/>

Spring Security dependency 주입
~~~xml
        <!-- spring security -->
	<!-- https://mvnrepository.com/artifact/org.springframework.security/spring-security-web -->
	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-web</artifactId>
		<version>5.0.6.RELEASE</version>
	</dependency>
	<!-- https://mvnrepository.com/artifact/org.springframework.security/spring-security-config -->
	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-config</artifactId>
		<version>5.0.6.RELEASE</version>
	</dependency>

	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-core</artifactId>
		<version>5.0.6.RELEASE</version>
	</dependency>

	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-taglibs</artifactId>
		<version>5.0.6.RELEASE</version>
~~~
로그인,자동 로그인, 로그아웃 설정
~~~xml
	<bean id="customLoginSuccess" class="kr.co.sunmoon.security.CustomLoginSuccessHandler"></bean>	

	<security:form-login login-page="/cdims_login" authentication-success-handler-ref="customLoginSuccess"/>
	<security:logout logout-url="/cdims_logout" invalidate-session="true" delete-cookies="remember-me,JSESSION_ID" />
	<security:remember-me data-source-ref="dataSource" token-validity-seconds="604800" />
~~~
---
- 신청서 작성 (지원 신청서, 결과 보고서) <br/>
<br/><br/>
1. 지원신청서, 결과보고서 목록 REST 방식을 이용해 (년도, 학기, 과목, 분반) 데이터를 보내 결과 리스트를 json 형태로 데이터 가져옴 

cdims_result_report.jsp 일부
~~~jsp
$(document).on('click', '#searchBtn', function() {
			
	var yearValue = document.querySelector('#year').value;
	var semester = document.querySelector('#semester').value;
	var subjectName = document.querySelector('#subject_name').value;
	var division = document.querySelector('#division').value;

	console.log(yearValue + ", " + semester + ", " + subjectName + ", " + division);

	resultreportService.getList({year:yearValue, semester:semester, subjectname:subjectName, division:division}, 
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
~~~ 

result-report.js 일부
~~~js
var resultreportService = (function() {

function getList(param, callback, error) {
	var year = param.year;
	var semester = param.semester;
	var subjectName = param.subjectname;
	var division = param.division;

	$.getJSON("/result_report/list/" + year + "/" + semester + "/" + subjectName + "/" + division + ".json",
		function(data) {
			if (callback) {
				callback(data); //댓글 숫자와 목록을 가져오는 경우
			}
		}).fail(function(xhr, status, err) {
			if (error) {	
				error();
			}
	});
}
~~~ 

ResultReportRestController.java 일부
~~~java
@GetMapping(value = "/list/{year}/{semester}/{subjectname}/{division}",
		produces = {MediaType.APPLICATION_XML_VALUE,
				MediaType.APPLICATION_JSON_UTF8_VALUE})
public ResponseEntity<List<ResultReportVO>> getList(@PathVariable("year") String year, @PathVariable("semester") String semester,
		@PathVariable("subjectname") String subjectname, @PathVariable("division") String division) {

	log.info("getList year : " + year + ", " + "semester : " + semester + "," + "subject : " + subjectname + "," + "division: " + division);

	return new ResponseEntity<>(resultReportService.getList(year, semester, subjectname, division), HttpStatus.OK);
}
~~~ 

ResultReportServiceImpl.java 일부
~~~java
@Override
public List<ResultReportVO> getList(String year, String semester, String subjectname, String division) {
	log.info("getList year : " + year + ", semester : " + semester + ", subjectname" + subjectname + ", division : "
			+ division);

	return resultreportMapper.getList(year, semester, subjectname, division);
}
~~~
<br/><br/>
2. 지원신청서, 결과보고서 조회페이지에서 해당 담당 교수일 경우 승인 및 취소(대기) 처리 가능 <br/>
cdims_result_report_get.jsp 
~~~jsp
	//CSRF 토큰 처리
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	//Ajax spring security header
	//ajaxSned()는 Ajax 전송 시(매번) SCRF 토큰을 같이 전송하도록 세팅함
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	var writer = null;
	<sec:authorize access="isAuthenticated()">
		// 작성자 (담당 교수)
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
~~~
result-report.js 일부
~~~js
function update(approvalStatus, callback, error) {
	console.log("approvalStatus teamno: " + approvalStatus.teamno + ", approval : " + approvalStatus.approval);

	$.ajax({
		type : 'put',
		url : '/result_report/' + approvalStatus.teamno + "/" + approvalStatus.approval, 
		data : JSON.stringify(approvalStatus),
		contentType : "application/json; charset=utf-8",
		success : function(result, status, xhr) {
			if (callback) {
				callback(result);
			}
		},
		error : function(xhr, status, er) {
			if (error) {
				error(er);
			}
		}
	});
}
~~~
ResultReportController.java 일부
~~~java
@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH}, value="/{teamno}/{approval}",
		consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
public ResponseEntity<String> approvalUpdate(@PathVariable("teamno") int teamno, @PathVariable("approval") String approval) {
	log.info("approvalUpdate teamno : " + teamno + ", approval : " + approval);


	return resultReportService.approvalUpdate(teamno, approval) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) :
		new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
}
~~~
ResultReportServiceImpl.java 일부
~~~java
@Override
public int approvalUpdate(int teamno, String approval) {
	log.info("approvalUpdate teamno : " + teamno + ", approval : " + approval);

	return resultreportMapper.approvalUpdate(teamno, approval); 
}
~~~

- 커뮤니티 (공지사항, 양식 서류(첨부파일 기능), Q&A (댓글 기능)), 검색 (키워드)
    
#### 산출물
- 요구사항 정의서

![캡디통합관리_요구사항정의서](https://user-images.githubusercontent.com/68316076/87619085-4b243380-c756-11ea-91e3-6b97bf450be0.PNG)

- Flowchart

<img width="982" alt="스크린샷 2020-07-16 오전 9 58 31" src="https://user-images.githubusercontent.com/68316076/87618863-d3560900-c755-11ea-8b80-78c1190ba0d9.png">

- ERD <br>
https://www.erdcloud.com/d/yTLGLXQKajRkhoXqy

<img width="1299" alt="스크린샷 2020-07-16 오전 10 02 26" src="https://user-images.githubusercontent.com/68316076/87618878-de109e00-c755-11ea-9a50-be1294e5a447.png">

