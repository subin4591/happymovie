<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="resources/images/MainIcon.ico">
    <title>슈퍼 마리오 브라더스ㅣHAPPYMOVIE</title>
    <link href="resources/css/detailed.css" rel=stylesheet>
    <script src="resources/js/jquery-3.6.4.min.js"></script>
    <script src="resources/js/detailed.js"></script>
</head>
<body>
    <header>
        <a href="main.html"><img id="logo" src="resources/images/logo.svg"></a>
        <input id="login" type="button" value="LOGIN" onclick = "location.href = 'finalLogin.html'">
        <div id="search">
            <form id="searchForm" method="GET" action="search.html" accept-charset="UTF-8">
                <input class="inputValue" name="query" type="text" value="영화 제목">
                <input class="searchImg" type="image" type="submit" src="resources/images/searchIcon.svg">
            </form>
        </div>
    </header>

    <img id="main_poster" src="resources/images/photos/posters/poster0.jfif">
    <div id="main">
        <h1>슈퍼 마리오 브라더스</h1>
        <h3>The Super Mario Bros. Movie, 2023</h3>
        <table id="main_table">
            <tr>
                <th>개봉</th><td>2023.04.26</td>
                <th>평점</th><td id="main_grade">★8.4</td>
            </tr>
            <tr>
                <th>장르</th><td>애니메이션/어드벤처/코미디</td>
                <th>누적관객</th><td>1,018,350명</td>
            </tr>
            <tr>
                <th>국가</th><td>미국, 일본</td>
                <th>박스오피스</th><td id="go_rank" onclick="location.href = 'rank'">2위</td>
            </tr>
            <tr>
                <th>등급</th><td>전체관람가</td>
                <th>러닝타임</th><td>92분</td>
            </tr>
            <tr>
                <th>감독</th><td>아론 호바스, 마이클 젤레닉</td>
                <th>제작사</th><td>유니버설 픽쳐스</td>
            </tr>
        </table>
    </div>

    <div id="main_btns">
        <input id="info_btn" class="main_btns" type="button" data-target="#info_contents" data-end="1119" value="정보">
        <input id="person_btn" class="main_btns" type="button" data-target="#person_contents" data-end="1645" value="인물">
        <input id="photo_btn" class="main_btns" type="button" data-target="#photo_contents" data-end="1168" value="사진">
        <input id="grade_btn" class="main_btns" type="button" data-target="#grade_contents" value="평점">
    </div>

    <div id="info_contents" class="contents">
        <h1><img class="bar" src="resources/images/Bar.svg">시놉시스</h1>
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
    </div>

    <div id="person_contents" class="contents">
        <h1><img class="bar" src="resources/images/Bar.svg">감독</h1>
        <table id='director_table' class='is_profile'><tr></tr><tr></tr></table>
        <h1><img class="bar" src="resources/images/Bar.svg">출연</h1>
        <table id='actor_table' class='is_profile'><tr></tr><tr></tr><tr></tr></table>
        <h1><img class="bar" src="resources/images/Bar.svg">제작진</h1>
        <table id='crew_table' class='not_profile'></table>
        <h1><img class="bar" src="resources/images/Bar.svg">영화사</h1>
        <table id='company_table' class='not_profile'></table>
    </div>

    <div id="photo_contents" class="contents">
        <div id="posters_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">포스터</h1>
            <input id="posters_more" class="more_btns" type="button" data-target="#photo_contents_posters" data-end="1440" value="더보기">
        </div>
        <table id="posters_table" class="photo_table"><tr></tr></table>
        <div id="stills_title" class="photo_titles">
            <h1><img class="bar" src="resources/images/Bar.svg">스틸컷</h1>
            <input id="stills_more" class="more_btns" type="button" data-target="#photo_contents_stills" data-end="1220" value="더보기">
        </div>
        <table id="stills_table" class="photo_table"><tr></tr></table>
    </div>

    <div id="photo_contents_posters" class="contents">
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

    <div id="photo_contents_stills" class="contents">
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

    <div id="grade_contents" class="contents">
        <div id="grade_title">
            <h1><img class="bar" src="resources/images/Bar.svg">평점</h1>
            <h2>★8.8점(10개)</h2>
        </div>
        <div id="write_comment">
            <div id="write_title">
                작성자 <input id="writer" class="is_write" name="작성자" type="text">
                암호 <input id="pw" class="is_write" name="암호" type="password">
                별점
                <div id="star_radio">
                    <input type="radio" name="start_select" value="1">
                    <input type="radio" name="start_select" value="2">
                    <input type="radio" name="start_select" value="3">
                    <input type="radio" name="start_select" value="4">
                    <input type="radio" name="start_select" value="5">
                    <input type="radio" name="start_select" value="6">
                    <input type="radio" name="start_select" value="7">
                    <input type="radio" name="start_select" value="8">
                    <input type="radio" name="start_select" value="9">
                    <input type="radio" name="start_select" value="10" checked>
                </div>
                <p id="write_star">★10</p><br>
            </div>
            <textarea id="write_text" class="is_write" name="댓글" rows="4" cols="80">댓글을 입력하세요.</textarea>
            <div id="write_end">
                <p id="text_th">0/100</p>
                <input id="write_btn" type="button" value="등록">
            </div>
        </div>
        <div id="comment_sort">
            <input class="sort_btn" data-target="date" id="sort_date_btn" type="button" value="최신순">
            <input class="sort_btn" data-target="star" type="button" value="별점순">
        </div>
        <ul id="comment_list"></ul>
    </div>

    <footer>
        <p>
            HAPPY MOVIE<br>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </p>
    </footer>
</body>
</html>