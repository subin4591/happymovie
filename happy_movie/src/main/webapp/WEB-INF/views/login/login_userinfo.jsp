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
	<title>USERINFOㅣHAPPYMOVIE</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(document).ready(function() {
			$(".errorText").css("color", "#892CDC");
			
			// 유효성 검사
			$("#infoForm input").on("focusout", function() {
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
							$(target).text("숫자와 영문자 조합으로 8~15자리를 입력하세요.");
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
					
					// 그 외
					else {
						$(target).css("color", "#892CDC");
					}
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
			$("#infoForm").on("submit", function() {
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
	<!-- header -->
	<%@ include file="../header.jsp" %>
    
    <form id="infoForm" action="loginuserinfosub" method="post">
    	<h1>회원정보</h1>
    	<input type="text" id="id" class="leftNot" name="user_id" placeholder="ID" maclength="15" data-target="Id" value="${ dto.user_id }" readonly>
    	<p id="errorId" class="errorText" data-target="아이디">아이디</p>
    	<input type="password" id="password" class="leftNot" name="pw" placeholder="PASSWORD" maclength="15" data-target="Pw" value="${ dto.pw }">
    	<p id="errorPw" class="errorText" data-target="비밀번호">비밀번호</p>
    	<input type="text" id="name" class="leftNot" name="name" placeholder="이름" maxlength="20" data-target="Name" value="${ dto.name }">
    	<p id="errorName" class="errorText" data-target="이름">이름</p>
    	<div class="inBtn">
	    	<input type="text" id="address" class="leftIn" name="address" placeholder="주소" data-target="Address" value="${ dto.address }">
    		<input type="button" id="findAddress" value="주소찾기">
    	</div>
    	<p id="errorAddress" class="errorText" data-target="주소">주소</p>
    	<input type="email" id="email" class="leftNot" name="email" placeholder="E-mail" data-target="Email" value="${ dto.email }">
    	<p id="errorEmail" class="errorText" data-target="이메일">이메일</p>
    	<input type="text" id="phone" class="leftNot" name="phone" placeholder="전화번호 ('-' 제외)" maxlength="11" data-target="Phone" value="${ dto.phone }">
    	<p id="errorPhone" class="errorText" data-target="전화번호">전화번호</p>
    	<button type="submit" id="infoBtn">수정</button>
    	<a id="deleteA" href="logindeleteuser">회원탈퇴</a>
    </form>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>