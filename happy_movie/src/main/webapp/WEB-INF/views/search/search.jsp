<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import = "java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SEARCH | HAPPYMOVIE</title>
    <link href = "resources/images/MainIcon.ico" rel = "shortcut icon">
    <link rel = "stylesheet" href = "resources/css/search.css">
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>  
     $(document).ready(function() {
        // search
        let sInput = $("#search .inputValue");
        let sBtn = $("#search .searchImg");
        let sForm = $("#search #searchForm");
        let sSearch = $("#searchText");

        window.onpageshow = function(event){
            if ( event.persisted || (window.performance && window.performance.navigation.type == 2))
            sInput.val("");
        };

        $.urlParam = function(name){
            var result = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
            if (result == null) return null;
            else return result[1] || 0;
        }
        var dedata =  decodeURIComponent(decodeURIComponent($.urlParam('query')));
        sSearch.text("'"+dedata+"'");
        sInput.val(""); 

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
            if(sInput.val() === "" || sInput.val().match(rule)|| sInput.val() === 0){
                    alert("검색어를 입력하세요");              
                    event.preventDefault();
                    return;
                }
            var data = encodeURIComponent(sInput.val());
            sInput.val(data);
            sInput.css("color", "rgb(0,0,0)");
            sform.submit();
        }); 
     });
    </script>
</head>
<body>
    <header class = "search_head">
        <div class = "search_top">
            <div class = "search_logo">
                <a href = "/happymovie/main" class = "link_main">
                    <img src = "resources/images/logo.svg" class = "search_main" alt = "Main">
                </a>
            </div>
            <div class = "login">
                <button id = "button_login" type = "button" onclick = "location.href = 'login">LOGIN</button>
            </div>
            <div id ="search">
                <form id = "searchForm" method = "GET" action = "./search" accept-charset="UTF-8">
                    <input type="text" class = "inputValue" name = "query" placeholder="영화 제목">
                    <input type="image" type = "submit" src="resources/images/searchIcon.svg" class = "searchImg">
                </form>
            </div>
        </div>
    </header>

    <div class = "search_page" style = "position: absolute; top: 80px;">
        
        <div class = "search_text" style = "position : relative; left: 40px; width : 85%; top: 20px;">
            <h2 style = "color: #BC6FF1; display : inline;" id = "searchText">
                ' '
            </h2>
            <h2 style = " display : inline;">검색 결과 </h2>
            <h4 style = "color:darkgray; display : inline;">${cnt}</h4>
        </div>
        
        <hr color = "#3F3F3F" style = "position : relative; top : 30px; margin-left : 20px; width : 1350px">

        <ul class = "search_list">
        <%
        	List<String> mid = (List<String>)request.getAttribute("list1");
        List<String> kort = (List<String>)request.getAttribute("list2");
        List<String> engt = (List<String>)request.getAttribute("list3");
        List<String> img = (List<String>)request.getAttribute("list4");
        List<String> genre = (List<String>)request.getAttribute("list5");
        List<String> date = (List<String>)request.getAttribute("list6");
        List<String> age = (List<String>)request.getAttribute("list7");
        
        
        	for (int i = 0; i < mid.size(); i++){
        %>
            <li>
                <div class = "slistItem">
                    <a href = "./detailed?movie_id= <%=mid.get(i) %>">
                        <img src = "<%=img.get(i)%>" onerror="this.src = 'resources/images/noimg.jpg'" alt = "movieImg" class = "itemImg">
                    </a>
                    <div class = "itemDetail" >
                        <strong class = "itemTitle" >
                            <a href = "./detailed?movie_id=<%=mid.get(i) %>"><%=kort.get(i) %></a>
                        </strong>
                        <span class = "itemEngTitle"><%=engt.get(i) %></span>
                        <dl><dt>제작</dt><dd><%=date.get(i) %></dd></dl>
                        <dl><dt>장르</dt><dd><%=genre.get(i) %></dd></dl>
                        <dl><dt>등급</dt><dd><%=age.get(i) %></dd></dl>
                    </div>
                </div>
            </li>
            <%} %>

        </ul>
    </div>
    
</body>
</html>