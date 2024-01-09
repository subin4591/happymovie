<%@page import="dto.ReviewPagingDTO"%>
<%@page import="dto.MovieDTO"%>
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
    <link href="resources/css/detailed/detailed_grade.css" rel=stylesheet>
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/KobisOpenAPIRestService.js"></script>
    <script src="resources/js/detailed/detailed_main.js"></script>
    <script>
		/// Model Data
		let movieCd = ${ movie_dto.movie_id };
		
		// Model-review Data
		// 리뷰 생성자
		function StarComm(seq, user_id, name, pw, comment, star, date){
			this.seq = seq;
			this.user_id = user_id;
			this.name = name;
			this.pw = pw;
			this.comment = comment;
			this.star = star;
		    this.date = new Date(date).toLocaleString('ko-KR', {
		        year: 'numeric', 
		        month: 'numeric', 
		        day: 'numeric', 
		        hour: '2-digit', 
		        minute:'2-digit',
		        hourCycle: 'h23'
		    });
		    this.print = function() {
		        return "<table>"
		            + "<tr>"
		                + "<td class='inner_name'>" + this.name + "</td>"
		                + "<td class='inner_date'>" + this.date + "</td>"
		                + "<td class='inner_star'>★" + this.star + "</td>"
		            + "</tr>"
		            + "<tr><td colspan='3'>" + this.comment + "</td></tr>"
		            + "<tr>"
		                + "<td class='inner_btn' colspan='3'>"
		                    + "<input class='comment_table_btn change_btn hidden_btn' data-seq=" + this.seq + " type='button' value='수정'>"
		                    + "<input class='comment_table_btn delete_btn hidden_btn' data-seq=" + this.seq + " type='button' value='삭제'>"
		                + "</td>"
		            + "</tr>"
		        + "</table>";
		    };
		    this.printUser = function() {
		        return "<table>"
		            + "<tr>"
		                + "<td class='inner_name'>" + this.name + "</td>"
		                + "<td class='inner_date'>" + this.date + "</td>"
		                + "<td class='inner_star'>★" + this.star + "</td>"
		            + "</tr>"
		            + "<tr><td colspan='3'>" + this.comment + "</td></tr>"
		            + "<tr>"
		                + "<td class='inner_btn' colspan='3'>"
			            	+ "<input class='comment_table_btn change_btn' data-seq=" + this.seq + " type='button' value='수정'>"
			            	+ "<input class='comment_table_btn delete_btn' data-seq=" + this.seq + " type='button' value='삭제'>"
		                + "</td>"
		            + "</tr>"
		        + "</table>";
		    };
		};	// StarComm end
		
		<% List<ReviewDTO> reviewList = (List<ReviewDTO>)request.getAttribute("review_list"); %>
		let grade_arr = [
			<% if(reviewList != null) {
					for (ReviewDTO dto : reviewList) { %>
						new StarComm(<%= dto.getSeq() %>,
								"<%= dto.getUser_id() %>",
								"<%= dto.getName() %>",
								"<%= dto.getPw() %>",
								"<%= dto.getContents() %>",
								<%= dto.getRating_star() %>,
								"<%= dto.getWriting_time() %>"),
					<% }
				} %>
		];	// review data end
		
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
			
			/// Review event
			// write event
		    $("#star_radio *").on("click", function() {
		        $("#write_star").text("★" + $(this).val());
		    });
		    $("#write_text").on({
		        keyup: function() {
		            let text_len = $(this).val().length;
		            let text_max = 100;
		            if (100 - text_len > 0) {
		                $("#text_th").text(text_len + "/" + text_max);
		            }
		            else {
		                alert(text_max + "자 까지 입력할 수 있습니다.");
		                $(this).val($(this).val().slice(0, 99));
		                $("#text_th").text(text_len + "/" + text_max);
		            }
		        },
		        focusin: function() {
		            if ($(this).val() == "댓글을 입력하세요.")
		                $(this).val("");
		            $(this).css({
		                "color": "white",
		                "outline": "none"
		            });
		        },
		        focusout: function() {
		            if ($(this).val() == "") {
		                $(this).val("댓글을 입력하세요.");
		                $(this).css("color", "#5F5F5F");
		            }
		        }

		    });
		    $("#write_btn").on("click", function(event) {
		    	event.preventDefault();
		    	if (${ session_id != null }) {
			        let empty_inputs = $(".is_write").filter(function() {
			            if ($(this).attr("id") === "write_text")
			                return $(this).val() === "댓글을 입력하세요.";
			            else
			                return $(this).val() === ""; 
			        });
			        if (empty_inputs.length > 0) {
			            let result = empty_inputs.map(function() {return this.name}).get().join(", ");
			            alert(result + "을(를) 입력하세요.");
			        }
			        else {
			        	if (${ rv_c > 0 }) {
			        		alert("리뷰는 한 번만 작성할 수 있습니다.");
			        	}
			        	else {
				            $("#write_comment").submit();			        		
			        	}
			        };
		    	}
		    	else {
		    		alert("로그인 후에 작성할 수 있습니다.");
		    	}
		    });

		    // sort event
		    let session_id = "${ session_id }";
		    $(".sort_btn[data-target='" + "${ sort_type }" + "']").addClass("sort_active");
		    $(".page_a:contains('" + ${ page } + "')").addClass("sort_active");
		    $(".sort_btn").on("click", function() {
		        window.location.href = "detailedgrade?movie_id=" + ${ movie_dto.movie_id } + "&sort_type=" + $(this).data("target");
		    });
	        grade_arr.forEach((g) => {
	            if (g.user_id == session_id) {
	            	$("#comment_list").append("<li id='c_li" + g.seq + "' data-seq='" + g.seq + "'>" 
	            			+ g.printUser() 
	            			+ "</li>");
	            }
	            else {
	            	$("#comment_list").append("<li id='c_li" + g.seq + "' data-seq='" + g.seq + "'>" + g.print() + "</li>");
	            }
	        });
	        
	        // my_review

		    // comment table button event
		    let td, what_btn, this_seq, find_data, find_pw;

		    $(document).on("click", ".comment_table_btn", function() {
		        this_seq = $(this).closest("li").data("seq");
		        find_data = grade_arr.find(item => item.seq == this_seq);
		        find_pw = (find_data).pw;
		        td = $(this).closest("td");
		    });

		    // pw input create
		    $(document).on("click", ".change_btn, .delete_btn", function() {
		        what_btn = $(this).val();
		        td.html("암호 <input id='pw_confirm" + this_seq + "' class='pw_confirm' type='password'>"
		            + "<input class='comment_table_btn pw_btn' type='button' value='확인'>"
		        );
		    });

		    // pw confirm
		    $(document).on("click", ".pw_btn", function() {
		        if ($("#pw_confirm" + this_seq).val() == find_pw) {
		            if (what_btn == "수정") {
		                $(this).closest("li").html("<form action='detailedgradeupdate' method='post'>"
		                	+ "<table style='padding: 10px; border: 2px solid #52057B'>"
		                	+ "<tr>"
		                        + "<td class='change_input'>" + find_data.name + "</td>"
		                        + "<td class='inner_star'>"
		                            + "<select id='change_star' name='rating_star'>"
		                                + "<option value='1'>★1</option>"
		                                + "<option value='2'>★2</option>"
		                                + "<option value='3'>★3</option>"
		                                + "<option value='4'>★4</option>"
		                                + "<option value='5'>★5</option>"
		                                + "<option value='6'>★6</option>"
		                                + "<option value='7'>★7</option>"
		                                + "<option value='8'>★8</option>"
		                                + "<option value='9'>★9</option>"
		                                + "<option value='10'>★10</option>"
		                            + "</select>"
		                        + "</td>"
		                    + "</tr>"
		                    + "<tr>"
		                        + "<td colspan='3'>"
		                        	+ "<textarea id='change_comment' name='contents' rows='4' cols='50' style='width: 800px;'>" 
		                        		+ find_data.comment
		                        	+ "</textarea>"
		                        + "</td>"
		                    + "</tr>"
		                    + "<tr>"
		                    	+ "<td class='inner_btn' colspan='3'>"
		                    		+ "<input class='comment_table_btn change_confirm_btn' type='submit' value='수정완료'>"
		                        + "</td>"
		                    + "</tr></table>"
		                    + "<input type='hidden' name='seq' value='" + this_seq + "'>"
		                    + "<input type='hidden' name='movie_id' value='" + ${ movie_dto.movie_id } + "'>"
		                    + "</form>"
		                );
		                $("#change_star").val(find_data.star.toString()).prop("selected", true);
		            }
		            else if (what_btn == "삭제") {
		                let is_delete = confirm("정말 삭제하시겠습니까?");
		                if (is_delete) {
		                	console.log(this_seq + " : " + ${ movie_dto.movie_id })
		                	window.location.href = "detailedgradedelete?movie_id=" + ${ movie_dto.movie_id } 
		                		+ "&seq=" + this_seq;
		                }
		                else {
		                    td.html("<input class='comment_table_btn change_btn' data-seq=" + this_seq + " type='button' value='수정'>"
				            	+ "<input class='comment_table_btn delete_btn' data-seq=" + this_seq + " type='button' value='삭제'>"
		                    );
		                }
		            }
		        }
		        else {
		            alert("암호가 틀렸습니다.");
		            td.html("<input class='comment_table_btn change_btn' data-seq=" + this_seq + " type='button' value='수정'>"
			        	+ "<input class='comment_table_btn delete_btn' data-seq=" + this_seq + " type='button' value='삭제'>"
		            );
		        }
		    });		// review event end
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
	    	<input type="hidden" value="grade" name="page_name">
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
        <input id="photo_btn" class="main_btns" type="button" data-url="detailedphoto?movie_id=${ movie_dto.movie_id }" value="사진">
        <input id="grade_btn" class="main_btns active" type="button" data-url="detailedgrade?movie_id=${ movie_dto.movie_id }" value="평점">
    </div>
    
	<div id="grade_contents" class="contents">
        <div id="grade_title">
            <h1><img class="bar" src="resources/images/Bar.svg">평점</h1>
            <h2>★${ movie_dto.star }점(${ total_cnt }개)</h2>
        </div>
        <form id="write_comment" action="detailedgradeinsert" method="post">
            <div id="write_title">
                작성자 <div id="writer">${ user_dto.name }</div>
                별점
                <div id="star_radio">
                    <input type="radio" name="rating_star" value="1">
                    <input type="radio" name="rating_star" value="2">
                    <input type="radio" name="rating_star" value="3">
                    <input type="radio" name="rating_star" value="4">
                    <input type="radio" name="rating_star" value="5">
                    <input type="radio" name="rating_star" value="6">
                    <input type="radio" name="rating_star" value="7">
                    <input type="radio" name="rating_star" value="8">
                    <input type="radio" name="rating_star" value="9">
                    <input type="radio" name="rating_star" value="10" checked>
                </div>
                <p id="write_star">★10</p><br>
            </div>
            <c:choose>
            	<c:when test="${ session_id != null }">
            		<textarea id="write_text" class="is_write" name="contents" rows="4" cols="80">댓글을 입력하세요.</textarea>
            	</c:when>
            	<c:otherwise>
            		<textarea id="write_text" class="is_write" name="contents" rows="4" cols="80" readonly>로그인 후에 작성할 수 있습니다.</textarea>
            	</c:otherwise>
            </c:choose>
            <div id="write_end">
                <p id="text_th">0/100</p>
                <input id="write_btn" type="submit" value="등록">
            </div>
            <input type="hidden" name="user_id" value="${ user_dto.user_id }">
            <input type="hidden" name="pw" value="${ user_dto.pw }">
            <input type="hidden" name="movie_id" value="${ movie_dto.movie_id }">
        </form>
        <div id="comment_sort">
            <input class="sort_btn" data-target="date" type="button" value="최신순">
            <input class="sort_btn" data-target="star" type="button" value="별점순">
            <input class="sort_btn" data-target="user" type="button" value="내평점">
        </div>
        <ul id="comment_list"></ul>
        <div id="page_nums">
        <%	
        	MovieDTO movie_dto = (MovieDTO)request.getAttribute("movie_dto");
        	String movie_id = movie_dto.getMovie_id();
        	String sort_type = (String)request.getAttribute("sort_type");
        	int divNum = (Integer)request.getAttribute("divNum");
        	int cnt = (Integer)request.getAttribute("cnt");
        	int totalPage = cnt / divNum;
        	
        	if (cnt % divNum != 0)
        		totalPage++;
        	
        	for (int p = 1; p <= totalPage; p++)
        		out.println("&nbsp;<a class='page_a'"
        			+ " href=\"detailedgrade?movie_id=" + movie_id + "&sort_type=" + sort_type + "&page=" + p + "\">"
        			+ p + "</a>&nbsp;");
        %>
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