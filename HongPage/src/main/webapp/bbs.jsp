<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content="width=device-width", initial-scale="1">
<link rel = "stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoratuib : none
	}
</style>
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
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 모바일용 메뉴 버튼 -->
			<button type="button" class="navbar-toggle collapsed" 
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- 네비게이션 메뉴 목록 -->
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class = "active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="username.jsp">회원목록</a></li>
				<li><a href="Calendar.jsp">캘린더</a></li>
			</ul>
			<!-- 로그인 여부에 따라 다르게 출력되는 드롭다운 메뉴 -->
			<%
				if(userID == null){
			%>
			<!-- 로그인 하지 않은 경우 -->
			<ul class = "nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<!-- 로그인 한 경우 -->
			<ul class = "nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- 게시판 목록을 보여주는 테이블 -->
	<div class="container">
		<div class = "row">
			<!-- 게시글 목록을 보여주는 테이블 -->
			<table class = "table table-striped" style ="text-align: center; border: 1px solid#dddddd">
				<thead>
					<!-- 게시글 목록의 헤더 -->
					<tr>
						<th style = "backgroud-color : #eeeeee; text-align:center;">번호</th>
						<th style = "backgroud-color : #eeeeee; text-align:center;">제목</th>
						<th style = "backgroud-color : #eeeeee; text-align:center;">작성자</th>
						<th style = "backgroud-color : #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시글 목록의 내용을 동적으로 생성 -->
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<!-- 게시글 번호 -->
						<td><%= list.get(i).getBbsID() %></td>
						<!--  게시글 제목 -->
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<!-- 게시글 작성자 -->
						<td><%= list.get(i).getUserID() %></td>
						<!-- 게시글 작성일 -->
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
							
					<%	
						}
					%>
				</tbody>
			</table>
			<!-- 페이지 이동 버튼 및 글쓰기 버튼 -->
			<%
				// 이전 페이지 버튼 생성
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				// 다음 페이지 버튼 생성
				} if(bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<!-- 글쓰기 버튼 -->
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>