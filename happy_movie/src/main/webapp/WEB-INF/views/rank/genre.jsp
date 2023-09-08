<%@page import="dto.ApiDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="referrer" content="no-referrer" />
	<title>RANK | HAPPYMOVIE</title>
	<link href = "resources/images/MainIcon.ico" rel = "shortcut icon">
	<link href = "resources/css/rank.css?v=1" rel = "stylesheet">
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
		
		});
	</script>

</head>
<body>
	

<header class="top"> 
    <div class="main_logo">
        <a href="main"><img src="resources/images/logo.svg" alt="Main" id="logo"></a>
        <%if(session.getAttribute("session_id") != null){ %>
          <a href="loginuserinfo"><img id="user_icon" src="resources/images/userIcon.png"></a>
         <%} %>
    </div>
    <div class = "login">
    	<%if(session.getAttribute("session_id") == null){ %>
        <button id = "button_login" type = "button"><a href = "login">LOGIN</a></button>
        <%} else{%>
        <button id = "button_logout" type = "button"><a href = "logout">LOGOUT</a></button>
        <%} %>
    </div>

    <div id="search">
        <form id = "searchForm" method = "GET" action = "/happymovie/search" accept-charset="UTF-8">
             <input type="text" class = "inputValue" name = "query" placeholder="영화 제목">
			 <img src="resources/images/searchIcon.svg" class="search_img"/>
        </form>
    </div>
</header>
    <div class="wrap"> 
        <div class="choice">
            <span id="reservation" class="link"><a href="rank">예매율순 </a></span>| <span id="grade" class="link"><a href="grade">평점순</a></span> | <span id="genre" class="link purple">장르별</span>
        </div>
        <div class="genre_choice" style="display:block">
            <span id="action" class="genre_text" ><a href="genrelist?genre=action">액션</a></span>
            <span id="comedy" class="genre_text" ><a href="genrelist?genre=comedy">코미디</a></span>
            <span id="thriller" class="genre_text" ><a href="genrelist?genre=thriller">스릴러</a></span>
            <span id="romance" class="genre_text" ><a href="genrelist?genre=romance">로맨스</a></span>
            <span id="fantasy" class="genre_text"><a href="genrelist?genre=fantasy">판타지</a></span>
		</div>
        
        
        <div class="content">
        <table class="genre_table">
            <%int num = 1; 
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%>
            <tr>
            <c:forEach items="${genreList}" var="dto" begin="0" end="4">
            <% 
            ApiDTO dto1 = (ApiDTO)pageContext.getAttribute("dto");
            Date date = inputFormat.parse(String.valueOf(dto1.getRelease_date()));
		    String release_date = outputFormat.format(date);%>
				<td>
					<a href="detailed?movie_id=${dto.movie_id}" >
					<div class="rating_age">
									<c:choose>
									 	<c:when test="${dto.rating_age eq '전체관람가'}">
									 		<img alt="관람등급" src="resources/images/age_all.png">
									 	</c:when>
									 	<c:when test="${dto.rating_age eq '12세이상관람가'}">
									 		<img alt="관람등급" src="resources/images/age_12.png">
									 	</c:when>
									 	<c:when test="${dto.rating_age eq '15세이상관람가'}">
									 		<img alt="관람등급" src="resources/images/age_15.png">
									 	</c:when>
									 	<c:otherwise>
									 		<img alt="관람등급" src="resources/images/age_19.png">
									 	</c:otherwise>
									</c:choose>
								</div>
					<div class='inner_wrap'>
                           <div class="inner_text">
                               <span class="back"> ${dto.synopsis }"</span>
                           </div>
                       </div> 
                       </a>
                       <div class='img_wrap'>
                               <img referrerpolicy="no-referrer" src="${dto.img_url}" alt="영화포스터" class="img" onerror="this.src='resources/images/noimg.jpg';">
                       </div>
                       <h3><a href="detailed?movie_id=${dto.movie_id}" ><c:out value="${dto.kor_title }"/></a></h3>
                       <p>평점 <span class='score'>${dto.rating_star}</span></p>
                       <p>국가 ${dto.country }</p>
                       <p>러닝타임 ${dto.running_time}분</p>
                       <p>개봉 <c:out value="<%=release_date %>"/></p>
				</td>	
			</c:forEach>
			</tr>
			<tr>
			<c:forEach items="${genreList}" var="dto" begin="5" end="10">
			<% 
            ApiDTO dto1 = (ApiDTO)pageContext.getAttribute("dto");
            Date date = inputFormat.parse(String.valueOf(dto1.getRelease_date()));
		    String release_date = outputFormat.format(date);%>
				<td>
					<a href="detailed?movie_id=${dto.movie_id}" >
					<div class="rating_age">
									<c:choose>
									 	<c:when test="${dto.rating_age eq '전체관람가'}">
									 		<img alt="관람등급" src="resources/images/age_all.png">
									 	</c:when>
									 	<c:when test="${dto.rating_age eq '12세이상관람가'}">
									 		<img alt="관람등급" src="resources/images/age_12.png">
									 	</c:when>
									 	<c:when test="${dto.rating_age eq '15세이상관람가'}">
									 		<img alt="관람등급" src="resources/images/age_15.png">
									 	</c:when>
									 	<c:otherwise>
									 		<img alt="관람등급" src="resources/images/age_19.png">
									 	</c:otherwise>
									</c:choose>
								</div>
					<div class='inner_wrap'>
                           <div class="inner_text">
                               <span class="back"> ${dto.synopsis }"</span>
                           </div>
                       </div> 
                       </a>
                       <div class='img_wrap'>
                               <img referrerpolicy="no-referrer" src="${dto.img_url}" alt="영화포스터" class="img" onerror="this.src='resources/images/noimg.jpg';">
                       </div>
                       <h3><a href="detailed?movie_id=${dto.movie_id}" ><c:out value="${dto.kor_title }"/></a></h3>
                       <p>평점 <span class='score'>${dto.rating_star}</span></p>
                       <p>국가 ${dto.country }</p>
                       <p>러닝타임 ${dto.running_time}분</p>
                       <p>개봉 <c:out value="<%=release_date%>"/></p>
				</td>	
			<%num++; %>
			</c:forEach>
			</tr>
          	</table> 
			<%
			  String genre = (String)request.getAttribute("genre");
			  int currentPage = (Integer)request.getAttribute("page");
			  int totalGenre = (Integer)request.getAttribute("totalGenre");
			  int totalPage = 0;
			  if(totalGenre % 10 == 0){
				  totalPage = totalGenre / 10;
			  }
			  else{
				  totalPage = totalGenre / 10 + 1;
			  }
			  int itemsPerPage = 5;
			  int startPage = 0;
			  if(currentPage % 5 == 0){
				  startPage =  currentPage / 5 * 5 - 4;
			  }else startPage =  currentPage / 5 * 5 + 1;
			  int endPage = startPage + 4;
			  
			  
			  %>
			  <div class="num_div">
			  	<div class="num_wrap">
			  	<% if(startPage > 5){ %>
				   <a href="genrelist?genre=<%=genre %>&page=<%=startPage - 5 %>">&lt;</a>
				   <%} %>
<!-- 			  		<span class="prev" >&lt;</span> -->
			  		<% 
			  for(int i = startPage; i <= endPage; i++){
				  if(i > totalPage) break;
				  else if(currentPage == i){%>
					  <a href="genrelist?genre=<%=genre %>&page=<%=i %>" class="num purple"> <%=i %> </a>
				  <%}else{
				  %>
				<a href="genrelist?genre=<%=genre %>&page=<%=i %>" class="num"> <%=i %> </a>
				<% }}
				%>
				<% if(startPage+5 <= totalPage){ %>
			   	<a href="genrelist?genre=<%=genre %>&page=<%=startPage + 5 %>">&gt;</a>
			   <%} %>
					<!-- <span class="next">&gt;</span> -->
				</div>
			</div>
        </div>
    </div>   
    <footer id="foot">

        <p>HAPPY MOVIE<br/>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </P>
    
    </footer>
    <script type="text/javascript" src="resources/js/genre.js?v=5"></script>
</body>
</html>
