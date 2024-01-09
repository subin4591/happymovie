<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			// main btns event
			$(`.main_btns[data-target='${ detailed_type }']`).addClass("active");
			
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
    <!-- header -->
	<%@ include file="../header.jsp" %>
    
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
        <input id="info_btn" class="main_btns" type="button"
        	data-target="info" data-url="detailed?movie_id=${ movie_dto.movie_id }" value="정보">
        <input id="person_btn" class="main_btns" type="button"
        	data-target="person" data-url="detailedperson?movie_id=${ movie_dto.movie_id }" value="인물">
        <input id="photo_btn" class="main_btns" type="button"
        	data-target="photo" data-url="detailedphoto?movie_id=${ movie_dto.movie_id }" value="사진">
        <input id="grade_btn" class="main_btns" type="button"
        	data-target="grade" data-url="detailedgrade?movie_id=${ movie_dto.movie_id }" value="평점">
    </div>

    <!-- contents -->
    <c:choose>
    	<c:when test="${ detailed_type == 'info' }">
    		<%@ include file="./detailed_info.jsp" %>
    	</c:when>
    	<c:when test="${ detailed_type == 'person' }">
    		<%@ include file="./detailed_person.jsp" %>
    	</c:when>
    	<c:when test="${ detailed_type == 'photo' }">
    		<%@ include file="./detailed_photo.jsp" %>
    	</c:when>
    	<c:when test="${ detailed_type == 'grade' }">
    		<%@ include file="./detailed_grade.jsp" %>
    	</c:when>
    </c:choose>
    
    <!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>