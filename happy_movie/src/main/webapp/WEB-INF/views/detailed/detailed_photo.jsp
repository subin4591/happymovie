<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/detailed/detailed_photo.css" rel=stylesheet>

<script>
	//Model-image Data
	let poster_list = "${ poster_list }".slice(1, -1).split(", ");
	let still_list = "${ still_list }".slice(1, -1).split(", ");
	
	if (poster_list.length == 0) {
		poster_list = [];
		still_list = [];
		
		for (let i = 0; i <= 13; i++)
			poster_list.push("resources/images/photos/posters/poster" + i + ".jfif");
		for (let i = 0; i <= 18; i++)
			still_list.push("resources/images/photos/stills/still" + i + ".jfif");
	};
	
	$(document).ready(function() {
		/// Photo event
	    // more button event
	    function ShowPhotoSlide(photo_type, photo_arr) {
	        let index = 0;
	        let big_img = $("#big_" + photo_type);
	        $("#" + photo_type + "_more_title h3").text("1/" + photo_arr.length);
	        big_img.attr("src", photo_arr[index]);

	        $(".prev_btn").on("click", function() {
	            index = (index + photo_arr.length - 1) % photo_arr.length;
	            $("#" + photo_type + "_more_title h3").text((index + 1) + "/" + photo_arr.length);
	            big_img.fadeOut(150, function() {
	                big_img.attr("src", photo_arr[index]);
	                big_img.fadeIn(150);
	            });
	        });
	        $(".next_btn").on("click", function() {
	            index = (index + 1) % photo_arr.length;
	            $("#" + photo_type + "_more_title h3").text((index + 1) + "/" + photo_arr.length);
	            big_img.fadeOut(150, function() {
	                big_img.attr("src", photo_arr[index]);
	                big_img.fadeIn(150);
	            });
	        });
	    };
	    $("#posters_more").on("click", function() {
	        ShowPhotoSlide("posters", poster_list);
	    });
	    $("#stills_more").on("click", function() {
	        ShowPhotoSlide("stills", still_list);
	    });	// photo event end
	});
</script>

<div id="photo_contents" class="contents">
    <div id="posters_title" class="photo_titles">
        <h1><img class="bar" src="resources/images/Bar.svg">포스터</h1>
        <input id="posters_more" class="more_btns" type="button" data-target="#photo_contents_posters" data-end="1440" value="더보기">
    </div>
    <table id="posters_table" class="photo_table">
    	<tr>
    		<c:choose>
    			<c:when test="${ empty poster_list }">
    				<c:forEach var="i" begin="0" end="8">
      			<td><img src="resources/images/photos/posters/poster${ i }.jfif"></td>
      		</c:forEach>
    			</c:when>
    			<c:otherwise>
      		<c:forEach items="${ poster_list }" var="imgP" end="8">
      			<td><img src="${ imgP }"></td>
      		</c:forEach>
    			</c:otherwise>
    		</c:choose>
    	</tr>
    </table>
    <div id="stills_title" class="photo_titles">
        <h1><img class="bar" src="resources/images/Bar.svg">스틸컷</h1>
        <input id="stills_more" class="more_btns" type="button" data-target="#photo_contents_stills" data-end="1220" value="더보기">
    </div>
    <table id="stills_table" class="photo_table">
    	<tr>
    		<c:choose>
    			<c:when test="${ empty still_list }">
    				<c:forEach var="i" begin="0" end="4">
      			<td><img src="resources/images/photos/stills/still${ i }.jfif"></td>
      		</c:forEach>
    			</c:when>
    			<c:otherwise>
      		<c:forEach items="${ still_list }" var="imgS" end="4">
      			<td><img src="${ imgS }"></td>
      		</c:forEach>
    			</c:otherwise>
    		</c:choose>
    	</tr>
    </table>
</div>

<div id="photo_contents_posters" class="contents contents_more">
    <div id="posters_more_title" class="photo_titles">
        <h1><img class="bar" src="resources/images/Bar.svg">포스터</h1>
        <h3></h3>
        <input class="close_btns" type="button" data-target="#photo_contents_posters" data-end="1168" value="X">
    </div>
    <div class="photo_more_contents">
        <input class="slide_btn prev_btn" type="button" value="&lt;">
        <img id="big_posters">
        <input class="slide_btn next_btn" type="button" value="&gt;">
    </div>
</div>

<div id="photo_contents_stills" class="contents contents_more">
    <div id="stills_more_title" class="photo_titles">
        <h1><img class="bar" src="resources/images/Bar.svg">스틸컷</h1>
        <h3></h3>
        <input class="close_btns" type="button" data-target="#photo_contents_stills" data-end="1168" value="X">
    </div>
    <div class="photo_more_contents">
        <input class="slide_btn prev_btn" type="button" value="&lt;">
        <img id="big_stills">
        <input class="slide_btn next_btn" type="button" value="&gt;">
    </div>
</div>