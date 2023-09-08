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
	<title>LOGINㅣHAPPYMOVIE</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script src="resources/js/login.js"></script>
	<script>
		$(document).ready(function() {
		    // submit event
		    $("#loginForm").on("submit", function() {
		    	let id = $("#id").val();
		    	let pw = $("#password").val();
		    	
		    	if (id == "" && pw == "") {
		    		alert("아이디와 비밀번호를 입력하세요.");
		    		return false;
		    	}
		    	else if (id == "") {
		    		alert("아이디를 입력하세요.");
		    		return false;
		    	}
		    	else if (pw == "") {
		    		alert("비밀번호를 입력하세요.");
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
    
    <form id="loginForm" action="loginresult" method="post">
    	<h1>LOGIN</h1>
    	<div id="loginInput">
    		<input type="text" id="id" name="user_id" placeholder="ID">
    		<input type="password" id="password" name="pw" placeholder="PASSWORD">
    	</div>
    	<div id="formBtn">
    		<button id="loginBtn" type="submit">LOGIN</button>
    		<a href="loginjoin">회원가입</a>
    	</div>
    </form>
	
	<footer>
        <p>
            HAPPY MOVIE<br>
            대표 : 코딩이최고조 | 전화번호 : 010-1234-5678 | 주소 : Zoom 소회의실4
        </p>
	</footer>
</body>
</html>