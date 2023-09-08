<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="resources/images/MainIcon.ico">
	<link href="resources/css/login/login_main.css" rel=stylesheet>
	<link href="resources/css/login/login_join.css" rel=stylesheet>
	<title>JOINㅣHAPPYMOVIE</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="resources/js/login.js"></script>
	<script>
		$(document).ready(function() {
			// 유효성 검사
			$("#joinForm input").on("focusout", function() {
				let val = $(this).val();
				let target = "#error" + $(this).data("target");
				let targetKor = $(target).data("target");
				
				if (val == "") {
					let targetText = "";
					
					if (targetKor == "이메일" || targetKor == "이름") {
						targetText = targetKor + "을 입력하세요.";	
					}
					else {
						targetText = targetKor + "를 입력하세요.";
					}
					
					$(target).text(targetText);
					$(target).css("color", "#FD7C7C");
				}
				else {
					// 비밀번호 유효성 검사
					if (targetKor == "비밀번호") {
						if (!/^[a-zA-Z0-9]{8,20}$/.test(val)) {
							$(target).text("8~15자의 영문 대/소문자, 숫자를 사용해 주세요.");
							$(target).css("color", "#FD7C7C");
						}
						else {
							$(target).css("color", "#892CDC");
						}
					}
					
					// 이메일 유효성 검사
					else if (targetKor == "이메일") {
						if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
							$(target).text("올바른 이메일 주소를 입력하세요.");
							$(target).css("color", "#FD7C7C");
						}
						else {
							$(target).css("color", "#892CDC");
						}
					}
					
					// 전화번호 유효성 검사
					else if (targetKor == "전화번호") {
						if (!/^\d+$/.test(val)) {
							$(target).text("올바른 전화번호를 입력하세요.");
							$(target).css("color", "#FD7C7C");
						}
						else {
							$(target).css("color", "#892CDC");
						}
					}
					
					// 아이디
					else if (targetKor == "아이디") {
						let targetText = $(target).text();
						if (targetText == "사용 가능한 아이디입니다.") {
							$(target).css("color", "#892CDC");
						}
						else if (targetText != "이미 존재하는 아이디입니다.") {
							$("#errorId").text("중복확인을 해주세요.");
							$("#errorId").css("color", "#FD7C7C");
						}
					}
					
					// 그 외
					else {
						$(target).css("color", "#892CDC");
					}
				}
			});
			
			// 아이디 중복확인
			$("#checkId").on("click", function() {
				if ($("#id").val() == "") {
					alert("아이디를 입력하세요.");
				}
				else {
					$.ajax({
						url: "loginjoincheckid",
						data: {id: $("#id").val()},
						dataType: "json",
						type: "post",
						success: function(data) {
							if (data.cnt > 0) {
								$("#errorId").text("이미 존재하는 아이디입니다.");
								$("#errorId").css("color", "#FD7C7C");
								alert("이미 존재하는 아이디입니다.");
							}
							else {
								$("#errorId").text("사용 가능한 아이디입니다.");
								$("#errorId").css("color", "#892CDC");
								alert("사용 가능한 아이디입니다.")
							}
						}
					});					
				}
			});
			
			// 주소찾기
			$("#findAddress").on("click", function() {
				new daum.Postcode({
					oncomplete: function(data) {
						let addr = "";	// 주소
						let extraAddr = "";	// 참고항목
						
						// 도로명 주소
						if (data.userSelectedType === "R") {
							addr = data.roadAddress;
							
							// 법정동의 경우 마지막 문자가 "동/로/가"
							if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							
							// 건물명이 있고, 공동주택일 경우
							if (data.buildingName !== "" && data.apartment === "Y") {
								extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
							}
							
							// 참고항목 존재 시 괄호 추가
							if (extraAddr !== "") {
								extraAddr = "(" + extraAddr + ")";
							}
						}
						// 지번 주소
						else {
							addr = data.jibunAddress;	
						}
						
						// 최종 주소
						let addrResult = "";
						addrResult += data.zonecode + " " + addr;	// 우변번호 + 주소
						
						// 참고항목 존재 여부
						if (extraAddr !== "") {
							addrResult += " " + extraAddr;
						}
						
						// 최종 주소 출력
						$("#address").val(addrResult);
						$("#address").focus();
					}
				}).open();
			});
			
			// submit
			$("#joinForm").on("submit", function() {
				let result = true;
				
				$(".errorText").each(function() {
					let color = $(this).css("color");
					if (color == "#FD7C7C" || color == "rgb(253, 124, 124)") {
						result = false;
					}
				});
				
				if (!result) {
					alert("다시 한번 확인해 주세요.");
					return false;
				}
			});
		});
	</script>
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
    
    <form id="joinForm" action="loginjoinsub" method="post">
    	<h1>회원가입</h1>
    	<div class="inBtn">
    		<input type="text" id="id" class="leftIn" name="user_id" placeholder="ID" maxlength="15" data-target="Id">
    		<input type="button" id="checkId" value="중복확인">
    	</div>
    	<p id="errorId" class="errorText" data-target="아이디">아이디를 입력하세요.</p>
    	<input type="password" id="password" class="leftNot" name="pw" placeholder="PASSWORD" maxlength="15" data-target="Pw">
    	<p id="errorPw" class="errorText" data-target="비밀번호">비밀번호를 입력하세요.</p>
    	<input type="text" id="name" class="leftNot" name="name" placeholder="이름" maxlength="20" data-target="Name">
    	<p id="errorName" class="errorText" data-target="이름">이름을 입력하세요.</p>
    	<div class="inBtn">
	    	<input type="text" id="address" class="leftIn" name="address" placeholder="주소" data-target="Address">
    		<input type="button" id="findAddress" value="주소찾기">
    	</div>
    	<p id="errorAddress" class="errorText" data-target="주소">주소를 입력하세요.</p>
    	<input type="email" id="email" class="leftNot" name="email" placeholder="E-mail" data-target="Email">
    	<p id="errorEmail" class="errorText" data-target="이메일">이메일을 입력하세요.</p>
    	<input type="text" id="phone" class="leftNot" name="phone" placeholder="전화번호 ('-' 제외)" maxlength="11" data-target="Phone">
    	<p id="errorPhone" class="errorText" data-target="전화번호">전화번호를 입력하세요.</p>
    	<button type="submit" id="joinBtn">가입</button>
    </form>
	
	<footer>
        <p>
            HAPPY MOVIE<br>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </p>
	</footer>
</body>
</html>