
<%@page import="admin.vo.AdminVO"%>
<%@page import="admin.vo.QnaVO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	List<QnaVO> unQnaList =(List<QnaVO>)request.getAttribute("unQnaList");
	
	String msg = session.getAttribute("msg") == null ? ""
			: (String)session.getAttribute("msg");
	session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미답변 문의 조회</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%
	AdminVO av = (AdminVO) session.getAttribute("LOGIN_ADMIN");
if (av == null) {
%>
	<script>
	
	alert("관리자 로그인을 해주세요."); //왜 안 뜨지...
	console.log("관리자 로그인을 해주세요.");
	
	</script>
<%
	response.sendRedirect(request.getContextPath() + "/admin");
	return;
}
%>
<style>
table {
/*   table-layout: fixed; */
}
table, th, tr {
  text-align: center;
}

.pager {
  float: left;
}
#pageArea {
  display: flex;
  justify-content: center;
}
</style>
</head>
<body>
<div class="container">
	<h1>미답변 문의 조회</h1>
	<h3>미답변 문의를 조회합니다.</h3>
 <input class="form-control" id="myInput" type="text" placeholder="Search..">
  <br>
  <table class="table table-bordered table-striped">
		    <thead>
		      <tr>
		        <th style="width: 10%">순번</th>
		        <th style="width: 35%">문의내용</th>
		        <th style="width: 15%">작성자 이메일</th>
		        <th style="width: 15%">작성일</th>
		        <th style="width: 15%">전체보기</a></th>
		        <th style="width: 15%">답변</a></th>
		      </tr>
		    </thead>
		    <tbody id="myTable">

		<%
	    	List<QnaVO> list = (List<QnaVO>)request.getAttribute("unQnaList");
	    	if(list != null){
		    	for(int i=0; i<list.size(); i++){
	    %>
	      <tr>
	        <td id=qaId><%=list.get(i).getQaId() %></td>
	        <td><%=list.get(i).getQaContent() %></td>
	        <td><%=list.get(i).getQaEmail() %></td>
	        <td><%=list.get(i).getQaDate() %></td>
	        <td><!-- 전체보기 모달 버튼 -->
  <button type="button" class="btn btn-info btn-sm"
    onclick="detail('<%=list.get(i).getQaTitle() %>', '<%=list.get(i).getQaContent() %>')">전체보기</button></td>
	      
	        <td><!-- 답변 모달 버튼 -->
  <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#answerModal<%=i %>" data-backdrop="static">답변</button></td>
	      </tr>
	      
	        
  <!-- 답변 모달 영역 시작 -->
  <div class="modal fade" id="answerModal<%=i %>" role="dialog">
    <div class="modal-dialog">
    
      <!-- 모달 컨텐츠 -->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">답변 등록</h4>
        </div>
        <div class="modal-body">
          <p id="qaAnswer"></p>
          <form id="answerForm">
          <div class="form-group">
            <textarea class="form-control" rows="4" id="answerText<%=i %>" name="answerText"></textarea>
          </div>
          <button type="button" class="btn btn-primary" onclick="submitAnswer(<%=list.get(i).getQaId() %>,$('#answerText<%=i %>').val())">등록</button>
        </form>
        </div>

      </div>
      
    </div>
  </div>
	      
	    <%
	    		}//for end
	    	}else{
	    %>
	    		<tr>
		          <td>게시물 없음</td>
		      	</tr>
		<%			      
	    	}
	    %>
	    </tbody>
	  </table>
	   <button type="button" class="btn btn-primary" onclick="redirectToMain()">홈으로</button>
  </div>
  
   <!-- 전체보기 모달 영역 시작 -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- 모달 컨텐츠 -->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="qaTitle"></h4>
        </div>
        <div class="modal-body">
          <p id="qaContent"></p>
        </div>

      </div>
      
    </div>
  </div>
  

  
  
  
	
	<!-- 페이징 영역 start -->		
	<div id="pageArea">
		
		<ul class="pager">
		  <li class="prev"><a href="#">Prev</a></li>
		</ul>
		
		<ul class="pagination pager">
		<%
			int sPage = (int)request.getAttribute("sPage");
			int ePage = (int)request.getAttribute("ePage");
			int cPage = (int)request.getAttribute("cPage");
	
			for(int i=sPage; i<=ePage; i++){
				//페이지번호 활성화 처리
				if(cPage == i){
		%>
		  <li class="active"><a href="#"><%=i %></a></li>
		<%			
				}else{
		%>
		  <li><a href="#"><%=i %></a></li>
		<%
				}
			}//for end %>
		</ul>
		
		<ul class="pager">
		  <li class="next"><a href="#">Next</a></li>
		</ul>
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


	$('.pagination li').on('click',function(){
// 		alert( $(this).text() );
		location.href="/FilmSquare/admin/qboard/unList.do?page=" + $(this).text();
	});
	
	$('.next').on('click',function(){
// 		alert( parseInt($('.pagination').children().last().text()) +1 );
		currentPage = parseInt($('.pagination').children().last().text()) +1;
		
		//현재 페이지가 totalPage보다 클때 페이지정보를 넘기지 않음
		if(<%=request.getAttribute("ttPage")%> < currentPage) return;
		location.href="/FilmSquare/admin/qboard/unList.do?page=" + currentPage;
	});
	
	$('.prev').on('click',function(){
		
		currentPage = parseInt($('.pagination').children().first().text()) -1;
		//현재페이지가 0보다 작거나 같을 때
		if(currentPage <= 0) return;
		location.href="/FilmSquare/admin/qboard/unList.do?page=" + currentPage;
	});

/* 전체보기 모달  */


    function detail(qaTitle, qaContent) {
        // 모달 내용에 다른 데이터를 동적으로 설정
        $('#qaTitle').text(qaTitle ? qaTitle : '제목 없음');
        $('#qaContent').text(qaContent);

        // 모달을 엽니다.
        $('#myModal').modal('show');
    }
    
    
    /* 답변달기 모달 */
  
    function submitAnswer(qaId, answerText) {
      // 여기에서 답변 폼 데이터를 처리하는 로직을 추가하세요.
      // 예를 들어, AJAX 호출을 사용하여 서버에 답변을 전송할 수 있습니다.
//       var qaId = $('#qaId').text();
      	console.log(qaId);
//       var answerText = $('#answerText').val();
      console.log("Submitted Answer: " + answerText);
      
      // AJAX를 사용하여 서버로 데이터 전송
      $.ajax({
        type: 'POST',  // 전송 방식 (POST 또는 GET)
        url: 'unList/answer.do',  // 서버의 엔드포인트 URL (실제 서버 URL로 대체해야 함)
        data: { answerText: answerText, qaId:qaId },  // 전송할 데이터
        success: function(response) {
          alert('정상처리되었습니다.');

          // 성공하면 콘솔에 메시지를 표시하고 모달을 닫음
          $('#answerModal').modal('hide');
          
          // 리스트 새로고침
       	location.reload();
        },
        error: function(error) {
          console.error('에러 발생:', error);
          // 에러 처리를 원하면 추가하세요.
        }
      });
      
      

      // 모달 닫기
      $('#answerModal').modal('hide');
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