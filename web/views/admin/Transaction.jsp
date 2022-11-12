<%-- 
    Document   : Transaction
    Created on : Oct 26, 2022, 1:05:37 PM
    Author     : fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <link href="../../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <title>Category management</title>
    </head>
    <body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader" style="display: none;">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="mini-sidebar" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- Topbar header - style you can find in pages.scss -->

            <!-- Topbar header - style you can find in pages.scss -->
            <jsp:include page="/manage/base/header.jsp"/>
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <jsp:include page="/manage/base/sidebar.jsp"/>
            <!-- ============================================================== -->
            <!-- End Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Page wrapper  -->
            <!-- ============================================================== -->
            <div class="page-wrapper">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="page-breadcrumb">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-8 align-self-center">
                            <h3 class="page-title mb-0 p-0">Transaction Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Transaction Management</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Container fluid  -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- Column -->
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <div id="pending">
                                    <h4 class="card-title">Pending transactions list</h4>
                                    <div style="color: red"> 
                                        ${sessionScope.error}
                                        <%request.getSession().removeAttribute("error");%>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table user-table " id="tableTrans">
                                            <thead class="thead-dark">
                                            <form id="pendingFilterForm" action="Transaction" method="post">
                                                <tr class="text-center" style="cursor: pointer; font-size: 15px;  text-align: center;">

                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Transaction ID</th>
                                                    <th class="text-center" style="width: 10%; text-align: center; vertical-align: middle">User ID<br/>
                                                        <input type="number" name="pendingUserId" value="${pendingTempTrans.user.id}" style="width: 100%" min="1" onblur="change('pendingFilterForm')">
                                                    </th>
                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Amount</th>
                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Type<br/>
                                                        <select name="pendingType" onchange="change('pendingFilterForm')" style="border: 0; background: none">
                                                            <option value="-1">All</option>
                                                            <option value="1" <c:if test="${pendingTempTrans.type eq 1}">selected</c:if> >Deposit</option>
                                                            <option value="2" <c:if test="${pendingTempTrans.type eq 2}">selected</c:if> >Withdraw</option>
                                                            <option value="3" <c:if test="${pendingTempTrans.type eq 3}">selected</c:if> >Purchase</option>
                                                            <option value="4" <c:if test="${pendingTempTrans.type eq 4}">selected</c:if> >Selling</option>
                                                            </select>
                                                        </th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle">Status<br/>
                                                        </th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle">Description</th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle; width: 14%">Product<br/>
                                                        </th>
                                                    </tr>
                                                </form>
                                                </thead>
                                                <tbody>
                                                <c:if test="${pendingList.size() == 0}">
                                                    <tr>
                                                        <td colspan="7" class="text-center">There is no transaction need to solve</td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach items="${pendingList}" var="transaction">
                                                    <tr>
                                                        <td class="text-center">${transaction.transactionId}</td>
                                                        <td class="text-center">${transaction.user.id}</td>
                                                        <td class="text-center">${transaction.amount}</td>
                                                        <td class="text-center">
                                                            <c:if test="${transaction.type == 1}">
                                                                Deposit
                                                            </c:if>
                                                            <c:if test="${transaction.type == 2}">
                                                                Withdraw
                                                            </c:if>
                                                            <c:if test="${transaction.type == 3}">
                                                                Purchase
                                                            </c:if>
                                                            <c:if test="${transaction.type == 4}">
                                                                Selling
                                                            </c:if>
                                                        </td>
                                                        <td class="text-center">
                                                            <form name="pendingform" id="changeStatus${transaction.transactionId}" action="Status" method="post">
                                                                <select name="upStatus" onchange="openModal('${transaction.transactionId}')">
                                                                    <option value=1 style="color: red">Fail</option>
                                                                    <option value=2 selected>Pending</option>
                                                                    <option value=3 style="color: #11f680">Success</option>
                                                                </select>
                                                                <input name="transactionId" type="hidden" value="${transaction.transactionId}"/>
                                                                <div class="modal fade" name="reject" id="reject${transaction.transactionId}" tabindex="-1" role="dialog" aria-hidden="true">
                                                                    <div class="modal-dialog modal-lg">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h3 class="modal-title">Reject transaction request</h3>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div class="wrapper row">
                                                                                    <div class="text-center" style="font-weight: bold">
                                                                                        Please explain why you reject this request
                                                                                    </div>
                                                                                    <table style="width: 80%; margin: auto">
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                Transaction ID
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.transactionId}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                User ID
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.user.id}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                Amount
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.amount}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                Reason
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                <input name="rejectReason" type="text" value=" " required/>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                            <div class="modal-footer" style="text-align: center">
                                                                                <input type="submit" class="primary text-center" value="Confirm"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="modal fade" name="accept" id="accept${transaction.transactionId}" tabindex="-1" role="dialog" aria-hidden="true">
                                                                    <div class="modal-dialog modal-lg">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h3 class="modal-title">Accept transaction request</h3>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div class="wrapper row">
                                                                                    <h4 class="text-center">
                                                                                        Are you sure you want to accept this request?<br/>
                                                                                        This action cannot be undone.
                                                                                    </h4>
                                                                                    <table style="width: 80%; margin: auto">
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                Transaction ID
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.transactionId}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                User ID
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.user.id}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th style="text-align: left">
                                                                                                Amount
                                                                                            </th>
                                                                                            <td style="width: 100%">
                                                                                                ${transaction.amount}
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                            <div class="modal-footer" style="text-align: center">
                                                                                <input name="rejectReason" type="text" value="Success" required style="display: none"/>
                                                                                <input type="submit" class="primary text-center" value="Confirm"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </td>
                                                        <td>${transaction.description}</td>
                                                        <td class="text-center">
                                                            <c:if test="${transaction.product ne null}">
                                                                ${transaction.product.productId} - ${transaction.product.toString()}
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="list">
                                    <h4 class="card-title">Transactions list</h4>

                                    <div class="table-responsive">
                                        <table class="table user-table " id="tableTrans">
                                            <thead class="thead-dark">
                                            <form id="filterForm" action="Transaction" method="post">
                                                <tr class="text-center" style="cursor: pointer; font-size: 15px;  text-align: center;">

                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Transaction ID</th>
                                                    <th class="text-center" style="width: 10%; text-align: center; vertical-align: middle">User ID<br/>
                                                        <input type="number" name="userId" value="${tempTrans.user.id}" style="width: 100%" min="1" onblur="change('filterForm')">
                                                    </th>
                                                    <th class="" style="text-align: center; vertical-align: middle">Amount</th>
                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Time</th>
                                                    <th class="text-center" style="text-align: center; vertical-align: middle">Type<br/>
                                                        <select name="type" onchange="change('filterForm')" style="border: 0; background: none">
                                                            <option value="-1">All</option>
                                                            <option value="1" <c:if test="${tempTrans.type eq 1}">selected</c:if> >Deposit</option>
                                                            <option value="2" <c:if test="${tempTrans.type eq 2}">selected</c:if> >Withdraw</option>
                                                            <option value="3" <c:if test="${tempTrans.type eq 3}">selected</c:if> >Purchase</option>
                                                            <option value="4" <c:if test="${tempTrans.type eq 4}">selected</c:if> >Selling</option>
                                                            </select>
                                                        </th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle">Status<br/>
                                                            <select name="status" onchange="change('filterForm')" style="border: 0; background: none">
                                                                <option value="-1">All</option>
                                                                <option value="1" <c:if test="${tempTrans.status eq 1}">selected</c:if> >Fail</option>
                                                            <option value="2" <c:if test="${tempTrans.status eq 2}">selected</c:if> >Pending</option>
                                                            <option value="3" <c:if test="${tempTrans.status eq 3}">selected</c:if> >Success</option>
                                                            </select>
                                                        </th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle">Description</th>
                                                        <th class="text-center" style="text-align: center; vertical-align: middle; width: 14%">Product<br/>
                                                            <input type="text" name="productId" value="${tempTrans.product.productId}" style="width: 100%" min="1" onblur="change('filterForm')">
                                                    </th>
                                                </tr>
                                            </form>
                                            </thead>
                                            <tbody>
                                                <c:if test="${transactionList.size() == 0}">
                                                    <tr>
                                                        <td colspan="8" class="text-center">There is no transaction here</td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach items="${transactionList}" var="transaction">
                                                    <tr>
                                                        <td class="text-center">${transaction.transactionId}</td>
                                                        <td class="text-center">${transaction.user.id}</td>
                                                        <td class="text-center">${transaction.amount}</td>
                                                        <td class="text-center">${transaction.transactionTime}</td>
                                                        <td class="text-center">
                                                            <c:if test="${transaction.type == 1}">
                                                                Deposit
                                                            </c:if>
                                                            <c:if test="${transaction.type == 2}">
                                                                Withdraw
                                                            </c:if>
                                                            <c:if test="${transaction.type == 3}">
                                                                Purchase
                                                            </c:if>
                                                            <c:if test="${transaction.type == 4}">
                                                                Selling
                                                            </c:if>
                                                        </td>
                                                        <td class="text-center">
                                                            <c:if test="${transaction.status == 1}">
                                                                Fail
                                                            </c:if>
                                                            <c:if test="${transaction.status == 2}">
                                                                <form id="changeStatus" action="Status" method="post">
                                                                    <select name="upStatus" onchange="changeStatus()">
                                                                        <option value="1" style="color: red" data-toggle="modal" data-target="#reject${transaction.transactionId}">Fail</option>
                                                                        <option value="2" selected>Pending</option>
                                                                        <option value="3" style="color: #11f680"><a data-toggle="modal" data-target="#accept${transaction.transactionId}">Success</a></option>
                                                                    </select>
                                                                    <input name="transactionId" type="hidden" value="${transaction.transactionId}">
                                                                    <div class="modal fade" name="reject" id="reject${transaction.transactionId}" tabindex="-1" role="dialog" aria-hidden="true">
                                                                        <div class="modal-dialog modal-lg">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <h3 class="modal-title">Reject transaction request</h3>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    <div class="wrapper row">
                                                                                        <div class="text-center" style="font-weight: bold">
                                                                                            Please explain why you reject this request
                                                                                        </div>
                                                                                        <table style="width: 80%; margin: auto">
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    Transaction ID
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.transactionId}
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    User ID
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.user.id}
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    Amount
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.amount}
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    Reason
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    <input name="rejectReason" type="text" value=" " required/>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="modal-footer" style="text-align: center">
                                                                                    <input type="submit" class="primary text-center" value="Confirm"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="modal fade" name="accept" id="accept${transaction.transactionId}" tabindex="-1" role="dialog" aria-hidden="true">
                                                                        <div class="modal-dialog modal-lg">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <h3 class="modal-title">Accept transaction request</h3>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    <div class="wrapper row">
                                                                                        <h4 class="text-center">
                                                                                            Are you sure you want to accept this request?<br/>
                                                                                            This action cannot be undone.
                                                                                        </h4>
                                                                                        <table style="width: 80%; margin: auto">
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    Transaction ID
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.transactionId}
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    User ID
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.user.id}
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th style="text-align: left">
                                                                                                    Amount
                                                                                                </th>
                                                                                                <td style="width: 100%">
                                                                                                    ${transaction.amount}
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="modal-footer" style="text-align: center">
                                                                                    <input name="rejectReason" type="text" value="Success" required style="display: none"/>
                                                                                    <input type="submit" class="primary text-center" value="Confirm"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </div>
                                                                </form>
                                                            </c:if>
                                                            <c:if test="${transaction.status == 3}">
                                                                Success
                                                            </c:if>
                                                        </td>
                                                        <td>${transaction.description}</td>
                                                        <td class="text-center">
                                                            <c:if test="${transaction.product ne null}">
                                                                ${transaction.product.productId} - ${transaction.product.toString()}
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                <!-- ============================================================== -->
            </div>
            <!-- End Container fluid  -->
            <!-- footer -->
            <footer class="footer">                                 
                <span class="fa fa-github"></span>
                <a href="https://github.com/nekon0/SoWePray">Our Project</a> 
            </footer>
            <!-- End footer -->
        </div>
        <!-- End Page wrapper  -->

        <!-- End Wrapper -->
        <!-- All Jquery -->
        <script src="/Bookie/manage/assets/plugins/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.js"></script>
        <script src="/Bookie/manage/html/js/app-style-switcher.js"></script>
        <!--Wave Effects -->
        <script src="/Bookie/manage/html/js/waves.js"></script>
        <!--Menu sidebar -->
        <script src="/Bookie/manage/html/js/sidebarmenu.js"></script>
        <!--Custom JavaScript -->
        <script src="/Bookie/manage/html/js/custom.js"></script>
        <script>
                                                                        function change(id) {
                                                                            document.getElementById(id).submit();
                                                                        }
                                                                        function changeStatus() {
                                                                            if (confirm("Are you sure want to change status of this transaction?\nThis action can not be undo.") == true) {
                                                                                document.getElementById('changeStatus').submit();
                                                                            } else {
                                                                                document.getElementById('changeStatus').reset();
                                                                            }
                                                                        }
                                                                        function openModal(transId) {
                                                                            var formId = 'changeStatus' + transId;
                                                                            var selection = document.getElementById(formId).childNodes[1].value;
                                                                            if (selection == 1) {
                                                                                var id = 'reject' + transId;
                                                                                var modal = document.getElementById(id);
                                                                                const modalEl = new bootstrap.Modal(modal);
                                                                                modalEl.show();
                                                                            }
                                                                            if (selection == 3) {
                                                                                var id = 'accept' + transId;
                                                                                var modal = document.getElementById(id);
                                                                                const modalEl = new bootstrap.Modal(modal);
                                                                                modalEl.show();
                                                                            }
                                                                        }
//                                                                        $(document).ready(function () { //Make script DOM ready
//                                                                            $('#upStatus').change(function () { //jQuery Change Function
//                                                                                var opval = $(this).val(); //Get value from select element
//                                                                                if (opval == "1") { //Compare it and if true
//                                                                                    $('#reject').modal("show"); //Open Modal
//                                                                                }
//                                                                                if (opval == "3") { //Compare it and if true
//                                                                                    $('#accept').modal("show"); //Open Modal
//                                                                                }
//                                                                            });
//                                                                        });
        </script>

    </body>
</html>