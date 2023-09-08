<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Test</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {
			alert("test");
		});
	</script>
</head>
<body>
	<h1>테스트 화면</h1>
	<h3>${ model }</h3>
</body>
</html>