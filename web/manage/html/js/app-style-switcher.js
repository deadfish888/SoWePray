$(function () {
    "use strict";

    //****************************
    /* Top navbar Theme Change function Start */
    //****************************
    function handlenavbarbg() {
        if ($('#main-wrapper').attr('data-navbarbg') == 'skin6') {
            // do this
            $(".topbar .navbar").addClass('navbar-light');
            $(".topbar .navbar").removeClass('navbar-dark');
        } else {
            // do that    
        }
    }
    ;

    handlenavbarbg();
});

function showPass() {
    var x = document.getElementById("unsignPass");
    var y = document.getElementById("hide1");
    var z = document.getElementById("hide2");

    if (x.type === "password") {
        x.type = "text";
        y.style.display = "none";
        z.style.display = "block";

    } else {
        x.type = "password";
         y.style.display = "block";
        z.style.display = "none";
    }
}