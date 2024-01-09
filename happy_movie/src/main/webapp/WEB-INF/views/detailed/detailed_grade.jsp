<%@page import="dto.MovieDTO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="resources/css/detailed/detailed_grade.css" rel=stylesheet>

<script>
	//Model-review Data
	// 리뷰 생성자
	function StarComm(seq, user_id, name, pw, comment, star, date){
		this.seq = seq;
		this.user_id = user_id;
		this.name = name;
		this.pw = pw;
		this.comment = comment;
		this.star = star;
	    this.date = new Date(date).toLocaleString('ko-KR', {
	        year: 'numeric', 
	        month: 'numeric', 
	        day: 'numeric', 
	        hour: '2-digit', 
	        minute:'2-digit',
	        hourCycle: 'h23'
	    });
	    this.print = function() {
	        return "<table>"
	            + "<tr>"
	                + "<td class='inner_name'>" + this.name + "</td>"
	                + "<td class='inner_date'>" + this.date + "</td>"
	                + "<td class='inner_star'>★" + this.star + "</td>"
	            + "</tr>"
	            + "<tr><td colspan='3'>" + this.comment + "</td></tr>"
	            + "<tr>"
	                + "<td class='inner_btn' colspan='3'>"
	                    + "<input class='comment_table_btn change_btn hidden_btn' data-seq=" + this.seq + " type='button' value='수정'>"
	                    + "<input class='comment_table_btn delete_btn hidden_btn' data-seq=" + this.seq + " type='button' value='삭제'>"
	                + "</td>"
	            + "</tr>"
	        + "</table>";
	    };
	    this.printUser = function() {
	        return "<table>"
	            + "<tr>"
	                + "<td class='inner_name'>" + this.name + "</td>"
	                + "<td class='inner_date'>" + this.date + "</td>"
	                + "<td class='inner_star'>★" + this.star + "</td>"
	            + "</tr>"
	            + "<tr><td colspan='3'>" + this.comment + "</td></tr>"
	            + "<tr>"
	                + "<td class='inner_btn' colspan='3'>"
		            	+ "<input class='comment_table_btn change_btn' data-seq=" + this.seq + " type='button' value='수정'>"
		            	+ "<input class='comment_table_btn delete_btn' data-seq=" + this.seq + " type='button' value='삭제'>"
	                + "</td>"
	            + "</tr>"
	        + "</table>";
	    };
	};	// StarComm end
	
	<% List<ReviewDTO> reviewList = (List<ReviewDTO>)request.getAttribute("review_list"); %>
	let grade_arr = [
		<% if(reviewList != null) {
				for (ReviewDTO dto : reviewList) { %>
					new StarComm(<%= dto.getSeq() %>,
							"<%= dto.getUser_id() %>",
							"<%= dto.getName() %>",
							"<%= dto.getPw() %>",
							"<%= dto.getContents() %>",
							<%= dto.getRating_star() %>,
							"<%= dto.getWriting_time() %>"),
				<% }
			} %>
	];	// review data end
	
	/// document
	$(document).ready(function() {
		/// Review event
		// write event
	    $("#star_radio *").on("click", function() {
	        $("#write_star").text("★" + $(this).val());
	    });
	    $("#write_text").on({
	        keyup: function() {
	            let text_len = $(this).val().length;
	            let text_max = 100;
	            if (100 - text_len > 0) {
	                $("#text_th").text(text_len + "/" + text_max);
	            }
	            else {
	                alert(text_max + "자 까지 입력할 수 있습니다.");
	                $(this).val($(this).val().slice(0, 99));
	                $("#text_th").text(text_len + "/" + text_max);
	            }
	        },
	        focusin: function() {
	            if ($(this).val() == "댓글을 입력하세요.")
	                $(this).val("");
	            $(this).css({
	                "color": "white",
	                "outline": "none"
	            });
	        },
	        focusout: function() {
	            if ($(this).val() == "") {
	                $(this).val("댓글을 입력하세요.");
	                $(this).css("color", "#5F5F5F");
	            }
	        }

	    });
	    $("#write_btn").on("click", function(event) {
	    	event.preventDefault();
	    	if (${ session_id != null }) {
		        let empty_inputs = $(".is_write").filter(function() {
		            if ($(this).attr("id") === "write_text")
		                return $(this).val() === "댓글을 입력하세요.";
		            else
		                return $(this).val() === ""; 
		        });
		        if (empty_inputs.length > 0) {
		            let result = empty_inputs.map(function() {return this.name}).get().join(", ");
		            alert(result + "을(를) 입력하세요.");
		        }
		        else {
		        	if (${ rv_c > 0 }) {
		        		alert("리뷰는 한 번만 작성할 수 있습니다.");
		        	}
		        	else {
			            $("#write_comment").submit();			        		
		        	}
		        };
	    	}
	    	else {
	    		alert("로그인 후에 작성할 수 있습니다.");
	    	}
	    });

	    // sort event
	    let session_id = "${ session_id }";
	    $(".sort_btn[data-target='" + "${ sort_type }" + "']").addClass("sort_active");
	    $(".page_a:contains('" + ${ page } + "')").addClass("sort_active");
	    $(".sort_btn").on("click", function() {
	        window.location.href = "detailedgrade?movie_id=" + ${ movie_dto.movie_id } + "&sort_type=" + $(this).data("target");
	    });
        grade_arr.forEach((g) => {
            if (g.user_id == session_id) {
            	$("#comment_list").append("<li id='c_li" + g.seq + "' data-seq='" + g.seq + "'>" 
            			+ g.printUser() 
            			+ "</li>");
            }
            else {
            	$("#comment_list").append("<li id='c_li" + g.seq + "' data-seq='" + g.seq + "'>" + g.print() + "</li>");
            }
        });
        
        // my_review

	    // comment table button event
	    let td, what_btn, this_seq, find_data, find_pw;

	    $(document).on("click", ".comment_table_btn", function() {
	        this_seq = $(this).closest("li").data("seq");
	        find_data = grade_arr.find(item => item.seq == this_seq);
	        find_pw = (find_data).pw;
	        td = $(this).closest("td");
	    });

	    // pw input create
	    $(document).on("click", ".change_btn, .delete_btn", function() {
	        what_btn = $(this).val();
	        td.html("암호 <input id='pw_confirm" + this_seq + "' class='pw_confirm' type='password'>"
	            + "<input class='comment_table_btn pw_btn' type='button' value='확인'>"
	        );
	    });

	    // pw confirm
	    $(document).on("click", ".pw_btn", function() {
	        if ($("#pw_confirm" + this_seq).val() == find_pw) {
	            if (what_btn == "수정") {
	                $(this).closest("li").html("<form action='detailedgradeupdate' method='post'>"
	                	+ "<table style='padding: 10px; border: 2px solid #52057B'>"
	                	+ "<tr>"
	                        + "<td class='change_input'>" + find_data.name + "</td>"
	                        + "<td class='inner_star'>"
	                            + "<select id='change_star' name='rating_star'>"
	                                + "<option value='1'>★1</option>"
	                                + "<option value='2'>★2</option>"
	                                + "<option value='3'>★3</option>"
	                                + "<option value='4'>★4</option>"
	                                + "<option value='5'>★5</option>"
	                                + "<option value='6'>★6</option>"
	                                + "<option value='7'>★7</option>"
	                                + "<option value='8'>★8</option>"
	                                + "<option value='9'>★9</option>"
	                                + "<option value='10'>★10</option>"
	                            + "</select>"
	                        + "</td>"
	                    + "</tr>"
	                    + "<tr>"
	                        + "<td colspan='3'>"
	                        	+ "<textarea id='change_comment' name='contents' rows='4' cols='50' style='width: 800px;'>" 
	                        		+ find_data.comment
	                        	+ "</textarea>"
	                        + "</td>"
	                    + "</tr>"
	                    + "<tr>"
	                    	+ "<td class='inner_btn' colspan='3'>"
	                    		+ "<input class='comment_table_btn change_confirm_btn' type='submit' value='수정완료'>"
	                        + "</td>"
	                    + "</tr></table>"
	                    + "<input type='hidden' name='seq' value='" + this_seq + "'>"
	                    + "<input type='hidden' name='movie_id' value='" + ${ movie_dto.movie_id } + "'>"
	                    + "</form>"
	                );
	                $("#change_star").val(find_data.star.toString()).prop("selected", true);
	            }
	            else if (what_btn == "삭제") {
	                let is_delete = confirm("정말 삭제하시겠습니까?");
	                if (is_delete) {
	                	console.log(this_seq + " : " + ${ movie_dto.movie_id })
	                	window.location.href = "detailedgradedelete?movie_id=" + ${ movie_dto.movie_id } 
	                		+ "&seq=" + this_seq;
	                }
	                else {
	                    td.html("<input class='comment_table_btn change_btn' data-seq=" + this_seq + " type='button' value='수정'>"
			            	+ "<input class='comment_table_btn delete_btn' data-seq=" + this_seq + " type='button' value='삭제'>"
	                    );
	                }
	            }
	        }
	        else {
	            alert("암호가 틀렸습니다.");
	            td.html("<input class='comment_table_btn change_btn' data-seq=" + this_seq + " type='button' value='수정'>"
		        	+ "<input class='comment_table_btn delete_btn' data-seq=" + this_seq + " type='button' value='삭제'>"
	            );
	        }
	    });		// review event end
	});
</script>

<div id="grade_contents" class="contents">
    <div id="grade_title">
        <h1><img class="bar" src="resources/images/Bar.svg">평점</h1>
        <h2>★${ movie_dto.star }점(${ total_cnt }개)</h2>
    </div>
    <form id="write_comment" action="detailedgradeinsert" method="post">
        <div id="write_title">
            작성자 <div id="writer">${ user_dto.name }</div>
            별점
            <div id="star_radio">
                <input type="radio" name="rating_star" value="1">
                <input type="radio" name="rating_star" value="2">
                <input type="radio" name="rating_star" value="3">
                <input type="radio" name="rating_star" value="4">
                <input type="radio" name="rating_star" value="5">
                <input type="radio" name="rating_star" value="6">
                <input type="radio" name="rating_star" value="7">
                <input type="radio" name="rating_star" value="8">
                <input type="radio" name="rating_star" value="9">
                <input type="radio" name="rating_star" value="10" checked>
            </div>
            <p id="write_star">★10</p><br>
        </div>
        <c:choose>
        	<c:when test="${ session_id != null }">
        		<textarea id="write_text" class="is_write" name="contents" rows="4" cols="80">댓글을 입력하세요.</textarea>
        	</c:when>
        	<c:otherwise>
        		<textarea id="write_text" class="is_write" name="contents" rows="4" cols="80" readonly>로그인 후에 작성할 수 있습니다.</textarea>
        	</c:otherwise>
        </c:choose>
        <div id="write_end">
            <p id="text_th">0/100</p>
            <input id="write_btn" type="submit" value="등록">
        </div>
        <input type="hidden" name="user_id" value="${ user_dto.user_id }">
        <input type="hidden" name="pw" value="${ user_dto.pw }">
        <input type="hidden" name="movie_id" value="${ movie_dto.movie_id }">
    </form>
    <div id="comment_sort">
        <input class="sort_btn" data-target="date" type="button" value="최신순">
        <input class="sort_btn" data-target="star" type="button" value="별점순">
        <input class="sort_btn" data-target="user" type="button" value="내평점">
    </div>
    <ul id="comment_list"></ul>
    <div id="page_nums">
    <%	
    	MovieDTO movie_dto = (MovieDTO)request.getAttribute("movie_dto");
    	String movie_id = movie_dto.getMovie_id();
    	String sort_type = (String)request.getAttribute("sort_type");
    	int divNum = (Integer)request.getAttribute("divNum");
    	int cnt = (Integer)request.getAttribute("cnt");
    	int totalPage = cnt / divNum;
    	
    	if (cnt % divNum != 0)
    		totalPage++;
    	
    	for (int p = 1; p <= totalPage; p++)
    		out.println("&nbsp;<a class='page_a'"
    			+ " href=\"detailedgrade?movie_id=" + movie_id + "&sort_type=" + sort_type + "&page=" + p + "\">"
    			+ p + "</a>&nbsp;");
    %>
    </div>
</div>