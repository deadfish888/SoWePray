/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function showBalance() {
    var eye = document.getElementById('eye');
    var eyeClass = eye.className.split(' ');
    var balance = document.getElementById('balance');
    if (eyeClass[1] === 'fa-eye') {
        balance = '$*****.**';
        eyeClass[1] = 'fa-eye-slash';
    } else {
//        eye = '<%= Session[user.getPaymentAccount().getBalance()]%>';
        balance = '1';
        eyeClass[1] = 'fa-eye';
    }
    ;
}

function changeIcon(anchor) {
    var icon = anchor.querySelector("i");
    icon.classList.toggle('bx-show');
    icon.classList.toggle('bx-hide');
    anchor.querySelector("span").textContent = icon.matches('.bx-hide') ? "Balance: $****.**" : anchor.querySelector("span").dataset.text;
}

function setRemovePaymentId(id) {
    document.getElementById('removedPaymentId').value = id;
}

function removePayment(id) {
    var inputPass = document.getElementById("removePaymentForm").password.value;
    var pass = document.getElementById('pass').value;
    if (inputPass === pass) {
        var form = document.getElementById("removePaymentForm").submit;
    } else {
        setRemovePaymentId(id, "Password is wrong");
    }
}

function validatePassword() {
//    var pass = document.getElementById('pass').value;
    let pass = document.forms["removeForm"]["pass"].value;
    let x = document.forms["removeForm"]["password"].value;
//    alert(document.forms["removeForm"]["removedPaymentId"].value);
    if (pass !== x) {
        document.getElementById("pass-noti").innerHTML = "Wrong password";
        return false;
    }
}

function validateAddPassword() {
    let pass = document.forms["addForm"]["pass"].value;
    let x = document.forms["addForm"]["password"].value;
    if (pass !== x) {
        document.getElementById("add-pass-noti").innerHTML = "Wrong password";
        return false;
    }
}

function validateRechargePassword() {
    let pass = document.forms["rechargeForm"]["pass"].value;
    let x = document.forms["rechargeForm"]["password"].value;
    if (pass !== x) {
        document.getElementById("recharge-pass-noti").innerHTML = "Wrong password";
        return false;
    }
}

function validateWithdrawPassword() {
    let pass = document.forms["withdrawForm"]["pass"].value;
    let x = document.forms["withdrawForm"]["password"].value;
    if (pass !== x) {
        document.getElementById("withdraw-pass-noti").innerHTML = "Wrong password";
        return false;
    }
}