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
	<script>
		$(document).ready(function() {
			// login post
		    let result = "${ result }";
		    if (result != "") {
		    	if (result == "로그인 성공") {
		    		alert("로그인에 성공했습니다.");
		    		window.location.href = "main";
		    	}
		    	else {
		    		if (result == "PW 불일치") {
			    		alert("PW가 일치하지 않습니다.");
			    	}
			    	else if (result == "ID 미존재") {
			    		alert("ID가 존재하지 않습니다.");
			    	}
			    	else {
			    		alert("로그인에 실패했습니다.");
			    	}
		    		window.location.href = "login";
		    	}
		    }
		});
	</script>
</head>
<body>
	
</body>
</html>