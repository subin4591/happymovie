<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DetailedDBInsert</title>
	<script src="resources/js/jquery-3.6.4.min.js"></script>
	<script>
		$(document).ready(function() {

		});
	</script>
</head>
<body>
	<h1>image_table insert</h1>
	<form action="detaileddbinsertimage" method="post">
		영화코드 <input type="text" name="movie_id" value="20200154"><br>
		URL <input type="text" name="img_url" style="width:500px;"><br>
		타입
		<select name="img_type">
			<option value="p" selected>p</option>
			<option value="s">s</option>
		</select><br>
		<input type="submit">
	</form><hr>
	
	<h1>crew_table insert</h1>
	<form action="detaileddbinsertcrew" method="post">
		영화코드 <input type="text" name="movie_id" value="20200154"><br>
		이름 <input type="text" name="name"><br>
		URL <input type="text" name="profile_url" style="width:500px;"><br>
		<input type="submit">
	</form><hr>
	
	<h1>review_table insert</h1>
	<form action="detaileddbinsertreview">
		영화코드 <input type="text" name="movie_id"><br>
		<input type="submit">
	</form>
	
	<h1>${ insertresult }</h1>
</body>
</html>