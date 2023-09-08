/// Events
$(document).ready(function() {
    /// Search
    let sInput = $("#search .inputValue");
    let sBtn = $("#search .searchImg");

    window.onpageshow = function(event) {
        if (event.persisted || (window.performance && window.performance.navigation.type == 2))
            sInput.val("영화 제목");
    };

    sInput.on({
        focusin: function() {
            if (sInput.val() === "영화 제목")
                sInput.val("");
                sInput.css({
                "color": "white",
                "outline": "none"
            });
        },
        focusout: function() {
            if (sInput.val() === "") {
                sInput.val("영화 제목");
                sInput.css("color", "#5F5F5F");
            }
        }
    });
    sBtn.on("click", function(event) {
        if(sInput.val() === "" || sInput.val() === "영화 제목") {
            alert("검색어를 입력하세요");                
            event.preventDefault();
            return;
        }
        var data = encodeURIComponent(sInput.val());
        sInput.css("color", "rgb(0,0,0)");
        sInput.val(data);
        sform.submit();
    });

    /// Main
    // AvgGrade();

    /// Contents
    // find footer top
    function FooterTop(end) {
        $("footer").css("top", end);
    };

    // page change event
    $(".main_btns").on("click", function() {
    	window.location.href = $(this).data("url");
    });
    $(".more_btns").on("click", function() {
        let target = $(this).data("target");
        $(".contents").not(target).css("display", "none");
        $(target).css("display", "block");
    });
    $(".close_btns").on("click", function() {
        let target = $(this).data("target");
        $(target).css("display", "none");
        $("#photo_contents").css("display", "block");
    });

    // footer top
    $(".main_btns, .more_btns, .close_btns").not($("#grade_btn")).on("click", function() {
        FooterTop($(this).data("end"));
    });
});