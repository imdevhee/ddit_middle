<%@page import="admin.vo.AdminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>에디터 게시판 작성</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
<!-- 부트스트랩 참조 영역 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
      crossorigin="anonymous">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha384-1H217gwSVyLSIfaLxHbE7dRb3v4mYCKbpQvzx0cegeju1MVsGrX5xXxAvs/HgeFs" crossorigin="anonymous"></script>

<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


</head>

<%
	AdminVO av = (AdminVO) session.getAttribute("LOGIN_ADMIN");
if (av == null) {
%>
	<script>
	
	alert("관리자 로그인을 해주세요.");
	console.log("관리자 로그인 해주세요.");
	
	</script>
<%
	response.sendRedirect(request.getContextPath() + "/admin");
	return;
}
%>

<style>
	.scroll {
  overflow: hidden;
}
	

</style>

<body>

<!-- 게시판 글쓰기 양식 영역 시작 -->
<div class="scroll container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <form method="post" action="editorInsert.do" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title text-center">에디터 게시판 글쓰기</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="ebTitle">제목</label>
                            <input type="text" class="form-control" id="ebTitle" name="ebTitle" maxlength="50">
                        </div>
                        <div class="form-group">
                            <label for="ebtContent">내용</label>
                            <textarea class="form-control" id="ebtContent" name="ebtContent" maxlength="2048" rows="5"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="ebImage">이미지 업로드</label>
                            <input type="file" id="ebImage" name="ebImage">
                        </div>
                        <div class="form-group">
                            <img id="previewImage" src="#" alt="이미지 미리보기" style="max-width: 100%; max-height: 140px; visibility: hidden;" >
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <button type="submit" class="btn btn-danger" style="background-color: black; color: white; border-radius: 0; border-color: white;">글쓰기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 게시판 글쓰기 양식 영역 끝 -->


<script>
//Fix the ID mismatch
$("#ebImage").change(function () {
    readURL(this);
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#previewImage').css('visibility', 'visible');
            $('#previewImage').attr('src', e.target.result);
            // Fix the ID mismatch and update the textarea content
            var currentContent = $('#ebtContent').val();
            var imageTag = '<img src="' + e.target.result + '" alt="이미지 미리보기" style="width: 100%; max-height: 140px;">';
//             $('#ebtContent').val(currentContent + '\n' + imageTag);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

</body>
</html>
