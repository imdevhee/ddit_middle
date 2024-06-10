<%@ page import="member.vo.MemberVO"%>
<%@ page import="member.vo.AtchFileVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	
    MemberVO mv = (MemberVO) session.getAttribute("LOGIN_MEMBER");
    MemberVO mvNic = (MemberVO) session.getAttribute("mvNic");
    MemberVO mvInt = (MemberVO) session.getAttribute("mvInt");
    AtchFileVO atchFileVO = (AtchFileVO) request.getAttribute("atchFileVO");
    String mempStreNm = (atchFileVO != null && atchFileVO.getMempStreNm() != null)
    ? atchFileVO.getMempStreNm()
    : "../../images/짱구포스터.PNG";
    
//     int index = mempStreNm.indexOf("Webcontent");
//     mempStreNm = mempStreNm.substring(index+11);
//     mempStreNm = "./" + mempStreNm;

    String nickName = "기본닉";

    if (mv != null && mv.getMemNcnm() != null && !mv.getMemNcnm().isEmpty()) {
        nickName = mv.getMemNcnm(); 
    }
    
    String intro = "소개글이 없습니다. 작성해주세요";
    
    if(mv != null && mv.getMemIntro()!= null && !mv.getMemIntro().isEmpty()) {
        intro = mv.getMemIntro();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>마이 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
/* 그리드의 높이 설정하여 .sidenav이 100%가 될 수 있도록 (필요에 따라 조정) */
.row.content {
	height: 1500px
}

/* 회색 배경색과 100% 높이 설정 */
.sidenav {
	background-color: #f1f1f1;
	height: 100%;
}

.profile-pic {
	text-align: center;
	padding: 20px 0;
}

/* 검은 배경색, 흰 텍스트 및 일부 패딩 설정 */
footer {
	background-color: #555;
	color: white;
	padding: 15px;
	position: fixed;
	bottom: 0;
	width: 100%;
}

/* 작은 화면에서 sidenav 및 그리드의 높이를 '자동'으로 설정 */
@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}
</style>

</head>
<body>

	<!-- YeEun Making CSS -->


	<div class="container-fluid">
		<div class="row content">
			<div class="col-sm-3 sidenav">
				<!-- 톱니바퀴 버튼 추가 -->
				<div class="profile-pic">
					<img id="profileImage" src="./images/pf/<%=mempStreNm%>" alt="프사"
						class="img-circle" width="150">
					<button type="button" class="btn btn-default" data-toggle="modal"
						data-target="#settingsModal">
						<span class="glyphicon glyphicon-cog"></span>
					</button>
				</div>

				<h4>
					닉네임:
					<%=nickName %></h4>
				<h5>
					소개글:<br><%=intro %>
				</h5>
				<ul class="nav nav-pills nav-stacked">
					<li class="active"><a href="#section1">프로필</a></li>
					<li><a href="#section2">게시물</a></li>
					<li><a href="# section3">사진</a></li>
					<li><a href="#section4">친구들</a></li>
				</ul>
				<br>
				<div class="input-group">
					<input type="text" class="form-control" placeholder="검색...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>

			<div class="col-sm-9">
				<h2><%=nickName%>님의 프로필
				</h2>
				<hr>
				<h4>프로필 변경</h4>
				<form id="fileUploadForm" enctype="multipart/form-data">
					<input type="file" name="file" id="fileInput">
					<button type="button" onclick="uploadFile()">Upload</button>
				</form>

				<div id="uploadedImageContainer">
					<!-- 프로필 이미지를 표시하기 위해 profileImgPath 변수 사용 -->
					<img id="profileImage" src="./images/pf/<%=mempStreNm%>" alt="프사"
						class="img-circle" width="150">
				</div>


				<hr>
				<h4>나의 소개글 변경</h4>
				<button type="button" class="btn btn-info btn-sm"
					data-toggle="modal" data-target="#introModal"
					data-backdrop="static">수정</button>

				<hr>
				<h4>나의 닉네임 변경</h4>
				<button type="button" class="btn btn-info btn-sm"
					data-toggle="modal" data-target="#nicModal" data-backdrop="static">수정</button>
				<hr>
			</div>
		</div>
	</div>


	<div class="modal fade" id="introModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">소개글 수정</h4>
				</div>
				<div class="modal-body">
					<form id="introForm">
						<div class="form-group">
							<label for="newIntro">새로운 소개글</label>
							<textarea class="form-control" rows="4" id="newIntro"
								name="newIntro"></textarea>
						</div>
						<button type="button" class="btn btn-primary"
							onclick="submitIntro()">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="nicModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">닉네임 수정</h4>
				</div>
				<div class="modal-body">
					<form id="nicForm">
						<div class="form-group">
							<label for="newNic">새로운 닉네임</label> <input type="text"
								class="form-control" id="newNic" name="newNic" required>
							<!-- required 속성 추가: 사용자가 입력하지 않으면 submit이 되지 않도록 합니다. -->
						</div>
						<button type="button" class="btn btn-primary"
							onclick="submitNic()">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>


<!-- 모달 추가 -->
<div class="modal fade" id="settingsModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">계정 설정</h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#passwordChangeModal" data-dismiss="modal">비밀번호 변경</button>
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#confirmWithdrawalModal" data-dismiss="modal">회원 탈퇴</button>
            </div>
        </div>
    </div>
</div>

<!-- 비밀번호 변경 모달 추가 -->
<div class="modal fade" id="passwordChangeModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">비밀번호 변경</h4>
            </div>
            <div class="modal-body">
                <form id="passwordChangeForm">
                    <div class="form-group">
                        <label for="currentPassword">현재 비밀번호</label>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">새로운 비밀번호</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="changePassword()">변경</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="confirmWithdrawalModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">회원 탈퇴 확인</h4>
            </div>
            <div class="modal-body">
                <form id="confirmWithdrawalForm">
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="button" class="btn btn-danger" onclick="confirmWithdrawal()">확인</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>



	<script>



	// JSP 페이지 로딩 시 memId 값을 설정
	var memId = '<%= (mv != null) ? mv.getMemId() : "" %>';

	function uploadProfileImage() {
	  var formData = new FormData();
	  var fileInput = $('#profileImageFile')[0];
	  var files = fileInput.files;

	  if (files.length > 0) {
	    formData.append('profileImageFile', files[0]);

	    // memId가 유효한지 확인
	    if (memId == null || memId.trim() === '') {
	      console.error('유효하지 않은 memId입니다.');
	      return;
	    }

	    // 파일을 서버로 전송하는 AJAX 호출
	    $.ajax({
	      type: 'POST',
	      url: '/FilmSquare/pfSet.do?memId=' + memId,
	      data: formData,
	      contentType: false,
	      processData: false,
	      success: function (response) {
	        console.log(response); // 서버 응답 확인
	        alert('프로필 이미지가 성공적으로 변경되었습니다.');

	        // 서버 응답에 따라 프로필 이미지 업데이트
	        if (response.success) {
	          var profileImgPath = response.profileImgPath;
	          
	          // 페이지 내 해당 부분 업데이트
	          $('.profile-pic img').attr('src', profileImgPath);
	        }

	        location.reload(); // 새로고침
	      },
	      error: function (error) {
	        console.error('에러 발생:', error);
	      }
	    });
	  } else {
	    alert('파일을 선택하세요.');
	  }
	}
	
	
	  function uploadFile() {
		    var formData = new FormData($('#fileUploadForm')[0]);

		    $.ajax({
		      type: 'POST',
		      url: '/FilmSquare/pfSet.do?memId=' + memId,
		      data: formData,
		      contentType: false,
		      processData: false,
		      success: function (response) {
		        var imageUrl = response.mempPath; // 수정된 부분
		        $('#profileImage').attr('src', imageUrl); // 이미지 업데이트
		        alert('프로필 이미지가 성공적으로 변경되었습니다.');
		        location.reload();
		      },
		      error: function (error) {
		        console.error('Error:', error);
		      }
		    });
		  }

	function submitNic() {
	    var newNic = $('#newNic').val();

	    // memId가 유효한지 확인
	    if (memId == null || memId.trim() === '') {
	        console.error('유효하지 않은 memId입니다.');
	        return;
	    }

	    console.log("닉네임 제출됨: " + newNic);
	    console.log("memId: " + memId);

	    // 수정된 닉네임과 memId를 서버로 전송하는 AJAX 호출
	    $.ajax({
	        type: 'POST',
	        url: '/FilmSquare/updateNic.do',
	        data: {
	            newNic: newNic,
	            memId: memId
	        },
	        success: function (response) {
	            console.log(response); // 서버 응답 확인
	            alert('닉네임이 성공적으로 수정되었습니다.');
	            $('#nicModal').modal('hide');
	            location.reload(); // 새로고침

	            // 서버 응답에 따라 닉네임 업데이트
	            if (response.success) {
	                nickName = newNic; // 닉네임 업데이트
	                // 페이지 내 해당 부분 업데이트
	                $('h4').text('닉네임: ' + nickName);
	            }
	        },
	        error: function (error) {
	            console.error('에러 발생:', error);
	        }
	    });
	}

	function submitIntro() {
	    var newIntro = $('#newIntro').val();

	    // memId가 유효한지 확인
	    if (memId == null || memId.trim() === '') {
	        console.error('유효하지 않은 memId입니다.');
	        return;
	    }

	    console.log("소개글 제출됨: " + newIntro);
	    console.log("memId: " + memId);

	    // 수정된 소개글과 memId를 서버로 전송하는 AJAX 호출
	    $.ajax({
	        type: 'POST',
	        url: '/FilmSquare/updateIntro.do',
	        data: {
	            newIntro: newIntro,
	            memId: memId
	        },
	        success: function (response) {
	            console.log(response); // 서버 응답 확인
	            alert('소개글이 성공적으로 수정되었습니다.');
	            $('#introModal').modal('hide');
	            location.reload(); // 새로고침

	            // 서버 응답에 따라 소개글 업데이트
	            if (response.success) {
	                intro = newIntro; // 소개글 업데이트
	                // 페이지 내 해당 부분 업데이트
	                $('h5').text('소개글: ' + intro);
	            }
	        },
	        error: function (error) {
	            console.error('에러 발생:', error);
	        }
	    });
	}


	


	    function changePassword() {
			var memId = '<%= (mv != null) ? mv.getMemId() : "" %>';
	        var currentPassword = $('#currentPassword').val();
	        var newPassword = $('#newPassword').val();

	        // 클라이언트 측에서 비밀번호 유효성 검사 등을 수행할 수 있습니다.
		console.log("currentPassword: " + currentPassword);

	        // 서버로 변경된 비밀번호 전송
	        $.ajax({
	            type: 'POST',
	            url: '/FilmSquare/passChange.do',
	            data: {
	                memId: memId,
	                memPw: currentPassword,
	                newPassword: newPassword

	            },
	            success: function (response) {
	            	console.log(JSON.stringify(response));

	                if (response.success) {
	                    alert('비밀번호가 성공적으로 변경되었습니다.');
	                    // 변경 성공 시 모달을 닫고 페이지 새로고침 또는 다른 처리 수행
	                    $('#passwordChangeModal').modal('hide');
	                    location.reload();
	                } else {
	                    alert('비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인하세요.');
	                }
	                $('#passwordChangeModal').modal('hide');
	            },
	            error: function (error) {
	                console.error('Error:', error);
	                alert('서버 오류 발생. 콘솔을 확인하세요.'); // 변경된 부분
	            }

	        });
	    }


	    function confirmWithdrawal() {
	        if (confirm('정말로 회원 탈퇴하시겠습니까?')) {
	            // 회원 탈퇴 관련 AJAX 처리 코드 추가
	            withdrawal(); // 탈퇴 처리 함수 호출
	        }
	    }
    var memId = '<%= (mv != null) ? mv.getMemId() : "" %>';
    
    function withdrawal() {
        var email = $('#email').val();
        var password = $('#password').val();

        // 서버로 이메일과 비밀번호 전송하여 회원 탈퇴 처리
        $.ajax({
            type: 'POST',
            url: '/FilmSquare/delete.do', 
            data: {
            	memId: memId,
            	memPw: password,
            	memEmail:email
            },
            success: function (response) {
				
            	console.log(response);
            	
                if (response.success) {
                    alert('회원 탈퇴가 성공적으로 처리되었습니다.');
                    // 회원 탈퇴 성공 시 로그인 페이지로 이동 또는 다른 처리 수행
                    window.location.href = '/FilmSquare/main.do';
                    console.log(response.success);
                    
                } else {
                    alert('회원 탈퇴에 실패했습니다. 이메일과 비밀번호를 확인하세요.');
                    console.log(response.success);
                }
                // 모달 닫기
                $('#confirmWithdrawalModal').modal('hide');
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    }

</script>

</body>
</html>
