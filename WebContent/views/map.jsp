<%@page import="member.vo.MemberVO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
#menu_wrap {
    display: flex;
    justify-content: flex-end; /* 부모 요소를 기준으로 오른쪽 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    padding: 10px;
  }
 .option {
    margin-right: 10px; /* 옵션과 리스트 사이 여백 조절 */
  }
.item {
	border: 1px solid #ddd;
	margin-bottom: 5px;
	cursor: pointer;
}

.item:hover {
	background-color: #f5f5f5;
}

body {
    margin: 0;
    display: flex;
    flex-direction: column;
}

main {
    flex: 1;
}

.main-banner {
	position: relative;
	max-height: 100%;
	overflow: hidden;
	margin: 100px;
}

#placesList {
	width: 100%;
	height: 100%;
}

.header-area {
	background-color: rgba(250, 250, 250, 0.15);
	/* position: absolute; */
	top: 40px;
	left: 0;
	right: 0;
	z-index: 100;
	-webkit-transition: all .5s ease 0s;
	-moz-transition: all .5s ease 0s;
	-o-transition: all .5s ease 0s;
	transition: all .5s ease 0s;
}

.background-header {
	background-color: #fff !important;
	height: 80px !important;
	/* position: fixed!important; */
	top: 0 !important;
	left: 0;
	right: 0;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.15) !important;
}

#menu-rap {
	display: inline;
	width: 500px;
}

#fooot {
	position: absolute;
	bottom: 0;
	width: 100%;
}


.header-area .main-nav {
    min-height: 80px;
    background: black;
    width: 108%;
    position: relative;
    left: -71px;
}

</style>
<!-- ***** Main Banner Area Start ***** -->
<section class="section main-banner" id="top" data-section="section1">
	
	<h2></h2>

<div id="map" style="width: 50%; height: 400px; float: left;"></div>
<div id="location"></div>

<!-- 여기에서 #menu_wrap 및 #placesList를 하나의 div로 감싸줍니다 -->
<div id="sideContent" style="width: 50%; height: 400px; float: right; padding-left: 10px;">
	<div id="menu_wrap" class="bg_white" style="height: 100%;">
		<div class="option">
			<div>
				<form id="searchForm">
					<input type="text" value="영화관" id="keyword" size="15" style="display: none">
				</form>
			</div>
		</div>
		<ul id="placesList" style="overflow-y: auto; max-height: 100%;"></ul>
	</div>
</div>
</section>
<!-- ***** Main Banner Area End ***** -->
<div id="fooot">
<%@include file="../include/footer.jsp"%>
</div>
<!-- Scripts -->
<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

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
          reqSection = $('.section').filter('[data-section="' + direction + '"]')
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

<!-- map 관련 script -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7465cff73e5618dd9060966e9c8e0073&libraries=services"></script>

<script>
        
var map, marker;

// 카카오 맵 API 초기화
function initMap() {
    // Geolocation API를 사용하여 현재 위치 얻기
    navigator.geolocation.getCurrentPosition(
        function (position) {
            // 현재 위치의 위도와 경도 가져오기
            const latitude = position.coords.latitude;
            const longitude = position.coords.longitude;

            // 위치 정보를 HTML에 출력
            const locationElement = document.getElementById('location');
//             locationElement.textContent = `현재 위치: 위도 ${latitude}, 경도 ${longitude}`;

            // 카카오 맵을 현재 위치에 표시
            map = new kakao.maps.Map(document.getElementById('map'), {
                center: new kakao.maps.LatLng(latitude, longitude), // 현재 위치를 중심으로 설정
                level: 5
            });

            // 지도에 마커 추가
            marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(latitude, longitude),
                map: map,
                title: '현재 위치'
            });

            // 페이지 로드 시 자동으로 영화관 검색
            searchPlaces();
        },
        function (error) {
            console.error('Error getting location:', error);
            // 실패한 경우 에러 메시지를 HTML에 출력
            const locationElement = document.getElementById('location');
            locationElement.textContent = '위치를 가져올 수 없습니다.';
        }
    );
}

// 초기화 함수 호출
initMap();
        // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
        
	//전역 변수로 위도와 경도 선언
	var lat, lng;
	var map;
	var ps;
	var infowindow;
	var markers;
	
	// 사용자의 현재 위치를 가져오는 함수
	function getCurrentLocation() {
		if (navigator.geolocation) {
			        navigator.geolocation.getCurrentPosition(function (position) {
			            lat = position.coords.latitude; // 위도
			            lng = position.coords.longitude; // 경도
			
			            // 사용자의 현재 위치를 지도 중심 좌표로 설정
			            var center = new kakao.maps.LatLng(lat, lng);
			            
			
			            // Map 객체 생성 시에 사용자의 현재 위치로 설정
			            var mapOption = {
			                center: center, // 지도의 중심좌표
			                level: 5 // 지도의 확대 레벨
			            };
			
			            // 지도를 생성합니다    
			            map = new kakao.maps.Map(document.getElementById('map'), mapOption);
			
			            // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			            infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
			
			            // 장소 검색 객체를 생성합니다
			             ps = new kakao.maps.services.Places();
			
			            // 마커를 담을 배열입니다
			            markers = [];
			            
			         	// 주변 검색 수행
			            searchPlaces();
			
			            console.log(center);
			        }, function(error) {
			            console.error('Error getting user location:', error);
			        });
			    } else {
			        console.error('Geolocation is not supported by this browser.');
			    }
			}
			        
			     
			
			        // 페이지 로드 시 자동으로 영화관 검색
			        window.onload = function () {
			        	getCurrentLocation();
			
			        };
        
     // 폼 제출 방지 및 검색 수행
        document.getElementById('searchForm').addEventListener('submit', function (event) {
            event.preventDefault(); // 폼 제출 방지
            searchPlaces(); // 검색 수행
        });

        // 키워드로 장소를 검색합니다
        function searchPlaces() {

            var keyword = document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }
            var center = map.getCenter();
            var options = {
                location: new kakao.maps.LatLng(center.getLat(), center.getLng()),
                radius: 4000, // 4킬로미터 반경 설정
            };
            
         	// 검색 전에 현재 위치로 지도 중심 이동
            map.setCenter(center);
            
            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB, options);
        }

         // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);
            
         // 페이지 로드 시 자동으로 영화관 검색
            searchPlaces();

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'), 
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(), 
        bounds = new kakao.maps.LatLngBounds(), 
        listStr = '';
        
        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();
        
        for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i), 
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                       // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function (marker, title) {
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, title);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });

                itemEl.onmouseover = function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout = function () {
                    infowindow.close();
                };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
    var el = document.createElement('li'),
        itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
            '<div class="info">' +
            '   <h5><a href="' + getPlaceLink(places) + '">' + places.place_name + '</a></h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
            '   <span class="jibun gray">' + places.address_name + '</span>';
    } else {
        itemStr += '    <span>' + places.address_name + '</span>';
    }

    itemStr += '  <span class="tel">' + places.phone + '</span>' +
        '</div>';

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

function getPlaceLink(places) {
    // 각 영화관에 대한 링크를 반환하는 함수
    // 예를 들어, CGV 대전과 메가박스 대전에 대한 예시
    if (places.place_name === 'CGV 대전') {
        return 'https://www.cgv.co.kr/theaters/?areacode=03%2C205&theaterCode=0007';
    } else if (places.place_name === '메가박스 대전중앙로') {
        return 'https://megabox.co.kr/booking';
    }

    return 'https://www.lottecinema.co.kr/NLCHS/Ticketing';
}

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지 사용시 옵션
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function (i) {
                    return function () {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }

    // 마커에 마우스오버 이벤트를 등록하는 함수입니다
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
        infowindow.setContent(content);
        infowindow.open(map, marker);
    }
</script>

<!-- map 초기화 함수 호출 -->
<script>
    initMap();
</script>
