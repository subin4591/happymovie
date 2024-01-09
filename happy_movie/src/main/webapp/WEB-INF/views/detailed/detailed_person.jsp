<%@page import="dto.CrewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="resources/css/detailed/detailed_person.css" rel=stylesheet>

<script>
	//Model-crew Data
	<% List<CrewDTO> crewList = (List<CrewDTO>)request.getAttribute("crew_list"); %>
	let crew_list = [
		<% if(crewList != null) {
				for (CrewDTO dto : crewList) { %>
					{
						name: "<%= dto.getName() %>",
						profile_url: "<%= dto.getProfile_url() %>"
					}, <%
				}
			} %>
	];
	
	$(document).ready(function() {
		// 영화 상세 정보 API data load
		$.ajax({
		    type: "get",
		    url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + movieCd,
		    success: function(data) {
		        let movieData = data.movieInfoResult.movieInfo;

		        // 감독
		        let directors = movieData.directors;
		        let directorsNm = [];
		        directors.forEach(d => {
		            // main info
		            directorsNm.push(d.peopleNm);
		            
		            // person contents
		            let profile_url = "resources/images/profiles/none_profile.png";
		            for (let c of crew_list) {
		            	if (c.name == d.peopleNm) {
		            		profile_url = c.profile_url
		            		break;
		            	}
		            }
		            $("#director_table tr:nth-child(1)").append("<td><img src='" + profile_url + "'></td>");
		            $("#director_table tr:nth-child(2)").append("<td>" + d.peopleNm + "</td>");
		        });
		        directorsNm = directorsNm.join(", ");
		        $("#directors").text(directorsNm);
		        
		        // 배우
		        let actors = movieData.actors;
		        actors.slice(0, 9).forEach(a => {
		            // person contents
		            let profile_url = "resources/images/profiles/none_profile.png";
		            for (let c of crew_list) {
		            	if (c.name == a.peopleNm) {
		            		profile_url = c.profile_url
		            		break;
		            	}
		            }
		            $("#actor_table tr:nth-child(1)").append("<td><img src='" + profile_url + "'></td>");
		            $("#actor_table tr:nth-child(2)").append("<td>" + a.peopleNm + "</td>");
		            if (a.cast != "") {
			            $("#actor_table tr:nth-child(3)").append("<td>" + a.cast + " 역</td>");			            	
		            }
		        });
		        
		        // 제작진
		        let staffs = movieData.staffs;
		        staffs.forEach(s => {
		            // person contents
		            if($("#crew_table tr:last-child td:first-child").text() == s.staffRoleNm) {
		            	$("#crew_table tr:last-child").html("<td>" + s.staffRoleNm + "</td><td>" 
		            			+ $("#crew_table tr:last-child td:last-child").text() + ", "
		            			+ s.peopleNm + "</td>");
		            }
		            else {
			            $("#crew_table").append("<tr><td>" + s.staffRoleNm + "</td><td>" + s.peopleNm + "</td></tr>");			            	
		            }
		        });
		        
		        // 제작사
		        let companys = movieData.companys;
		        $("#companys").text(companys[0].companyNm);	// main info
		        companys.forEach(c => {
		            // person contents
		            $("#company_table").append("<tr><td>" + c.companyPartNm + "</td><td>" + c.companyNm + "</td></tr>");
		        });
		    }	// success end
		});	// ajax end
	});
</script>

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