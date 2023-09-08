<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import = "java.util.*"%>

<% 
		String muteB = "1"; //동영상 뮤트 여부
             
%>

<!DOCTYPE html>
<html></html>
<head>
    <meta charset="UTF-8">
    <title>MAIN | HAPPYMOVIE</title>
    <link href = "resources/images/MainIcon.ico"" rel = "shortcut icon">
    <link rel = "stylesheet" href = "resources/css/main.css">
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>  
        $(document).ready(function() {
        	
        	
            // video slide       
            let mainView = [$('#main_video1'), $('#main_video2'), $('#main_video3')];
            let slideView = mainView[0];
            function mainView1(){
                if ($('#slide1').prop('checked')){
                    slideView = mainView[0];
                }
                else if ($('#slide2').prop('checked')){
                	slideView = mainView[1];
                }
                else if ($('#slide3').prop('checked')){
                    slideView = mainView[2];
                }
            };
         // video volume
            $("#volumeMuted").hover(function(){
                if($(this).attr("src") === "resources/images/volumeMuted.svg")
                    $(this).attr("src","resources/images/volumeMuted2.svg");
                else $(this).attr("src","resources/images/volumeUnmuted2.svg");
                $(this).css("width", "60px")
                $(this).css("height", "60px")
                $(this).css("transition","0.2s");
            },function(){
                if($(this).attr("src") === "resources/images/volumeMuted2.svg")
                    $(this).attr("src","resources/images/volumeMuted.svg");
                else $(this).attr("src","resources/images/volumeUnmuted.svg");
                $(this).css("width", "50px")
                $(this).css("height", "50px")
                $(this).css("transition","0.2s");
            });
			
         // chrome 정책상? 자동재생과 음소거 해제 동시에 불가능하다고 함..
            $("#volumeMuted").click(function(){
                mainView1();
                if($(this).attr("src") === "resources/images/volumeMuted2.svg"){
                    $(this).attr("src","resources/images/volumeUnmuted2.svg");
                    <%muteB = "0"; %>
                    if ($('#slide1').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex].getVideo_url()}+"&controls=0");
                    }
                    else if ($('#slide2').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex2].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex2].getVideo_url()}+"&controls=0");
                    }
                    else if ($('#slide3').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex3].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex3].getVideo_url()}+"&controls=0");
                    }
                }
                else{
                    $(this).attr("src","resources/images/volumeMuted2.svg");
                    <%muteB = "1"; %>
                    if ($('#slide1').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex].getVideo_url()}+"&controls=0");
                    }
                    else if ($('#slide2').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex2].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex2].getVideo_url()}+"&controls=0");
                    }
                    else if ($('#slide3').prop('checked')){
                    	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex3].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex3].getVideo_url()}+"&controls=0");
                    }
                }
            });

            // video slide
            let slideL = $('.video_slide_left');
            let slideR = $('.video_slide_right');
            let slideT = $('.video_caption');

            function slideText1(){
                slideT.animate({opacity : -100}, 150, function(){
                    if ($('#slide1').prop('checked')){
                    slideT.text("${videoList[mIndex].getComment()}");
                }
                else if ($('#slide2').prop('checked')){
                	 slideT.text("${videoList[mIndex2].getComment()}");
                }
                else if ($('#slide3').prop('checked')){
                	 slideT.text("${videoList[mIndex3].getComment()}");
                }
                });
                
                slideT.animate({opacity : 100}, 150);
            };

            function muteSlide(){
            	<%muteB = "1"; %>
                $("#volumeMuted").attr("src","resources/images/volumeMuted.svg");
                if ($('#slide1').prop('checked')){
                	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex].getVideo_url()}+"&controls=0");
                }
                else if ($('#slide2').prop('checked')){
                	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex2].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex2].getVideo_url()}+"&controls=0");
                }
                else if ($('#slide3').prop('checked')){
                	slideView.attr("src","https://play-tv.kakao.com/embed/player/cliplink/"+${videoList[mIndex3].getVideo_url()}+"?autoplay="+<%=muteB %>+"&mute="+<%=muteB %>+"&profile=HIGH&loop=1&playlist="+${videoList[mIndex3].getVideo_url()}+"&controls=0");
                }
            };
            
            slideL.click(function(){
                if($('#slide1').prop('checked')) $('#slide3').prop('checked', true);
                else if($('#slide2').prop('checked')) $('#slide1').prop('checked', true);
                else if($('#slide3').prop('checked')) $('#slide2').prop('checked', true);
                muteSlide();
                slideText1();
                //slideView.get(0).currentTime = 0;
            });
            slideR.click(function(){
                if($('#slide1').prop('checked')) $('#slide2').prop('checked', true);
                else if($('#slide2').prop('checked')) $('#slide3').prop('checked', true);
                else if($('#slide3').prop('checked')) $('#slide1').prop('checked', true);
                muteSlide();
                slideText1();
                //slideView.get(0).currentTime = 0;
            });
            
            // search
            let sInput = $("#search .inputValue");
            let sBtn = $("#search .searchImg");
            let sForm = $("#search #searchForm");
        
            window.onpageshow = function(event){
            if ( event.persisted || (window.performance && window.performance.navigation.type == 2))
            sInput.val("");
        };

            sInput.focusin(function() {
                sInput.css({
                    "color": "white",
                    "outline": "none"
                });
            });
            var rule = /^\s+$/
            sForm.submit(function(event){                
                if(sInput.val() === "" || sInput.val().match(rule) || sInput.val() === 0){
                    alert("검색어를 입력하세요");                
                    event.preventDefault();
                    return;
                }
            });
            sBtn.click(function(){
                if(sInput.val() === "" || sInput.val().match(rule) || sInput.val() === 0){
                    alert("검색어를 입력하세요");                
                    event.preventDefault();
                    return;
                }
                var data = encodeURIComponent(sInput.val());
                sInput.val(data);
                sInput.css("color", "rgb(0,0,0)");
                sform.submit();    
            });
            setTimeout(function(){
                sInput.val('');
            });  
        });
    </script>
    <style></style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS" crossorigin="anonymous"></script>

    <div class = "main_page">
        <header class = "main_head">
            <div class = "main_top">
                <div class = "main_logo">
                    <a href = "/happymovie/main" class = "link_main">
                        <img src = "resources/images/logo.svg" class = "logo_main" alt = "Main">
                    </a>
                </div>
                <div class = "login">
                	<c:choose>
			        	<c:when test="${ session_id != null }">
			        		<a href="loginuserinfo"><img id="user_icon" src="resources/images/userIcon.png"></a>
			        		<button id = "button_login" type = "button" onclick = "location.href = 'logout'">LOGOUT</button>
			        	</c:when>
			        	<c:otherwise>
			        		<button id = "button_login" type = "button" onclick = "location.href = 'login'">LOGIN</button>
			        	</c:otherwise>
                	</c:choose>
                </div>
            </div>
        </header>
        
        <div class ="main_video_container">
            <div class = "main_view_list">
                <input type = "radio" name = "slide" id = "slide1" checked>
                <input type = "radio" name = "slide" id = "slide2">
                <input type = "radio" name = "slide" id = "slide3">
                
                <div class = "slideView">
                    <ul class= "slideList">
                        <li>
                            <a>
                            <iframe id = "main_video1" allow="autoplay; fullscreen; encrypted-media" 
                            allowfullscreen="" 
                            src="https://play-tv.kakao.com/embed/player/cliplink/
                            ${videoList[mIndex].getVideo_url()}?autoplay=<%=muteB %>&mute=<%=muteB %>&profile=HIGH&loop=1&playlist=
                            ${videoList[mIndex].getVideo_url()}&controls=0">
                            </iframe>
                            </a>
                        </li>
                        <li>
                            <a>
                                <iframe id = "main_video2" allow="autoplay; fullscreen; encrypted-media" 
                            allowfullscreen="" 
                            src="https://play-tv.kakao.com/embed/player/cliplink/
                            ${videoList[mIndex2].getVideo_url()}?autoplay=<%=muteB %>&mute=<%=muteB %>&profile=HIGH&loop=1&playlist=
                            ${videoList[mIndex2].getVideo_url()}&controls=0">
                            </iframe>
                            </a>
                        </li>
                        <li>
                            <a>
                                <iframe id = "main_video3" allow="autoplay; fullscreen; encrypted-media" 
                            allowfullscreen="" 
                            src="https://play-tv.kakao.com/embed/player/cliplink/
                            ${videoList[mIndex3].getVideo_url()}?autoplay=<%=muteB %>&mute=<%=muteB %>&profile=HIGH&loop=1&playlist=
                            ${videoList[mIndex3].getVideo_url()}&controls=0">
                            </iframe>
                            </a>
                        </li>
                    </ul>
                    <!-- 
                    <video autoplay loop muted id = "main_video3" oncontextmenu="return false">
                                    <source src = "resources/video/슈퍼 마리오 브라더스 공식 2차 예고편.mp4" type = "video/mp4">
                                    <strong>해당 브라우저에서는 영상을 지원하지 않습니다.</strong>
                                </video>
                     -->
                </div>
            </div>
            
            <div class = "video_caption" >
            ${videoList[mIndex].getComment()}
            </div> 
            
            <div class = "video_slide_left">
                <img src = "resources/images/videoSlideLeft.svg" id = "videoSlideLeft" alt = "videoSlideLeft">
            </div>
            <div class = "video_slide_right">
                <img src = "resources/images/videoSlideRight.svg" id = "videoSlideRight" alt = "videoSlideRight">
            </div>
            <div class = "video_volume_button">
                <img src = "resources/images/volumeMuted.svg" alt = "ImgButton" id = "volumeMuted">
            </div>
        </div>

        <div class = "main_search">
            <div id ="search">
                <form id = "searchForm" method = "GET" action = "/happymovie/search" accept-charset="UTF-8">
                    <input type="text" class = "inputValue" name = "query" placeholder="영화 제목">
                    <input type="image" type = "submit" src="resources/images/searchIcon.svg" class = "searchImg">
                </form>
            </div>
        </div>

        <div class = "main_menu">
            <nav id = "main_menu">
                <ul>
                    <li><a class = "menulink" id = "actionL" href = "genrelist?genre=action">액션<br>TOP 10</a></li>
                    <li><a class = "menulink" id = "comedyL" href = "genrelist?genre=comedy">코미디<br>TOP 10</a></li>
                    <li><a class = "menulink" id = "thrillerL" href = "genrelist?genre=thriller">스릴러<br>TOP 10</a></li>
                    <li><a class = "menulink" id = "romanceL" href = "genrelist?genre=romance">로맨스<br>TOP 10</a></li>
                    <li><a class = "menulink" id = "fantasyL" href = "genrelist?genre=fantasy">판타지<br>TOP 10</a></li>
                </ul>
            </nav>
        </div>

        <div class = "main_ranking_text">
            <h2> <img src = "resources/images/Bar.svg" alt = "" style = "position : absolute; top:40px; left : -20px; width : 10px; height : 45px;">
                전체 영화 랭킹 TOP5</h2>
        </div>

        <div class = "main_ranking_5">
            <nav id = "main_ranking_5">
                <ul>
                    <li><a class = "ranking5link" href = "/happymovie/detailed?movie_id=${ranking5List[0].getMovie_id()}">
                        <h3>1
                            <img src = "resources/images/star/${ranking5star0}" alt = "star" class = "star">
                        </h3>
                        <img src = "${ranking5List[0].getImg_url()}" onerror="this.src = 'resources/images/NoMovie.png'"	alt = "movie1"><br>
                        <h6>${ranking5List[0].getKor_title()}</h6>
                    </a></li>
                    <li><a class = "ranking5link" href = "/happymovie/detailed?movie_id=${ranking5List[1].getMovie_id()}">
                        <h3>2
                            <img src = "resources/images/star/${ranking5star1}" alt = "star" class = "star">
                        </h3>
                        <img src = "${ranking5List[1].getImg_url()}" onerror="this.src = 'resources/images/NoMovie.png'" alt = "movie2"><br>
                        <h6>${ranking5List[1].getKor_title()}</h6>
                    </a></li>
                    <li><a class = "ranking5link" href = "/happymovie/detailed?movie_id=${ranking5List[2].getMovie_id()}">
                        <h3>3
                            <img src = "resources/images/star/${ranking5star2}" alt = "star" class = "star">
                        </h3>
                        <img src = "${ranking5List[2].getImg_url()}" onerror="this.src = 'resources/images/NoMovie.png'" alt = "movie3"><br>
                        <h6>${ranking5List[2].getKor_title()}</h6>
                    </a></li>
                    <li><a class = "ranking5link" href = "/happymovie/detailed?movie_id=${ranking5List[3].getMovie_id()}">
                        <h3>4
                            <img src = "resources/images/star/${ranking5star3}" alt = "star" class = "star">
                        </h3>
                        <img src = "${ranking5List[3].getImg_url()}" onerror="this.src = 'resources/images/NoMovie.png'" alt = "movie4"><br>
                        <h6>${ranking5List[3].getKor_title()}</h6>
                    </a></li>
                    <li><a class = "ranking5link" href = "/happymovie/detailed?movie_id=${ranking5List[4].getMovie_id()}">
                        <h3>5
                            <img src = "resources/images/star/${ranking5star4}" alt = "star" class = "star">
                        </h3>
                        <img src = "${ranking5List[4].getImg_url()}" onerror="this.src = 'resources/images/NoMovie.png'" alt = "movie5"><br>
                        <h6>${ranking5List[4].getKor_title()}</h6>
                    </a></li>
                </ul>
            </nav>
        </div>

		<div class = "main_ranking_text">
            <h2> <img src = "resources/images/Bar.svg" alt = "" style = "position : absolute; top:40px; left : -20px; width : 10px; height : 45px;">
                전체 영화 랭킹 TOP5</h2>
        </div>
        <div class = "main_bookmark_text">
            <h2> <img src = "resources/images/Bar.svg" alt = "" style = "position : absolute; top:40px; left : -20px; width : 10px; height : 45px;">
                나의 북마크</h2>
        </div>

        <div class = "main_bookmark">
            <nav id = "main_bookmark">
                <ul>
                   	<%
                    	List<String> bm = (List<String>)request.getAttribute("bookmarkListm");
                    	List<String> bi = (List<String>)request.getAttribute("bookmarkListi");
                    	List<String> bt = (List<String>)request.getAttribute("bookmarkListt");
                    	
                    	for (int i = 0; i < bm.size(); i++) { %>
                    		<li>
                    			<a class = 'bookmark' href = '/happymovie/detailed?movie_id=<%= bm.get(i) %>'>
                    			<img src = '<%= bi.get(i) %>' alt = 'movie'><br>
                    			<h6><%= bt.get(i) %></h6>
                    			<form action="mainbookmarkdelete" method="post" id="mainbookmarkdelete">
	                    			<button class = "btnD">
				                    	<img src = "resources/images/bookmarkOn.svg" alt = "<%= bm.get(i) %>" class = "bookmarkButton">
				                    </button>
                    				<input type="hidden" value="<%= bm.get(i) %>" name="movie_id">
                    				<input type="hidden" value="${ session_id }" name="user_id">
                    			</form>
                    		</li>
                    	<%
                    	}
                   	%>
                </ul>
            </nav>
        </div>
        
        <script>
        $(document).ready(function() {
        	//bookmark button
        	$(".bookmarkButton").click(function(){
				$("#mainbookmarkdelete").submit();
        	});
        });
        </script>
        
        <footer>
            <p>HAPPY MOVIE<br/>
                대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom
                소회의실4
            </footer>
    </div>
</body>
