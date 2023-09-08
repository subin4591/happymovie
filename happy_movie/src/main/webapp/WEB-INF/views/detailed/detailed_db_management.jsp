<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DetailedDBManagement</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script src="resources/js/KobisOpenAPIRestService.js"></script>
	<script>
		$(document).ready(function() {
			let key = "736697ae7e8ff21f7f31778b2d47a87d";
			
			// 어제 날짜
	        let day = new Date();
	        day.setDate(day.getDate() - 1);
	        let options = {
	        		year: "numeric",
	        		month: "2-digit",
	        		day: "2-digit"
	        };
	        let targetDt = day.toLocaleDateString('ko-KR', options).replace(/\./g, "").replace(/\s/g, "");
	        
	        // 일주일 전 날짜
	        day.setDate(day.getDate() - 7);
	        let targetDtY = day.toLocaleDateString('ko-KR', options).replace(/\./g, "").replace(/\s/g, "");
	        
			// 일별 박스오피스 순위 API data load
			$.ajax({
				type: "get",
				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt,
				success: function(data) {
					$("#boxH1").text(targetDt + " 박스오피스 순위");
					
					let boxData = data.boxOfficeResult.dailyBoxOfficeList;
					let movieCdArr = [];	// 영화 코드
					let movieNmArr = [];	// 영화 제목
					
					for (let i = 0; i < boxData.length; i++) {
						$("#boxForm").append(boxData[i].movieCd + "&nbsp;|&nbsp;" 
							+ (i+1) + "위&nbsp;|&nbsp;" + boxData[i].movieNm + "<br>");
					}
				}	// success end
			});	// ajax end
			
			// 주간 박스오피스 순위 API data load
			$.ajax({
				type: "get",
				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="
						+ key + "&targetDt=" + targetDtY + "&weekGb=0",
				success: function(data) {
					$("#weekH1").text(targetDtY + " 주간 박스오피스 순위");
					
					let boxData = data.boxOfficeResult.weeklyBoxOfficeList;
					let movieCdArr = [];	// 영화 코드
					let movieNmArr = [];	// 영화 제목
					
					for (let i = 0; i < boxData.length; i++) {
						$("#weekForm").append(boxData[i].movieCd + "&nbsp;|&nbsp;" 
								+ (i+1) + "위&nbsp;|&nbsp;" + boxData[i].movieNm + "<br>");
					}
				}	// success end
			});	// ajax end
		});	// document end
	</script>
</head>
<body>
	<h1 id="boxH1"></h1>
	<div id="boxForm"></div>
	<hr>
	
	<h1 id="weekH1"></h1>
	<div id="weekForm"></div>
</body>
</html>