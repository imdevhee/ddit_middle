 <h3><img src="<%=request.getContextPath()%>/images/logo_black.png" alt="회원가입"></h3>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color:  #000000;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            max-width: 400px;
            width: 100%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .search-title {
            background-color: #333;
            color: #fff;
            padding: 10px;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-search {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .find-name,
        .find-phone {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            width: 100%;
        }

        .btnSearch {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        input[type="button"] {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        input[type="button"]:hover {
            background-color: #45a049;
        }

        input[type="button"][name="cancel"] {
            background-color: #f44336;
        }

        input[type="button"][name="cancel"]:hover {
            background-color: #d32f2f;
        }
    </style>
  

    
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <div class="container">
        <div class="search-title">
            <h3>본인확인</h3>
        </div>
        <form action="/findEmail.jsp" name="memberfind" method="POST" class="form-search">
            <div class="find-name">
                <label for="memName">이름</label>
                <input type="text" id="memName" name="memName" placeholder="등록한 이름" required>
            </div>
            <div class="find-phone">
                <label for="memTelno">번호</label>
                <input type="text" id="memTelno" name="memTelno" placeholder="휴대폰 번호를 입력 (예: 010-1234-5678)" required>
            </div>
            <div class="btnSearch">
                <input type="button" name="enter" value="찾기" onClick="email_search()">
                <input type="button" name="cancel" value="취소" onClick="history.back()">
            </div>
        </form>
    </div>

    <script>
    function email_search() {
        var frm = document.memberfind;

        if (frm.memName.value.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: '이름을 입력해주세요',
            });
            return;
        }

        // 추가: 정규 표현식을 사용하여 유효한 휴대폰 번호인지 확인
        var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!phoneRegex.test(frm.memTelno.value.trim())) {
            Swal.fire({
                icon: 'error',
                title: '유효한 휴대폰 번호를 입력해주세요 (예: 010-1234-5678)',
            });
            return;
        }

        Swal.fire({
            icon: 'info',
            title: '처리 중',
            text: '이메일 찾는 중입니다...',
            showConfirmButton: false,
            allowOutsideClick: false,
        });

        // 1초 후에 SweetAlert를 닫고 폼을 제출한다.
        setTimeout(() => {
            Swal.close();
            frm.method = "post";
            frm.action = "../../findEmail.do";
            frm.submit();
        }, 1000); // 1000 밀리초 (1초)로 변경
    }

    </script>
 
    
</body>
</html>
