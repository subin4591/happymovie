<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/header.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		/// Search
	    let sInput = $("#search .inputValue");
	    let sBtn = $("#search .searchImg");
	    
	    sBtn.on("click", function(event) {
	    	// 공백 검사
	        if(sInput.val() === "") {
	            alert("검색어를 입력하세요");                
	            event.preventDefault();
	            return;
	        }
	        
	    	// submit
	        var data = encodeURIComponent(sInput.val());
	        sInput.val(data);
	        sform.submit();
	    });
	});
</script>
<header>
	<a href="main"><img id="logo" src="resources/images/logo.svg"></a>
	<div id="search">
		<form id="searchForm" method="GET" action="search" accept-charset="UTF-8">
			<input class="inputValue" name="query" type="text" placeholder="영화 제목">
			<input class="searchImg headerBtns" type="image" type="submit" src="resources/images/searchIcon.svg">
		</form>
	</div>
	<c:choose>
		<c:when test="${ session_id != null }">
			<a href="loginuserinfo"><img id="user_icon" class="headerBtns" src="resources/images/userIcon.png"></a>
			<input class="login_btns headerBtns" type="button" value="LOGOUT" onclick = "location.href = 'logout'">
		</c:when>
		<c:otherwise>
       		<input class="login_btns headerBtns" type="button" value="LOGIN" onclick = "location.href = 'login'">
       	</c:otherwise>
	</c:choose>
</header>