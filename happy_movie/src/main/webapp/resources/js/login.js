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
});