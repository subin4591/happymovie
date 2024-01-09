<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="resources/images/MainIcon.ico">
	<link href="resources/css/login/login_main.css" rel=stylesheet>
	<link href="resources/css/login/login_login.css" rel=stylesheet>
	<title>USERDELETEㅣHAPPYMOVIE</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			console.log("${ pw }");
			
		    // submit event
		    $("#deleteForm").on("submit", function() {
		    	let pw = $("#password").val();
		    	let realPw = "${ pw }";
		    	
		    	if (pw == "") {
		    		alert("비밀번호를 입력하세요.");
		    		return false;
		    	}
		    	else if (pw != realPw) {
		    		alert("비밀번호를 확인하세요.");
		    		return false;
		    	}
		    	else {
		    		alert("탈퇴되었습니다.");
		    	}
		    });
		});
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../header.jsp" %>
    
    <form id="deleteForm" action="logindeleteusersub" method="post">
    	<h1>회원탈퇴</h1>
    	<div id="loginInput">
    		<input type="text" id="id" name="user_id" value="${ id }">
    		<input type="password" id="password" name="pw" placeholder="PASSWORD">
    	</div>
    	<div id="formBtn">
    		<button id="deleteBtn" type="submit">회원탈퇴</button>
    	</div>
    </form>
	
	<!-- footer -->
	<%@ include file="../footer.jsp" %>
</body>
</html>