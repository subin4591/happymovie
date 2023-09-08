<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="UTF-8">
<title>DetailedAPITest</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script src="resources/js/KobisOpenAPIRestService.js"></script>
<script>
	$(document).ready(function() {
		let key = "736697ae7e8ff21f7f31778b2d47a87d";
		
		$("#listBtn").on("click", function() {
			let searchName = $("#searchName").val();
			
			$.ajax({
				type: "get",
				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=" + key + "&movieNm=" + searchName,
				success: function(data) {
					$("#result").html("<h1>" + searchName + " 검색 결과</h1><hr>");
					
					let movieData = data.movieListResult.movieList;
					for (let i = 0; i < movieData.length; i++) {
						let movieCd = movieData[i].movieCd; // 영화코드
						let movieNm = movieData[i].movieNm; // 영화명(국문)
						let movieNmEn = movieData[i].movieNmEn; // 영화명(영문)
						let openDt = movieData[i].openDt; // 개봉일
						let nationAlt = movieData[i].nationAlt; // 제작국가
						let genreAlt = movieData[i].genreAlt; // 영화장르
						
						$("#result").append("<h1>" + movieCd + "</h1>");
						$("#result").append("<h3>" + movieNm + "</h3>");
						$("#result").append("<h3>" + movieNmEn + "</h3>");
						$("#result").append("<h3>" + openDt + "</h3>");
						$("#result").append("<h3>" + nationAlt + "</h3>");
						$("#result").append("<h3>" + genreAlt + "</h3>");
						$("#result").append("<hr>");
					} // for end
				}, // success end
				error: function(request, error) {
					$("#result").html("<h1>ERROR</h1>");
					$("#result").append("<h3>[코드] " + request.status + "</h3>");
					$("#result").append("<h3>[메시지] " + request.responseText + "</h3>");
					$("#result").append("<h3>[error] " + error + "</h3>");
				} // error end
			}); // ajax end
		});	// listBtn event end
		
		$("#detBtn").on("click", function() {
			let searchCode = $("#searchCode").val();
			
			$.ajax({
				type: "get",
				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + searchCode,
				success: function(data) {
					$("#result").html("<h1>" + searchCode + " 검색 결과</h1>");
					
					let movieData = data.movieInfoResult.movieInfo;
					$("#table").html("<tr><th colspan='3'>" + searchCode + "</th></tr>");
					
					// 리턴타입 arr X
					// 영화코드, 영화명(국문), 영화명(영문), 상영시간, 개봉연도
					let dataName = ["movieCd", "movieNm", "movieNmEn", "showTm", "openDt"];
					
					for (let dn of dataName) {
						$("#table").append(
							"<tr><th>" + dn + "</th><td colspan='2'>" + movieData[dn] + "</td></tr>"		
						);
					} // for end
					
					// 리턴타입 arr O
					// 제작국가, 장르명, 감독, 배우, 상영형태, 영화사, 심의정보, 스텝
					let dataArrName = ["nations", "genres", "directors", "actors", "companys", "audits", "staffs"];
					
					for (let dan of dataArrName) {
						let arrData = movieData[dan];
						$("#table").append("<tr><th colspan='3'>" + dan + "</th></tr>");
						
						for (let i = 0; i < arrData.length; i++) {
							let keyLen = Object.keys(arrData[i]).length;
							$("#table").append("<tr><th rowspan='" + (keyLen+1) + "'>" + (i+1) + "</th></tr>");
							for (let o in arrData[i]) {
								$("#table").append(
										"<tr><th>" + o + "</th><td>" + arrData[i][o] + "</td></tr>"		
								);
							} // for end
						} // for end
					} // for end
				},	// success end
				error: function(request, error) {
					$("#result").html("<h1>ERROR</h1>");
					$("#result").append("<h3>[코드] " + request.status + "</h3>");
					$("#result").append("<h3>[메시지] " + request.responseText + "</h3>");
					$("#result").append("<h3>[error] " + error + "</h3>");
				} // error end
			}); // ajax end
		});	// detBtn event end
	});	// document event end
</script>
</head>
<body>
	영화제목 <input type="text" id="searchName">
	<input type="button" id="listBtn" value="영화목록"><br>
	영화코드 <input type="text" id="searchCode">
	<input type="button" id="detBtn" value="영화상세">
	<div id="result"></div>
	<table id="table" border="3"></table>
</body>
</html>