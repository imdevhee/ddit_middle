<%@page import="movie.vo.GradeVOforYE"%>

<%@page import="movie.service.PosterServiceImpl"%>
<%@page import="movie.service.IPosterService"%>
<%@page import="movie.vo.PosterVO"%>
<%@page import="java.util.List"%>
<%@page import="movie.vo.MvGradeVO"%>
<%@page import="member.servive.AtchFileServiceImpl"%>
<%@page import="member.servive.IAtchFileService"%>
<%@page import="member.servive.MemberServiceImpl"%>
<%@page import="member.servive.IMemberService"%>
<%@page import="movie.service.MovieGradeServiceImpl"%>
<%@page import="movie.service.IMovieGradeService"%>
<%@page import="member.vo.AtchFileVO"%>
<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="globals.css" />
    <link rel="stylesheet" href="styleguide.css" />
    <link rel="stylesheet" href="style.css" />
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Actor&family=Inter:wght@400;500;900&family=Roboto:wght@400;500;700&family=Ropa+Sans&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>

:root {
    --primary: rgba(231, 29, 29, 1);
    --black: rgba(0, 0, 0, 1);
    --white: rgba(255, 255, 255, 1);
    --star: rgba(241, 197, 40, 1);
    --body-regular-font-family: "RopaSans-Regular", Helvetica;
    --body-regular-font-weight: 400;
    --body-regular-font-size: 16px;
    --body-regular-letter-spacing: 0px;
    --body-regular-line-height: 150%;
    --body-regular-font-style: normal;
    --poster-mini-shadow: 4px 4px 4px 0px rgba(196, 196, 196, 0.5), -4px -3px 4px 0px rgba(196, 196, 196, 0.2),
      4px -2px 4px 0px rgba(196, 196, 196, 0.2);
    --variable-collection-gray: rgba(123, 123, 123, 1);
    --variable-collection-stroke: var(--variable-collection-gray);
    --variable-collection-light-gary: rgba(196, 196, 196, 1);
  }
  

.mypage {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    background-color: var(--black);
  }
  
  .mypage .navbar {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    padding: 13px 20px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .text-wrapper {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Actor-Regular", sans-serif;
    font-weight: 400;
    color: var(--white);
    font-size: 33px;
    letter-spacing: 0;
    line-height: 33px;
    white-space: nowrap;
  }
  
  .mypage .title {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    padding: 0px 20px 16px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .div {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Abril Fatface", serif;
    font-weight: 400;
    color: #ffffff;
    font-size: 281px;
    letter-spacing: 0;
    line-height: 224.8px;
    white-space: nowrap;
  }
  
  .mypage .collection {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 32px;
    padding: 16px 32px 32px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
    background-color: var(--white);
  }
  
  .mypage .frame {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    padding: 64px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-color: var(--variable-collection-gray);
  }
  
  .mypage .frame-2 {
    display: inline-flex;
    align-items: center;
    gap: 32px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .frame-3 {
    position: relative;
    flex: 0 0 auto;
    border-radius: 100px;
    background-size: cover;
    background-position: 50% 50%;
  }
  
  .mypage .frame-4 {
    display: inline-flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 24px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .frame-5 {
    display: inline-flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
    position: relative;
    flex: 0 0 auto;
  }
  
  .mypage .text-wrapper-2 {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Ubuntu-Regular",  sans-serif;
    font-weight: 400;
    color: #7b7b7b;
    font-size: 33px;
    letter-spacing: 0;
    line-height: 26.4px;
    white-space: nowrap;
  }
  
  .mypage .text-wrapper-3 {
    position: relative;
    width: fit-content;
    font-family: "Ubuntu-Bold", sans-serif;
    font-weight: 700;
    color: #000000;
    font-size: 56px;
    letter-spacing: 0;
    line-height: 44.8px;
    white-space: nowrap;
  }
  
  .mypage .p {
    font-family: "Ubuntu-Regular", sans-serif;
    font-weight: 400;
    color: var(--variable-collection-gray);
    font-size: 33px;
    letter-spacing: 0;
    line-height: 39.6px;
    position: relative;
    width: fit-content;
  }
  
  .mypage .text-wrapper-4 {
    position: relative;
    width: fit-content;
    font-family: "Ubuntu-Regular", sans-serif;
    font-weight: 400;
    color: var(--variable-collection-gray);
    font-size: 33px;
    letter-spacing: 0;
    line-height: 39.6px;
    white-space: nowrap;
  }
  
  .mypage .frame-6 {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 60px;
    padding: 50px 64px 30px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .element {
    margin-top: -1px;
    font-weight: 400;
    color: transparent;
    font-size: 41px;
    line-height: 49.2px;
    position: relative;
    width: fit-content;
    font-family: "Ubuntu-Bold", sans-serif;
    letter-spacing: 0;
    white-space: nowrap;
  }
  
  .mypage .span {
    font-weight: 700;
    color: #000000;
  }
  
  .mypage .text-wrapper-5 {
    font-family: "Ubuntu-Regular", sans-serif;
    color: #7b7b7b;
    font-size: 33px;
    line-height: 39.6px;
  }
  
  .mypage .frame-7 {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    gap: 200px;
    position: relative;
    align-self: stretch;
    flex: 0 0 auto;
  }
  
  .mypage .element-2 {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Ubuntu-Bold", sans-serif;
    font-weight: 400;
    color: #000000;
    font-size: 41px;
    text-align: center;
    letter-spacing: 0;
    line-height: 49.2px;
  }
  
  .mypage .text-wrapper-6 {
    font-weight: 700;
  }
  
  .mypage .text-wrapper-7 {
    font-family: "Ubuntu-Regular", sans-serif;
    font-size: 32px;
    line-height: 38.4px;
  }
 

  .mypage .frame-8 {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 32px;
    padding: 64px;
    position: relative;
    align-self: stretch;
    
    flex: 0 0 auto;
    border-top-width: 1px;
    border-top-style: solid;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    border-color: var(--variable-collection-gray);
  }
  
  .mypage .text-wrapper-8 {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Ubuntu-Bold", Helvetica;
    font-weight: 700;
    color: #000000;
    font-size: 62px;
    letter-spacing: 0;
    line-height: 74.4px;
    white-space: nowrap;
  }
  
  .mypage .frame-9 {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    gap: 32px;
    position: relative;
    align-self: stretch;
    
    flex: 0 0 auto;
  }
  
  .mypage .frame-10 {
    display: flex;
    height: 590px;
    align-items: flex-end;
    gap: 8px;
    position: relative;
    flex: 1;
    flex-grow: 1;
    overflow: hidden;
  }
  
  .mypage .text-wrapper-9 {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Ubuntu-Light", Helvetica;
    font-weight: 300;
    color: var(--variable-collection-gray);
    font-size: 34px;
    letter-spacing: 0;
    line-height: 40.8px;
    white-space: nowrap;
  }

  .mypage .frame-12 {
    position: relative;
    flex: 1;
    align-self: stretch;
    width: 100%;
    flex-grow: 1;
    background-color: #ffa4a4;
    border-radius: 8px;
  }

  .mypage .frame-11 {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-end;
    gap: 10px;
    position: relative;
    flex: 1;
    flex-grow: 1;
  }
  .mypage .frame-21 {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
    position: relative;
    flex: 1;
    align-self: stretch;
    flex-grow: 1;
  }
  
  .mypage .text-wrapper-10 {
    position: relative;
    width: fit-content;
    margin-top: -1px;
    font-family: "Ubuntu-Regular", Helvetica;
    font-weight: 400;
    color: #000000;
    font-size: 36px;
    letter-spacing: 0;
    line-height: 43.2px;
    white-space: nowrap;
  }
  
  .mypage .frame-22 {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    gap: 10px 10px;
    position: relative;
    align-self: stretch;
    
    flex: 0 0 auto;
  }
  
  .mypage .frame-23 {
    position: relative;
    width: 159px;
    height: 226px;
    border-radius: 4px;
    
    background-size: cover;
    background-position: 50% 50%;
  }
  .frame-11 .frame-12.clicked {
    background-color: #ff5252; /* 클릭한 요소의 배경색을 #ff5252로 지정 */
  }
  
</style>
  </head>
  <body>
    <div class="mypage">
      <div class="navbar">
        <div class="text-wrapper">FILM SQUARE</div>
        <div class="text-wrapper">CALENDAR</div>
        <div class="text-wrapper">MAP</div>
        <div class="text-wrapper">SEARCH</div>
        <div class="text-wrapper">MY PAGE</div>
      </div>
   
<%
IMovieGradeService gradeService = MovieGradeServiceImpl.getInstance();
IMemberService memService = MemberServiceImpl.getInstance();
IAtchFileService fileService = AtchFileServiceImpl.getInstance();
IPosterService posterService = PosterServiceImpl.getInstance();
%>

<%
// 테스트
MemberVO mem = memService.getAMember(new MemberVO("61"));
AtchFileVO file = fileService.getAFile(mem.getMemId());

// MemberVO mem = (MemberVO) session.getAttribute("LOGIN_MEMBER");
// MemberVO mvNic = (MemberVO) session.getAttribute("mvNic");
// MemberVO mvInt = (MemberVO) session.getAttribute("mvInt");
// AtchFileVO file = (AtchFileVO) request.getAttribute("atchFileVO");


///////////////////////////////////////////////////////////////////
// !!!!!!!!!!!!!!!!!!!!!!!기본 사진!!!!!!!!!!!!!!!!!!!
/////////////////////////////////////////////////////

String mempStreNm = (file != null && file.getMempStreNm() != null)
	? file.getMempStreNm() : "/user-icon.png";

// int index = mempStreNm.indexOf("Webcontent");
// mempStreNm = mempStreNm.substring(index+11);
// mempStreNm = "./" + mempStreNm;

String nickName = "기본닉";

if (mem != null && mem.getMemNcnm() != null && !mem.getMemNcnm().isEmpty()) {
    nickName = mem.getMemNcnm(); 
}

String intro = "소개글이 없습니다. 작성해주세요";

if(mem != null && mem.getMemIntro()!= null && !mem.getMemIntro().isEmpty()) {
    intro = mem.getMemIntro();
}

%>
   
      
      
      <div class="title"><div class="div">MY PAGE</div></div>
      <div class="collection">
        <div class="frame">
          <div class="frame-2">
            <div class="frame-3" style="background-image: url(<%=mempStreNm%>)"></div>
            <div class="frame-4">
              <div class="frame-5">
                <div class="text-wrapper-2"><%=mem.getMemEmail() %></div>
                <div class="text-wrapper-3"><%=nickName %></div>
              </div>
              <p class="p"><%=intro %></p>
            </div>
          </div>
          <!-- 버튼 처리 -->
          <div class="text-wrapper-4">수정하기</div>
        </div>
        <div class="frame-6">
          <p class="element">
            <!-- 영화 수 뽑기 -->
            <%
            int watchedMovieNum = memService.getWatchedMovieNum(mem.getMemId());
            int rank = memService.getMemberRank(mem);
            int gradeCount = memService.getGradeCount(mem);
            int commentCount = memService.getCommentCount(mem);
            int collCount = memService.getCollCout(mem);
            %>
            <span class="span">지금까지 <%=watchedMovieNum %>편의 영화를 감상했습니다. </span>
            <!-- 통계 -->
            <span class="text-wrapper-5">필름 스퀘어 상위 <%=rank/10%>%</span>
          </p>
          <div class="frame-7">
            <p class="element-2">
                <!-- 평가 수 -->
              <span class="text-wrapper-6"><%=gradeCount %><br /></span> <span class="text-wrapper-7">평가</span>
            </p>
            <p class="element-2">
                <!-- 코멘트 수 -->
              <span class="text-wrapper-6"><%=commentCount %><br /></span> <span class="text-wrapper-7">코멘트</span>
            </p>
            <p class="element-2">
                <!-- 컬렉션 수 -->
              <span class="text-wrapper-6"><%=collCount %><br /></span> <span class="text-wrapper-7">컬렉션</span>
            </p>
          </div>
        </div>
       </div>
       
       
       
       <div class="frame-8">
          <div class="text-wrapper-8">MY RATE</div>
          <div class="frame-9">
          	<div class="frame-21">
          	
          	
            <%
            List<GradeVOforYE> gradeList = gradeService.getGradeList(new MvGradeVO(mem.getMemId(),10));            
            %>
              <div class="text-wrapper-10">5점 준 영화들</div>
              <div class="frame-22">
                <% for(int i=0; (i<gradeList.size() || i<10); i++){ 
                	GradeVOforYE grade = gradeList.get(i);                	
            		PosterVO poster = posterService.getPosterByMvId(grade.getMvId().intValue());
                %>
                <a class="frame-23" href="#영화 디테일 경로#" style="background-image: url(<%=poster.getPosterImg()%>)"></a>
	            <%} %>

              </div>
            </div>
          
            <div class="frame-10">

            <!-- 스타일에 높이, 텍스트래퍼9 안에 평점 표시(클릭했을 때) -->
            <%
            
            
            	int countMostCommonGrade = gradeService.countMostCommonGrade(new MvGradeVO(mem.getMemId(),0));	

        	int rate1= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),1))/(double)countMostCommonGrade*500);
        	int rate2= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),2))/(double)countMostCommonGrade*500);
        	int rate3= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),3))/(double)countMostCommonGrade*500);
        	int rate4= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),4))/(double)countMostCommonGrade*500);
        	int rate5= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),5))/(double)countMostCommonGrade*500);
        	int rate6= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),6))/(double)countMostCommonGrade*500);
        	int rate7= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),7))/(double)countMostCommonGrade*500);
        	int rate8= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),8))/(double)countMostCommonGrade*500);
        	int rate9= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),9))/(double)countMostCommonGrade*500);
        	int rate10= (int)((double)gradeService.countAGrade(new MvGradeVO(mem.getMemId(),10))/(double)countMostCommonGrade*500);
            
            %>
            	<div class="frame-11" id="graph1" style="height: <%=rate1%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph2" style="height: <%=rate2%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph3" style="height: <%=rate3%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph4" style="height: <%=rate4%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph5" style="height: <%=rate5%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph6" style="height: <%=rate6%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph7" style="height: <%=rate7%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph8" style="height: <%=rate8%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph9" style="height: <%=rate9%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            	<div class="frame-11" id="graph10" style="height: <%=rate10%>px">
                	<div class="text-wrapper-9"></div>
                   	<div class="frame-12"></div>
                </div>
            </div>
            
			
            
          </div>
        </div>
        
        
        
        
        
      </div>
      
     </body>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function () {
    // 초기에 i가 8인 값에 대한 스타일 설정
    $(".frame-11#graph8 .frame-12").addClass("clicked");

    $(".frame-11").click(function () {
        // 모든 frame-11의 frame-12에 대한 스타일 초기화
        $(".frame-11 .frame-12").removeClass("clicked");

        // 클릭한 frame-11의 frame-12에 스타일 추가
        $(this).find(".frame-12").addClass("clicked");

        var selectedGrade = this.id.replace("graph", "");

        $(".frame-21 .text-wrapper-10").text(selectedGrade / 2 + "점 준 영화들");

        // 기존에 적용된 스타일 초기화
        $(".frame-12").removeClass("clicked");

        // 현재 클릭한 frame-11에 해당하는 frame-12에 스타일 추가
        $(this).find(".frame-12").addClass("clicked");

        // 나머지 frame-11의 frame-12에 대한 스타일 제거
        $(".frame-11").not(this).find(".frame-12").removeClass("clicked");

        // Ajax 요청
        $.ajax({
            type: "POST",
            url: "/FilmSquare/mypage.do", // 실제 서블릿의 URL로 변경 !!!!!!!!!!!!!
            data: { selectedGrade: selectedGrade },
            success: handleServerResponse,
            error: function (error) {
                console.error("에러 발생:", error);
            }
        });
    });
});

// 서버 응답 처리
function handleServerResponse(response) {
    // 서버로부터 받은 응답을 JSON으로 파싱
    var posterList = JSON.parse(response);

    // frame-22 엘리먼트 선택
    var frame22Element = $(".frame-22");

    // 기존의 frame-23 엘리먼트들 제거
    frame22Element.find(".frame-23").remove();

    // 새로운 frame-23 엘리먼트들 추가
    for (var i = 0; i < posterList.length; i++) {
        var posterVO = posterList[i];
        var frame23Html = '<a class="frame-23" href="#영화 디테일 경로#" style="background-image: url(' + posterVO.posterImg + ')"></a>';
        frame22Element.append(frame23Html);
    }
}

</script>
</html>