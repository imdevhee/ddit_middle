<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>





<style>

.item {
   border: 1px solid #ddd;
   margin-bottom: 5px;
   cursor: pointer;
}

.item:hover {
   background-color: #f5f5f5;
}

.col-12 {
   flex: 0 0 auto;
   width: 100%;
   background: lightslategray;
}

.main-banner {
   position: relative;
   max-height: 100%;
   overflow: hidden;
   /* margin-bottom: -7px; */
   margin: 100px;
}

#placesList {
   width: 650px;

}

.form-horizontal {
   bottom: 500px;
}

section {
	display: flex;
	justify-content: center;
	padding-top: 150px;

}
#submitBtn {
	border: 1px solid black;
}


</style>
<body>
<%

	String loginFail = (String)request.getAttribute("loginFail");
	if(loginFail != null && !loginFail.isEmpty()){
%>
	<script>alert("<%=loginFail %>");</script>
<%
	}
%>
  <!-- ***** Main Banner Area Start ***** -->
<section class="section main-banner" id="top" data-section="section1">
	<form class="form-horizontal" method="post"
		action="<%=request.getContextPath() %>/memLogin.do">
		<!-- 이메일 입력 -->
		<div class="form-group">
			<label class="control-label col-sm-2" for="email">Email:</label>
			<div class="col-sm-10">
				<input type="email" name="memEmail" class="form-control" id="email"
					placeholder="이메일">
			</div>
		</div>
		<!-- 비밀번호 입력 -->
		<div class="form-group">
			<label class="control-label col-sm-2" for="pwd">Password:</label>
			<div class="col-sm-10">
				<input type="password" name="memPw" class="form-control" id="pwd"
					placeholder="비밀번호">
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button id="submitBtn" type="submit" class="btn btn-default">Submit</button>
			</div>
		</div>
	
<!-- 		카카오 Login 버튼 -->
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<a href="javascript:kakaoLogin()"><img src="<%=request.getContextPath()%>/images/kakao_login_medium_narrow.png" alt="카카오"></a>
		</div>
	</div>


	<!-- 네이버 Login 버튼 -->
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<a href="#"><img src="<%=request.getContextPath()%>/images/btnG_완성형.png" alt="네이버"></a>
		</div>
	</div>

	<!-- 회원가입 링크 -->
	<div class="col-xs-12 join">
		<a href="<%=request.getContextPath()%>/insert.do">회원가입</a>
	</div>

	<!-- 이메일 찾기 버튼 -->
	<div class="col-xs-12 join">
		<button type="button"
			onclick="window.location.href='<%=request.getContextPath()%>/views/member/find.jsp'">이메일
			찾기</button>
	</div>

	<!-- 비밀번호 찾기 링크 -->
	<div class="col-xs-12 join">
		<button type="button"
			onclick="window.location.href='<%=request.getContextPath()%>/views/member/find2.jsp'">비밀번호
			찾기</button>
	</div>
	
	</form>
</section>	






	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
				<script> 
				Kakao.init("ca85312fd4718194ae795cede6884ff8");
    			</script>


  
<%@include file="../include/footer.jsp"%>

  <!-- Scripts -->
  <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script src="assets/js/isotope.min.js"></script>
    <script src="assets/js/owl-carousel.js"></script>
    <script src="assets/js/lightbox.js"></script>
    <script src="assets/js/tabs.js"></script>
    <script src="assets/js/video.js"></script>
    <script src="assets/js/slick-slider.js"></script>
    <script src="assets/js/custom.js"></script>
    <script>
        //according to loftblog tut
        $('.nav li:first').addClass('active');

        var showSection = function showSection(section, isAnimate) {
          var
          direction = section.replace(/#/, ''),
          reqSection = $('.section').filter('[data-section="' + direction + '"]'),
          reqSectionPos = reqSection.offset().top - 0;

          if (isAnimate) {
            $('body, html').animate({
              scrollTop: reqSectionPos },
            800);
          } else {
            $('body, html').scrollTop(reqSectionPos);
          }

        };

        var checkSection = function checkSection() {
          $('.section').each(function () {
            var
            $this = $(this),
            topEdge = $this.offset().top - 80,
            bottomEdge = topEdge + $this.height(),
            wScroll = $(window).scrollTop();
            if (topEdge < wScroll && bottomEdge > wScroll) {
              var
              currentId = $this.data('section'),
              reqLink = $('a').filter('[href*=\\#' + currentId + ']');
              reqLink.closest('li').addClass('active').
              siblings().removeClass('active');
            }
          });
        };

        $('.main-menu, .responsive-menu, .scroll-to-section').on('click', 'a', function (e) {
          e.preventDefault();
          showSection($(this).attr('href'), true);
        });

        $(window).scroll(function () {
          checkSection();
        });


        
        
        
        

        
        function kakaoLogin() {
    		
          	Kakao.Auth.login({
//          	scope:'profile_nickname, profile_image, account_email, name, gender, age_range, birthday, phone_number, friends',
            success: function(authObj) {
            	console.log(authObj);
            	Kakao.API.request({
                	url:'/v2/user/me',
//              	success: res => {
//                  	const kakao_account = res.kakao_account;
//                  	console.log(kakao_account);
//                  	const kakao_account_mail = res.kakao_account.email;
//                  	console.log(res.kakao_account.email);
    				success: function(resp){
    					let info = resp.kakao_account;
    					console.log(info);
//     					let id = resp.id;
//     					age_range birthday account_email profile_image gender profile_nickname name phone_number friends
    					let data = {
    						token: Kakao.Auth.getAccessToken(),
//     						memId: id,

    						memNcnm: info.profile.nickname,
    						memBirthday: info.birthday,
    						memBirthyear: info.birthyear,
    						memGender: info.gender,
    						memName: info.name, 
    						memEmail: info.email,
    						memTelno: info.phone_number,
    						memFrom: "kakao"
    					};
    					
    					let ajax = new XMLHttpRequest();
    					
    					ajax.open('POST', '/FilmSquare/kakaoLogin.do');
    					ajax.setRequestHeader('Content-Type','application/json');
    					
    					ajax.onload = function(){
    						if(ajax.status == 200){
//     							console.log(200);
								if(ajax.responseText){
									location.href="main.do";
								}else{
									//인서트 실패시..
									alert('카카오 로그인에 실패했습니다.');
									location.href="memLogin.do";
								}
    						}else{
//     							console.log(2123231200);
    						}
    						
    					
    					}
    					console.log(data);
    					ajax.send(JSON.stringify(data));
    				}
    				
              });
            }
          });
        }

        



        


      </script>
        
        




</body>
</html>