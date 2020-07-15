<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE HTML>
<!--
	Horizons by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
<head>
<title>선문대학교 캡스톤디자인</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/login.css" />

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/skel-layers.min.js"></script>
<script src="js/init.js"></script>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/skel.css" />
<link rel="stylesheet" href="css/style.css" />

<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->

</head>
<body class="homepage">

	<!-- navigation -->
	<div class="navbar navbar-inverse navbar-fixed-top" id="menubar">
		<div class="container" id="img_div">
			<div class="navbar-header">
				<a href="/cdims_main"><img src="images/s2.png" id="img"></a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<form role="form" action="/cdims_logout" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<sec:authorize access="isAnonymous()">
							<button style="margin: 10px;" id="login_button">로그인</button>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<label for="user" id="login_name"><p><sec:authentication property="principal.member.userName"/></p></label>
							<button id="logout_button">로그아웃</button>
						</sec:authorize>
					</form>
				</ul>
			</div>
		</div>
	</div>

	<!-- Header -->
	<div id="header">
		<div class="container">

			<!-- Logo -->
			<h1>캡스톤디자인</h1>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li><a class="list">소개</a>
						<ul>
							<li><a href="/cdims_intro">캡스톤디자인 소개</a></li>
							<li><a href="/cdims_global_intro">글로벌캡스톤디자인 소개</a></li>
						</ul></li>
					<li><a class="list">신청 및 수행이력</a>
						<ul>
							<li><a href="/apply_support/cdims_apply_support">지원신청서</a></li>
							<li><a href="/result_report/cdims_result_report">결과보고서</a></li>
						</ul></li>
					<li><a href="#" class="list">커뮤니티</a>
						<ul>
							<li><a href="/community/cdims_notice">공지사항</a></li>
							<li><a href="/community/cdims_form_document">양식 서류</a></li>
							<li><a href="/community/cdims_qa">Q&A</a></li>
						</ul></li>
				</ul>
			</nav>

			<!-- Banner -->
			<div id="banner">
				<div class="container">
					<section>
						<header class="major">
							<h2>Enjoy your Capston design</h2>
							<span class="byline">당신의 평생기술로 도약하는 캡스톤 디자인</span>
						</header>
						<form role="form" action="/cdims_logout" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<sec:authorize access="isAnonymous()">
								<a id="login_button" style="padding: 15px;" class="button alt">로그인</a>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<a id="logout_button" style="padding: 15px;" class="button alt">로그아웃</a>
							</sec:authorize>
						</form>
					</section>
				</div>
			</div>

		</div>
	</div>

	<!-- footer -->
	<%@ include file="../views/includes/footer.jsp"%>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$(document).on("click", "#login_button", function() {
				self.location = "/cdims_login";
			});
			$(document).on("click", "#logout_button", function(e) {
				$("form").submit();
			});
		});
	</script>
</body>
</html>