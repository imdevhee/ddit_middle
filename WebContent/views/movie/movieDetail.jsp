<%@page import="movie.vo.MvCommentVO"%>
<%@page import="movie.service.MovieDetailServiceImpl"%>
<%@page import="movie.service.IMovieDetailService"%>
<%@page import="movie.service.PosterServiceImpl"%>
<%@page import="movie.service.IPosterService"%>
<%@page import="movie.vo.PosterVO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="collection.vo.CollcontentVO"%>
<%@page import="collection.service.CollcontentServiceImpl"%>
<%@page import="collection.service.ICollcontentService"%>
<%@page import="movie.service.IMovieInfoService"%>
<%@page import="movie.vo.VodVO"%>
<%@page import="movie.vo.ActorVO"%>
<%@page import="movie.vo.MvCollectionVO"%>
<%@page import="movie.vo.MvGradeVO"%>
<%@page import="movie.vo.MvPosterVO"%>
<%@page import="movie.vo.SottVO"%>
<%@page import="java.util.List"%>
<%@page import="movie.vo.MovieInfoVO"%>
<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>영화 상세 페이지</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="globals.css" />
  <link rel="stylesheet" href="styleguide.css" />
  <link rel="stylesheet" href="style.css" />
  <link rel="stylesheet" href="css/detail.css">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Actor&family=Inter:wght@400;500;900&family=Roboto:wght@400;500;700&family=Ropa+Sans&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">
  


<%
	
	int logincheck = 0;

	ICollcontentService collContService = CollcontentServiceImpl.getInstance();
	IPosterService posterService = PosterServiceImpl.getInstance();
	IMovieDetailService movieDetailService = MovieDetailServiceImpl.getInstance();
	
	MovieInfoVO movie = (MovieInfoVO)request.getAttribute("mvDetail");
	MemberVO loginMem = (MemberVO)request.getAttribute("LOGIN_MEMBER");
	
	int mvId = movie.getMvId();

	String memId = "61";
	MvGradeVO memGrade = movieDetailService.getMovieGrade(mvId);
	List<MvCollectionVO> memClList = movieDetailService.getCltList(mvId);
	
// 	String memId = null;
// 	MvGradeVO memGrade = null;
// 	List<MvCollectionVO> memClList = null;
	if(loginMem!=null){
		memGrade = (MvGradeVO)request.getAttribute("memGrade");
		memId = loginMem.getMemId();
		memClList = (List<MvCollectionVO>)request.getAttribute("memClList");
		logincheck = 1;
	}
	
	

	
	
	
	int movieRtime = movie.getMvRtime();
	String movieRtimeConverted = "";
	
	if(movieRtime>=60){
		int rHour = movieRtime/60;
		movieRtimeConverted += rHour + "시간";		
	}
	int rMin = movieRtime%60;
	if(rMin!=0){
		movieRtimeConverted += " " + rMin + "분";
	}
	
	if(movieRtimeConverted.length()!=0){
		movieRtimeConverted += " / ";
	}
	
	List<SottVO> sottList = (List<SottVO>)request.getAttribute("sottList");
	MvPosterVO poster = (MvPosterVO)request.getAttribute("mvPoster");
	String backImg;
	if(movie.getMvBackground()!=null){
		backImg = movie.getMvBackground();
	}else {
		backImg = posterService.getStillListByMvId(movie.getMvId()).get(0).getPosterImg();
	}

%>
<style>


/* body ::before { */
/*     position: fixed; */
/*     top: 0; */
/*     left: 0; */
/*     right: 0; */
/*     bottom: 0; */
<%--     background-image: url(<%=backImg%>); --%>
/*     -webkit-filter: blur(5px);  */
/*     -moz-filter: blur(5px);  */
/*     -o-filter: blur(5px);  */
/*     -ms-filter: blur(5px);  */
/*     filter: blur(5px); */
/*     z-index: -1;  */
/*     content: ""; */
/* } */

</style>
</head>
<body>
    <div class="body">

      <div class="movie-head">
        <div class="background-frame">
            <div class="background-image" style="background-image: url(<%=backImg%>)"><div class="gradi"></div></div>
        </div>
    
        <div class="info">
          <div class="movie-title"><%=movie.getMvTitle() %></div>
          <div class="frame-2">
            <div class="p eng-title"><%=movie.getMvEngtitle() %></div>
            <div class="text-wrapper-2 year-genre-nation"><%=movie.getMvRyear() %> / <%=movie.getMvGenre() %> / <%=movie.getMvNation() %></div>
            <div class="text-wrapper-2 rtime"><%=movieRtimeConverted %><%=movie.getMvAgelimit() %></div>
          </div>
        </div>

        <div class="info-2">
        <% 
        	if( !(sottList==null || sottList.size()==0) || !( sottList.size()==1 && sottList.get(0).getOttId()==6  ) ){
        %>
	        <div class="frame-3">
        <%
    	    	for(SottVO ott : sottList){
        			int ottId = ott.getOttId();
        			if(ottId==8) continue;
        			String sottLink = ott.getSottLink();
        %>
            <a class="ott-wrapper" href="<%=sottLink%>"><img class="ellipse" src="images/icons/ott_logo/ott<%=ottId%>.png" /></a>
        <% 
	        	}
        %>
          </div>
          <div class="text-wrapper-3">여기에서 볼 수 있어요</div>        
        </div>
        <% 
        	}
        %>

      </div>
      
     <!-- movie-head 끝 -->

<%


%>


      <div class="section">


        <div class="frame-4">


          <div class="aside">
            <div class="foster" style="background-image: url(<%=poster.getPosterImg()%>)"></div>
<!--             <div class="frame-5"> -->
<!--               <div class="div-wrapper"><div class="text-wrapper-4">결제</div></div> -->
<!--               <div class="div-2"> -->
<!--                 <div class="frame-6"><div class="text-wrapper-4">VOD 구매</div></div> -->
<!--                 <div class="frame-6"><div class="text-wrapper-4">구독하기</div></div> -->
<!--               </div> -->
<!--             </div> -->
          </div>  
          
          <!-- aside 끝 -->  
          
          <div class="aside-2">
            <div class="frame-7">


              <div class="rate">

          	<%

        	// 로그인한 상태면 사용자 별점, 아닐 경우 회색 별
        	// 마우스 오버 이벤트 주기
        	// 클릭하면 별점 등록 후 별 픽스
        	
          		
          		
          	%>

                <div class="rate-my">
                	<div class="rate-stars">
	                  <img class="star-grade" id="star1" src="images/icons/star1.png" data-value="1" />
	                  <img class="star-grade" id="star2" src="images/icons/star2.png" data-value="2" />
	                  <img class="star-grade" id="star3" src="images/icons/star1.png" data-value="3" />
	                  <img class="star-grade" id="star4" src="images/icons/star2.png" data-value="4" />
	                  <img class="star-grade" id="star5" src="images/icons/star1.png" data-value="5" />
	                  <img class="star-grade" id="star6" src="images/icons/star2.png" data-value="6" />
	                  <img class="star-grade" id="star7" src="images/icons/star1.png" data-value="7" />
	                  <img class="star-grade" id="star8" src="images/icons/star2.png" data-value="8" />
	                  <img class="star-grade" id="star9" src="images/icons/star1.png" data-value="9" />
	                  <img class="star-grade" id="star10" src="images/icons/star2.png" data-value="10" />
                	</div>
                  <div class="text-wrapper-5" id="chat">좋은 영화네요!</div>          	
                </div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>

$(document).ready(function() {
	var starScore = <%=(memGrade != null) ? memGrade.getMvgRating() : 0 %>;
	var stars = document.querySelector('.star-grade');	
	var starBox = document.querySelector('.rate-stars');

	setStars(starScore);

	starBox.addEventListener("mouseover", function (event) {
		var starPeice = event.target;
		var datavalue = starPeice.getAttribute('data-value');
		setStars(datavalue);
    });
	
	starBox.addEventListener("mouseout", function (event) {
		var starPeice = event.target;
		var datavalue = starPeice.getAttribute('data-value');
		setStars(datavalue);
		setStars(starScore);
    });

	
	starBox.addEventListener("click", function (event) {
		var starPeice = event.target;
		var datavalue = starPeice.getAttribute('data-value');

		if(<%=logincheck%>==1){
		    $.ajax({
		        type: "POST",
		        url: "/FilmSquare/mvGradeInsert.do",
		        data: {
		        	selectedRating: datavalue,
		            mvId:<%=movie.getMvId()%>,
		            memId:<%=memId%>
		        	},
		        success: function (response) {
	                // 성공 시 실행할 코드
	                Swal.fire({
	                    icon: 'success',
	                    title: '별점을 등록했어요',
	                    showConfirmButton: false,
	                    timer: 1500  // 1.5초 뒤에 알림이 사라짐
	                });
	                // 1.5초 뒤에 리스트 새로고침
	                setTimeout(function () {
	                    location.reload();
	                }, 1500);
	                setedStars(datavalue);
	            },
		        error: function (error) {
	                // 실패 시 실행할 코드
	                console.log("별점 등록 실패", error);
	                Swal.fire({
	                    icon: 'error',
	                    title: '별점 등록 실패',
	                    text: '별점 등록 중 오류가 발생했어요',
	                });
	            }
		    });
		} else {
// 			alert("로그인해주세요!");
			setedStars(datavalue);
		}
    });
	
	function setedStars(datavalue) {
		starScore=datavalue;
	}
	
	function setStars(starScore) {
		
		setChat(starScore);
		
		
		
		var star1 = document.getElementById("star1");
		if(starScore>=1){
			star1.src = "images/icons/star3.png";
		}else{
			star1.src = "images/icons/star1.png";
		}
		
		var star2 = document.getElementById("star2");
		if(starScore>=2){
			star2.src = "images/icons/star4.png";
		}else{
			star2.src = "images/icons/star2.png";
		}
		
		var star3 = document.getElementById("star3");
		if(starScore>=3){
			star3.src = "images/icons/star3.png";
		}else{
			star3.src = "images/icons/star1.png";
		}
		
		var star4 = document.getElementById("star4");
		if(starScore>=4){
			star4.src = "images/icons/star4.png";
		}else{
			star4.src = "images/icons/star2.png";
		}
		
		var star5 = document.getElementById("star5");
		if(starScore>=5){
			star5.src = "images/icons/star3.png";
		}else{
			star5.src = "images/icons/star1.png";
		}
		
		var star6 = document.getElementById("star6");
		if(starScore>=6){
			star6.src = "images/icons/star4.png";
		}else{
			star6.src = "images/icons/star2.png";
		}
		
		var star7 = document.getElementById("star7");
		if(starScore>=7){
			star7.src = "images/icons/star3.png";
		}else{
			star7.src = "images/icons/star1.png";
		}
		
		var star8 = document.getElementById("star8");
		if(starScore>=8){
			star8.src = "images/icons/star4.png";
		}else{
			star8.src = "images/icons/star2.png";
		}
		
		var star9 = document.getElementById("star9");
		if(starScore>=9){
			star9.src = "images/icons/star3.png";
		}else{
			star9.src = "images/icons/star1.png";
		}
		
		var star10 = document.getElementById("star10");
		if(starScore>=10){
			star10.src = "images/icons/star4.png";
		}else{
			star10.src = "images/icons/star2.png";
		}
		
	}
	
	function setChat(starScore) {
		var chatElem =  document.getElementById("chat");
		if(starScore>7){
			chatElem.innerText = '좋은 영화네요!';
		}else if(starScore>4){
			chatElem.innerText = '그럭저럭이에요~';			
		}else if(starScore>0){
			chatElem.innerText = '별로예요!!';						
		}else {
			chatElem.innerText = '아직 별점을 등록하지 않았어요.';						
		}
	}
	
});


</script>


            <%
            MvGradeVO grade = (MvGradeVO)request.getAttribute("mvGrade");
            %>
                <div class="rate-everage">
                  <div class="text-wrapper-6"><%=grade.getGradeAvg()/10 %></div>
                  <div class="text-wrapper-7">평균 별점</div>
                </div>
                <div class="rate-everage">
                  <div class="text-wrapper-6"><%=grade.getGradeCAvg()/10 %></div>
                  <div class="text-wrapper-7">평론가 평점</div>
                </div>
              </div>        
      
<!--       	rate 끝 -->


              <div class="usermenus">
              
                <div type="button" class="button-watchlist" id="coll-btn" data-toggle="modal" data-target="#cltModal" data-backdrop="static">
                  <img class="SVG" src="images/icons/icon_plus.png" />
                  <div class="text-wrapper-8">컬렉션에 담기</div>
                </div>
                <div type="button"  class="button-commet" id="comm-btn" data-toggle="modal" data-target="#commentModal" data-backdrop="static" >
                  <img class="SVG-2" src="images/icons/icon_write.png" />
                  <div class="text-wrapper-8">코멘트 쓰기</div>
                </div>
                <div class="button-more" id="wish-btn"onclick="mvlater('<%=mvId%>','<%=memId%>')">
                  <img class="SVG-2" id="movie-like" src="images/icons/icon_like.png" data-value="1"; />
                  <div class="text-wrapper-8">보고 싶어요!</div>
                </div>
                
              </div>
              
       <script type="text/javascript">      

//////나의 컬렉션 새로 만들기

function clInsert(memId,clTitle) {
		console.log(memId+'컬렉션제목:'+clTitle);

// Ajax 요청
$.ajax({
    url: '<%=request.getContextPath()%>/clInsert.do', // 실제 서버 컨트롤러 URL로 변경
    type: 'POST', // 또는 'GET'
    data: { memId: memId, clTitle: clTitle }, // 서버로 전송할 데이터
    success: function (response) {
        // Ajax 요청이 성공하면 여기서 수행할 작업
        Swal.fire({
            icon: 'success',
            title: '새로운 컬렉션을 만들었어요',
            showConfirmButton: false,
            timer: 1500  // 1.5초 뒤에 알림이 사라짐
        });
        // 1.5초 뒤에 리스트 새로고침
        setTimeout(function () {
            location.reload();
        }, 1500);
    },
    error: function (error) {
        // Ajax 요청이 실패하면 여기서 수행할 작업
        console.error('에러 발생:', error);
    }
});
}

/////나의 컬렉션에 담기
function mycl(clId, mvId) {
// Ajax 요청
	console.log(clId+"|"+mvId);
$.ajax({
    type: "POST", // 또는 "GET"
    url: "<%=request.getContextPath()%>/myClInsert.do", // 서버의 실제 URL로 변경
    data: {clId: clId, mvId: mvId},
    success: function(response) {
        // Ajax 요청이 성공하면 실행되는 부분
        Swal.fire({
            icon: 'success',
            title: '컬렉션에 담았어요',
            showConfirmButton: false,
            timer: 1500  // 1.5초 뒤에 알림이 사라짐
        });
    },
    error: function(error) {
        // Ajax 요청이 실패하면 실행되는 부분
        console.error("컬렉션 담기 요청 실패:", error);
    }
});
}


//////////좋아요 버튼

function mvcLikeInsert(memId, mvcId) {
// Ajax로 dopost 방식으로 데이터 전송
console.log(memId,mvcId);
$.ajax({
type: "POST",
async: false,
url: "<%=request.getContextPath() %>/mvcLikeInsert.do",
data: { memId: memId, mvcId: mvcId },
success: function(response) {
 // 성공 시 실행할 코드
 Swal.fire({
     icon: 'success',
     title: '이 코멘트에 좋아요를 했어요',
     showConfirmButton: false,
     timer: 1500  // 1.5초 뒤에 알림이 사라짐
 });
 // 1.5초 뒤에 리스트 새로고침
 setTimeout(function () {
     location.reload();
 }, 1500);
},
error: function(error) {
 // 실패 시 실행할 코드
 Swal.fire({
     icon: 'error',
     title: 'Ajax 요청 실패',
     text: '댓글 좋아요 등록에 실패했어요',
 });
 // 1.5초 뒤에 리스트 새로고침
 setTimeout(function () {
     location.reload();
 }, 1500);
}
});
}




///////////보고싶어요 버튼 클릭 시 실행할 함수//////////

function mvlater(mvId, memId) {

var like = document.getElementById("movie-like");
var likecheck = like.getAttribute('data-value');
if(likecheck==1){
	like.src="images/icons/liked.png";
	like.setAttribute('data-value','2');
}else {
	like.src="images/icons/icon_like.png";
	like.setAttribute('data-value','1');	
}
	
console.log("mvId값:", mvId);
console.log("memId값:", memId);
if (memId != null) {
// Ajax 요청 보내기
$.ajax({
 type: 'POST', // 또는 'GET' 등 HTTP 메소드 선택
 url: '<%=request.getContextPath()%>/laterInsert.do',
 // dataType: 'json', // 응답 데이터 형식 (JSON을 기대할 경우)
 data: {mvId:mvId,memId:memId},
 success: function (response) {
     // 성공 시 처리할 코드
     Swal.fire({
         icon: 'success',
         title: '나중에 볼 영화에 추가되었어요',
         showConfirmButton: false,
         timer: 1500  // 1.5초 뒤에 알림이 사라짐
     });
 },
 error: function (error) {
     // 오류 시 처리할 코드
     console.error('영화 추가 중 오류 발생:', error);
     Swal.fire({
         icon: 'error',
         title: '영화 추가 실패',
         text: '나중에 볼 영화 추가 중 오류가 발생했어요',
     });
 }
});
} else {
Swal.fire({
 icon: 'info',
 title: '로그인 필요',
 text: '로그인을 해주세요',
});
}
}


       
       
       
       
       </script>


<!-- 컬렉션 담기 모달 창 -->
<div class="modal fade" id="cltModal" tabindex="-1" role="dialog" aria-labelledby="cltModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="cltModalLabel">나의 컬렉션 목록</h4>
            </div>
            <div class="modal-body" id="clListContainer">
            <div style="display: flex; justify-content: space-between; align-items: center;">
    <input type="text" id="clTitle" style="flex: 1; padding: 10px; margin: 8px 0; box-sizing: border-box; border: 2px solid #ccc; border-radius: 4px; outline: none;" placeholder="새로운 컬렉션 제목을 입력해 주세요">
    <button type="button" class="btn btn-primary" style="margin-left: 10px; padding: 10px 20px;" onclick="clInsert(<%=memId %>,$('#clTitle').val())">+</button>
</div>

                <!-- 모달 내용을 추가 -->
                <%
                for(int i=0 ; i<memClList.size(); i++) {
			    %>
				<hr>
			<div style="display: flex; justify-content: space-between; cursor: pointer;" onclick="mycl(<%=memClList.get(i).getClId()%>,<%=memId%>)">

			   <div><%=memClList.get(i).getClTitle() %></div>
			    <div><%=memClList.get(i).getClDate() %></div>
				</div>	
			    
			    
			    <%            	
                }
                %>
                <p></p>
            </div>
            
        </div>
    </div>
</div>



  
  <!-- 코멘트 모달 영역 시작 -->
<div class="modal fade" id="commentModal" role="dialog">
  <div class="modal-dialog">
  
    <!-- 모달 컨텐츠 -->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">❝ <%=movie.getMvTitle() %> ❞ 에 대한 생각을 자유롭게 작성해 주세요.</h4>
      </div>
      <div class="modal-body">
        <p id="comment"></p>
        <form id="commentForm">
          <div class="form-group">
            <textarea class="form-control" rows="4" id="commentText" name="commentText"></textarea>
          </div>
          <!-- 날짜 선택 입력 칸 추가 -->
          <div class="form-group">
            <label for="commentDate">언제 감상하셨나요?</label>
            <input type="date" class="form-control" id="commentDate" name="commentDate">
          </div>
          <!-- 체크박스 추가 -->
          <div class="form-check">
            <input type="checkbox" class="form-check-input" id="approvalCheckbox" name="approvalCheckbox" value="Y">
            <label class="form-check-label" for="approvalCheckbox">스포일러가 포함되었다면 체크해 주세요.</label>
          </div>
          <br>
          <!-- 등록 버튼 -->
          <button type="button" class="btn btn-primary" onclick="submitComment(<%=memId %>,<%=mvId %>,$('#commentText').val(), getCheckboxValue(),$('#commentDate').val())">등록</button>
        </form>
      </div>
    </div>
  </div>
</div>


  



            </div>
            
<!--       frame-7 끝 -->

            <div class="synob">
              <p class="text-wrapper-9">
		        <%=movie.getMvPlot()%>
              </p>
            </div>
 
 
 
            <div class="div-3">

              <div class="div-wrapper-2"><div class="text-wrapper-10">출연 / 제작</div></div>

              <div class="crew-list">
              
              <%
              
              List<ActorVO> actorList = (List<ActorVO>)request.getAttribute("actorList");
              
              int count = 0;
              for(ActorVO actor : actorList){
				  if(++count>9) break;  
				  String psImg = "images/icons/alterImage.png";
				  if(actor.getPsiSrc()!=null) psImg = actor.getPsiSrc();
              %>
                <a class="crew" href="<%=request.getContextPath() %>/personDetail.do?psId=<%=actor.getPsId() %>">
                  <div class="pic" style="background-image: url(<%=psImg%>)"></div>
                  <div class="info-3">
                    <div class="name"><div class="text-wrapper-11"><%=actor.getPsName() %></div></div>
                    <div class="sub"><div class="text-wrapper-12"><%=actor.getActorRole() %></div></div>
                  </div>
                </a>     
              <% 
              }
              %>
   
              </div>
            </div>
<!--      div3 end        -->
      

          </div>

        </div>   
        
<!--         frame-4 end -->
            

            <div class="vods">
              <div class="div-wrapper-2"><div class="text-wrapper-13">예고편 보기</div></div>
              <div class="vod-list-2">
              <%
              
                List<VodVO> vodList = (List<VodVO>)request.getAttribute("vodList");
                count = 0;
              	for(VodVO vod: vodList){
              		if(++count>4) break;
              %>
                <div class="pic-6" id="videoLink" onclick="openModal('<%=vod.getMvvodLink() %>')">
<!-- 			      <div class="iframe-container"> -->
<%-- 				    <video width="100%" height="auto"  id="video" class="video" src="<%=vod.getMvvodLink() %>" type="video/mp4" control></video> --%>
<!-- 				  </div> -->
					<video id="myVideo" width="100%" height="auto" controls>
        			<source src="<%=vod.getMvvodLink() %>" type="video/mp4"></source>
					</video>
				    <div class ="smallsj"><%= vod.getMvvodTitle() %></div>
                </div>                
              <%
              	}
              %>
              </div>
            </div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var video = document.getElementById('myVideo');

    // 비디오가 로드되면 1초 후에 멈추도록 설정
    video.addEventListener('loadeddata', function() {
      setTimeout(function() {
        video.pause();
      }, 2000);
    });

    // 만약 비디오가 재생 중에 사용자가 멈출 경우 clearTimeout을 사용하여 예약된 멈춤을 취소할 수 있음
    video.addEventListener('pause', function() {
      clearTimeout(pauseTimeout);
    });
  });
</script>


			<!-- 모달 창을 위한 엘리먼트 -->
			<div id="myModal" class="modal">
			  <div class="vod-modal-content">
			    <!-- 모달 내부에 iframe을 삽입할 컨테이너 -->
			    <div class="iframe-container">
			      <iframe id="modalVideoPlayer" class="modal-video" frameborder="0" allowfullscreen></iframe>
			    </div>
			  </div>
			</div>

		<script>
		  // 모달 창 열기 함수
		  function openModal(videoUrl) {
		    const modal = document.getElementById('myModal');
		    const modalVideoPlayer = document.getElementById('modalVideoPlayer');
		
		    // 모달 내부의 iframe 소스 설정
		    modalVideoPlayer.src = videoUrl;
		
		    // 모달 창을 보이게 합니다.
		    modal.style.display = 'flex';
		
		    // 모달 외부를 클릭할 때 모달 창을 닫습니다.
		    window.onclick = function(event) {
		      if (event.target == modal) {
		        modal.style.display = 'none';
		
		        // iframe을 멈추도록 설정
		        modalVideoPlayer.contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');
		      }
		    }
		  }
		</script>
        



        <div class="frame-8">

          <div class="colls">

            <div class="div-wrapper-2"><p class="text-wrapper-13">이 영화가 담긴 컬렉션 보기</p></div>

            <div class="coll-list">

		<%
		List<MvCollectionVO> collList = (List<MvCollectionVO>)request.getAttribute("cltList");
		
		int collCount = 0;
		for(MvCollectionVO coll : collList){			
			if(++collCount>6) break;
 		%>
              <div class="frame-9">
                <div class="coll">
		<% 
			List<CollcontentVO> collContList = collContService.getCollContentList(new CollcontentVO(new BigDecimal(coll.getClId())));
			
			CollcontentVO collCont1 = collContList.get(0);
			CollcontentVO collCont2 = collContList.get(1);
			CollcontentVO collCont3 = collContList.get(2);
			CollcontentVO collCont4 = collContList.get(3);
				
			PosterVO collPoster1 = posterService.getPosterByMvId(collCont1.getMvId().intValue());
			PosterVO collPoster2 = posterService.getPosterByMvId(collCont2.getMvId().intValue());
			PosterVO collPoster3 = posterService.getPosterByMvId(collCont3.getMvId().intValue());
			PosterVO collPoster4 = posterService.getPosterByMvId(collCont4.getMvId().intValue());
		%>
                  <div class="frame-10">
                    <div class="frame-11" style="background-image: url(<%=collPoster1.getPosterImg()%>)"></div>
                    <div class="frame-12" style="background-image: url(<%=collPoster2.getPosterImg()%>)"></div>
                  </div>

                  <div class="frame-10">
                    <div class="frame-13" style="background-image: url(<%=collPoster3.getPosterImg()%>)"></div>
                    <div class="frame-14" style="background-image: url(<%=collPoster4.getPosterImg()%>)"></div>
                  </div>
                </div>
                <div class="frame-15"><div class="text-wrapper-14"><%=coll.getClTitle() %></div></div>
              </div>
      	<%
      	}
      	%>
      
      </div>
      </div>
      


<!-- 코멘트 -->


<div style="width: 100%; height: 100%; padding-left: 16px; padding-right: 16px; justify-content: space-between; align-items: center; display: inline-flex">
<div class="text-wrapper-13">코멘트</div>
<a href="<%=request.getContextPath() %>/cmtMore.do?mvId=<%=mvId %>" style="color: #FF2F6E; font-size: 16px; font-family: Roboto; font-weight: 600; word-wrap: break-word; text-decoration: none">더보기</a>
</div>


<div style="width: 100%; height: 100%; justify-content: flex-start; align-items: flex-start; gap: 20px; display: inline-flex; flex-wrap: wrap"> <!-- 코멘트 전체 시작 -->
    
    
    <%
    
    List<MvCommentVO> cmtList = (List<MvCommentVO>)request.getAttribute("cmtList");
    
    int cmtMax = Math.min(cmtList.size(), 8);
    for(int i = 0; i<cmtMax; i++){
    %>
    <!-- 코멘트 한블럭 시작-->
    <div id ="likelink" style="width: 310px; height: 270px; padding-left: 12px; padding-right: 12px; background: #F2F2F2; border-radius: 8px; overflow: hidden; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 10px; display: inline-flex">
        <div style="width: 100%; padding-bottom: 1px; border-bottom: 1px #E5E5E5 solid; justify-content: center; align-items: center; gap: 16px; display: inline-flex">
            <div style="flex: 1 1 0; align-self: stretch; padding-top: 11px; padding-bottom: 11px; padding-right: 94.48px; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex">
                <div style="width: 32px; height: 32px; padding: 1px; border-radius: 16px; overflow: hidden; border: 1px rgba(0, 0, 0, 0.08) solid; justify-content: center; align-items: center; display: inline-flex">
                    <% //프로필 사진
                    String mempPath = cmtList.get(i).getMempPath();
                    if(mempPath == null) {
                    %>
                    <img style="width: 30px; height: 30px" src="images/pf/user-icon.png" />
                    <%
                    }else {
                    	mempPath = cmtList.get(i).getMempPath().substring(cmtList.get(i).getMempPath().indexOf("images"));
                    	
                    %>
                    <img style="width: 30px; height: 30px" src="<%= mempPath%>" />

                    <%
                    }
                    %>  
                </div>
                <div style="align-self: stretch; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex">
                    <div style="color: #1F1F1F; font-size: 17px; font-family: Roboto; font-weight: 600; line-height: 22px; word-wrap: break-word"><%=cmtList.get(i).getMemNcnm() %></div><!-- 멤버 닉네임 -->
                </div>
            </div>
            <div style="width: 55.52px; padding-top: 3.50px; padding-bottom: 3.50px; padding-left: 9px; padding-right: 8.58px; background: white; border-radius: 13px; border: 1px #EAEAEA solid; justify-content: center; align-items: flex-start; gap: 3px; display: inline-flex">
<!--                 <div style="width: 16px; height: 16px; justify-content: center; align-items: center; display: inline-flex"> -->
<!--                     <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex"> -->
<!--                         <div style="width: 16px; height: 16px; position: relative; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: flex"> -->
<!--                             <div style="width: 14.67px; height: 14px; background: #4A4A4A"></div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
					<img alt="" src="images/icons/Star.png" style="width: 20px">
                <div style="width: 20px; height: 19px; color: #4A4A4A; font-size: 14px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word"><%=(double) cmtList.get(i).getMemMvgRating()/10 %></div><!-- 멤버 평점 -->
            </div>
        </div>
<!--         <div style="width: 100%; height: 140px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: inline-flex"> -->
        <div style="width: 100%; height: 140px; padding-top: 2px; padding-bottom: 2px; overflow: hidden;">
            <div style="width: 100%; height: 100%; color: black; font-size: 15px; font-family: Roboto; font-weight: 400; line-height: 24px; word-wrap: normal;  display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;">
            <a style="text-decoration: none; color: inherit; " href="<%=request.getContextPath() %>/cmtDetail.do?mvId=<%=mvId %>&mvcId=<%=cmtList.get(i).getMvcId() %>">
            	<p  style="text-decoration: none; color: inherit; display: block; width: 100%; height: 100%; overflow: hidden; text-overflow: ellipsis">
      
            <%
				if(cmtList.get(i).getMvcSpoyn().equals("Y")){
			%>
					<div style="text-align: center;">스포일러가 포함된 코멘트입니다.<br>클릭해 주세요.</div>
			<%
				}else {
            %>
            <%=cmtList.get(i).getFullContent() %> 
            <% } %>    
            	</p>
            </a>
            </div><!-- 코멘트 내용 -->
        </div>
        <div style="width: 300px; height: 44px; position: relative; border-top: 1px #E5E5E5 solid">
            <div style="padding-top: 1px; padding-bottom: 1px; left: 3px; top: 12.50px; position: absolute; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
<!--                 <div style="width: 18px; height: 18px; justify-content: center; align-items: center; display: flex"> -->
<!--                     <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex"> -->
<!--                         <div style="width: 18px; height: 18px; position: relative; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: flex"> -->
<!--                             <div style="width: 13.87px; height: 14.25px; background: #787878"></div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
				<img alt="" src="images/icons/joayo.png" style="width: 20px" >
                <div style="color: #787878; font-size: 14px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word"><%= cmtList.get(i).getMvcLikeCnt() %></div><!-- 좋아요 개수 -->
            </div>
            <div style="padding-top: 1px; padding-bottom: 1px; left: 70px; top: 12.50px; position: absolute; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
<!--                 <div style="width: 18px; height: 18px; justify-content: center; align-items: center; display: flex"> -->
<!--                     <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex"> -->
<!--                         <div style="width: 18px; height: 18px; position: relative; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: flex"> -->
<!--                             <div style="width: 13.50px; height: 13.50px; background: #787878"></div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
                <img alt="" style="width: 20px" src="images/icons/reply.png">
                <div style="width: 7.92px; height: 19px; color: #787878; font-size: 14px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word"><%=cmtList.get(i).getMvcReplyCnt() %></div><!-- 댓글 개수 -->
            </div>
            <a href="#likelink" onclick="mvcLikeInsert('<%=memId %>', '<%=cmtList.get(i).getMvcId() %>')" style="width: 107px; height: 23px; left: 176px; top: 15px; position: absolute; text-align: right; color: #FF2F6E; font-size: 17px; font-family: Roboto; font-weight: 400; line-height: 22px; word-wrap: break-word; text-decoration: none">좋아요</a>
        </div> 
    </div> <!-- 코멘트 한블럭 끝 -->
    <%
    }
    %>

</div>  <!-- 코멘트 전체 끝 -->

      
      
      
      </div>
      </div>
      </div>
      </body>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      