<%@page import="movie.vo.MovieInfoVO"%>
<%@page import="movie.vo.MvCommentVO"%>
<%@page import="java.util.List"%>
<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
MovieInfoVO mvv = (MovieInfoVO) request.getAttribute("mvDetail");
List<MvCommentVO> cmtList = (List<MvCommentVO>) request.getAttribute("cmtList");


// 세션에 로그인 정보 꺼내기
	MemberVO mv = (MemberVO) request.getSession().getAttribute("LOGIN_MEMBER");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코멘트 전체 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>

.subject {
 padding:15px;
 font-size: 24px;
 font-family: Roboto;
 font-weight: 700;
 line-height: 28px;
 word-wrap: break-word
}
.container {
            display: flex; /* Flexbox를 사용하여 자식 요소를 일렬로 배치합니다. */
            flex-direction: column;
            align-items: center; /* 가운데 정렬을 위해 추가합니다. */
            position: relative;
            left:28%; /* 이거 조절하기 */
}

.box {
    width: 100px;
    height: 100px;
    margin: 10px; /* 각 상자 사이의 간격을 조절합니다. */
    background-color: #3498db;
    color: #ffffff;
    text-align: center;
    line-height: 100px;
}
.glyphicon-remove:before {
    content: "\e014";
    position: relative;
    left: 370px;
}
</style>
</head>
<body>


<!-- 코멘트 -->


<div style="padding-left: 16px; padding-right: 16px; align-items: center; display: inline-flex">
</div>

<div class="container" style="justify-content: flex-start; align-items: flex-start; gap: 20px; display: inline-flex"> <!-- 코멘트 전체 시작 -->
<div style="display: flex; justify-content: space-between; align-items: center; padding: 15px;">
    <div class="subject">코멘트 전체 보기</div>
    <a href="<%=request.getContextPath()%>/movieDetail.do?mvId=<%=mvv.getMvId()%>">
        <span class="glyphicon glyphicon-remove"  style="margin-left: auto; font-size: 30px;"></span>
    </a>
</div>

   
    
    <%
    int cmtMax = Math.min(cmtList.size(), 5);
    for(int i = 0; i<cmtList.size(); i++){
    %>
    <!-- 코멘트 한블럭 시작-->
    <div class="box" id ="likelink" style="width: 620px; height: 270px; padding-left: 12px; padding-right: 12px; background: #F2F2F2; border-radius: 8px; overflow: hidden; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 38px; display: inline-flex">
        <div style="width: 600px; padding-bottom: 1px; border-bottom: 1px #E5E5E5 solid; justify-content: center; align-items: center; gap: 16px; display: inline-flex">
            <div style="flex: 1 1 0; align-self: stretch; padding-top: 11px; padding-bottom: 11px; padding-right: 94.48px; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex">
                <div style="width: 32px; height: 32px; padding: 1px; border-radius: 16px; overflow: hidden; border: 1px rgba(0, 0, 0, 0.08) solid; justify-content: center; align-items: center; display: inline-flex">
                    <img style="width: 30px; height: 30px" src="
                    <% //프로필 사진
                    String mempPath = cmtList.get(i).getMempPath();
                    if(mempPath == null) {
                    %>
                    	https://png.pngtree.com/png-vector/20191003/ourmid/pngtree-cyber-man-icon-isolated-on-abstract-background-png-image_1779333.jpg
                    <%
                    }else {
                    	mempPath = cmtList.get(i).getMempPath().substring(cmtList.get(i).getMempPath().indexOf("images"));
                    %>
                    ./<%= mempPath%>
                    <%
                    }
                    %>  
                    " />
                </div>
                <div style="align-self: stretch; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex">
                    <div style="color: #1F1F1F; font-size: 17px; font-family: Roboto; font-weight: 600; line-height: 22px; word-wrap: break-word"><%=cmtList.get(i).getMemNcnm() %></div><!-- 멤버 닉네임 -->
                </div>
            </div>
            <div style="width: 55.52px; padding-top: 3.50px; padding-bottom: 3.50px; padding-left: 9px; padding-right: 8.58px; background: white; border-radius: 13px; border: 1px #EAEAEA solid; justify-content: center; align-items: flex-start; gap: 3px; display: inline-flex">
                <div style="height: 16px; justify-content: center; align-items: center; display: inline-flex">
                    <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex">
                        
                    </div>
                </div>
                <div style="width: 50px; height: 19px; color: #4A4A4A; font-size: 12px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word">★ <%=(double) cmtList.get(i).getMemMvgRating()/10 %></div><!-- 멤버 평점 -->
            </div>
        </div>
        <div style="width: 600px; height: 72px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: inline-flex">
            <div style="width: 601.36px; height: 68px; color: black; font-size: 15px; font-family: Roboto; font-weight: 400; line-height: 24px; word-wrap: break-word">
            <a href="<%=request.getContextPath() %>/cmtDetail.do?mvId=<%=mvv.getMvId() %>&mvcId=<%=cmtList.get(i).getMvcId() %>" style="text-decoration: none; color: inherit; display: block; width: 100%; height: 100%;">
      
            <%
				if(cmtList.get(i).getMvcSpoyn().equals("Y")){
			%>
					<div style="text-align: center;">스포일러가 포함된 코멘트입니다.<br>클릭해 주세요.</div>
			<%
				}else {
            %>
            <%=cmtList.get(i).getMvcContent() %> 
            <% } %>    
            </a>
            </div><!-- 코멘트 내용 -->
        </div>
        <div style="width: 600px; height: 44px; position: relative; border-top: 1px #E5E5E5 solid">
            <div style="padding-top: 1px; padding-bottom: 1px; left: 3px; top: 12.50px; position: absolute; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="width: 18px; height: 18px; justify-content: center; align-items: center; display: flex">
                    <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex">
                        <div style="width: 18px; height: 18px; position: relative; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: flex">
                            <i class="material-icons" style="color: #787878;">thumb_up</i>
                        </div>
                    </div>
                </div>
                <div style="color: #787878; font-size: 14px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word"><%= cmtList.get(i).getMvcLikeCnt() %></div><!-- 좋아요 개수 -->
            </div>
            <div style="padding-top: 1px; padding-bottom: 1px; left: 44.56px; top: 12.50px; position: absolute; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
                <div style="width: 18px; height: 18px; justify-content: center; align-items: center; display: flex">
                    <div style="flex: 1 1 0; align-self: stretch; justify-content: center; align-items: center; display: inline-flex">
                        <div style="width: 18px; height: 18px; position: relative; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: flex">
                           <i class="material-icons" style="color: #787878;">chat_bubble</i>
                        </div>
                    </div>
                </div>
                <div style="width: 7.92px; height: 19px; color: #787878; font-size: 14px; font-family: Roboto; font-weight: 400; line-height: 19px; word-wrap: break-word"><%=cmtList.get(i).getMvcReplyCnt() %></div><!-- 댓글 개수 -->
            </div>
            <a href="#likelink" onclick="mvcLikeInsert('<%=mv.getMemId() %>', '<%=cmtList.get(i).getMvcId() %>')" style="width: 107px; height: 23px; left: 490px; top: 15px; position: absolute; text-align: right; color: #FF2F6E; font-size: 17px; font-family: Roboto; font-weight: 400; line-height: 22px; word-wrap: break-word; text-decoration: none">좋아요</a>
        </div> 
    </div> <!-- 코멘트 한블럭 끝 -->
    <%
    }
    %>

</div>  <!-- 코멘트 전체 끝 -->

<script>

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
//             alert("이 코멘트에 '좋아요'를 했어요.");
        	location.reload();
        },
        error: function(error) {
            // 실패 시 실행할 코드
            alert("Ajax 요청 실패", error);
        }
    });
}



</script>



</body>
</html>