/// Events
$(document).ready(function() {
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