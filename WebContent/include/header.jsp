<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="TemplateMo">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <title>FilmSquare</title>

    <!-- 부트스트랩 사용 링크 -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS파일 목록 -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-edu-meeting.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/lightbox.css">
    
    <style>
      /* 상단 메뉴 색 변경  */
      .col-12 {
      	background-color: #101010;
      	height: 0;
      	z-index: 5000;
      }
      
      .header-area.header-sticky {
	  	background-color: black;
	  	min-height: 0;
	  }
      
      
      header {
      	top: 0;
      
      }
      .container:first-child {
		width: 30000px;
	  }
	  #search-bar {
	  	position: relative;
	  	bottom: 20px;
	  }
	  
	  .header-area .main-nav .logo {
	      line-height: 70px;
	  
	  }
	  
	  .header-area .main-nav .nav li a {
	      bottom: 16px;
	  }
	  
	  a:hover {
	  	font-size: larger;
	  }
	  
	  
	  /* 상단메뉴 글씨 색 */
    
    
    </style>

  </head>

<body>



<% 
	MemberVO mv = (MemberVO)session.getAttribute("LOGIN_MEMBER"); 

	if(mv != null && mv.getMemEmail() != null && !mv.getMemEmail().equals("")){
	
	String memId = mv.getMemId();
	
%>

  <!-- ***** 회원일 경우 헤더영역 시작 ***** -->
  <header class="header-area header-sticky">
      <div class="container">
          <div class="row">
              <div class="col-12">
                  <nav class="main-nav">
                      <!-- ***** 로고 시작 ***** -->
                      <a href="<%=request.getContextPath()%>/main.do" class="logo">
                        Film Square
                      </a>
                      <!-- ***** 로고 끝 ***** -->
                      <!-- ***** 상단 메뉴 시작 ***** -->
                      <ul class="nav">
                          <li><a href="<%=request.getContextPath() %>/map.do"><span class="glyphicon glyphicon-map-marker">&nbsp;</span>내 근처 영화관 찾기</a></li>
     					  <li><a href="<%=request.getContextPath() %>/releasingCal.do"><span class="glyphicon glyphicon-calendar">&nbsp;</span>개봉 예정작 일정보기</a></li>
                          <li class="scroll-to-section">
                          <form method="post" action="<%=request.getContextPath()%>/search.do" id="search-bar" class="navbar-form" role="search">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search"
								name="search">
						</div>
						<button id="searchBtn" type="submit" class="btn btn-default">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</form>
					</li> 
                         <li><a href="<%=request.getContextPath()%>/memLogout.do"><span
						      class="glyphicon glyphicon-log-out"></span> Logout</a></li> 
                         <li><a href="<%=request.getContextPath()%>/mypage.do?memId=<%=memId%>"><span
						      class="glyphicon glyphicon-user"></span></a></li> 
                      </ul>        
                      <!-- ***** 상단 메뉴 끝 ***** -->
                  </nav>
              </div>
          </div>
      </div>
  </header>
  <!-- ***** 회원일 경우 헤더영역 끝 ***** -->
 
<%	
	} else {
%>
   <!-- ***** 비회원일 경우 헤더영역 시작 ***** -->
  <header class="header-area header-sticky">
      <div class="container">
          <div class="row">
              <div class="col-12">
                  <nav class="main-nav">
                      <!-- ***** 로고 시작 ***** -->
                      <a href="<%=request.getContextPath()%>/main.do" class="logo">
                          Film Square
                      </a>
                      <!-- ***** 로고 끝 ***** -->
                      <!-- ***** 상단 메뉴 시작 ***** -->
                      <ul class="nav">
                          <li><a href="<%=request.getContextPath() %>/map.do"><span class="glyphicon glyphicon-map-marker">&nbsp;</span>내 근처 영화관 찾기</a></li>
     					  <li><a href="<%=request.getContextPath() %>/releasingCal.do"><span class="glyphicon glyphicon-calendar">&nbsp;</span>개봉 예정작 일정보기</a></li>
                          <li class="scroll-to-section">
                          <form method="post" action="<%=request.getContextPath()%>/search.do" id="search-bar" class="navbar-form" role="search">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search"
								name="search">
						</div>
						<button id="searchBtn" type="submit" class="btn btn-default">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</form>
					</li> 
                         <li><a href="<%=request.getContextPath()%>/memLogin.do"><span
						      class="glyphicon glyphicon-log-in"></span> Login</a></li> 
                      </ul>        
                      <!-- ***** 상단 메뉴 끝 ***** -->
                  </nav>
              </div>
          </div>
      </div>
  </header>

  <!-- ***** 비회원일 경우 헤더영역 끝 ***** -->
 
<% } %>
</body>
</html>