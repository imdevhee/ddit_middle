<%@page import="movie.vo.MovieInfoVO"%>
<%@page import="movie.service.MovieInfoServiceImpl"%>
<%@page import="movie.service.IMovieInfoService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="movie.vo.PosterVO"%>
<%@page import="movie.vo.MvGradeVO"%>
<%@page import="movie.vo.GradeVOforYE"%>
<%@page import="java.util.List"%>
<%@page import="member.vo.AtchFileVO"%>
<%@page import="member.vo.MemberVO"%>
<%@page import="movie.service.PosterServiceImpl"%>
<%@page import="member.servive.AtchFileServiceImpl"%>
<%@page import="member.servive.MemberServiceImpl"%>
<%@page import="movie.service.IPosterService"%>
<%@page import="member.servive.IAtchFileService"%>
<%@page import="member.servive.IMemberService"%>
<%@page import="movie.service.MovieGradeServiceImpl"%>
<%@page import="movie.service.IMovieGradeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="globals.css" />
    <link rel="stylesheet" href="styleguide.css" />
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" >
<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Actor&family=Inter:wght@400;500;900&family=Roboto:wght@400;500;700&family=Ropa+Sans&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
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
<title>마이페이지</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<div class="mypage">
      <div class="navbar">
        <div class="text-wrapper">FILM SQUARE</div>
        <div class="text-wrapper">CALENDAR</div>
        <div class="text-wrapper">MAP</div>
        <div class="text-wrapper">SEARCH</div>
        <div class="text-wrapper">LOG OUT</div>
      </div>
<%
IMovieGradeService gradeService = MovieGradeServiceImpl.getInstance();
IMemberService memService = MemberServiceImpl.getInstance();
IAtchFileService fileService = AtchFileServiceImpl.getInstance();
IPosterService posterService = PosterServiceImpl.getInstance();
IMovieInfoService movieService = MovieInfoServiceImpl.getInstance();

//테스트
MemberVO mv = (MemberVO) session.getAttribute("LOGIN_MEMBER");
//   if(mem==null) mem = memService.getAMember(new MemberVO("61")); 
AtchFileVO file = fileService.getAFile(mv.getMemId());


String mempStreNm = (file != null && file.getMempStreNm() != null)
	? file.getMempStreNm() : "../../images/icons/user-basic.png";

String nickName = "닉네임을 설정하세요!";

if (mv != null && mv.getMemNcnm() != null && !mv.getMemNcnm().isEmpty()) {
    nickName = mv.getMemNcnm(); 
}

String intro = "소개글이 없습니다. 작성해주세요";

if(mv != null && mv.getMemIntro()!= null && !mv.getMemIntro().isEmpty()) {
    intro = mv.getMemIntro();
}

%>
<script>

document.addEventListener("DOMContentLoaded", function () {
    var profile = document.getElementById("profile");
    var editImage = document.getElementById("edit-image");
    var modal = document.getElementById("modal");
    var modalprofile = document.getElementById("modal-profile");

    profile.addEventListener("mouseover", function () {
        // 마우스가 올라갔을 때 edit-image에 백그라운드 이미지 추가
        editImage.style.backgroundImage = "url('${pageContext.request.contextPath}/images/icons/add-photo.png')"; // 변경될 이미지 경로 설정
    });

    profile.addEventListener("mouseout", function () {
        // 마우스가 나갔을 때 edit-image의 백그라운드 이미지 제거
        editImage.style.backgroundImage = "none";
    });

    profile.addEventListener("click", function () {
        // 클릭했을 때 모달 창을 보이게 함
        modalprofile.style.backgroundImage = profile.style.backgroundImage;
        modal.style.display = "flex";
    });

    // 모달 바깥을 클릭하면 모달이 사라지도록 함
    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
});

</script>  



      <div class="title"><div class="div">MY PAGE</div></div>
      <div class="collection">
        <div class="frame">
          <div class="frame-2">
            <div class="profile" id="profile" style="background-image: url(${pageContext.request.contextPath}/images/pf/<%=mempStreNm%>)"><span class="edit-image" id="edit-image"></span>
           
         
            </div>
					<div class="frame-4">
						<div class="frame-5">
							<div class="text-wrapper-2" type="button" class="btn btn-default" data-toggle="modal"
							data-target="#settingsModal">
							<%=mv.getMemEmail()%>
<!-- 							<span class="glyphicon glyphicon-cog"></span> -->
							</div>
							<br>
							<div class="text-wrapper-3"><%=nickName%>
								<button type="button" class="btn btn-default" data-toggle="modal"
							data-target="#nicModal">
<!-- 							<span class="glyphicon glyphicon-cog"></span> -->
								<img style="width: 30px" alt="" src="images/icons/icon-settings-gray.png">
							</button>
							</div>
						</div>
						<br>
						<p class="p"><%=intro %>
						
							<button type="button" class="btn btn-default" data-toggle="modal"
							data-target="#introModal">
								<img style="width: 30px" alt="" src="images/icons/icon-settings-gray.png">
							</button>
						</p>
					</div>
				</div>
        </div>
        
 <!-- 모달 창 -->
<div id="modal" class="modal">
    <div class="modal-content" style="max-width: 676.09px; width: 100%;">
        <!-- 모달 내용 -->
        <div class="modal-profile" id="modal-profile"></div>
        <div class="modal-btns-container">
            <!-- Updated form with styled file input and button -->
            <form id="fileUploadForm" enctype="multipart/form-data">
                <div class="input-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="fileInput" name="file">
                        <label class="custom-file-label" for="fileInput">파일 선택</label>
                    </div>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-dark" onclick="uploadFile()">업로드</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="imageUploadModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">프로필 변경</h4>
            </div>
            <div class="modal-body">
                <form id="profileUploadForm" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="profileImage">프로필 이미지 선택</label>
                        <input type="file" class="form-control-file" id="profileImage" name="profileImage">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="uploadProfileImage()">업로드</button>
                </form>
                <div id="uploadedImageContainer">
                    <!-- 프로필 이미지를 표시하기 위해 profileImgPath 변수 사용 -->
                    <img id="profileImage" src="./../images/pf/<%=mempStreNm%>" alt="프사"
                        class="img-circle" width="150">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 이하 생략 -->

<div class="modal fade" id="nicModal" role="dialog" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <!-- 중앙에 위치하는 모달 내용 -->
        <div class="modal-content">
				<div class="modal-header">
					
				<div class="modal-body">
					<form id="nicForm">
						<div class="form-group">
							 <label for="newNic" style="font-size: 25px;">새로운 닉네임</label>
					<button type="button" class="close" data-dismiss="modal" >&times;</button>
					<textarea class="form-control" rows="4"
								class="form-control" id="newNic" name="newNic"></textarea>
							<!-- required 속성 추가: 사용자가 입력하지 않으면 submit이 되지 않도록 합니다. -->
						</div>
						<button type="button" class="btn btn-primary"
							onclick="submitNic()" style="font-size: 14px; padding: 10px 15px;">등록</button>
					</form>
				</div>
				</div>
			</div>
		</div>
	</div>       
        
 <!-- 소개글 수정 모달 -->
<div class="modal fade" id="introModal" role="dialog" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            <div class="modal-body">
                <form id="introForm">
                    <div class="form-group">
                        <label for="newIntro" style="font-size: 25px;">새로운 소개글</label>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <textarea class="form-control" rows="4" id="newIntro" name="newIntro"></textarea>
                    </div>
                  <button type="button" class="btn btn-primary" onclick="submitIntro()" style="font-size: 14px; padding: 10px 15px;">등록</button>

                </form>
            </div>
            </div>
        </div>
    </div>
</div>

<!-- 모달 추가 -->
<div class="modal fade" id="settingsModal" role="dialog" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#passwordChangeModal" data-dismiss="modal" style="font-size: 14px; padding: 10px 15px;">비밀번호 변경</button>
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#confirmWithdrawalModal" data-dismiss="modal" style="font-size: 14px; padding: 10px 15px;">회원 탈퇴</button>
            </div>
        </div>
    </div>
            </div>
</div>

<!-- 비밀번호 변경 모달 추가 -->
<div class="modal fade" id="passwordChangeModal" role="dialog" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            <div class="modal-body">
                <form id="passwordChangeForm">
                    <div class="form-group">
                        <label for="currentPassword" style="font-size: 25px;">현재 비밀번호</label>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword" style="font-size: 25px;">새로운 비밀번호</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="changePassword()" style="font-size: 14px; padding: 10px 15px;">변경</button>
                </form>
            </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="confirmWithdrawalModal" role="dialog" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">회원 탈퇴 확인</h4>
                <button type="button" class="close" data-dismiss="modal" style="font-size: 14px; padding: 10px 15px;">&times;</button>
            </div>
            <div class="modal-body">
                <form id="confirmWithdrawalForm">
                    <div class="form-group">
                        <label for="email" style="font-size: 25px;">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password" style="font-size: 25px;">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="button" class="btn btn-danger" onclick="confirmWithdrawal()" style="font-size: 14px; padding: 10px 15px;">확인</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="font-size: 14px; padding: 10px 15px;">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>





<!-- 이미지 업로드 모달 -->
<script>
var memId = '<%= (mv!= null) ? mv.getMemId() : "" %>';

function uploadFile() {
    var formData = new FormData($('#fileUploadForm')[0]);

    $.ajax({
        type: 'POST',
        url: '/FilmSquare/pfSet.do?memId=' + memId,
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: '프로필 이미지가 성공적으로 변경되었습니다.',
                    showConfirmButton: false,
                    timer: 2000
                });
                $('#fileUploadModal').modal('hide');
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
            	 Swal.fire({
                     icon: 'success',
                     title: '프로필 이미지가 성공적으로 변경되었습니다.',
                     showConfirmButton: false,
                     timer: 2000
                });
            }
        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
    setTimeout(function () {
        location.reload();
    }, 3500);
}
function setBasicImage() {
    // 기본 이미지 경로
    var basicImagePath = "../../images/icons/user-basic.png";

    // 프로필 이미지를 기본 이미지로 변경
    $('#modal-profile').css('background-image', 'url("' + basicImagePath + '")');

    // 파일 선택 input 초기화
    $('#fileInput').val('');
}
function uploadProfileImage() {
    var formData = new FormData($('#profileUploadForm')[0]);
    var fileInput = $('#profileImageFile')[0];
    var files = fileInput.files;

    if (files.length > 0) {
        formData.append('profileImageFile', files[0]);

        if (memId == null || memId.trim() === '') {
            console.error('유효하지 않은 memId입니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '/FilmSquare/pfSet.do?memId=' + memId,
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                if (response.success) {
                    Swal.fire({
                        icon: 'success',
                        title: '프로필 이미지가 성공적으로 변경되었습니다.',
                        showConfirmButton: false,
                        timer: 2000
                    });
                    $('#profileImageModal').modal('hide');
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                	Swal.fire({
                        icon: 'success',
                        title: '프로필 이미지가 성공적으로 변경되었습니다.',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            },
            error: function (error) {
                console.error('에러 발생:', error);
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: '파일을 선택하세요.',
            showConfirmButton: false,
            timer: 2000
        });
    }
    setTimeout(function () {
        location.reload();
    }, 3500);
}

function submitNic() {
    var newNic = $('#newNic').val();

    if (memId == null || memId.trim() === '') {
        console.error('유효하지 않은 memId입니다.');
        return;
    }

    $.ajax({
        type: 'POST',
        url: '/FilmSquare/updateNic.do',
        data: {
            newNic: newNic,
            memId: memId
        },
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: '닉네임이 성공적으로 수정되었습니다.',
                    showConfirmButton: false,
                    timer: 2000
                });
                $('#nicModal').modal('hide');
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
                Swal.fire({
                    icon: 'success',
                    title: '닉네임이 성공적으로 수정되었습니다.',
                    showConfirmButton: false,
                    timer: 2000
                });
                $('#nicModal').modal('hide');
                setTimeout(function () {
                    location.reload();
                }, 2000);
            }
        },
        error: function (error) {
            console.error('에러 발생:', error);
        }
    });
    setTimeout(function () {
        location.reload();
    }, 2000);
}

function submitIntro() {
    var newIntro = $('#newIntro').val();

    if (memId == null || memId.trim() === '') {
        console.error('유효하지 않은 memId입니다.');
        return;
    }

    $.ajax({
        type: 'POST',
        url: '/FilmSquare/updateIntro.do',
        data: {
            newIntro: newIntro,
            memId: memId
        },
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: '소개글이 성공적으로 수정되었습니다.',
                    showConfirmButton: false,
                    timer: 2000
                });
                $('#introModal').modal('hide');
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
            	 Swal.fire({
                     icon: 'success',
                     title: '소개글이 성공적으로 수정되었습니다.',
                     showConfirmButton: false,
                     timer: 2000
                 });
                 $('#introModal').modal('hide');
                 setTimeout(function () {
                     location.reload();
                 }, 2000);
            }
        },
        error: function (error) {
            console.error('에러 발생:', error);
        }
    });
    setTimeout(function () {
        location.reload();
    }, 2000);
}



function changePassword() {
    var memId = '<%= (mv != null) ? mv.getMemId() : "" %>';
    var currentPassword = $('#currentPassword').val();
    var newPassword = $('#newPassword').val();

    $.ajax({
        type: 'POST',
        url: '/FilmSquare/passChange.do',
        data: {
            memId: memId,
            memPw: currentPassword,
            newPassword: newPassword
        },
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: '비밀번호가 성공적으로 변경되었습니다.'
                });
                $('#passwordChangeModal').modal('hide');
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인하세요.'
                });
                $('#passwordChangeModal').modal('hide');
            }
        },
        error: function (error) {
            console.error('Error:', error);
            Swal.fire({
                icon: 'error',
                title: '서버 오류 발생. 콘솔을 확인하세요.'
            });
            $('#passwordChangeModal').modal('hide');
        }
    });
    setTimeout(function () {
        location.reload();
    }, 2000);
}

function confirmWithdrawal() {
    Swal.fire({
        title: '정말로 회원 탈퇴하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '네',
        cancelButtonText: '아니오'
    }).then((result) => {
        if (result.isConfirmed) {
            withdrawal();
        }
    });
}

function withdrawal() {
    var memId = '<%= (mv != null) ? mv.getMemId() : "" %>';
    var email = $('#email').val();
    var password = $('#password').val();

    $.ajax({
        type: 'POST',
        url: '/FilmSquare/delete.do',
        data: {
            memId: memId,
            memPw: password,
            memEmail: email
        },
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: '회원 탈퇴가 성공적으로 처리되었습니다.'
                });
                $('#confirmWithdrawalModal').modal('hide');
                setTimeout(function () {
                    window.location.href = '/FilmSquare/main.do';
                }, 2000);
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '회원 탈퇴에 실패했습니다. 이메일과 비밀번호를 확인하세요.'
                });
                $('#confirmWithdrawalModal').modal('hide');
            }
        },
        error: function (error) {
            console.error('Error:', error);
            $('#confirmWithdrawalModal').modal('hide');
        }
    });
    setTimeout(function () {
    	window.location.href = '/FilmSquare/main.do';
    }, 2000);
    
}


// 모달 띄우기 함수
function showModal(modalId) {
    $('#' + modalId).modal('show');
}

// 모달 닫기 함수
function closeModal(modalId) {
    $('#' + modalId).modal('hide');
}
</script>

        
        
        <div class="frame-6">
          <p class="element">
            <!-- 영화 수 뽑기 -->
            <%
            int watchedMovieNum = memService.getWatchedMovieNum(mv.getMemId());
            int rank = memService.getMemberRank(mv);
            int gradeCount = memService.getGradeCount(mv);
            int commentCount = memService.getCommentCount(mv);
            int collCount = memService.getCollCout(mv);
            String rankingPer = 100-(rank/10) + "";
            if(mv.getMemId().equals("61")){
            	rankingPer = "1.26";
            }
            %>
          
            <span class="span">지금까지 <%=watchedMovieNum %>편의 영화를 감상했습니다. </span>
            <span class="text-wrapper-5">필름 스퀘어 상위 <%=rankingPer%>%</span>
          </p>
          <div class="frame-7">
            <p class="element-2">
              <span class="text-wrapper-6"><%=gradeCount %><br /></span> <span class="text-wrapper-7">평가</span>
            </p>
            <p class="element-2">
              <span class="text-wrapper-6"><%=commentCount %><br /></span> <span class="text-wrapper-7">코멘트</span>
            </p>
            <p class="element-2">
              <span class="text-wrapper-6"><%=collCount %><br /></span> <span class="text-wrapper-7">컬렉션</span>
            </p>
          </div>
        </div>
        
        
        
        
        <div class="frame-8">
          <div class="text-wrapper-8">MY RATE</div>
          <div class="frame-9">
          
<!--       점수 준 영화 목록 -->
          
            <div class="frame-10">
              <div class="text-wrapper-9"></div>
              <div class="frame-11">
                <%
                List<GradeVOforYE> gradeList = gradeService.getGradeList(new MvGradeVO(mv.getMemId(),8));
                int cnt = 0;
                for(int i=0; (i<gradeList.size() && cnt++<10); i++){ 
                	GradeVOforYE grade = gradeList.get(i);                	
            		PosterVO poster = posterService.getPosterByMvId(grade.getMvId().intValue());
            		if(poster==null) cnt--;
                %>
                <a class="frame-12" href="<%=request.getContextPath() %>/movieDetail.do?mvId=<%=grade.getMvId().intValue() %>" style="background-image: url(<%=poster.getPosterImg()%>)"></a>
                <% } %>
              </div>
            </div>
            
            
            
            
<!--            그래프  -->
            
            <div class="frame-17">
            
            <%
            	int countMostCommonGrade = gradeService.countMostCommonGrade(new MvGradeVO(mv.getMemId(),0));
            
            	for(int i=1; i<=10; i++) {
            		int rate= (int)((double)gradeService.countAGrade(new MvGradeVO(mv.getMemId(),i))/(double)countMostCommonGrade*500 + 20);
            %>
            
              <div class="frame-18" id="graph<%=i%>" style="height: <%=rate%>px">
                <div class="text-wrapper-10"></div>
                <div class="frame-19">  </div>
              </div>
              
             <% } %>
              
              
              
            </div>
          </div>
        </div>
        
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function () {
    // 초기에 i가 8인 값에 대한 스타일 설정
    $("#graph8 .frame-19").addClass("clicked");
    $("#graph8 .text-wrapper-10").text(4);
    
    $(".frame-18").on('click', function () {
    	
        var selectedGrade = this.id.replace("graph", "");
//     	alert(selectedGrade);
        $(".frame-10 .text-wrapper-9").text( (selectedGrade / 2) + "점 준 영화들");

        // 모든 frame-19에 대한 스타일 초기화
        $(".frame-19").removeClass("clicked");
        $(".text-wrapper-10").text(" ");

        // 클릭한 frame-11의 frame-12에 스타일 추가
        $(this).find(".frame-19").addClass("clicked");

        $(this).find(".text-wrapper-10").text((selectedGrade/2));

        // Ajax 요청
        $.ajax({
            type: "POST",
            url: "/FilmSquare/mypage.do", // 서블릿의 URL로 변경 !!!!!!!!!!!!!
            data: {
            	selectedGrade: selectedGrade,
            	mypagemember: 61	
            	},
            success: handleRateResponse,
            error: function (error) {
                console.error("에러 발생:", error);
            }
        });
//     	alert(selectedGrade);
    });
    
    $(".graph8 .text-wrapper-10").text("4");
    $(".frame-10 .text-wrapper-9").text("4점 준 영화들");
    
});

// 서버 응답 처리
function handleRateResponse(response) {
	
	
    // 서버로부터 받은 응답을 JSON으로 파싱
    var posterList = JSON.parse(response);
    
// 	alert("handleServerResponse / posterList : " + posterList.length );

    // frame-11 엘리먼트 선택
    var frame11Element = $(".frame-11");

    // 기존의 frame-12 엘리먼트들 제거
    frame11Element.find(".frame-12").remove();

    var frame12Html = "";
    // 새로운 frame-12 엘리먼트들 추가
    for (var i = 0; i < posterList.length; i++) {
        var poster = posterList[i];
        var posterImg = poster.posterImg;
        var mvId = poster.mvId;
//         alert("posterImg: " + posterImg + "\nmvId: " + mvId);
        frame12Html += '<a class="frame-12" href="/FilmSquare/movieDetail.do?mvId='+mvId+'" style="background-image: url(' + posterImg + ')"></a>';
    }
    frame11Element.append(frame12Html);
//     alert(frame12Element);
}
</script>
        
<%
	Calendar cal = Calendar.getInstance();
	
	// 시스템 오늘 날짜
	int ty = cal.get(Calendar.YEAR);
	int tm = cal.get(Calendar.MONTH) + 1;
	int td = cal.get(Calendar.DATE);
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
	// 날짜마다 대표 포스터 담아줄 map 객체
	Map<LocalDate, PosterVO> posterMap = new HashMap<>();
// 	List<Integer> mvIdList = movieService.getWatchedList(new MvGradeVO(mem.getMemId(),));
	
	
	
%>        
            
            
            
<script>
$(document).ready(function () {
	
	  // 문서가 준비되었을 때 실행될 코드

	  // 현재 날짜를 가져옴
	  var currentDate = new Date();
	  changeMonth(0);

	  // 달력 업데이트 함수 호출

	  // 이전 달 버튼 클릭 이벤트 핸들러 등록
	  $(".btn-before").on('click', function () {
	    changeMonth(-1); // 한 달 이전으로 변경
	  	
	    
	  });

	  // 다음 달 버튼 클릭 이벤트 핸들러 등록
	  $(".btn-after").on("click", function () {
	    changeMonth(1); // 한 달 다음으로 변경
	  });
	  
	  // 날짜 클릭 이벤트 핸들러
	  document.getElementById('calendarBody').addEventListener('click', function(event) {
		    var clickedElement = event.target;

		    // 클릭된 엘리먼트가 frame-34 클래스를 가지고 있는지 확인
		    if (clickedElement.classList.contains('frame-34')) {
		        // 클릭된 엘리먼트에 대한 처리를 여기에 추가
		        // 예: alert('클릭된 엘리먼트 ID: ' + clickedElement.id);
		        // 여기에 원하는 동작을 추가
// 		        alert('클릭된 frame-34 엘리먼트 ID: ' + clickedElement.id);
	  			changeDateSection(clickedElement.id);
		    }
		});

	  
});

	function handleMyCalResponse(response) {
    	
// 		alert("handleMyCalResponse");
    	var paramMap = JSON.parse(response);
    	
    	var myMovieMap = paramMap["myMovieMap"];
    	var year = paramMap["year"];
    	var month = paramMap["month"];
    	var date = paramMap["date"];
//     	alert(date);
    	updateCalendar(new Date(year, month),myMovieMap);
		
	}
	
    // 월 텍스트 변경
	function parseMonthText(monthText) {
	  var parts = monthText.split('.');
	  var year = parseInt(parts[0]);
	  var month = parseInt(parts[1]) - 1; // 월은 0부터 시작하므로 1을 빼줍니다.
	  return new Date(year, month);
	}

    // 달력 업데이트
    function updateCalendar(date,myMovieMap) {
    	
    	for (var key in myMovieMap) {
    	    if (myMovieMap.hasOwnProperty(key)) {
//     	        alert("마이무비맵 키: " + key);
    	    }
    	}
    	
        var year = date.getFullYear();
        var month = date.getMonth();
        var firstDay = new Date(year, month-1, 1);
        var lastDay = new Date(year, month, 0);
        var daysInMonth = lastDay.getDate();
        var startingDay = firstDay.getDay(); // 0부터 시작하는 인덱스
        
// 		alert("firstDay : "+firstDay + "/ lastDay : " + lastDay
// 				 + "/ daysInMonth : " + daysInMonth + "/ startingDay : " + startingDay);
        

// 		firstDay : Mon Jan 01 2024 00:00:00 GMT+0900 (한국 표준시)/ lastDay : Wed Jan 31 2024 00:00:00 GMT+0900 (한국 표준시)
// 		daysInMonth : 31/ startingDay : 1
        
        var calendarBody = document.getElementById('calendarBody');
        calendarBody.innerHTML = ''; // 이전 콘텐츠 지우기

        var weekBlock = document.createElement('div');
        weekBlock.className = 'frame-32';
        
        // 1일 이전의 빈 셀 삽입
        for (var i = 0; i < startingDay; i++) {
          var emptyCell  = document.createElement('div');
          emptyCell .className = 'frame-34';
          weekBlock.appendChild(emptyCell);
        }

        // 각 날짜에 대한 셀 삽입
        for (var i = 1; i <= daysInMonth; i++) {
          var cell = document.createElement('div');
          cell.className = 'frame-34';
//           alert(year + '-' + month + '-' + i);
          cell.id = year + '-' + month + '-' + i; // ID 설정
          
          var textWrapper = document.createElement('div');
          textWrapper.className = 'text-wrapper-13';
          textWrapper.innerText = i;
          cell.appendChild(textWrapper);
          
       // 이미지 URL이 있는 경우 백그라운드 이미지로 설정
          if (myMovieMap && myMovieMap.hasOwnProperty(cell.id)) {
        	  var myMovieList = myMovieMap[cell.id];
//         	  alert(i+"."+myMovieList.length);
        	  for( var j=0; j<myMovieList.length; j++){
        		  var myMovie = myMovieList[j];
        		  var poster = myMovie.posterImg;
        		  if(poster == null) continue;
        		  cell.innerHTML = '';
		          cell.style.backgroundImage = 'url("' + poster + '")';
        	  }
          }
          weekBlock.appendChild(cell);
// 	        alert(i+".daycell");
          
          
       	// 각 주의 시작일마다 frame-32 추가
          if ((i + startingDay) % 7 === 0) {
// 	        alert(i+".monday");
            calendarBody.appendChild(weekBlock);
           	weekBlock = document.createElement('div');
            weekBlock.className = 'frame-32';
          }
        }
        // 마지막 주의 남은 빈 셀 채우기
        var remainingDays = 7 - (daysInMonth + startingDay) % 7;
        for (var i = 0; i < remainingDays; i++) {
          var emptyCell = document.createElement('div');
          emptyCell.className = 'frame-34';
          weekBlock.appendChild(emptyCell);
        }

        // 마지막 주 추가
//         alert("마지막 주 추가");
        calendarBody.appendChild(weekBlock);
        
      }

    // 월 변경
	function changeMonth(offset) {
//     	alert(offset);

		//초기 연월 설정
		var initialMonthText = document.getElementById('currentMonth').innerText;
		var currentDate = parseMonthText(initialMonthText);
		currentDate.setMonth(currentDate.getMonth() + offset);
// 		alert(currentDate);

		  // 현재 날짜 이후로는 넘어가지 않도록 제한
		  var today = new Date();
		  if (currentDate > today) {
		    currentDate = today;
		  }
		    
		var year = currentDate.getFullYear();
		var month = (currentDate.getMonth() + 1).toString(); 
		
// 		alert(year + "." +month);
		      
		// Ajax 요청
	        $.ajax({
	            type: "POST",
	            url: "/FilmSquare/myCal.do",
	            data: {
	            	mypyear: year,
	            	mypmonth: month,
	            	mypagemember: 61
	            	},
	            success: handleMyCalResponse,
	            error: function (error) {
	                console.error("에러 발생:", error);
	            }
	        });
// 		  alert("!!!!");
		  updateMonthText(currentDate);
	}

    // 월 텍스트 변경
    function updateMonthText(date) {
      var year = date.getFullYear();
      var month = (date.getMonth() + 1).toString().padStart(2, '0');
      document.getElementById('currentMonth').innerText = year + '.' + month;
    }

</script>
            
        <div class="frame-29">
          <div class="text-wrapper-11">MOVIE CALENDAR</div>
          <div class="frame-30">
            <div class="frame-wrapper">
            
              <div class="frame-10 calendar-section">
              
              
                <div class="frame-31 calendar-year-month">
                  <img class="btn-before" src="${pageContext.request.contextPath}/images/icons/icon-before.png"/>
                  <div class="text-wrapper-12" id="currentMonth"><%=year%>. <%=month%></div>
                  <img class="btn-after" src="${pageContext.request.contextPath}/images/icons/icon-after.png"/>
                </div>
                
                <div id="calendarBody"></div>

             </div>
            </div>
            
            
            
            
<script>
function changeDateSection(id){
	var selectedDate = parseIdText(id);
	var year = selectedDate.getFullYear();
	var month = (selectedDate.getMonth() + 1).toString();
	var date = selectedDate.getDate();

	var textWrapper14 = document.getElementById('whenUSee');
	textWrapper14.innerText = year + ". " + month + ". "+date+" 에 본 영화들";
	
	// Ajax 요청
    $.ajax({
        type: "POST",
        url: "/FilmSquare/myCal.do",
        data: {
        	mypyear: year,
        	mypmonth: month,
        	mypdate: date,
        	mypagemember: 61
        	},
        success: handleMyCalDate,
        error: function (error) {
            console.error("에러 발생:", error);
        }
    });
}

function handleMyCalDate(response){
	var paramMap = JSON.parse(response);
	
	var myMovieMap = paramMap["myMovieMap"];
	var year = paramMap["year"];
	var month = paramMap["month"];
	var date = paramMap["date"];
	var key = year+"-"+month+"-"+date
	
	var myMovieList = myMovieMap[key];
	
	updateDateSection(year,month,date,myMovieList);
}

function updateDateSection(year,month,date,myMovieList) {
	
	var watchedMovieByDate = document.getElementById('watchedMovieByDate');
	watchedMovieByDate.innerHTML = ''; // 이전 콘텐츠 지우기
	
	for(var i=0; i<myMovieList.length; i++){
		
		var myMovie = myMovieList[i];
        
		var movieBlock = document.createElement('div');
		movieBlock.className = 'frame-37';
		
        var poster = '${pageContext.request.contextPath}/images/icons/alterPoster.png';
		if(poster) poster = myMovie.posterImg;
			
		var posterBlock = document.createElement('a');
		posterBlock.className = 'frame-38';
		posterBlock.style.backgroundImage = 'url("' + poster + '")';
		posterBlock.href = "/FilmSquare/movieDetail.do?mvId="+myMovie.mvId;
		movieBlock.appendChild(posterBlock);
		
		
		var movieInfoBlock = document.createElement('div');
		movieInfoBlock.className = 'movie-info';
		
		
		var frame39 = document.createElement('div');
		frame39.className = 'frame-39';
		
		var titleBlock = document.createElement('div');
		titleBlock.className = 'movie-title';
		var titletextBlock = document.createElement('div');
		titletextBlock.className = 'text-wrapper-15';
		titletextBlock.innerText = myMovie.mvTitle;
		titleBlock.appendChild(titletextBlock);

		
		var gradeBlock = document.createElement('div');
		gradeBlock.className = 'movie-grade';
		var star = document.createElement('img');
		star.className = 'star';
		star.src='${pageContext.request.contextPath}/images/icons/Star.png';
		var tW16 = document.createElement('div');
		tW16.className = 'text-wrapper-16';
		var grade = '아직 평점을 등록하지 않았습니다.';
		if(myMovie.mvGrade) grade = (myMovie.mvGrade)/2;
		tW16.innerText = grade;
		gradeBlock.appendChild(star);
		gradeBlock.appendChild(tW16);
		
		var movieDetail = document.createElement('div');
		movieDetail.className = 'movie-detail';

		var tw17 = document.createElement('div');
		tw17.className = 'text-wrapper-17';
		var comment = '아직 코멘트를 등록하지 않았습니다.'
		if(myMovie.mvComment) comment = myMovie.mvComment;  
		tw17.innerText = comment;

		movieDetail.appendChild(tw17);
		frame39.appendChild(gradeBlock);
		movieInfoBlock.appendChild(titleBlock);
		movieInfoBlock.appendChild(frame39);
		movieInfoBlock.appendChild(movieDetail);
		movieBlock.appendChild(movieInfoBlock);
		watchedMovieByDate.appendChild(movieBlock);
// 		alert(myMovieList.length + "." + myMovie.mvTitle);


		
		
		
		watchedMovieByDate.appendChild(movieBlock);
		
	}
	
	
}

// 월 텍스트 변경
function parseIdText(id) {
  var parts = id.split('-');
  var year = parseInt(parts[0]);
  var month = parseInt(parts[1]) - 1; // 월은 0부터 시작하므로 1을 빼줍니다.
  var date = parts[2];
  return new Date(year, month, date);
}

</script>
            <div class="frame-10" id="datesection">
              <p class="text-wrapper-14" id="whenUSee">2024. 1. 22 에 본 영화들</p>
              <div class="frame-36" id="watchedMovieByDate">
              </div>
            </div>
          </div>
        </div>
        
        
<!--         월별통계 -->

<script>
$(document).ready(function () {
	
	  // 문서가 준비되었을 때 실행될 코드

	  // 현재 날짜를 가져옴
	  var currentDate = new Date();
// 	  alert("!!");
	  setRateSection(0);
	  
	  // 이전 달 버튼 클릭 이벤트 핸들러 등록
	  $(".rate-before").on('click', function () {
// 		  alert("click / rate-before");
		  setRateSection(-1); // 한 달 이전으로 변경
	  	
	    
	  });

	  // 다음 달 버튼 클릭 이벤트 핸들러 등록
	  $(".rate-after").on('click', function () {
// 		  alert("click / rate-after");
		  setRateSection(1); // 한 달 다음으로 변경
	  });	  


	  
});

function setRateSection(offset) {
	//초기 연도 설정
	var yearElem = document.getElementById("rate-month");
// 	alert("!!");
	var year = parseInt(yearElem.innerText)+offset;
	var today = new Date();
	
	if(year > today.getFullYear()){
		year=today.getFullYear();
	}
	
	setYear(year);
	
// 	alert(year);
	// Ajax 요청
    $.ajax({
        type: "POST",
        url: "/FilmSquare//myrate.do",
        data: {
        	mypyear: year,
        	mypagemember: 61
        	},
        success: handleMyRateResponse,
        error: function (error) {
            console.error("에러 발생:", error);
        }
    });	
	
}

function setYear(year) {
	
	var yearElem = document.getElementById('rate-month');
	yearElem.innerText = year;
	
}

function handleMyRateResponse(response) {
	
	

	var yearElem = document.getElementById('rate-month');
	var year = yearElem.innerText;
	
	
	var posterListMap = JSON.parse(response);
	
	var yearGraph = document.getElementById('yearGraph');
	yearGraph.innerHTML = ''; // 이전 콘텐츠 지우기
	
	for(var i=1; i<=12; i++){
// 		alert(year+"."+i);
		var posterList = posterListMap[year+"."+i];
		var aMonth = document.createElement('div');
		aMonth.className = 'frame-46';
		
		var monthText = document.createElement('div');
		monthText.className = 'text-wrapper-19';
		monthText.innerText = posterList.length;
		aMonth.appendChild(monthText);
		
		for(var p=0; p<posterList.length && p<10; p++){
			
			var poster = '${pageContext.request.contextPath}/images/icons/alterPoster.png';
			if(posterList[p])poster = posterList[p].posterImg;
			
			var posterDiv = document.createElement('div');
			posterDiv.className = 'frame-47';
			posterDiv.style.backgroundImage = 'url("' + poster + '")';
			aMonth.appendChild(posterDiv);
			
		}
		
		yearGraph.appendChild(aMonth);
			
	}
	
	
	
}

</script>
        
        <div class="div-wrapper">
          <div class="frame-42">
            <div class="frame-43">
              <div class="frame-44">
                <img class="vector-2 rate-before" src="${pageContext.request.contextPath}/images/icons/grey_before.png" />
                <div class="text-wrapper-18" id="rate-month">2024</div>
                <img class="vector-3 rate-after" src="${pageContext.request.contextPath}/images/icons/grey_after.png" />
              </div>
              <div class="text-wrapper-8">RATE</div>
            </div>
            
            <div class="frame-45" id="yearGraph">
            
            </div>
            <div class="frame-60">
              <div class="frame-61"><div class="text-wrapper-20">1</div></div>
              <div class="frame-61"><div class="text-wrapper-20">2</div></div>
              <div class="frame-61"><div class="text-wrapper-20">3</div></div>
              <div class="frame-61"><div class="text-wrapper-20">4</div></div>
              <div class="frame-61"><div class="text-wrapper-20">5</div></div>
              <div class="frame-61"><div class="text-wrapper-20">6</div></div>
              <div class="frame-61"><div class="text-wrapper-20">7</div></div>
              <div class="frame-61"><div class="text-wrapper-20">8</div></div>
              <div class="frame-61"><div class="text-wrapper-20">9</div></div>
              <div class="frame-61"><div class="element-3">10</div></div>
              <div class="frame-61"><div class="element-3">11</div></div>
              <div class="frame-61"><div class="element-3">12</div></div>
            </div>
          </div>
        </div>
        
<script>

$(document).ready(function () {
	
	  // 문서가 준비되었을 때 실행될 코드
	  
	// Ajax 요청
    $.ajax({
        type: "POST",
        url: "/FilmSquare/mycate.do",
        data: {
        	mypagemember: 61
        	},
        success: handleMyCateResponse,
        error: function (error) {
            console.error("에러 발생:", error);
        }
    });	
	  
});

function handleMyCateResponse(response) {
	
	var cateCountMap = JSON.parse(response);
	
	var countSum = cateCountMap["countSum"];
	var actionCount = cateCountMap["actionCount"];
	var dramaCount = cateCountMap["dramaCount"];
	var comedyCount = cateCountMap["comedyCount"];
	var melloCount = cateCountMap["melloCount"];
	var thrillerCount = cateCountMap["thrillerCount"];
	var fantasyCount = cateCountMap["fantasyCount"];
	var sfCount = cateCountMap["sfCount"];
	var horrorCount = cateCountMap["horrorCount"];
	var totalRTime = cateCountMap["totalRTime"];
	
	var actionRate = actionCount/countSum*100;
	var dramaRate = actionRate+dramaCount/countSum*100;
	var comedyRate = dramaRate+comedyCount/countSum*100;
	var melloRate = comedyRate+melloCount/countSum*100;
	var thrillerRate = melloRate+thrillerCount/countSum*100;
	var fantasyRate = thrillerRate+fantasyCount/countSum*100;
	var sfRate = fantasyRate+sfCount/countSum*100;
	var horrorRate = sfRate+horrorCount/countSum*100;
	
	var pieChart = document.createElement('div');
	pieChart.className = 'pie-chart';
	pieChart.style.background = 'conic-gradient('
								+ '#FF595E 0% '+actionRate+'%,'
								+'#FF924C '+actionRate+'% '+dramaRate+'%,'
								+'#FFCA3A '+dramaRate+'% '+comedyRate+'%,'
								+'#8AC926 '+comedyRate+'% '+melloRate+'%,'
								+'#52A675 '+melloRate+'% '+thrillerRate+'%,'
								+'#1982C4 '+thrillerRate+'% '+fantasyRate+'%,'
								+'#4267AC '+fantasyRate+'% '+sfRate+'%,'
								+'#6A4C93 '+sfRate+'% 100%)';

	var pieCenter = document.createElement('div');
	pieCenter.className = 'pie-center';
	pieChart.appendChild(pieCenter);
	
	var chartContainer = document.getElementById('chart');
// 	alert("!!!!");
	chartContainer.appendChild(pieChart);

	var textIndex = document.getElementById('cate-action');
	textIndex.innerText = "액션  " + (actionCount/countSum*100).toFixed(2) + "%";
	
	textIndex = document.getElementById('cate-drama');
	textIndex.innerText = '드라마  '+ (dramaCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-comedy');
	textIndex.innerText = '코미디  '+ (comedyCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-mello');
	textIndex.innerText = '멜로  '+ (melloCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-thriller');
	textIndex.innerText = '스릴러  '+ (thrillerCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-fantasy');
	textIndex.innerText = '판타지  '+ (fantasyCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-sf');
	textIndex.innerText = 'SF  '+ (sfCount/countSum*100).toFixed(2) +'%';
	
	textIndex = document.getElementById('cate-horror');
	textIndex.innerText = '공포  '+ (horrorCount/countSum*100).toFixed(2) +'%';
	
	var totalTime = document.getElementById('total-time');
	var lifeSpan = document.getElementById('life-span');
	
	totalTime.innerText = '지금까지 총 ' + addCommasToNumber(totalRTime) + '분 동안 영화를 봤어요';
	
	var levelSection = document.getElementById('levels1');

	var maxLevel = document.querySelector('.max-level');
	
	if(totalRTime>=1440){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/mayfly.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.1 하루살이<br /></span>"
			+"<span class='text-wrapper-26'>1,440분</span>"
			+"</p></div>";
			levelSection.appendChild(mayfly);
		lifeSpan.innerText="하루살이의 수명을 이겼어요!";
		maxLevel.src="images/icons/mayfly.png";
// 		alert("lv1");
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=20160){
// 		alert("lv2");
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/bee.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.2 꿀벌<br /></span>"
			+"<span class='text-wrapper-26'>20,160분</span>"
			+"</p></div>";
			levelSection.appendChild(mayfly);
			lifeSpan.innerText="꿀벌의 수명을 이겼어요!";
			maxLevel.src="images/icons/bee.png";
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=40320){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/butterfly.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.3 나비<br /></span>"
			+"<span class='text-wrapper-26'>40,320분</span>"
			+"</p></div>";
			lifeSpan.innerText="나비의 수명을 이겼어요!";
			levelSection.appendChild(mayfly);
			maxLevel.src="images/icons/butterfly.png";
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=80640){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/dragonfly.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.4 잠자리<br /></span>"
			+"<span class='text-wrapper-26'>80,640분</span>"
			+"</p></div>";
			lifeSpan.innerText="잠자리의 수명을 이겼어요!";
			levelSection.appendChild(mayfly);
			maxLevel.src="images/icons/dragonfly.png";
	}else {
		addBlank(levelSection);
	}
	
	levelSection = document.getElementById('levels2');
	
	if(totalRTime>=161280){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/ant.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.5 개미<br /></span>"
			+"<span class='text-wrapper-26'>161,280분</span>"
			+"</p></div>";
			lifeSpan.innerText="개미의 수명을 이겼어요!";
			levelSection.appendChild(mayfly);
			maxLevel.src="images/icons/icon-ant.png";
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=322560){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/ant.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.5 개미<br /></span>"
			+"<span class='text-wrapper-26'>161,280분</span>"
			+"</p></div>";
			levelSection.appendChild(mayfly);
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=645120){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/ant.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.5 개미<br /></span>"
			+"<span class='text-wrapper-26'>161,280분</span>"
			+"</p></div>";
			levelSection.appendChild(mayfly);
	}else {
		addBlank(levelSection);
	}
	
	if(totalRTime>=900000){
		var mayfly = document.createElement('div');
		mayfly.className = 'overlap-group-wrapper'; 
		mayfly.innerHTML = "<div class='overlap-group'>"
			+"<img class='level-icon' src='${pageContext.request.contextPath}/images/icons/ant.png' />"
			+"<p class='lv'>"
			+"<span class='text-wrapper-25'>Lv.5 개미<br /></span>"
			+"<span class='text-wrapper-26'>161,280분</span>"
			+"</p></div>";
			levelSection.appendChild(mayfly);
	}else {
		addBlank(levelSection);
	}
	
}

function addBlank(levelSection){
	var frame70 = document.createElement('div');
	frame70.className = 'frame-70';
	frame70.innerHTML = "<div class='text-wrapper-27'>?</div>";
	levelSection.appendChild(frame70);
}

function addCommasToNumber(number) {
    // 숫자를 문자열로 변환
    let numStr = number.toString();

    // 정규식을 사용하여 세 자리마다 쉼표 삽입
    numStr = numStr.replace(/\B(?=(\d{3})+(?!\d))/g, ',');

    return numStr;
}



</script>
        
        <div class="frame-29-1">
          <div class="frame-62">
            <div class="frame-63">
              <div class="text-wrapper-11">CATEGORY</div>
              <div class="frame-64">
                <div class="chart-wrapper" id="chart">
                </div>
                
                <div class="frame-65" id="category-index-container">
                  <div class="frame-66" id="categorization">
                    <div class="category-index">
                      <div class="color-index" style="background: #FF595E"></div>
                      <div class="index-text" id="cate-action">액션</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #FF924C"></div>
                      <div class="index-text" id="cate-drama">드라마</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #FFCA3A"></div>
                      <div class="index-text" id="cate-comedy">코미디</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #8AC926"></div>
                      <div class="index-text" id="cate-mello">멜로</div>
                    </div>
                    
                  </div>
                  <div class="frame-66" id="categorization">
                    <div class="category-index">
                      <div class="color-index" style="background: #52A675"></div>
                      <div class="index-text" id="cate-thriller">스릴러</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #1982C4"></div>
                      <div class="index-text" id="cate-fantasy">판타지</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #4267AC"></div>
                      <div class="index-text" id="cate-sf">SF</div>
                    </div>
                    <div class="category-index">
                      <div class="color-index" style="background: #6A4C93"></div>
                      <div class="index-text" id="cate-horror">공포</div>
                    </div>
                    
                  </div>
                    
                  </div>
                </div>
              </div>
            </div>
            
            <div class="frame-68">
              <img class="max-level" src="${pageContext.request.contextPath}/images/icons/dragonfly.png" />
              <p class="text-wrapper-24" id="total-time"></p>
              <p class="text-wrapper-24" id="life-span"></p>
              <div class="frame-69" id="levels">
	              <div class="frame-69-1" id="levels1"></div>
    	          <div class="frame-69-1" id="levels2"></div>
              
              
              
               
              </div>
            </div>
          </div>
        </div>
<!--         <div class="frame-71"> -->
<!--           <div class="frame-72"> -->
<!--             <div class="text-wrapper-28">좋아하는 컬렉션</div> -->
<!--             <div class="frame-73"> -->
<!--               <div class="frame-74"> -->
<!--                 <div class="frame-75"> -->
<!--                   <div class="frame-76"> -->
<!--                     <div class="frame-77"> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-79"></div> -->
<!--                         <div class="frame-80"></div> -->
<!--                       </div> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-81"></div> -->
<!--                         <div class="frame-82"></div> -->
<!--                       </div> -->
<!--                     </div> -->
<!--                     <div class="text-wrapper-29">오직 위시</div> -->
<!--                   </div> -->
<!--                   <div class="frame-76"> -->
<!--                     <div class="frame-77"> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-83"></div> -->
<!--                         <div class="frame-84"></div> -->
<!--                       </div> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-85"></div> -->
<!--                         <div class="frame-86"></div> -->
<!--                       </div> -->
<!--                     </div> -->
<!--                     <div class="text-wrapper-29">오직 위시</div> -->
<!--                   </div> -->
<!--                   <div class="frame-87"> -->
<!--                     <div class="frame-77"> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-88"></div> -->
<!--                         <div class="frame-89"></div> -->
<!--                       </div> -->
<!--                       <div class="frame-78"> -->
<!--                         <div class="frame-90"></div> -->
<!--                         <div class="frame-91"></div> -->
<!--                       </div> -->
<!--                     </div> -->
<!--                     <div class="text-wrapper-29">오직 위시</div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--             <div class="frame-74"> -->
<!--               <div class="frame-75"> -->
<!--                 <div class="frame-76"> -->
<!--                   <div class="frame-77"> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-92"></div> -->
<!--                       <div class="frame-93"></div> -->
<!--                     </div> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-94"></div> -->
<!--                       <div class="frame-95"></div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                   <div class="text-wrapper-29">오직 위시</div> -->
<!--                 </div> -->
<!--                 <div class="frame-76"> -->
<!--                   <div class="frame-77"> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-96"></div> -->
<!--                       <div class="frame-97"></div> -->
<!--                     </div> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-98"></div> -->
<!--                       <div class="frame-99"></div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                   <div class="text-wrapper-29">오직 위시</div> -->
<!--                 </div> -->
<!--                 <div class="frame-87"> -->
<!--                   <div class="frame-77"> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-100"></div> -->
<!--                       <div class="frame-101"></div> -->
<!--                     </div> -->
<!--                     <div class="frame-78"> -->
<!--                       <div class="frame-102"></div> -->
<!--                       <div class="frame-103"></div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                   <div class="text-wrapper-29">오직 위시</div> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class="frame-104"> -->
<!--             <div class="text-wrapper-28">좋아하는 인물</div> -->
<!--             <div class="frame-105"> -->
<!--               <div class="frame-106"> -->
<!--                 <div class="frame-107"></div> -->
<!--                 <div class="text-wrapper-30">권봄</div> -->
<!--               </div> -->
<!--               <div class="frame-106"> -->
<!--                 <div class="frame-108"></div> -->
<!--                 <div class="text-wrapper-30">권봄</div> -->
<!--               </div> -->
<!--               <div class="frame-106"> -->
<!--                 <div class="frame-109"></div> -->
<!--                 <div class="text-wrapper-30">권봄</div> -->
<!--               </div> -->
<!--               <div class="frame-106"> -->
<!--                 <div class="frame-110"></div> -->
<!--                 <div class="text-wrapper-30">권봄</div> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--         </div> -->
      </div>
    </div>

</body>
</html>