<%@page import="admin.vo.EditorBoardVO"%>
<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="member.servive.MemberServiceImpl"%>
<%@page import="member.servive.IMemberService"%>
<%@page import="member.vo.AtchFileVO"%>
<%@page import="member.servive.AtchFileServiceImpl"%>
<%@page import="member.servive.IAtchFileService"%>
<%@page import="movie.vo.PosterVO"%>
<%@page import="movie.service.PosterServiceImpl"%>
<%@page import="movie.service.IPosterService"%>
<%@page import="movie.vo.MovieInfoVO"%>
<%@page import="movie.service.MovieInfoServiceImpl"%>
<%@page import="movie.service.IMovieInfoService"%>
<%@page import="collection.service.CollcontentServiceImpl"%>
<%@page import="collection.vo.CollcontentVO"%>
<%@page import="jdk.nashorn.internal.runtime.regexp.joni.constants.CCVALTYPE"%>
<%@page import="java.util.List"%>
<%@page import="collection.vo.CollectionVO"%>
<%@page import="collection.service.ICollectionService"%>
<%@page import="collection.service.CollectionServiceImpl"%>
<%@page import="collection.service.ICollcontentService"%>
<%@page import="member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="./include/header.jsp"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>

/* 각 콘텐츠 제목 텍스트 중앙정렬 */
h2 {
	text-align: left;
}

#top {
	background-color: black;
	opacity: 1.0;
	top: 0;
}

.carousel-inner>.item>img, .carousel-inner>.item>a>img {
	width: 99%;
	height: auto;
	margin: auto;
	background-color: blue;
	margin: auto;
}

#myCarousel {
	display: flex;
	flex-direction: column;
	justify-content: center;
	top: 100px;
	bottom: 500px;
	z-index: 1;
}

body:first-child {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.service {
	
}

.movie-title-text {
	color: #000;
	text-align: center;
	font-family: Roboto;
	font-size: 35px;
	font-style: normal;
	font-weight: 800;
	line-height: normal;
	letter-spacing: -0.3px;
}

.movie-title {
	display: flex;
	align-items: center;
	gap: 10px;
}

.poster-image {
	flex: 1 0 0;
	align-self: stretch;
}

.movie-poster {
	display: flex;
	width: 200px;
	height: 300px;
	justify-content: center;
	align-items: center;
	gap: 10px;
	overflow: hidden;
	border-radius: 8px;
}

.movie {
	display: flex;
	width: 1312px;
	padding: 16px;
	align-items: flex-start;
	gap: 32px;
}

.movie-list {
	display: flex;
	width: 1312px;
	padding: 16px;
	align-items: flex-start;
	gap: 32px;
}

.css-coll-detail-button {
	color: #000;
	text-align: center;
	font-family: Roboto;
	font-size: 25px;
	font-style: normal;
	font-weight: 500;
	line-height: normal;
	letter-spacing: -0.3px;
}

.css-coll-title {
	color: #000;
	text-align: center;
	font-family: Roboto;
	font-size: 40px;
	font-style: normal;
	font-weight: 800;
	line-height: normal;
	letter-spacing: -0.3px;
	margin: 0%;
}

.css-user-ncnm {
	color: #A5A5A7;
	font-family: Roboto;
	font-size: 25px;
	font-style: normal;
	font-weight: 400;
	line-height: normal;
	letter-spacing: -0.3px;
	margin: 0%;
}

.frame12 {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	gap: 8px;
}

.css-member-profile-image {
	width: 80px;
	height: 80px;
	border-radius: 80px;
	border: 2px solid #555765;
}

.frame13 {
	display: flex;
	padding: 1px 0px;
	justify-content: center;
	align-items: center;
	gap: 10px;
}

.frame74 {
	display: flex;
	align-items: center;
	gap: 16px;
}

.list-title {
	display: flex;
	padding: 0px 8px;
	justify-content: space-between;
	align-items: center;
	align-self: stretch;
}

.frame72 {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	gap: 8px;
}

.list {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	gap: 8px;
background-color: #D9D9D9;
}

.upcoming-meetings {
	margin-top: 100px;]

}


</style>

<!-- ***** Main Banner Area Start ***** -->
<section class="section main-banner" id="top" data-section="section1">


	<div class="container">
		<br>
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">

				<div class="item active">
					<img src="images/111.PNG" alt="Chania" width="460" height="345">
					<div class="carousel-caption">
						<h3>Chania</h3>
						<p>The atmosphere in Chania has a touch of Florence and
							Venice.</p>
					</div>
				</div>

				<div class="item">
					<img src="images/222.PNG" alt="Chania" width="460" height="345">
					<div class="carousel-caption">
						<h3>Chania</h3>
						<p>The atmosphere in Chania has a touch of Florence and
							Venice.</p>
					</div>
				</div>

				<div class="item">
					<img src="images/333.PNG" alt="Flower" width="460" height="345">
					<div class="carousel-caption">
						<h3>Flowers</h3>
						<p>Beautiful flowers in Kolymbari, Crete.</p>
					</div>
				</div>

				<div class="item">
					<img src="images/111.PNG" alt="Flower" width="460" height="345">
					<div class="carousel-caption">
						<h3>Flowers</h3>
						<p>Beautiful flowers in Kolymbari, Crete.</p>
					</div>
				</div>

			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>

		</div>
	</div>



	<div class="video-overlay header-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="caption">
						<div class="main-button-red"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- ***** Main Banner Area End ***** -->
<%
	ICollectionService collService = CollectionServiceImpl.getInstance();
	ICollcontentService collContService = CollcontentServiceImpl.getInstance();
	IMovieInfoService movieService = MovieInfoServiceImpl.getInstance();
	IPosterService posterService = PosterServiceImpl.getInstance();
	IAtchFileService fileService = AtchFileServiceImpl.getInstance();
	IMemberService memService = MemberServiceImpl.getInstance();
	List<EditorBoardVO> ediList = (List<EditorBoardVO>)request.getAttribute("selectEditor");
	System.out.println("edijsp"+ediList);

%>

<section class="our-courses" id="courses">
	<div class="container">
		<div class="row">






			<div class="col-lg-12">
				<div class="section-heading">
					<h2>박스오피스 순위</h2>
				</div>
			</div>
			<div class="col-lg-12">
				<div class="owl-courses-item owl-carousel">
					<div class="item">
						<img src="assets/images/course-01.jpg" alt="Course One">
						<div class="down-content">
							<h4>Morbi tincidunt elit vitae justo rhoncus</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-02.jpg" alt="Course Two">
						<div class="down-content">
							<h4>Curabitur molestie dignissim purus vel</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-03.jpg" alt="">
						<div class="down-content">
							<h4>Nulla at ipsum a mauris egestas tempor</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-04.jpg" alt="">
						<div class="down-content">
							<h4>Aenean molestie quis libero gravida</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-01.jpg" alt="">
						<div class="down-content">
							<h4>Lorem ipsum dolor sit amet adipiscing elit</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-02.jpg" alt="">
						<div class="down-content">
							<h4>TemplateMo is the best website for Free CSS</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-03.jpg" alt="">
						<div class="down-content">
							<h4>Web Design Templates at your finger tips</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-04.jpg" alt="">
						<div class="down-content">
							<h4>Please visit our website again</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-01.jpg" alt="">
						<div class="down-content">
							<h4>Responsive HTML Templates for you</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-02.jpg" alt="">
						<div class="down-content">
							<h4>Download Free CSS Layouts for your business</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-03.jpg" alt="">
						<div class="down-content">
							<h4>Morbi in libero blandit lectus cursus</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<img src="assets/images/course-04.jpg" alt="">
						<div class="down-content">
							<h4>Curabitur molestie dignissim purus</h4>
							<div class="info">
								<div class="row">
									<div class="col-8">
										<ul>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
											<li><i class="fa fa-star"></i></li>
										</ul>
									</div>
									<div class="col-4">
										<span></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="services">
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="section-heading">
                <h2>에디터 글</h2>
            </div>
            <div class="col-lg-12">
            <div class="owl-service-item owl-carousel">
                    <div class="item">
                <% for (int i = 0; i < ediList.size(); i++) { %>
                        <div class="icon">
                            <img src="<%=ediList.get(i).getEbiStreNm()%>" alt="">
                        </div>
                        <div class="down-content">
                            <div class="content-left">
                                <h4><%=ediList.get(i).getEbTitle()%></h4>
                            </div>
                            
                            <div class="content-right">
                                <p><%=ediList.get(i).getEbDate()%></p>
                            </div>
                        </div>
                    </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>



</section>


<section class="upcoming-meetings" id="meetings">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="section-heading">
					<h2>인기 컬렉션</h2>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
	
	<%
	BigDecimal clId = new BigDecimal(161);
	List<CollcontentVO> collContVOList = collContService.getCollContentList(new CollcontentVO(clId));
	CollectionVO coll = collService.getACollection(new CollectionVO(clId));
	String memId = coll.getMemId();
	MemberVO mem = memService.getAMember(new MemberVO(memId));
	AtchFileVO file = fileService.getAFile(memId);
	System.out.println("index!!");
%>
			<!-- 컬렉션 -->

			<div>collection</div>
			<div class="list">
				<div class="frame72">
					<div class="list-title">
						<div class="frame74">
							<div class="frame13">
							<%
							System.out.println("memberProfile");
							if(file==null || file.getMempPath()==null || file.getMempPath().equals("")){
								System.out.println("There is no member profile");
							%>
								<img class="css-member-profile-image"
									src="./images/pf/user-icon.png">
							<%
							} else {
								System.out.println("Printing memberProfile");
							%>
								<img class="css-member-profile-image"
									src="<%=file.getMempPath()%>">							
							<%
							}
							%>
							</div>
							<div class="frame12">
								<p class="css-user-ncnm"> <%=mem.getMemNcnm() %> 님의 컬렉션</p>
								<p class="css-coll-title"> <%=coll.getClTitle() %> </p>
							</div>
						</div>
						<a class="css-coll-detail-button"
							href="<%=request.getContextPath()%>/collectionDetail.do?clId=<%=clId%>">
							<span>모두 보기</span>
						</a>
					</div>
					<div class="movie-list">
					<%
					System.out.println("PrintingMovieList");
					int index = 0;
					for(int i=0; i<6; i++){
						System.out.println((i+1) +". MovieList");
						System.out.println("index : " + index);						
						CollcontentVO collCont = collContVOList.get(index);
						if(collCont == null) break;
						System.out.println("got collCont");
						MovieInfoVO movie = movieService.getAMovie(collCont.getMvId().intValue());
						System.out.println("got movie");
						PosterVO poster = posterService.getPosterByMvId(movie.getMvId());
						System.out.println("got poster");
						index++;
						if(poster==null){
							System.out.println("no poster");
							i--;
							continue;
						}
						
					%>
					
						<div class="movie">
							<a href="#영화상세#">
								<div class="movie-poster">
									<img class="poster-image" alt="영화제목포스터"
										src="<%=poster.getPosterImg()%>">
								</div>
								<div class="movie-title">
									<div class="movie-title-text"><%=movie.getMvTitle() %></div>
									<!-- <div class="css-movie-list-grade">
                                    <span>평균</span>
                                    <img alt="star" src="/images/icons/Star.png">
                                    <span>평균별점</span>
                                </div> -->
								</div>
							</a>
						</div>
						<%
					} 
					System.out.println("PrintingMovieList end");
						%>
					</div>
				</div>
			</div>

</section>
<%@include file="./include/footer.jsp"%>

<!-- Scripts -->
<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>

<script src="assets/js/isotope.min.js"></script>
<script src="assets/js/owl-carousel.js"></script>
<script src="assets/js/lightbox.js"></script>
<script src="assets/js/tabs.js"></script>
<script src="assets/js/video.js"></script>
<script src="assets/js/slick-slider.js"></script>
<script src="assets/js/custom.js"></script>
<script>
        //according to loftblog tut
        $('.nav li:first').addClass('active');

        var showSection = function showSection(section, isAnimate) {
          var
          direction = section.replace(/#/, ''),
          reqSection = $('.section').filter('[data-section="' + direction + '"]'),
          reqSectionPos = reqSection.offset().top - 0;

          if (isAnimate) {
            $('body, html').animate({
              scrollTop: reqSectionPos },
            800);
          } else {
            $('body, html').scrollTop(reqSectionPos);
          }

        };

        var checkSection = function checkSection() {
          $('.section').each(function () {
            var
            $this = $(this),
            topEdge = $this.offset().top - 80,
            bottomEdge = topEdge + $this.height(),
            wScroll = $(window).scrollTop();
            if (topEdge < wScroll && bottomEdge > wScroll) {
              var
              currentId = $this.data('section'),
              reqLink = $('a').filter('[href*=\\#' + currentId + ']');
              reqLink.closest('li').addClass('active').
              siblings().removeClass('active');
            }
          });
        };

        $('.main-menu, .responsive-menu, .scroll-to-section').on('click', 'a', function (e) {
          e.preventDefault();
          showSection($(this).attr('href'), true);
        });

        $(window).scroll(function () {
          checkSection();
        });
    </script>






</body>
</html>