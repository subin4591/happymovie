$(document).ready(function() {

let sInput = $("#search .inputValue");
let sBtn = $("#search .search_img");
let sForm = $("#search #searchForm");

window.onpageshow = function(event){
if ( event.persisted || (window.performance && window.performance.navigation.type == 2))
sInput.val("");
};

sInput.focusin(function() {
    sInput.css({
        "color": "white",
        "outline": "none"
    });
});
var rule = /^\s+$/
sForm.submit(function(event){                
    if(sInput.val() === "" || sInput.val().match(rule) || sInput.val() === 0){
        alert("검색어를 입력하세요");                
        event.preventDefault();
        return;
    }
});
sBtn.click(function(){
    if(sInput.val() === "" || sInput.val().match(rule) || sInput.val() === 0){
        alert("검색어를 입력하세요");                
        event.preventDefault();
        return;
    }
    var data = encodeURIComponent(sInput.val());
    sInput.val(data);
    sInput.css("color", "rgb(0,0,0)");
    sForm.submit();    
});
setTimeout(function(){
    sInput.val('');
});  

		
$("#reservation").on("click", function() {
    $('.table').removeClass("active");
    $('.reservation').addClass("active");
    $('.link').removeClass('purple');
    $('.genre_text').removeClass('purple');
    $(this).addClass('purple');
    $('.num_nav').removeClass('active');
    $('.genre_table').removeClass('active'); 
});
let view_grade = function(){
$('.table').removeClass("active");
    $('.grade').addClass("active");
    $('.num_wrap').addClass("active");
    $('.link').removeClass('purple');
    $('.genre_text').removeClass('purple');
    $(this).addClass('purple');
    $('.num_nav').removeClass('active');
    $('.genre_table').removeClass('active'); 
}
$("#grade").on("click", view_grade);
$("#genre").on("mouseover", function() {
    $('.genre_choice').css('display','block');
}).on('mouseleave',function(){
    $('.genre_choice').css('display','none');
});
$('.genre_choice').on('mouseover',function(){
    $(this).css('display','block');
}).on('mouseleave',function(){
    $(this).css('display','none');
})
$('.num').on('click',function(){
    $('.num').removeClass('purple');
    $(this).addClass('purple');
})
$("input").on("focus", function() {
    $(this).attr("placeholder", "");
    $(this).css('outline','none');
});
$("input").on("blur", function() {
    $(this).attr("placeholder", "영화 제목");
});
$('.search_input').on('keydown',function(e) {
    if (e.keyCode == 13) {
      $('#searchForm').submit();
    }
});
$('.back').on('mouseover',function() {
    $(this).closest('div').css('display','block');
})
$('.img_wrap').on('mouseover',function(){
    $(this).prev().find('.inner_text').css('display','block');
}).on('mouseleave',function(){
    $(this).prev().find('.inner_text').css('display','none');
});

$('.inner_text').on('mouseenter',function(){
    $(this).css('display','block');
}).on('mouseleave',function(){
    $(this).css('display','none');
});

let view_action = function(){  
    $('.table').removeClass("active");;
    $('.genre_text').removeClass('purple');
    $('#action').addClass('purple'); 
    $('.action').addClass('active');
    $('.link').removeClass('purple');
    $('#genre').addClass('purple');       
    $('.link').removeClass('active');
    $('.num_nav').addClass('active'); 
    $('.genre_table').addClass('active'); 
};
let view_comedy = function(){
    $('.table').removeClass("active");
    $('.genre_text').removeClass('purple');
    $('#comedy').addClass('purple');
    $('.comedy').addClass('active');
    $('.link').removeClass('purple');
    $('#genre').addClass('purple')
    $('.link').removeClass('active');
    $('.num_nav').addClass('active');
    $('.genre_table').addClass('active'); 
};
let view_thriller = function(){
    $('.table').removeClass("active");
    $('.genre_text').removeClass('purple');
    $('#thriller').addClass('purple');
    $('.thriller').addClass('active');
    $('.link').removeClass('purple');
    $('#genre').addClass('purple');
    $('.num_nav').addClass('active');
    $('.genre_table').addClass('active'); 
};
let view_romance = function(){
    $('.table').removeClass("active");
    $('.genre_text').removeClass('purple');
    $('#romance').addClass('purple');
    $('.romance').addClass('active');
    $('.link').removeClass('purple');
    $('#genre').addClass('purple');
    $('.num_nav').addClass('active');
    $('.genre_table').addClass('active'); 
};
let view_fantasy = function(){
    $('.table').removeClass("active");
    $('.genre_text').removeClass('purple');
    $('#fantasy').addClass('purple');
    $('.fantasy').addClass('active');
    $('.link').removeClass('purple');
    $('#genre').addClass('purple');
    $('.num_nav').addClass('active');
    $('.genre_table').addClass('active'); 
};
$('#action').on('click',view_action);
$('#comedy').on('click',view_comedy);
$('#thriller').on('click',view_thriller);
$('#romance').on('click',view_romance);
$('#fantasy').on('click',view_fantasy);
$('.prev').on('click',function(){  
    var find_clss = $('.num_wrap').find('.purple');
    if(!find_clss.prev().hasClass('prev')){
        find_clss.removeClass('purple');
        find_clss.prev().addClass('purple');    
    }
    else if($('.num_wrap .num:first').text() != 1){
        $('.num').each(function(){
            var num = parseInt($(this).text()) - 5;
            $(this).text(num);
        });
        $('.num_wrap .num:first').removeClass('purple');
        $('.num_wrap .num:last').addClass('purple');
    }
});
$('.next').on('click',function(){  
    var find_clss = $('.num_wrap').find('.purple');
    if(!find_clss.next().hasClass('next')){
        find_clss.removeClass('purple');
        find_clss.next().addClass('purple');    
    }
    else{
        $('.num').each(function(){
            var num = parseInt($(this).text()) + 5;
            $(this).text(num);
        });
        $('.num_wrap .num:last').removeClass('purple');
        $('.num_wrap .num:first').addClass('purple');
    }
});

const url = window.location.href;

if (url.includes('action')) {
    $('#action').addClass('purple');
} else if (url.includes('comedy')) {
   $('#comedy').addClass('purple');
} else if(url.includes('thriller')){
    $('#thriller').addClass('purple');
} else if(url.includes('romance')){
    $('#romance').addClass('purple');
} else if(url.includes('fantasy')){
    $('#fantasy').addClass('purple');
}
});




