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
    <link href="resources/css/detailed/detailed_photo.css" rel=stylesheet>
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/KobisOpenAPIRestService.js"></script>
    <script src="resources/js/detailed/detailed_main.js"></script>
    <script>
		/// Model Data
		let movieCd = ${ movie_dto.movie_id };
		
		// Model-image Data
		let poster_list = "${ poster_list }".slice(1, -1).split(", ");
		let still_list = "${ still_list }".slice(1, -1).split(", ");
		
		if (poster_list.length == 0) {
			poster_list = [];
			still_list = [];
			
			for (let i = 0; i <= 13; i++)
				poster_list.push("resources/images/photos/posters/poster" + i + ".jfif");
			for (let i = 0; i <= 18; i++)
				still_list.push("resources/images/photos/stills/still" + i + ".jfif");
		};
		
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
			        let companys = movieData.companys[0].companyNm;	// 제작사
			        
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
			
		    /// Photo event
		    // more button event
		    function ShowPhotoSlide(photo_type, photo_arr) {
		        let index = 0;
		        let big_img = $("#big_" + photo_type);
		        $("#" + photo_type + "_more_title h3").text("1/" + photo_arr.length);
		        big_img.attr("src", photo_arr[index]);

		        $(".prev_btn").on("click", function() {
		            index = (index + photo_arr.length - 1) % photo_arr.length;
		            $("#" + photo_type + "_more_title h3").text((index + 1) + "/" + photo_arr.length);
		            big_img.fadeOut(150, function() {
		                big_img.attr("src", photo_arr[index]);
		                big_img.fadeIn(150);
		            });
		        });
		        $(".next_btn").on("click", function() {
		            index = (index + 1) % photo_arr.length;
		            $("#" + photo_type + "_more_title h3").text((index + 1) + "/" + photo_arr.length);
		            big_img.fadeOut(150, function() {
		                big_img.attr("src", photo_arr[index]);
		                big_img.fadeIn(150);
		            });
		        });
		    };
		    $("#posters_more").on("click", function() {
		        ShowPhotoSlide("posters", poster_list);
		    });
		    $("#stills_more").on("click", function() {
		        ShowPhotoSlide("stills", still_list);
		    });	// photo event end
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
	    	<input type="hidden" value="photo" name="page_name">
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
        <input id="info_btn" class="main_btns" type="button" data-url="detailed?movie_id=${ movie_dto.movie_id }" value="정보">
        <input id="person_btn" class="main_btns" type="button" data-url="detailedperson?movie_id=${ movie_dto.movie_id }" value="인물">
        <input id="photo_btn" class="main_btns active" type="button" data-url="detailedphoto?movie_id=${ movie_dto.movie_id }" value="사진">
        <input id="grade_btn" class="main_btns" type="button" data-url="detailedgrade?movie_id=${ movie_dto.movie_id }" value="평점">
    </div>
    
	<div id="photo_contents" class="contents">
        <div id="posters_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">포스터</h1>
            <input id="posters_more" class="more_btns" type="button" data-target="#photo_contents_posters" data-end="1440" value="더보기">
        </div>
        <table id="posters_table" class="photo_table">
        	<tr>
        		<c:choose>
        			<c:when test="${ empty poster_list }">
        				<c:forEach var="i" begin="0" end="8">
		        			<td><img src="resources/images/photos/posters/poster${ i }.jfif"></td>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
		        		<c:forEach items="${ poster_list }" var="imgP" end="8">
		        			<td><img src="${ imgP }"></td>
		        		</c:forEach>
        			</c:otherwise>
        		</c:choose>
        	</tr>
        </table>
        <div id="stills_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">스틸컷</h1>
            <input id="stills_more" class="more_btns" type="button" data-target="#photo_contents_stills" data-end="1220" value="더보기">
        </div>
        <table id="stills_table" class="photo_table">
        	<tr>
        		<c:choose>
        			<c:when test="${ empty still_list }">
        				<c:forEach var="i" begin="0" end="4">
		        			<td><img src="resources/images/photos/stills/still${ i }.jfif"></td>
		        		</c:forEach>
        			</c:when>
        			<c:otherwise>
		        		<c:forEach items="${ still_list }" var="imgS" end="4">
		        			<td><img src="${ imgS }"></td>
		        		</c:forEach>
        			</c:otherwise>
        		</c:choose>
        	</tr>
        </table>
    </div>

    <div id="photo_contents_posters" class="contents contents_more">
        <div id="posters_more_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">포스터</h1>
            <h3></h3>
            <input class="close_btns" type="button" data-target="#photo_contents_posters" data-end="1168" value="X">
        </div>
        <div class="photo_more_contents">
            <input class="slide_btn prev_btn" type="button" value="&lt;">
            <img id="big_posters">
            <input class="slide_btn next_btn" type="button" value="&gt;">
        </div>
    </div>

    <div id="photo_contents_stills" class="contents contents_more">
        <div id="stills_more_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">스틸컷</h1>
            <h3></h3>
            <input class="close_btns" type="button" data-target="#photo_contents_stills" data-end="1168" value="X">
        </div>
        <div class="photo_more_contents">
            <input class="slide_btn prev_btn" type="button" value="&lt;">
            <img id="big_stills">
            <input class="slide_btn next_btn" type="button" value="&gt;">
        </div>
    </div>

    <footer>
        <p>
            HAPPY MOVIE<br>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </p>
    </footer>
</body>
</html>