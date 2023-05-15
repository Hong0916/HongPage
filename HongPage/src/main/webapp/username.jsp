<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width = device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
	var searchRequest = new XMLHttpRequest();
	var registerRequest = new XMLHttpRequest();
	function searchFunction() {
		searchRequest.open("Post",
				"./UserSearchServlet?userName="
						+ encodeURIComponent(document
								.getElementById("userName").value), true);
		searchRequest.onreadystatechange = searchProcess;
		searchRequest.send(null);
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if (searchRequest.readyState = 4 && searchRequest.status == 200) {
			var object = eval('(' + searchRequest.responseText + ')');
			var result = object.result;
			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}
			}
		}
	}

	function registerFunction() {
		registerRequest.open("Post",
				"./UserRegisterServlet?userID="
						+ encodeURIComponent(document
								.getElementById("registerID").value)
						+ "&userPassword="
						+ encodeURIComponent(document
								.getElementById("registerPassword").value)
						+ "&userName="
						+ encodeURIComponent(document
								.getElementById("registerName").value)
						+ "&userGender="
						+ encodeURIComponent($(
								'input[name=registerGender]:checked').val())
						+ "&userEmail="
						+ encodeURIComponent(document
								.getElementById("registerEmail").value)
						+ "&userAge="
						+ encodeURIComponent(document
								.getElementById("registerAge").value), true);
		registerRequest.onreadystatechange = registerProcess;
		registerRequest.send(null);
	}
	function registerProcess() {
		if (registerRequest.readyState == 4 && registerRequest.status == 200) {
			var result = registerRequest.responseText;
			if (result != 1) {
				alert("등록에 실패했습니다.");
			} else {
				var userName = document.getElementbyId("userName");
				var registerID = document.getElementbyId("registerID");
				var registerPassword = document
						.getElementbyId("registerPassword");
				var registerName = document.getElementbyId("registerName");
				var registerEmail = document.getElementbyId("registerEmail");
				var registerAge = document.getElementbyId("registerAge");
				userName.value = "";
				registerID.value = "";
				registerPassword.value = "";
				registerName.value = "";
				registerEmail.value = "";
				registerAge.value = "";
				searchFunction();
			}
		}
	}
	window.onload = function() {
		searchFunction();
	}
</script>
</head>
<body>
	<%
	// 현재 로그인한 사용자의 ID를 담을 변수 초기화
	String userID = null;
	//로그인한 사용자가 있으면 해당 사용자의 ID를 변수에 저장
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	// 페이지 번호 변수 초기화
	int pageNumber = 1;
	// 페이지 번호를 request 객체에서 가져오는데 값이 있으면 해당 값을 변수에 저장
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<nav class="navbar navbar-default">
		<!-- 네비게이션 헤드 시작 -->
		<div class="navbar-header">
			<!-- 로고 및 홈페이지 링크 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 네비게이션 내용 시작 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<!-- 네비게이션 목록, 메인페이지와 게시판페이지가 있다. -->
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="active"><a href="username.jsp">회원목록</a></li>
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

	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction()"
					type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();"
					type="button">검색</button>
			</div>
		</div>
		<table class="table"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa; text-align: center;">이름</th>
					<th style="background-color: #fafafa; text-align: center;">나이</th>
					<th style="background-color: #fafafa; text-align: center;">성별</th>
					<th style="background-color: #fafafa; text-align: center;">이메일</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
			</tbody>
		</table>
	</div>
	<div class="container">
		<table class="table"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2"
						style="background-color: #fafafa; text-align: center;">회원 등록
						양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>아이디</h5></td>
					<td><input class="form-control" type="text" id="registerID"
						size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>비밀번호</h5></td>
					<td><input class="form-control" type="text"
						id="registerPassword" size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>이름</h5></td>
					<td><input class="form-control" type="text" id="registerName"
						size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>나이</h5></td>
					<td><input class="form-control" type="text" id="registerAge"
						size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>성별</h5></td>
					<td>
						<div class="form-group" style="text-align: center;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active"> <input
									type="radio" name="registerGender" autocomplete="off"
									value="남자" checked>남자
								</label> <label class="btn btn-primary"> <input type="radio"
									name="registerGender" autocomplete="off" value="여자">여자
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center"><h5>이메일</h5></td>
					<td><input class="form-control" type="email"
						id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right"
							onclick="registerFunction();" type="button">등록</button></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>