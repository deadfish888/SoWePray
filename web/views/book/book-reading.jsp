<%-- 
    Document   : book-reading
    Created on : Sep 28, 2022, 1:56:27 PM
    Author     : thanhienee
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.product.Product"%>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${chapter.title}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
    </head>
    <body id="mainpart" class="is-preload reading-page">
        <!-- Wrapper -->
        <div id="wrapper">

            <!-- Header -->
            <header id="header">
                <div class="inner">
                    <!-- Logo -->
                    <a href="./Home" class="logo">
                        <span class="fa fa-book"></span>
                        <span class="title">BOOKIE</span>
                    </a>


                    <!-- Nav -->
                    <nav>
                        <ul>
                            <li><a href="#menu">Menu</a></li>
                        </ul>
                    </nav>
                </div>
            </header>

            <!-- Menu -->
            <c:set var="context" value="${pageContext.request.contextPath}" />

            <nav id="menu">
                <h2>
                    <div class="row">
                        <div class="col-4">
                            <img src="${!empty listV.get(0).book.image?listV.get(0).book.image:"images/novel-sample.png"}" class="rounded" width="60" />
                        </div>
                        <div class="col-8 p-0">
                            <h6 class="m-0"><a href="./BookDetail?id=${listV.get(0).book.id}">${listV.get(0).book.title}</a></h6>
                            <p style="font-size: 13px"><a href="./Author?id=${listV.get(0).book.author.id}"><i class="fa fa-pencil"></i><strong>${listV.get(0).book.author.name}</a></strong></p>
                        </div>
                    </div>

                </h2>
                <ul>
                    <c:forEach items="${listV}" var="vol">
                        <li>
                            <a href="./BookReading?id=${vol.bookId}&cid=${vol.chapters.get(0).id}">${vol.title}</a>
                            <ul>
                                <c:forEach items="${vol.chapters}" var="chap">
                                    <li id="c${chap.id}" class="${chap.id==chapter.id?"active":""}"><a href="./BookReading?id=${chap.volume.bookId}&cid=${chap.id}">${chap.title}</a></li>
                                    </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                </ul>
            </nav>

            <!-- SideOption -->
            <section id="rd-side_icon" class="none force-block-l side_option">
                <c:if test="${!empty chapter.prev}">
                    <a href="./BookReading?id=${chapter.volume.bookId}&cid=${chapter.prev.id}" class="rd_sd-button_item"><i class='bx bu bx-chevrons-left bx-sm btm '></i></a><br>
                    </c:if>
                <a class="rd_sd-button_item" href="BookDetail?id=${listV.get(0).book.id}"><i class='bx bu bxs-home bx-sm btm'></i></a><br>
                <a id="rd-setting_icon" data-affect="#" class="rd_sd-button_item" onclick="rdtoggle('setting', 'fade-in-down')"><i class='bx bu bx-font-family bx-sm'></i></a><br>
                <a id="info" href="#menu" data="${chapter.id}" class="rd_sd-button_item"><i class='bx bu bx-info-circle bx-sm'></i></a><br>
                    <c:if test="${!empty chapter.next}">
                    <a href="./BookReading?id=${chapter.volume.bookId}&cid=${chapter.next.id}"class="rd_sd-button_item">
                        <i class='bx  bx-chevrons-right bx-sm'></i></a><br>
                    </c:if>
            </section>
            <section id="setting" class="rdtoggle">
                <section class="re_set-in basic-section clear rdtoggle_body">
                    <header class="sect-header"><span class="sect-title">Customize</span></header>
                    <main class="sect-body">
                        <div class="set-list set-color clear">
                            <label>Background</label>
                            <div class="set-input clear">
                                <span data-color="#fff" data-id="0" style="background-color: #fff"></span>
                                <span data-color="#e6f0e6" data-id="1" style="background-color: #e6f0e6"></span>
                                <span data-color="#e3f5fa" data-id="2" style="background-color: #e3f5fa"></span>
                                <span data-color="#f6f4ec" data-id="3" style="background-color: #f6f4ec"></span>
                                <span data-color="#eae4d3" data-id="4" style="background-color: #eae4d3"></span>
                                <span data-color="#f5e9ef" data-id="5" style="background-color: #f5e9ef"></span>
                                <span data-color="#222222" data-id="6" style="background-color: #222222"></span>
                            </div>
                        </div>
                        <div class="set-list set-font-family clear"><label>Font Family</label>
                            <div class="set-slide set-input">
                                <select>
                                    <option>Times New Roman</option>
                                    <option>Noto Sans</option>
                                </select>
                            </div>
                        </div>
                        <div class="set-list set-font clear"><label>Font size</label>
                            <div class="set-slide set-input">
                                <span class="set-slide_button set-smaller"><i class="fas fa-chevron-left"></i></span>
                                <input class="set-slide_input" disabled="" value="16px" type="text" style="width: 180px; display: inline">
                                <span class="set-bigger set-slide_button"><i class="fas fa-chevron-right"></i></span>
                            </div>
                        </div>
                    </main>
                </section>
                <div class="black-click"></div>
            </section>
            <!-- Main -->
            <div id="main">
                <h1 style="text-align: center">${book.title}</h1>
                <h2 style="text-align: center">${chapter.title}</h2>
                <h4 class="h5" style="text-align: right;margin-right: 8%;font-style: italic; ">${words} words</h4>
                <div id="chapter-content" class="long-text no-select" style="font-family: Times New Romans,Times New Roman, Georgia, serif;">
                    ${chapter.getContent()}
                </div>

            </div>

        </div>
        <style>
            div#chapter-content{
                margin-left: 80px; margin-right: 100px;
                
            }
            
            .animation {
                -webkit-animation-duration: 1s;
                animation-duration: 1s;
                -webkit-animation-fill-mode: both;
                animation-fill-mode: both;
            }
            .basic-section, .board-list, .board_categ-list, .detail-list, .feature-section, .mail-page .mail-detail-list, .modal-content, .page-breadcrumb, .private-tabs, .profile-feature, .series-users, .showcase-item, .sub-index-style, .user-pm .mail-list {
                background-color: hsla(0,0%,100%,.9);
                border-color: #e4e5e7 #dadbdd hsla(210,4%,80%,.8);
                border-radius: 4px;
                border-style: solid;
                border-width: 1px;
                overflow: hidden;
            }
            .re_set-in {
                display: block;
                margin: auto;
                width: 390px;
            }

            #setting {
                height: 100%;
                opacity: 0;
                position: fixed;
                width: 100%;
                z-index: -1;
            }
            .bx{
                border-bottom: 1px solid #ccc;
                border-left: 1px solid #ccc;
                border-right: 1px solid #ccc;
                padding: 15px 15px;
            }

            .btm{
                border-top: 1px solid #ccc;
            }

            .side_option{
                position: fixed;
                bottom: 30px;
                right: 30px;
            }
            #bookmarks.on, #chapters.on, #setting.on, #setting.on .re_set-in {
                opacity: 1;
                z-index: 989;
            }


            #licensed-list header.section-title, #tba-list header.section-title, .basic-section .sect-header, .detail-list header.section-title, .modal-header, .private-tabs header, table.broad-table tr th {
                background-color: #f4f5f6;
                border-bottom: 1px solid #dadbdd;
                padding: 10px;
            }
            .basic-section .sect-header {
                font-weight: 700;
            }
            .basic-section .sect-title, .fs-4, .index-section .section-title, .last-topics .title, .profile-showcase header span, h4 {
                font-size: 18px;
                font-size: 1.8rem;
                line-height: 26px;
                line-height: 2.6rem;
            }
            .basic-section .sect-title {
                display: inline-block;
                margin-left: 0;
                padding-right: 0;
            }

            section.basic-section main {
                padding: 10px;
            }
            .set-list {
                display: block;
                display: table-row;
                padding-bottom: 20px;
            }

            .clear:after, .clear:before, .daily-recent_views .series-detail:after, .daily-recent_views .series-detail:before, .detail-list-item:after, .detail-list-item:before, .licensed-list-form .input-group:after, .licensed-list-form .input-group:before, .listall-item:after, .listall-item:before, .user-pm .mail:after, .user-pm .mail:before, ul.others-list li:after, ul.others-list li:before {
                content: " ";
                display: table;
            }
            .clear:after, .daily-recent_views .series-detail:after, .detail-list-item:after, .licensed-list-form .input-group:after, .listall-item:after, .user-pm .mail:after, ul.others-list li:after {
                clear: both;
            }
            .set-input {
                display: table-cell;
                padding: 10px;
            }
            .set-color span {
                border: 1px solid #eee;
                cursor: pointer;
                float: left;
                height: 35px;
                width: 35px;
            }
            .set-input {
                display: table-cell;
                padding: 10px;
            }
            option {
                font-weight: normal;
                display: block;
                white-space: nowrap;
                min-height: 1.2em;
                padding: 0px 2px 1px;
            }
            .set-slide_button {
                color: #36a189;
                cursor: pointer;
                padding: 10px;
            }
            input {
                writing-mode: horizontal-tb !important;
                text-rendering: auto;
                color: fieldtext;
                letter-spacing: normal;
                word-spacing: normal;
                line-height: normal;
                text-transform: none;
                text-indent: 0px;
                text-shadow: none;
                display: inline-block;
                text-align: start;
                appearance: auto;
                -webkit-rtl-ordering: logical;
                cursor: text;
                background-color: field;
                margin: 0em;
                padding: 1px 2px;
                border-width: 2px;
                border-style: inset;
                border-color: -internal-light-dark(rgb(118, 118, 118), rgb(133, 133, 133));
                border-image: initial;
            }
            input:disabled {
                cursor: default;
                background-color: -internal-light-dark(rgba(239, 239, 239, 0.3), rgba(59, 59, 59, 0.3));
                color: -internal-light-dark(rgb(84, 84, 84), rgb(170, 170, 170));
                border-color: rgba(118, 118, 118, 0.3);
            }
            .black-click {
                background-color: #000;
                height: 100%;
                left: 0;
                opacity: .6;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1;
                z-index: -1;
            }
            #mainpart.reading-page.style-0, #mainpart.reading-page.style-0 #rd-side_icon {
                background-color: #eaeaea;
            }
            #mainpart.reading-page.style-1, #mainpart.reading-page.style-1 #rd-side_icon {
                background-color: #e6f0e6;
            }
            #mainpart.reading-page.style-2, #mainpart.reading-page.style-2 #rd-side_icon {
                background-color: #e3f5fa;
            }
            #mainpart.reading-page.style-3, #mainpart.reading-page.style-3 #rd-side_icon {
                background-color: #f6f4ec;
            }
            #mainpart.reading-page.style-6, #mainpart.reading-page.style-6 #rd-side_icon,#mainpart.reading-page.style-6 .rd_sd-button_item{
                background-color: #222222;
                color: whitesmoke;
            }
            #mainpart.reading-page.style-4, #mainpart.reading-page.style-4 #rd-side_icon {
                background-color: #eae4d3;
            }
            #mainpart.reading-page.style-5, #mainpart.reading-page.style-5 #rd-side_icon {
                background-color: #f5e9ef;
            }
            .set-color span.current {
                border: 3px solid #36a189;
            }
            .black{
                color: #585858;
            }
        </style>
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>
        <script>
                    function setCookie(cname, cvalue, exdays) {
                        const d = new Date();
                        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
                        let expires = "expires=" + d.toUTCString();
                        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
                    }

                    function getCookie(cname) {
                        let name = cname + "=";
                        let ca = document.cookie.split(';');
                        for (let i = 0; i < ca.length; i++) {
                            let c = ca[i];
                            while (c.charAt(0) == ' ') {
                                c = c.substring(1);
                            }
                            if (c.indexOf(name) == 0) {
                                return c.substring(name.length, c.length);
                            }
                        }
                        return "";
                    }

                    function checkCookie() {
                        let user = getCookie("username");
                        if (user != "") {
                            alert("Welcome again " + user);
                        } else {
                            user = prompt("Please enter your name:", "");
                            if (user != "" && user != null) {
                                setCookie("username", user, 365);
                            }
                        }
                    }

                    function showBox()
                    {
                        var id = document.getElementById("info").getAttribute("data");
                        const box = document.getElementById("c" + id);
                        box.scrollIntoView({block: "center"});

                    }

                    function turnoffall() {
                        $(".rdtoggle").removeClass("on");
                        $(".rdtoggle_body").removeClass("animation fade-in-left-big fade-in-down");
                        $("html").removeClass("overflow-hiden");
                    }

                    function rdtoggle(classicon, effect) {
                        if ($(classicon).hasClass("on")) {
                            turnoffall();
                        } else {
                            turnoffall();
                            $(classicon).addClass("on");
                            $("html").addClass("overflow-hiden");
                            $(classicon + " .rdtoggle_body").addClass("animation " + effect);
                        }
                    }
                    ;

                    $("#info").on('click', function () {
                        showBox();
                    });
                    $("#rd-setting_icon").on('click', function () {
                        rdtoggle("#setting", "fade-in-down");
                    });

                    $(".black-click").on('click', function () {
                        turnoffall();
                    });

                    var bgcolor = getCookie('color') || 0;
                    var fontfamily = getCookie('fontfamily') || '';
                    var fontsize = getCookie('font') || 18;
                    var margin = getCookie('margin') || 0;

                    function setcolor(alter = true) {
                        var switcher = $(".set-color .set-input span").eq(bgcolor);
                        switcher.addClass("current");

                        if (alter) {
                            for (var i = 0; i < $(".set-color .set-input span").length; i++) {
                                $("#mainpart").removeClass('style-' + i);
                            }
                            $("#mainpart").addClass('style-' + bgcolor);
                            if(bgcolor=='6') {
                                $("#setting").addClass("black");
                            }
                            else{
                                $("#setting").removeClass("black");
                            }
                    }
                    }

                    // This creates unsmooth experience so we only use it for select box
                    function setfontfamily() {
                        $('.set-font-family select option').filter(function () {
                            return fontfamily.split(',')[0].indexOf($(this).text()) != -1;
                        }).attr('selected', true);
                    }

                    function setfontstyle(alter = true) {
                        $(".set-font input.set-slide_input").val(fontsize + "px");

                        if (alter) {
                            $("div#chapter-content").css("font-size", fontsize + "px");

                            var lineheight = +fontsize + 10;
                            $("#chapter-content").css("line-height", lineheight + "px");
                    }
                    }

                    setcolor();
                    setfontfamily();
                    $('div#chapter-content').css('font-family', fontfamily);
                    setfontstyle();

                    //1px = 0.0625rem;
                    //16px = 1rem (default);

                    $(".set-color .set-input span").click(function () {
                        bgcolor = $(this).data("id");
                        $(".set-color .set-input span").removeClass("current");
                        setcolor();
                        setCookie('color', bgcolor, 365);
                    });

                    $('.set-font-family select').on('change', function () {
                        fontfamily = "'" + $('option:selected', this).text() + "', " + '\'Times New Roman\', Georgia, serif';

                        $('div#chapter-content').css('font-family', fontfamily);

                        setCookie('fontfamily', fontfamily, 365);
                    });

                    $(".set-font .set-slide_button.set-smaller").click(function () {
                        fontsize = fontsize - 2;
                        if (fontsize < 0)
                            fontsize = 0;
                        setfontstyle();
                        setCookie('font', fontsize, 365);
                    });

                    $(".set-font .set-slide_button.set-bigger").click(function () {
                        fontsize = +fontsize + 2;
                        setfontstyle();
                        setCookie('font', fontsize, 365);
                    });

                    

        </script>


    </body>
</html>