<%@page import="dto.ReviewDTO"%>
<%@page import="dto.CrewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="resources/images/MainIcon.ico">
    <link href="resources/css/detailed/detailed_main.css" rel=stylesheet>
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/KobisOpenAPIRestService.js"></script>
    <script src="resources/js/detailed/detailed_main.js"></script>
    <script>
		/// Model Data
		let movieCd = ${ movie_dto.movie_id };
		
		// Function
		function tryLogin() {
        	alert("로그인이 필요합니다.");
    	};
    	
    	function AvgGrade() {
    	    // len
    	    let grade_len = grade_arr.length;

    	    // sum
    	    let grade_sum = 0;
    	    grade_arr.forEach(g => {grade_sum += g.star});

    	    // avg
    	    let grade_avg = (grade_sum / grade_len).toFixed(1);

    	    // update
    	    $("#main_grade").text("★" + grade_avg);
    	    $("#grade_title h2").text("★" + grade_avg + "(" + grade_len + "개)");
    	};
		
		/// API
		// API data
		let key = "736697ae7e8ff21f7f31778b2d47a87d";
		let yesterday = new Date();
		yesterday.setDate(yesterday.getDate() - 1);
		let options = {
		        year: "numeric",
		        month: "2-digit",
		        day: "2-digit"
		};
		let targetDt = yesterday.toLocaleDateString('ko-KR', options).replace(/\./g, "").replace(/\s/g, "");
		
		/// document
		$(document).ready(function() {
			// 영화 상세 정보 API data load
			$.ajax({
			    type: "get",
			    url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + movieCd,
			    success: function(data) {
			        let movieData = data.movieInfoResult.movieInfo;
			        
			        // 리턴 타입 array X
			        let movieNm = movieData.movieNm; // 영화명(국문)
			        let movieNmEn = movieData.movieNmEn;	// 영화명(영문)
			        let showTm = movieData.showTm;	// 상영시간
			        let openDt = movieData.openDt;	// 개봉연도
			        let audits = movieData.audits[0].watchGradeNm;	// 심의정보
			        let companys = movieData.companys[0].companyNm;		// 제작사
			        
			        
			        $("#detailed_title").text(movieNm + "ㅣHAPPYMOVIE");
			        $("#movieNm").text(movieNm);
			        $("#movieNmEn").text(movieNmEn + ", " + openDt.substring(0, 4));
			        $("#showTm").text(showTm + "분");
			        $("#openDt").text(openDt.substring(0, 4) + "." + openDt.substring(4, 6) + "." + openDt.substring(6, 8));
			        $("#audits").text(audits);
			        $("#companys").text(companys);
			        
			        // 리턴 타입 array O
			        // 제작국가
			        let nations = [];
			        for (let i = 0; i < movieData.nations.length; i++) {
			            nations.push(movieData.nations[i].nationNm);
			        }
			        nations = nations.join(", ");
			        $("#nations").text(nations);
			        
			        // 장르명
			        let genres = [];	// 장르
			        for (let i = 0; i < movieData.genres.length; i++) {
			            genres.push(movieData.genres[i].genreNm);
			        }
			        genres = genres.join("/");
			        $("#genres").text(genres);
			        
			        // 감독
			        let directors = movieData.directors;
			        let directorsNm = [];
			        directors.forEach(d => {
			            // main info
			            directorsNm.push(d.peopleNm);
			        });
			        directorsNm = directorsNm.join(", ");
			        $("#directors").text(directorsNm);
			    }	// success end
			});	// ajax end
		
			// 일별 박스오피스 순위 API data load
			$.ajax({
			    type: "get",
			    url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt,
			    success: function(data) {
			        let boxData = data.boxOfficeResult.dailyBoxOfficeList;
			        let rank, audiAcc;	// 순위, 누적관객수
			        for (let i = 0; i < boxData.length; i++) {
			            if (movieCd == boxData[i].movieCd) {
			                rank = boxData[i].rank;
			                audiAcc = boxData[i].audiAcc;
			                audiAcc = parseInt(audiAcc).toLocaleString("en-US");
			                
			                $("#main_table").append("<tr>"
			                        + "<th>박스오피스</th><td id='rank'><a href='rank'>"
			                        + rank + "위</a></td>"
			                        + "<th>누적관객</th><td>"
			                        + audiAcc +"명</td></tr>"
			                );
			                break;
			            };	// if end
			        };	// for end
			    }	// success end
			});	// ajax end
			
		    /// Bookmark event
			$(".bookmark_img").click(function(){
				if (${ session_id == null }) {
					tryLogin();
				}
				else {
					$("#bookmark_form").submit();				
				}
			});	// bookmark event end
		});	// document end
    </script>
    <title id="detailed_title"></title>
</head>
<body>
    <header>
        <a href="main"><img id="logo" src="resources/images/logo.svg"></a>
        <div id="search">
            <form id="searchForm" method="GET" action="search" accept-charset="UTF-8">
                <input class="inputValue" name="query" type="text" value="영화 제목">
                <input class="searchImg" type="image" type="submit" src="resources/images/searchIcon.svg">
            </form>
        </div>
        <c:choose>
        	<c:when test="${ session_id != null }">
        		<a href="loginuserinfo"><img id="user_icon" src="resources/images/userIcon.png"></a>
        		<input class="login_btns" type="button" value="LOGOUT" onclick = "location.href = 'logout'">
        	</c:when>
        	<c:otherwise>
        		<input class="login_btns" type="button" value="LOGIN" onclick = "location.href = 'login'">
        	</c:otherwise>
        </c:choose>
    </header>
    
    <div id="main">
		<c:choose>
			<c:when test="${ empty movie_dto.img_url }">
				<img id="main_poster" src="resources/images/photos/posters/poster0.jfif">
			</c:when>
			<c:otherwise>
				<img id="main_poster" src="${ movie_dto.img_url }">
			</c:otherwise>
	    </c:choose>
	    
	    <form id="bookmark_form" action="detailedbookmark" method="post">
	    	<input type="hidden" value="${ session_id }" name="user_id">
	    	<input type="hidden" value="${ movie_dto.movie_id }" name="movie_id">
	    	<input type="hidden" value="info" name="page_name">
			<c:choose>
		    	<c:when test="${ book_cnt > 0 }">
		    		<img class="bookmark_img b_on" src="resources/images/bookmarkOn.svg" alt="bookmarkOn">
		    		<input type="hidden" value="delete" name="type">
		    	</c:when>
		    	<c:otherwise>
					<img class="bookmark_img b_off" src="resources/images/bookmarkOff.svg" alt="bookmarkOff">
					<input type="hidden" value="insert" name="type">	    	
		    	</c:otherwise>
	    	</c:choose>
	    </form>
	    
		<div id="main_info">
			<h1 id="movieNm"></h1>
			<h3 id="movieNmEn"></h3>
	        <table id="main_table">
	            <tr>
	                <th>개봉</th><td id="openDt"></td>
	                <th>평점</th>
	                <c:choose>
	                	<c:when test="${ movie_dto.star != 0.0 }">
	                		<td id="main_grade">★${ movie_dto.rating_star }(평론가) / ★${ movie_dto.star }(유저)</td>
	                	</c:when>
	                	<c:otherwise>
	                		<td id="main_grade">★${ movie_dto.rating_star }</td>
	                	</c:otherwise>
	                </c:choose>
	            </tr>
	            <tr>
	                <th>장르</th><td id="genres"></td>
	                <th>국가</th><td id="nations"></td>
	            </tr>
	            <tr>
	                <th>등급</th><td id="audits"></td>
	                <th>러닝타임</th><td id="showTm"></td>
	            </tr>
	            <tr>
	                <th>감독</th><td id="directors"></td>
	                <th>제작사</th><td id="companys"></td>
	            </tr>
	        </table>	
		</div>
    </div>

    <div id="main_btns">
        <input id="info_btn" class="main_btns active" type="button" data-url="detailed?movie_id=${ movie_dto.movie_id }" value="정보">
        <input id="person_btn" class="main_btns" type="button" data-url="detailedperson?movie_id=${ movie_dto.movie_id }" value="인물">
        <input id="photo_btn" class="main_btns" type="button" data-url="detailedphoto?movie_id=${ movie_dto.movie_id }" value="사진">
        <input id="grade_btn" class="main_btns" type="button" data-url="detailedgrade?movie_id=${ movie_dto.movie_id }" value="평점">
    </div>

    <div id="info_contents" class="contents">
        <h1><img class="bar" src="resources/images/Bar.svg">시놉시스</h1>
        <c:choose>
	        <c:when test="${ movie_dto.synopsis == null || movie_dto.synopsis eq '정보가 없습니다.' }">
				<p>
		            따단-딴-따단-딴 ♫<br>
		            전 세계를 열광시킬 올 타임 슈퍼 어드벤처의 등장!<br><br>
		
		            뉴욕의 평범한 배관공 형제 '마리오'와 '루이지'는<br>
		            배수관 고장으로 위기에 빠진 도시를 구하려다<br>
		            미스터리한 초록색 파이프 안으로 빨려 들어가게 된다.<br><br>
		
		            파이프를 통해 새로운 세상으로 차원 이동하게 된 형제.<br>
		            형 '마리오'는 뛰어난 리더십을 지닌 '피치'가 통치하는 버섯왕국에 도착하지만<br>
		            동생 '루이지'는 빌런 '쿠파'가 있는 다크랜드로 떨어지며 납치를 당하고<br>
		            ‘마리오’는 동생을 구하기 위해 '피치'와 '키노피오'의 도움을 받아 '쿠파'에 맞서기로 결심한다.<br><br>
		
		            그러나 슈퍼스타로 세상을 지배하려는 그의 강력한 힘 앞에<br>
		            이들은 예기치 못한 위험에 빠지게 되는데...!<br><br>
		
		            동생을 구하기 위해! 세상을 지키기 위해!<br>
		            '슈퍼 마리오'로 레벨업하기 위한 '마리오'의 스펙터클한 스테이지가 시작된다!<br>
	        	</p>
			</c:when>
			<c:otherwise>
				<p>${ movie_dto.synopsis }</p>
			</c:otherwise>
		</c:choose>
    </div>
    
    <footer>
        <p>
            HAPPY MOVIE<br>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </p>
    </footer>
</body>
</html>