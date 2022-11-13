<%-- 
    Document   : ADprofile
    Created on : Sep 13, 2022, 10:52:12 AM
    Author     : duypham0705
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Model.*"%>
<%@page import="context.*"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html dir="ltr" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Dash Board</title>
        <!-- Favicon icon -->
        <!-- Custom CSS -->
        <!--<link rel="stylesheet" href="html/css/style.min.css">-->
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <link href="/Bookie/manage/assets/plugins/chartist-js/dist/chartist.min.css" rel="stylesheet">
        <link href="/Bookie/manage/assets/plugins/chartist-js/dist/chartist-init.css" rel="stylesheet">
        <link href="/Bookie/manage/assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet">
        <!--This page css - Morris CSS -->
        <link href="/Bookie/manage/assets/plugins/c3-master/c3.min.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
             data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- ============================================================== -->
            <!-- Topbar header - style you can find in pages.scss -->
            <jsp:include page="/manage/base/header.jsp"/>
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <jsp:include page="/manage/base/sidebar.jsp"/>



            <div class="page-wrapper">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="page-breadcrumb">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-8 align-self-center">
                            <h3 class="page-title mb-0 p-0">Dashboard</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
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

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="d-flex flex-wrap align-items-center">
                                                <div>
                                                    <h3 class="card-title">By Month</h3>
                                                    <h6 class="card-subtitle">User Sign up in ${requestScope.thisYear}</h6>
                                                </div>
                                                <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
                                                <div id="chartContainer" style="height: 300px; width: 100%;">
                                                    <script type="text/javascript">
                                                        window.onload = function () {
                                                            var chart = new CanvasJS.Chart("chartContainer",
                                                                    {

                                                                        title: {
                                                                            text: "Users - per month"
                                                                        },
                                                                        axisX: {
                                                                            valueFormatString: "MMM",
                                                                            interval: 1,
                                                                            intervalType: "month"
                                                                        },
                                                                        axisY: {
                                                                            includeZero: false

                                                                        },
                                                                        data: [
                                                                            {
                                                                                type: "bar",

                                                                                dataPoints: [
                                                                                    {x: new Date(2022, 00, 1), y: ${requestScope.m0}},
                                                                                    {x: new Date(2022, 01, 1), y: ${requestScope.m1}},
                                                                                    {x: new Date(2022, 02, 1), y: ${requestScope.m2}},
                                                                                    {x: new Date(2022, 03, 1), y: ${requestScope.m3}},
                                                                                    {x: new Date(2022, 04, 1), y: ${requestScope.m4}},
                                                                                    {x: new Date(2022, 05, 1), y: ${requestScope.m5}},
                                                                                    {x: new Date(2022, 06, 1), y: ${requestScope.m6}},
                                                                                    {x: new Date(2022, 07, 1), y: ${requestScope.m7}},
                                                                                    {x: new Date(2022, 08, 1), y: ${requestScope.m8}},
                                                                                    {x: new Date(2022, 09, 1), y: ${requestScope.m9}},
                                                                                    {x: new Date(2022, 10, 1), y: ${requestScope.m10}},
                                                                                    {x: new Date(2022, 11, 1), y: ${requestScope.m11}}
                                                                                ]
                                                                            }
                                                                        ]
                                                                    });

                                                            chart.render();
                                                        }
                                                    </script>
                                                </div>

                                            </div>

                                            <div class="card-body text-center ">
                                                <div>
                                                    <hr class="mt-0 mb-0">
                                                </div>
                                                <h8 class="text-info">
                                                    <i class="mdi mdi-account">Total Users ${sum}</i></h8>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="amp-pxl" style="height: 0px;">
                                                <div class="chartist-tooltip"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-body">
                                    <h3 class="card-title">Total Book</h3>
                                    <h6 class="card-subtitle">Amount ${requestScope.books} </h6>
                                    
                                    <h3 class="card-title">Total Comment</h3>
                                    <h6 class="card-subtitle">Amount ${requestScope.cmt}</h6>
                                    <h3 class="card-title">Total Report</h3>
                                    <h6 class="card-subtitle">Amount </h6>

                                </div>
                                <div>
                                    <hr class="mt-0 mb-0">
                                </div>
                                <div class="card-body text-center ">
                                    <ul class="list-inline d-flex justify-content-center align-items-center mb-0">
                                        <li class="me-4">
                                            <h6 class="text-info">
                                                </h6>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="d-flex flex-wrap align-items-center">
                                                <div>
                                                    <h3 class="card-title">By Quaters</h3>
                                                    <h6 class="card-subtitle">Line Chart about Users Sign up from 2021</h6>
                                                </div>

                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
                                                <canvas id="myChart" style="width:100%;max-width:700px;margin-left: 70px"></canvas>
                                                <script>
                                                        function chart() {
                                                            var xValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                                                            var yValues = ${requestScope.listQuater };
                                                            new Chart("myChart", {
                                                                type: "line",
                                                                data: {
                                                                    labels: xValues,
                                                                    datasets: [{
                                                                            fill: false,
                                                                            lineTension: 0,
                                                                            backgroundColor: "rgba(0,0,255,1.0)",
                                                                            borderColor: "rgba(0,0,255,0.1)",
                                                                            data: yValues
                                                                        }]
                                                                },
                                                                options: {
                                                                    legend: {display: false},
                                                                    scales: {
                                                                        yAxes: [{ticks: {min: 0, max: ${requestScope.max+5}}
                                                                            }],
                                                                    }
                                                                }
                                                            });
                                                        }
                                                        document.getElementById("myChart").innerHTML = chart();
                                                </script>
                                            </div>

                                            <div class="card-body text-center ">
                                                <div style="margin-bottom: 10px">
                                                    <hr class="mt-0 mb-0">
                                                </div>
                                                <h8 class="text-info">
                                                    <i class="mdi mdi-account">Total Users ${totalU}</i></h8>
                                                <br>
                                                <h10 class="text-info"><i class="mdi mdi-calendar-text"> 1 : before ${requestScope.forYear}</i></h10><br>
                                                <h10 class="text-info"><i class="mdi mdi-calendar-text"> 2-5 : quater in ${requestScope.forYear}</i></h10><br>
                                                <h10 class="text-info"><i class="mdi mdi-calendar-text"> 6-9 : quater in ${requestScope.thisYear}</i></h10>

                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="amp-pxl" style="height: 0px;">
                                                <div class="chartist-tooltip"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-body">
                                    <h3 class="card-title">Authors</h3>
                                    <h6 class="card-subtitle">Piechart </h6>

                                    <canvas id="myChart2" style="height: 290px; width: 100%;  position: relative;"></canvas>

                                    <script>
                                        function searchByName(param1, param2) {
                                            var xValues = ["Authors", "Users - Authors"];
                                            var yValues = [param1, param2];
                                            var barColors = [
                                                "#1e88e5",
                                                "#26c6da"
                                            ];
                                            new Chart("myChart2", {
                                                type: "doughnut",
                                                data: {
                                                    labels: xValues,
                                                    datasets: [{
                                                            backgroundColor: barColors,
                                                            data: yValues
                                                        }]
                                                },
                                                options: {
                                                    title: {
                                                        display: false,
                                                        text: ""
                                                    }
                                                }
                                            });
                                        }
                                        document.getElementById("myChart2").innerHTML = searchByName(${requestScope.per1}, ${requestScope.per2});
                                    </script>

                                </div>
                                <div>
                                    <hr class="mt-0 mb-0">
                                </div>
                                <div class="card-body text-center ">
                                    <ul class="list-inline d-flex justify-content-center align-items-center mb-0">
                                        <li class="me-4">
                                            <h6 class="text-info">
                                                <i class="mdi mdi-account-edit"></i>Total Authors ${totalA}</h6>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <!-- ============================================================== -->
                <!-- End Container fluid  -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- footer -->
                <!-- ============================================================== -->

                <!-- ============================================================== -->
                <!-- End footer -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- End Page wrapper  -->
                <!-- ============================================================== -->


                <!-- ============================================================== -->
                <!-- End Container fluid  -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- footer -->
                <!-- ============================================================== -->
                <footer class="footer">                                 
                    <span class="fa fa-github"></span>
                    <a href="https://github.com/nekon0/SoWePray">Our Project</a> 
                </footer>
                <!-- ============================================================== -->
                <!-- End footer -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Page wrapper  -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Wrapper -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- All Jquery -->
        <!-- ============================================================== -->
        <script src="https://kit.fontawesome.com/a65741f09b.js" crossorigin="anonymous"></script>

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

        <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="/Bookie/manage/assets/plugins/chartist-js/dist/chartist.min.js"></script>
        <script src="/Bookie/manage/assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.min.js"></script>
        <!--c3 JavaScript -->
        <script src="/Bookie/manage/assets/plugins/d3/d3.min.js"></script>
        <script src="/Bookie/manage/assets/plugins/c3-master/c3.min.js"></script>
        <!--Custom JavaScript -->
        <script src="/Bookie/manage/html/js/pages/dashboards/dashboard1.js"></script>
        <script src="/Bookie/manage/html/js/custom.js"></script>

    </body>

</html>
