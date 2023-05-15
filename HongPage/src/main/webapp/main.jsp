<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 출력 스트림을 생성하기 위해 import -->
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!-- "viewport" : 메타데이터 
	"width=device-width" : 뷰포트의 너비를 디바이스의 너비로
	initial-scale="1" : 뷰포트 초가 롹대/축소 비율을 1로 설정 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	/* 로그인한 사용자의 아이디를 가져오는 코드 */
	%>
	<!-- 네비게이션 바 시작 -->
	<nav class="navbar navbar-default">
		<!-- 네비게이션 헤드 시작 -->
		<div class="navbar-header">
			<!-- 작대기 3개를 쌓아올려 버튼 무늬를 만들기(햄버거 버튼) -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- 로고 및 홈페이지 링크 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 네비게이션 내용 시작 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<!-- 네비게이션 목록, 메인페이지와 게시판페이지가 있다. -->
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="username.jsp">회원목록</a></li>
				<li><a href="Calendar.jsp">캘린더</a></li>
			</ul>
			<%
			/* 로그인한 사용자가 없으면 접속하기 메뉴를 보여줌 */
			if (userID == null) {
			%>
			<!-- 접속하기 메뉴 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<!-- 로그인 메뉴 -->
						<li><a href="login.jsp">로그인</a></li>
						<!-- 회원가입 메뉴 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			// 로그인한 사용자가 있으면 회원관리 메뉴를 보여줍니다.
			} else {
			%>
			<!-- 회원관리 메뉴 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<!-- 로그아웃 메뉴 -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹사이트 소개</h1>
				<p>테스트 페이지</p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>