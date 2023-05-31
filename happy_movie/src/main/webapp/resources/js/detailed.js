/// Data
// person arr
let director = [
    {name: "아론 호바스", profile: "aaron.png"}, 
    {name: "마이클 젤레닉", profile: "none_profile.png"}
];
let actor = [
    {name: "크리스 프랫", role: "마리오", profile: "chris.png"},
    {name: "안야 테일러 조이", role: "피치 공주", profile: "anya.png"},
    {name: "잭 블랙", role: "바우저", profile: "jack.png"},
    {name: "세스 로건", role: "동키 콩", profile: "seth.png"},
    {name: "찰리 데이", role: "루이지", profile: "charlie.png"},
    {name: "키건 마이클 키", role: "토드", profile: "keegan.png"},
];
let crew = [
    {name: "크리스토퍼 멜레단드리", role: "제작"},
    {name: "미야모토 시게루", role: "기획"},
    {name: "매튜 포겔", role: "각본"},
    {name: "기욤 아레토스", role: "미술"}
];
let company = [
    {name: "유니버설 픽쳐스", role: "배급"},
    {name: "유니버설 픽쳐스", role: "수입"}
];

// photos arr
let posters = Array.from({length: 13}, (v, i) => `poster${i}.jfif`);
let stills = Array.from({length: 18}, (v, i) => `still${i}.jfif`);

// grade arr
let seq = 0;
function StarComm(name, pw, comment, star, date) {
    this.seq = seq++;
    this.name = name;
    this.pw = pw;
    this.comment = comment;
    this.star = star;
    let date_result;
    if (date)
        date_result = new Date(date);
    else
        date_result = new Date();
    this.date = date_result.toLocaleString('ko-KR', {
        year: 'numeric', 
        month: 'numeric', 
        day: 'numeric', 
        hour: '2-digit', 
        minute:'2-digit',
        hourCycle: 'h23'
    });
    this.print = function() {
        return `<table>
            <tr>
                <td class="inner_name">${this.name}</td>
                <td class="inner_date">${this.date}</td>
                <td class="inner_star">★${this.star}</td>
            </tr>
            <tr><td colspan="3">${this.comment}</td></tr>
            <tr>
                <td class="inner_btn" colspan="3">
                    <input class="comment_table_btn change_btn" data-seq=${this.seq} type="button" value="수정">
                    <input class="comment_table_btn delete_btn" data-seq=${this.seq} type="button" value="삭제">
                </td>
            </tr>
        </table>`;
    }
};
let grade_arr = [
    new StarComm("최고야", "1234", "마리오 최고야", 10, "2023.4.26. 23:11"),
    new StarComm("황수빈", "1234", "기대했는데 그저 그랬음", 5, "2023.4.27. 21:15"),
    new StarComm("황정빈", "1234", "하루종일 노래를 흥얼거리게 돼요!", 10, "2023.4.28. 09:57"),
    new StarComm("권도현", "1234", "높은 퀄리티, 지루할 틈 없는 연출", 8, "2023.4.30. 14:01"),
    new StarComm("최도현", "1234", "마리오 게임을 한번이라도 해본사람은 만족할듯", 9, "2023.5.1. 12:36"),
    new StarComm("권고야", "1234", "추억과 함께 되살아나는 동심", 10, "2023.5.3. 01:24"),
    new StarComm("문정빈", "1234", "눈과 귀가 즐거운 영화, 가족들과 함께 보면 좋을 것 같아요!", 9, "2023.5.5, 17:45"),
    new StarComm("문수빈", "1234", "노잼", 1, "2023.5.7. 15:10")
];
function AvgGrade() {
    // len
    let grade_len = grade_arr.length;

    // sum
    let grade_sum = 0;
    grade_arr.forEach(g => {grade_sum += g.star});

    // avg
    let grade_avg = (grade_sum / grade_len).toFixed(1);

    // update
    $("#main_grade").text(`★${grade_avg}`);
    $("#grade_title h2").text(`★${grade_avg}(${grade_len}개)`)
};

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
    AvgGrade();

    /// Contents
    // person contents
    director.forEach(d => {
        $("#director_table tr:nth-child(1)").append(`<td><img src='resources/images/profiles/${d.profile}'></td>`);
        $("#director_table tr:nth-child(2)").append(`<td>${d.name}</td>`);
    });
    actor.forEach(a => {
        $("#actor_table tr:nth-child(1)").append(`<td><img src='resources/images/profiles/${a.profile}'></td>`);
        $("#actor_table tr:nth-child(2)").append(`<td>${a.name}</td>`);
        $("#actor_table tr:nth-child(3)").append(`<td>${a.role} 역</td>`);
    });
    crew.forEach(c => {
        $("#crew_table").append(`<tr><td>${c.role}</td><td>${c.name}</td></tr>`);
    });
    company.forEach(c => {
        $("#company_table").append(`<tr><td>${c.role}</td><td>${c.name}</td></tr>`);
    });

    // photo contents
    posters.slice(0, 9).forEach(p => {
        $("#posters_table").append(`<td><img src='resources/images/photos/posters/${p}'></td>`);
    });
    stills.slice(0, 5).forEach(s => {
        $("#stills_table").append(`<td><img src='resources/images/photos/stills/${s}'></td>`);
    });

    // find footer top
    let FooterTop = function(end) {
        $("footer").css("top", end);
    };

    // page change event
    $(".main_btns").on("click", function() {
        $(".main_btns").removeClass("active");
        $(this).addClass("active");
    });
    $(".main_btns, .more_btns").on("click", function() {
        let target = $(this).data("target");
        $(".contents").not(target).css("display", "none");
        $(target).css("display", "block");
    });
    $(".close_btns").on("click", function() {
        let target = $(this).data("target");
        $(target).css("display", "none");
        $("#photo_contents").css("display", "block");
    });

    /// Photo event
    // more button event
    function ShowPhotoSlide(photo_type, photo_arr) {
        let index = 0;
        let big_img = $(`#big_${photo_type}`);
        $(`#${photo_type}_more_title h3`).text(`1/${photo_arr.length}`);
        big_img.attr("src", `resources/images/photos/${photo_type}/${photo_arr[index]}`);

        $(".prev_btn").on("click", function() {
            index = (index + photo_arr.length - 1) % photo_arr.length;
            $(`#${photo_type}_more_title h3`).text(`${index + 1}/${photo_arr.length}`);
            big_img.fadeOut(150, function() {
                big_img.attr("src", `resources/images/photos/${photo_type}/${photo_arr[index]}`);
                big_img.fadeIn(150);
            });
        });
        $(".next_btn").on("click", function() {
            index = (index + 1) % photo_arr.length;
            $(`#${photo_type}_more_title h3`).text(`${index + 1}/${photo_arr.length}`);
            big_img.fadeOut(150, function() {
                big_img.attr("src", `resources/images/photos/${photo_type}/${photo_arr[index]}`);
                big_img.fadeIn(150);
            });
        });
    };
    $("#posters_more").on("click", function() {
        ShowPhotoSlide("posters", posters);
    });
    $("#stills_more").on("click", function() {
        ShowPhotoSlide("stills", stills);
    });

    /// Grade event
    // write event
    $("#star_radio *").on("click", function() {
        $("#write_star").text(`★${$(this).val()}`);
    });
    $("#write_text").on({
        keyup: function() {
            let text_len = $(this).val().length;
            let text_max = 100;
            if (100 - text_len > 0) {
                $("#text_th").text(`${text_len}/${text_max}`);
            }
            else {
                alert(`${text_max}자 까지 입력할 수 있습니다.`);
                $(this).val(`${$(this).val().slice(0, 99)}`)
                $("#text_th").text(`${text_len}/${text_max}`);
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
    $("#write_btn").on("click", function(e) {
        let empty_inputs = $(".is_write").filter(function() {
            if ($(this).attr("id") === "write_text")
                return $(this).val() === "댓글을 입력하세요.";
            else
                return $(this).val() === ""; 
        });
        if (empty_inputs.length > 0) {
            let result = empty_inputs.map(function() {return this.name}).get().join(", ");
            alert(`${result}을(를) 입력하세요.`);
        }
        else {
            let name = $("#writer").val();
            let pw = $("#pw").val();
            let comment = $("#write_text").val();
            let star = parseInt($("#star_radio *:checked").val());
            let temp = new StarComm(name, pw, comment, star);

            grade_arr.push(temp);
            $("#comment_list").prepend(`<li id="c_li${temp.seq}" data-seq="${temp.seq}">${temp.print()}</li>`);

            AvgGrade();

            let end = grade_arr.length * 125 + 1000;
            FooterTop(end);
        };
    });

    // sort event
    function SortComment(sort_type) {
        let end = grade_arr.length * 125 + 1000;
        let target = sort_type;

        $("#comment_list").empty();
        grade_arr.sort(function(a, b) {
            if (target == "date")
                return new Date(a.date) - new Date(b.date);
            else
                return a[target] - b[target];
        });
        grade_arr.forEach((g) => {
            $("#comment_list").prepend(`<li id="c_li${g.seq}" data-seq="${g.seq}">${g.print()}</li>`);
        });
        FooterTop(end);
    };
    $(".sort_btn").on("click", function() {
        SortComment($(this).data("target"));
        $(this).css("font-weight", "bold");
        $(".sort_btn").not($(this)).css("font-weight", "normal");
    });

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
        td.html(`
            암호 <input id="pw_confirm${this_seq}" class="pw_confirm" type="password">
            <input class="comment_table_btn pw_btn" type="button" value="확인">
        `);
    });

    // pw confirm
    $(document).on("click", ".pw_btn", function() {
        if ($(`#pw_confirm${this_seq}`).val() == find_pw) {
            if (what_btn == "수정") {
                $(this).closest("table").html(`
                    <tr>
                        <td class="change_input"><input id="change_name" type="text" value="${find_data.name}"></td>
                        <td class="change_input"><input id="change_pw" type="password" value="${find_data.pw}"></td>
                        <td class="inner_star">
                            <select id="change_star">
                                <option value="1">★1</option>
                                <option value="2">★2</option>
                                <option value="3">★3</option>
                                <option value="4">★4</option>
                                <option value="5">★5</option>
                                <option value="6">★6</option>
                                <option value="7">★7</option>
                                <option value="8">★8</option>
                                <option value="9">★9</option>
                                <option value="10">★10</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <textarea id="change_comment" rows="4" cols="80">${find_data.comment}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="inner_btn" colspan="3">
                            <input class="comment_table_btn change_confirm_btn" type="button" value="수정완료">
                        </td>
                    </tr>
                `);
                $("#change_star").val(find_data.star.toString()).prop("selected", true);
            }
            else if (what_btn == "삭제") {
                let is_delete = confirm("정말 삭제하시겠습니까?");
                if (is_delete) {
                    grade_arr = grade_arr.filter(item => item.seq != this_seq);
                    AvgGrade();
                    $(`#c_li${this_seq}`).remove();

                    let end = grade_arr.length * 125 + 1000;
                    FooterTop(end);
                }
                else {
                    td.html(`
                        <input class="comment_table_btn change_btn" type="button" value="수정">
                        <input class="comment_table_btn delete_btn" type="button" value="삭제">
                    `);
                }
            }
        }
        else {
            alert("암호가 틀렸습니다.");
            td.html(`
                <input class="comment_table_btn change_btn" type="button" value="수정">
                <input class="comment_table_btn delete_btn" type="button" value="삭제">
            `);
        }
    });

    // change confirm
    $(document).on("click", ".change_confirm_btn", function() {
        find_data.name = $("#change_name").val();
        find_data.pw = $("#change_pw").val();
        find_data.comment = $("#change_comment").val();
        find_data.star = parseInt($("#change_star").val());
        find_data.date = new Date().toLocaleString('ko-KR', {
            year: 'numeric', 
            month: 'numeric', 
            day: 'numeric', 
            hour: '2-digit', 
            minute:'2-digit',
            hour12: false}).replace(/\./g, ".").replace(",", ",");

        $(`#c_li${this_seq}`).html(find_data.print());
        AvgGrade();
    });

    // footer top
    $(".main_btns, .more_btns, .close_btns").not($("#grade_btn")).on("click", function() {
        FooterTop($(this).data("end"));
    });

    // defalt click
    $("#info_btn").trigger("click");
    $("#grade_btn").on("click", function() {
        $("#sort_date_btn").trigger("click");
    });
});