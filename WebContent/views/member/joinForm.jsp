<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comm.controller.EmailService" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.util.Properties" %>

<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.security.SecureRandom" %>

<!DOCTYPE html>
<html>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <style>
#mem_Name {
    color: black;
}
    
    input {
    color: black;
}
    .glyphicon-minus:before {
    content: "\2212";
    top: 7px;
    position: relative;
    left: 24px;
}
        body {
            text-align: center;
            padding-top: 50px; /* 필요에 따라 조정하세요 */
        }
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .container {
            display: flex;
            max-width: 1200px; /* 필요에 따라 조정하세요 */
            margin: auto;
        }
body {
    color: white;
}

.form-control,
.control-label {
    color: white;
}

.btn-default {
    color: black; /* 필요에 따라 버튼 텍스트 색상을 조정하세요 */
}
form-container h3 {
    text-align: center; /* Center the text */
    margin-right: 40px; /* Remove the right margin */
}
        .form-container {
            flex: 1;
            margin-top: 20px; /* 필요에 따라 조정하세요 */
            text-align: left;
            position: relative;
    		left: 100px;
        }

        .image-container {
            flex: 1;
            background-image: url('../../images/이미지경로.jpg'); /* 이미지 경로를 조정하세요 */
            background-size: cover;
            background-position: center;
            height: 100vh; /* 뷰포트의 전체 높이에 맞춤 */
        }

        .rq {
            color: red;
        }

        .form-group {
            margin-bottom: 35px;
        }
        
        img {
    vertical-align: middle;
    position: relative;
    left: 150px;
	}
	hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
    left: -100px;
    position: relative;
    </style>
</head>

<body style="background-color:#000000" >
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <div class="container">
        <div class="form-container">
            <h3><img src="<%=request.getContextPath()%>/images/logo_black.png" alt="회원가입"></h3>
            <hr>
    <form action="./insert.do" class="form-horizontal" method="post" onsubmit="return valid()">
     
      <div class="form-group">
        <label for="name" class="control-label col-sm-2">이름<span class="rq"> *</span></label>
        <span class="sp"></span>
        <div class="col-sm-6">
          <input type="text"  style="color: black;" class="form-control" id="mem_Name" name="memName" required pattern="[가-힣]{2,8}">
        </div>
      </div>
      
         <div class="form-group">
            <label for="pass" class="control-label col-sm-2">비밀번호<span class="rq"> *</span></label>
            <div class="col-sm-6">
               <input type="password" style="color: black;"  class="form-control" id="mem_Pw" name="memPw" required pattern="(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$%\^&amp;\*\(\)_\+\|]).{8,}" oninput="checkPasswordMatch()">
            </div>
         </div>

         <div class="form-group">
            <label for="passConfirm" class="control-label col-sm-2">비밀번호 확인</label>
            <div class="col-sm-6">
               <input type="password"  style="color: black;" class="form-control" id="passConfirm" name="memPassConfirm" required pattern="(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$%\^&amp;\*\(\)_\+\|]).{8,}" oninput="checkPasswordMatch()">
               <span id="passConfirmMessage"></span>
            </div>
         </div>



			<div class="form-group">
				<label for="nname" class="control-label col-sm-2">닉네임<span class="rq"> *</span></label> <span
					class="sp"></span>
				<div class="col-sm-6">
					<input type="text"  style="color: black;" class="form-control" id="mem_Ncnm"
						name="memNcnm" required pattern="[가-힣]{2,8}">
					<!-- 실시간 닉네임 중복 체크 결과를 출력할 영역 -->
					<span id="nicknameCheckResult"></span>
				</div>
				<!-- 닉네임 중복 확인 버튼 추가 -->
				<div class="col-sm-2">
					<button type="button"  onclick="checkNickname()" style="color: black;">중복확인</button>
				</div>
			</div>


			<!-- 이메일 입력 -->
			<div class="form-group">
				<label for="email" class="control-label col-sm-2">이메일<span
					class="rq"> *</span></label>
				<div class="col-sm-6">
					<input type="email"  style="color: black;" class="form-control" id="email"
						name="memEmail" placeholder="이메일을 입력하세요"
						pattern="[0-9a-zA-Z]+@[0-9a-zA-Z]+(\.[a-z]+){1,2}">
				</div>
				<!-- 이메일 인증 버튼 추가 -->
				<div class="col-sm-2">
					<button type="button" onclick="sendVerificationEmail()" style="color: black;">이메일
						전송<span class="rq"> *</span></button>
				</div>
			</div>

			<!-- 전송된 숫자 입력 -->
			<div class="form-group">
				<label for="verificationCode" class="control-label col-sm-2">인증
					코드<span class="rq"> *</span>
				</label>
				<div class="col-sm-6">
					<input type="text"  style="color: black;" class="form-control" id="verificationCode"
						name="verification_code" placeholder="인증 코드를 입력하세요" required
						pattern="[0-9]{6}">
				</div>
				<!-- 인증번호 확인 버튼 추가 -->
				<div class="col-sm-2">
					<button type="button" onclick="checkVerificationCode()" style="color: black;">인증번호 확인</button>
				</div>
			</div>

			<div class="form-group">
				<label for="inum"  class="control-label col-sm-2">주민등록번호<span
					class="rq"> *</span></label>
			<div class="col-sm-2">
			    <input type="text"  style="color: black;" class="form-control" id="inum1" name="memInum1" 
			    placeholder="123456" required pattern="[0-9]{6}">
			</div>
			<div class="col-sm-1">
			 <input type="hidden"  style="color: black;" class="form-control">
			    <span class="glyphicon glyphicon-minus"></span>
			</div>
			<div class="col-sm-3">
			    <input type="text"  style="color: black;" class="form-control" id="inum2" name="memInum2" 
			    placeholder="1234567" required pattern="[0-9]{7}">
			</div>
				<span id="inumErrorMessage" class="rq"></span>
			</div>

			<div class="form-group">
				<label for="tel" class="control-label col-sm-2">연락처<span class="rq"> *</span></label>
				<div class="col-sm-6">
					<input type="text"  style="color: black;" class="form-control" id="mem_Telno"
						name="memTelno" placeholder="010-0000-0000" required
						pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}">
				</div>
			</div>

			<!-- Google reCAPTCHA -->
			<div class="form-group">
				<label for="recaptcha" class="control-label col-sm-2">reCAPTCHA<span
					class="rq"> *</span></label>
				<div class="col-sm-6">
					<div class="g-recaptcha"
						data-sitekey="6LcKxUgpAAAAAAN-TGBKRTy8hzXUodck7LrXEUoA"></div>
					<span id="recaptchaError" class="rq"></span>
				</div>
			</div>

	

			<!-- 제출 버튼 -->
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-6" style="left: 90px;">

					<div class="col-sm-offset-2 col-sm-6">
                 	<button type="button" class="btn btn-default" id="joinButton" onclick="submitForm()">가입하기</button>
						<button type="button" class="btn btn-default" onclick="history.back()">취소</button>
					</div>
				</div>
                    <span id="joinspan"></span>
                </div>
        </form>
    </div>
				
			</div>
    
<script>
function submitForm() {
    // 여기에 추가적인 유효성 검사나 필요한 처리를 할 수 있습니다.

    // 서버로 폼 데이터 전송
    $.ajax({
        type: "POST",
        url: "../../insert.do",
        data: $("form").serialize(), // 모든 폼 데이터를 직렬화
        success: function (response) {
            // 서버에서의 응답에 따라 처리
            if (response === "success") {
                // 가입 성공 시 원하는 동작을 수행
                Swal.fire({
                    icon: 'success',
                    title: '가입이 완료되었습니다.',
                    timer: 5000, // 5초 동안 알림 창이 표시됨
                });

                // 2초 뒤에 페이지 이동
                setTimeout(function() {
                    window.location.href = "<%=request.getContextPath()%>/memLogin.do";
                }, 2000);
            } else {
                // 가입 실패 시 원하는 동작을 수행
              Swal.fire({
                    icon: 'success',
                    title: '가입이 완료되었습니다.',
                    timer: 5000, // 5초 동안 알림 창이 표시됨
                });

                // 2초 뒤에 페이지 이동
                setTimeout(function() {
                    window.location.href = "<%=request.getContextPath()%>/memLogin.do";
                }, 2000);
            }
        },
        error: function (error) {
            // 에러 처리
           Swal.fire({
                    icon: 'success',
                    title: '가입이 완료되었습니다.',
                    timer: 5000, // 5초 동안 알림 창이 표시됨
                });
            // 2초 뒤에 페이지 이동
            setTimeout(function() {
                window.location.href = "<%=request.getContextPath()%>/memLogin.do";
            }, 2000);
        }
    });
}
$(document).ready(function() {
    var passwordInput = $("#mem_Pw");
    var confirmPasswordInput = $("#passConfirm");	
    var isPasswordInput = false;

    passwordInput.on("input", function() {
       isPasswordInput = true;
    });

    confirmPasswordInput.on("input", function() {
       var password = passwordInput.val();
       var confirmPassword = confirmPasswordInput.val();

       if (!isPasswordInput || password.trim().length === 0 && confirmPassword.trim().length === 0) {
          $("#passConfirmMessage").html("");
          return;
       }

       if (password === confirmPassword) {
          $("#passConfirmMessage").html("비밀번호 일치").css("color", "green");
          document.getElementById("joinButton").disabled = false;
       } else {
          $("#passConfirmMessage").html("비밀번호 불일치").css("color", "red");
          document.getElementById("joinButton").disabled = true;
       }
    });
 });

function sendVerificationEmail() {
    var userEmail = document.getElementById("email").value;

    var verificationCode = Math.floor(100000 + Math.random() * 900000);

    $.ajax({
        type: "POST",
        url: "../../sendCode.do",
        data: {
            memEmail: userEmail,
            verification_code: verificationCode
        },
        success: function (response) {
            if (response === "success") {
                Swal.fire({
                    icon: 'success',
                    title: '이메일 인증 메일이 전송되었습니다.',
                });
                // 인증 성공 시 가입 버튼 활성화
                document.getElementById("joinButton").disabled = false;
                document.getElementById("cancelButton").disabled = false;
            } else if (response === "duplicate") {
                Swal.fire({
                    icon: 'error',
                    title: '중복된 이메일 주소입니다. 다른 이메일 주소를 사용하세요.',
                });
                // 중복된 이메일이면 다시 페이지로 이동

            } else {
                Swal.fire({
                    icon: 'error',
                    title: '이메일 전송 실패',
                });
                // 이메일 전송 실패 시 가입 버튼 비활성화
                document.getElementById("joinButton").disabled = true;
            }
        },
        error: function (error) {
            Swal.fire({
                icon: 'error',
                title: '서버 오류: ' + error,
            });
        }
    });
}

function checkVerificationCode() {
    var verificationCodeInput = document.getElementById("verificationCode").value;

    $.ajax({
        type: "POST",
        url: "../../checkCode.do", 
        data: {
            verification_code: verificationCodeInput
        },
        success: function (response) {
            if (response === "success") {
                // 인증 성공 메시지만 표시하고 가입 버튼을 활성화하지 않음
                Swal.fire({
                    icon: 'success',
                    title: '인증 성공. 인증 코드가 확인되었습니다.',
                });
                // 인증 성공 시 가입 버튼 활성화
                document.getElementById("joinButton").disabled = false;
                document.getElementById("cancelButton").disabled = false;
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '인증 실패. 올바른 인증 코드를 입력하세요.',
                });
                // 인증 실패 시 가입 버튼 비활성화
                document.getElementById("joinButton").disabled = true;
            }
        },
        error: function (error) {
            Swal.fire({
                icon: 'error',
                title: '서버 오류: ' + error,
            });
        }
    });
}

function cancelRegistration() {
    window.location.href = "main.do";
}

function checkNickname() {
    var nickname = $("#mem_Ncnm").val();

    console.log("닉네임 확인 중:", nickname);

    $.ajax({
        type: "POST",
        url: "../../nickChk.do",
        data: {
            nickname: nickname
        },
        success: function(response) {
            console.log("서버 응답:", response);

            if (response.trim() === "사용가능") {
                $("#nicknameCheckResult").html("<span style='color: green;'>사용 가능한 닉네임입니다.</span>");
                document.getElementById("joinButton").disabled = false;
            } else {
                $("#nicknameCheckResult").html("<span style='color: red;'>이미 사용 중인 닉네임입니다.</span>");
                document.getElementById("joinButton").disabled = true;
            }
        },
        error: function(error) {
            Swal.fire({
                icon: 'error',
                title: '서버 오류: ' + error,
            });
        }
    });
}

	
</script>
</body>
</html>