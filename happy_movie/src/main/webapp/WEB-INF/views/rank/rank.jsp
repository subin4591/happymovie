<%@page import="dao.ApiDAO"%>
<%@page import="dto.ApiDTO"%>
<%@page import="rank.ApiService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="rank.ApiSearch"%>
<%@page import="rank.movieList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <button id = "button_logout" type = "button" ><a href = "logout">LOGOUT</a></button>
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
            <span id="reservation" class="link purple">예매율순 </span>| <span id="grade" class="link"><a href="grade">평점순</a></span> | <span id="genre" class="link">장르별</span>
        </div>
        <div class="genre_choice">
		<%-- 영화명:<input type="text" name="movieNm" value="<%=movieNm %>"> <br/>
		개봉연도조건:<input type="text" name="openStartDt" value="<%=openStartDt %>"> ~ <input type="text" name="openEndDt" value="<%=openEndDt %>">
		제작연도조건:<input type="text" name="prdtStartYear" value="<%=prdtStartYear %>"> ~ <input type="text" name="prdtEndYear" value="<%=prdtEndYear %>"> --%>		
		<%-- 영화형태:
			<c:forEach items="${movieTypeCd.codes}" var="code" varStatus="status">
			<input type="checkbox" name="movieTypeCdArr" value="<c:out value="${code.fullCd}"/>" id="movieTpCd_<c:out value="${code.fullCd}"/>"/> <label for="movieTpCd_<c:out value="${code.fullCd}"/>"><c:out value="${code.korNm}"/></label>
			<c:if test="${status.count %4 eq 0}"><br/></c:if>
			</c:forEach>
			<br/> --%>
            <span id="action" class="genre_text" ><a href="genrelist?genre=action">액션</a></span>
            <span id="comedy" class="genre_text" ><a href="genrelist?genre=comedy">코미디</a></span>
            <span id="thriller" class="genre_text" ><a href="genrelist?genre=thriller">스릴러</a></span>
            <span id="romance" class="genre_text" ><a href="genrelist?genre=romance">로맨스</a></span>
            <span id="fantasy" class="genre_text"><a href="genrelist?genre=fantasy">판타지</a></span>
		</div>
        
        
        <div class="content">
        	<table class="reservation active table"> 
        	<tr>
        	<% ArrayList totalArray = new ArrayList(); %>
        	<% ApiDAO apiService = new ApiDAO(); 
        	int num = 1;
        	int movieCd = 0;
        	ApiDTO dto = null;%>
        	<% ArrayList ratelist = (ArrayList)request.getAttribute("ratelist"); 
        	session.setAttribute("ratelist", ratelist);
        	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
            
        	%>
					<c:forEach items="${dtolist}" var="dto" begin="0" end="4">
					<%
					ApiDTO dto1 = (ApiDTO)pageContext.getAttribute("dto"); 
					Date date = inputFormat.parse(String.valueOf(dto1.getRelease_date()));
		            String release_date = outputFormat.format(date);
					%>
					
							<td>
								<div class="rank">
									<c:out value="<%=num %>"/>
								</div>
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
								<a href="detailed?movie_id=${dto.movie_id}" >
								<div class='inner_wrap'>
		                            <div class="inner_text">
		                                <span class="back"> ${dto.synopsis}</span>
		                            </div>
		                        </div> 
		                        </a>
		                        <div class='img_wrap'>
		                        		<img referrerpolicy="no-referrer" src="${dto.img_url}" alt="영화포스터" class="img">
		                        </div>
		                        <h3><a href="detailed?movie_id=${dto.movie_id}" ><c:out value="${dto.kor_title }"/></a></h3>
		                        <p>평론가평점 <span class='score'>${dto.rating_star}</span> 유저평점 <span>${dto.star}</span></p>
		                        <p>예매율 <c:out value="<%=ratelist.get(num-1) %>"/>% </p> 
		                        <p>러닝타임 ${dto.running_time}분</p>
		                        <p>개봉 <c:out value="<%=release_date %>"/></p>
							</td>
							<%-- <%totalArray.add(boxOfficeMap); %> --%>
							<%num++; %>
					</c:forEach>
        	</tr>

        	<tr>   	
        		<c:forEach items="${dtolist}" var="dto" begin="5" end="10">
					<%
					ApiDTO dto1 = (ApiDTO)pageContext.getAttribute("dto"); 
					Date date = inputFormat.parse(String.valueOf(dto1.getRelease_date()));
		            String release_date = outputFormat.format(date);%>
							<td>
								<div class="rank">
									<c:out value="<%=num %>"/>
								</div>
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
								<a href="detailed?movie_id=${dto.movie_id}" >
								<div class='inner_wrap'>
		                            <div class="inner_text">
		                                <span class="back"> ${dto.synopsis}</span>
		                            </div>
		                        </div> 
		                        </a>
		                        <div class='img_wrap'>
		                        		<img referrerpolicy="no-referrer" src="${dto.img_url}" alt="영화포스터" class="img">
		                        </div>
		                        <h3><a href="detailed?movie_id=${dto.movie_id}" ><c:out value="${dto.kor_title }"/></a></h3>
		                        <p>평론가평점 <span class='score'>${dto.rating_star}</span> 유저평점 <span>${dto.star}</span></p>
		                        <p>예매율 <c:out value="<%=ratelist.get(num-1) %>"/>% </p> 
		                        <p>러닝타임 ${dto.running_time}분</p>
		                        <p>개봉 <c:out value="<%=release_date%>"/></p>
							</td>
							<%-- <%totalArray.add(boxOfficeMap); %> --%>
							<%num++; %>
					</c:forEach>
        	</tr>
        	<%-- <%Collections.sort(totalArray, new Comparator<Map<String, Object>>() {
        	    public int compare(Map<String, Object> m1, Map<String, Object> m2) {
        	        Double grade1 = Double.parseDouble((String) m1.get("grade"));
        	        Double grade2 = Double.parseDouble((String) m2.get("grade"));
        	        return grade2.compareTo(grade1); // Descending order
        	        // Use the following for ascending order
        	        // return grade1.compareTo(grade2); 
        	    }
        	}); %> --%>
			<%-- <%session.setAttribute("totalArray", totalArray); %> --%>
		
        	</table>         
        </div>
    </div>   
    <footer id="foot">

        <p>HAPPY MOVIE<br/>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </P>
    
    </footer>
    <script type="text/javascript" src="resources/js/rank.js?v=2"></script>
</body>
</html>
