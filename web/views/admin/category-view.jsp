<%-- 
    Document   : category-view
    Created on : Oct 16, 2022, 2:35:07 AM
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
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="../../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script>
            
            function edit(id) {
                var a = "after" + id;
                var b = "before" + id;

                var get = document.getElementById("after" + id);
                if (get.style.display === "none") {
                    get.style.display = "block";
                    document.getElementById("before" + id).style.display = "none";
                } else {
                    get.style.display = "none";
                    document.getElementById("before" + id).style.display = "block";

                }
            }
        </script>
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
                            <h3 class="page-title mb-0 p-0">Category Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Category Management</li>
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
                                <h4 class="card-title">Categories list</h4>
                                <div class="left-filter">
                                    <button class="text-center btn btn-purple" value="addCategory" data-toggle="modal" 
                                            data-target="#addCategory">Add category</button> 
                                    <span>  <c:if test="${sessionScope.addCategoryMessage ne null}">${sessionScope.addCategoryMessage}</c:if></span>
                                    <%request.getSession().removeAttribute("addCategoryMessage");%>
                                </div>

                                <div class="modal" id="addCategory" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content text-center">
                                            <form action="Add" method="post" id="addCategoryForm" name="addForm">
                                                <div class="modal-header">
                                                    <h3 class="modal-title">Add category</h3>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="wrapper row">
                                                        <table>
                                                            <tr>
                                                                <th style="padding-left: 2em; width: 30%">
                                                                    Category name
                                                                </th>
                                                                <td>
                                                                    <input type="text" name="categoryName" style="width: 80%" required/>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="modal-footer" style="text-align: center">
                                                    <button type="button" data-dismiss="modal">Cancel</button>
                                                    <input type="submit" value="Confirm"/>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table user-table " id="tablepro">
                                        <thead>
                                            <tr class="text-center" style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                <th class="text-center">ID</th>
                                                <th class="text-center" style="width: 40%">Name</th>
                                                <th class="text-center">Number of books</th>
                                                <th class="text-center">Active</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${categoryList}" var="category">
                                                <tr>
                                                    <td class="text-center">${category.id}</td>
                                                    <td>
                                                        <div id="before${category.id}" style="display: block">
                                                            <button style="border: 0; background: none" onclick="edit(${category.id})">
                                                                ${category.name} 
                                                                <i id="pen" class='fa fa-pencil-square'></i>
                                                            </button>
                                                        </div>
                                                        <div id="after${category.id}" style="display: none">
                                                            <form action="Update" method="post" name="remove">
                                                                <input type="text" name="categoryName" value="${category.name}" required>
                                                                <input type="hidden" name="categoryId" value="${category.id}">
                                                                <button style="border: 0; background: none" type="submit">
                                                                    <i id="confirm${category.id}" class="fa fa-check-circle" style="color: #09dd80"></i>
                                                                </button>
                                                                <button style="border: 0; background: none" type="reset" onclick="edit(${category.id})">
                                                                    <i id="discard${category.id}" class="fa fa-times-circle red" style="color: red"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">${categoryMap[category]}</td>

                                                    <td class="text-center">
                                                        <form action="Remove?categoryId=${category.id}" method="post" name="remove" onsubmit="return confirm('Are you sure you want to change the active status of this category?');">
                                                            <c:if test="${category.active}">
                                                                <input type="hidden" name="active" value="1"/>
                                                                <button type="submit" style="border: 0; background: none">
                                                                    <i id="checkbox" class='fa fa-check-square'></i>
                                                                </button></c:if>
                                                            <c:if test="${!category.active}">
                                                                <input type="hidden" name="active" value="0"/>
                                                                <button type="submit" style="border: 0; background: none">
                                                                    <i id="checkbox" class='fa fa-square-o'></i>
                                                                </button></c:if>
                                                            </form>
                                                        </td>
                                                    </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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


    </body>
</html>
