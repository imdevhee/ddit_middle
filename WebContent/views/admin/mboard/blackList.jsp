
<%@page import="admin.vo.AdminVO"%>
<%@page import="member.vo.MemberVO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	List<MemberVO> blackList =(List<MemberVO>)request.getAttribute("blackList");
	
	String msg = session.getAttribute("msg") == null ? ""
			: (String)session.getAttribute("msg");
	session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<%
	AdminVO av = (AdminVO) session.getAttribute("LOGIN_ADMIN");
if (av == null) {
%>
	<script>
	
	alert("관리자 로그인을 해주세요.");
	console.log("관리자 로그인을 해주세요.");
	
	</script>
<%
	response.sendRedirect(request.getContextPath() + "/admin");
	return;
}
%>
<meta charset="UTF-8">
<title>회원 조회</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
table {
/*   table-layout: fixed; */
}
table, th, tr {
  text-align: center;
}

th {
font-family: 'Roboto', sans-serif;
font-size: 18px;
}
body, h3 {
  font-family: 'Roboto', sans-serif;

}
#pageArea {
  display: flex;
  justify-content: center;
font-weight: bold;
}
 .paginatio {
    display: flex;

  }
  .modal-backdrop {
    opacity: 0 !important;
  }
  
 ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;

}
</style>
</head>
<body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<div class="container">
	<h1>블랙리스트</h1>
	<h3>정지된 회원 목록을 조회합니다.</h3>
<input class="form-control" id="myInput" type="text" placeholder="Search..">
  <br>

<!-- 리스트출력 영역 start -->
  <table class="table table-bordered table-striped">
    <thead>
      <tr>
			<th>순번</th>
			<th>이메일</th>
			<th>이름</th>
			<th>닉네임</th>
			<th>전화</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>신고건수</th>
			<th>관리</th>
		 </tr>
    </thead>
    <tbody id="myTable">

<%
	if(blackList.size()==0){
		
%>	
		<tr>
			<td colspan="9">회원 정보가 존재하지 않습니다.</td>
		
		</tr>
<%
	}else{
		
		for(int i=0; i<blackList.size(); i++){ 
		
%>		
		<tr>
			<td><%=blackList.get(i).getMemId() %></td>
			<td><%=blackList.get(i).getMemEmail() %></td>
			<td><%=blackList.get(i).getMemName() %></td>
			<td><%=blackList.get(i).getMemNcnm() %></td>
			<td><%=blackList.get(i).getMemTelno() %></td>
			<td><%=blackList.get(i).getMemBirth() %></td>
			<td><%=blackList.get(i).getMemMW() %></td>
			<%
	if(blackList.get(i).getReportCount() == 0) {
%>
			<td><%=blackList.get(i).getReportCount() %></td>
<%
	}else {
%>
			<td><a href="./blackList/detail.do?memId=<%=blackList.get(i).getMemId()%>"><%=blackList.get(i).getReportCount() %></a></td>
<%
	}
%>
			<td> <!-- 모달 버튼 -->
  <button type="button" class="btn btn-info btn-sm" style="background-color: black; color: white; border-radius: 0; border-color: white;" data-toggle="modal" data-target="#myModal<%=i %>" data-backdrop="static">수정</button></td>
		</tr>

<!-- 모달 영역 시작 -->
  <div class="modal fade" id="myModal<%=i %>" role="dialog">
    <div class="modal-dialog">
    
      <!-- 모달 컨텐츠 -->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">블랙리스트에서 삭제하시겠습니까?</h4>
        </div>
        <div class="modal-body">
          <!-- 예 버튼 -->
        <button type="button" class="btn btn-primary" style="background-color: black; color: white; border-radius: 0; border-color: white;" onclick="confirm(<%=blackList.get(i).getMemId() %>)">예</button>
        <!-- 아니오 버튼 -->
        <button type="button" class="btn btn-default" style="border-radius: 0;" data-dismiss="modal">아니오</button>
        </div>
        <!-- <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div> -->
      </div>
      
    </div>
  </div>
  

<%

		}
	}
%>
		</tbody>
  </table>
  
   <button type="button" class="btn btn-primary" onclick="redirectToMain()">홈으로</button>
  </div>
	 

	
	<!-- 페이징 영역 start -->		
	<div id="pageArea">
		

		  <div class="prev"><a href="#" class="w3-button">PREV</a></div>
		  <div class="paginatio">
		<%
			int sPage = (int)request.getAttribute("sPage");
			int ePage = (int)request.getAttribute("ePage");
			int cPage = (int)request.getAttribute("cPage");
	
			for(int i=sPage; i<=ePage; i++){
				//페이지번호 활성화 처리
				if(cPage == i){
		%>
		  <div class="active"><a href="#" class="w3-button w3-black"><%=i %></a></div>
		<%			
				}else{
		%>
		  <div><a href="#" class="w3-button"><%=i %></a></div>
		<%
				}
			}//for end %>
		</div>
				  <div class="next"><a href="#" class="w3-button">NEXT</a></div>

	
	
	</div>
	<!-- 페이징 영역 end -->		
</div>

<script>

function redirectToMain() {
    // 페이지 리디렉션
    window.location.href = '<%=request.getContextPath()%>/admin/main.do';
}


	//검색
	$(document).ready(function(){
	  $("#myInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#myTable tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
	});



	$('.paginatio div').on('click',function(){
// 		alert( $(this).text() );
		location.href="/FilmSquare/admin/mboard/blackList.do?page=" + $(this).text();
	});
	
	$('.next').on('click',function(){
// 		alert( parseInt($('.pagination').children().last().text()) +1 );
		currentPage = parseInt($('.paginatio').children().last().text()) +1;
		
		//현재 페이지가 totalPage보다 클때 페이지정보를 넘기지 않음
		if(<%=request.getAttribute("ttPage")%> < currentPage) return;
		location.href="/FilmSquare/admin/mboard/blackList.do?page=" + currentPage;
	});
	
	$('.prev').on('click',function(){
		
		currentPage = parseInt($('.paginatio').children().first().text()) -1;
		//현재페이지가 0보다 작거나 같을 때
		if(currentPage <= 0) return;
		location.href="/FilmSquare/admin/mboard/blackList.do?page=" + currentPage;
	});

	

	  // 모달
// 예 버튼을 클릭했을 때 실행되는 함수
function confirm(memId) {
    // 여기에 예 버튼을 클릭했을 때의 동작을 구현
    // 예를 들어, 어떤 작업을 수행하거나 서버로 요청을 보낼 수 있음
    console.log("memId값:", memId);

    // AJAX를 이용하여 서버로 요청을 보냅니다.
    $.ajax({
        type: 'POST',  // 또는 'GET' 등 HTTP 메소드 선택
        url: 'blackList/update.do',  // 서블릿의 URL
        data: { memId : memId },  // 전송할 데이터, 필요한 경우에 데이터 추가
        success: function(response) {
            // 서버에서의 응답에 따른 동작을 구현
            Swal.fire({
                icon: 'success',
                title: '정상적으로 처리되었습니다.'
            });

            // 모달을 닫습니다.
            $('#myModal').modal('hide');

            // 리스트 새로고침
            location.reload();
        },
        error: function(error) {
            // 에러 발생 시의 동작을 구현
            console.error("에러 발생: " + error);
        }
    });
}

</script>
	
	
	
	
	
	


	
<%-- <%
	if(msg.equals("성공")){
%>
<script>
	alert('정상적으로 처리되었습니다.');
</script>
<%
	}
%> --%>
</body>
</html>