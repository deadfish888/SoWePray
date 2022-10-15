<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside class="left-sidebar" data-sidebarbg="skin6">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav">
                <c:set var="context" value="${pageContext.request.contextPath}" />
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="${context}/Edit" aria-expanded="false">
                        <i class="mdi me-2 mdi-account-check"></i><span class="hide-menu">Profile</span></a>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="index.html" aria-expanded="false"><i class="mdi me-2 mdi-gauge"></i><span
                            class="hide-menu">Dashboard</span></a></li>
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="${context}/Admin/Users" aria-expanded="false"><i class="mdi me-2 mdi-table"></i><span
                            class="hide-menu">Users Management</span></a></li>
                <li id="book-management" class="sidebar-item" > <a id="book-management-a" class="sidebar-link waves-effect waves-dark sidebar-link"
                                                                   href="${context}/Admin/Book" aria-expanded="false"><i
                            class="mdi me-2 mdi-book-multiple-variant"></i><span class="hide-menu">Book Management</span></a></li>
                <li id="category-management" class="sidebar-item"> 
                    <a id="category-management-a" class="sidebar-link waves-effect waves-dark sidebar-link"
                       href="${context}/Admin/Category/View" aria-expanded="false">
                        <i class="mdi me-2 mdi-book-multiple-variant"></i>
                        <span class="hide-menu">Category Management</span></a>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="./manage/GGmap.jsp" aria-expanded="false"><i class="mdi me-2 mdi-earth"></i><span
                            class="hide-menu">Google Map</span></a></li>
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="pages-blank.html" aria-expanded="false"><i
                            class="mdi me-2 mdi-book-open-variant"></i><span class="hide-menu">Blank</span></a>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                             href="pages-error-404.html" aria-expanded="false"><i
                            class="mdi me-2 mdi-help-circle"></i><span class="hide-menu">Error 404</span></a>
                </li>
                <!--                            <li class="text-center p-20 upgrade-btn">
                                                <a href="https://www.wrappixel.com/templates/materialpro/"
                                                   class="btn btn-warning text-white mt-4" target="_blank">Upgrade to
                                                    Pro</a>
                                            </li>-->
            </ul>

        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
    <div class="sidebar-footer">
        <div class="row">
            <div class="col-4 link-wrap">
                <!-- item-->
                <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Settings"><i
                        class="ti-settings"></i></a>
            </div>
            <div class="col-4 link-wrap">
                <!-- item-->
                <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Email"><i
                        class="mdi mdi-gmail"></i></a>
            </div>
            <div class="col-4 link-wrap">
                <!-- item-->
                <a href="/Bookie/Logout" class="link" data-toggle="tooltip" title="" data-original-title="Logout"><i
                        class="mdi mdi-power"></i></a>
            </div>
        </div>
    </div>
</aside>