<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/views/base/userHeadImport.jsp"/>
                <script src="https://cdn.tiny.cloud/1/izyaj8jmwovw4l5rpdwzaikjwkm00f6sg4wd6v8cffj4h7y3/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

        <title>Series ${book.title}</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="${context}/images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id} ${sessionScope.user.is_super() eq 3?"- <i class=\"fa fa-dollar\"></i>":""}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="../Profile">My profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="../Security">Security</a>
                    </li>
                    <li class="active sidebar-item">
                        My Novels
                    </li>
                    <li class="sidebar-item">
                        <a href="../Payment">Payment</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="#">Support</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10" style="display: block">
                <!-- Menu -->
                <div class="" style="padding: 0; display: block">
                    <header id="header" style="padding: 0;padding-top: 1.1em">
                        <div>
                            <!-- Logo -->
                            <a href="${context}/Home" class="logo" style="margin-bottom: 1.1em">
                                <span class="fa fa-book" style="padding-left: 2em"></span>
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
                    <jsp:include page="/views/base/menu.jsp" />
                </div>
                <div>
                    <div class="text-center">
                        <h2>Series ${book.title}</h2>
                    </div>
                    <div class="container rounded py-3">
                        <div class="row col-12">
                            <jsp:include page="/views/user/toc/toc.jsp"/>
                            <div class="col-lg-8 col-xlg-9 col-md-7">
                                <div class="card">
                                    <div class="card-body">
                                        <h3 class="card-title mt-2"> 
                                            Chapter ${requestScope.chap.no}
                                        </h3>
                                        <form action="./${service}Chapter" method="post" style="margin-bottom: 0">
                                            <input type="hidden" name="id" value="${requestScope.chap.id}">
                                            <input type="hidden" name="bookId" value="${requestScope.book.id}">
                                            <input type="hidden" name="volumeId" value="${requestScope.vol.id}">
                                            <div class="row mb-3">
                                                <label for="title" class="col-sm-2 col-form-label">Title <span style="color:red">*</span></label>
                                                <div class="col-sm-10">
                                                    <input name="title" type="text" class="form-control" id="title" required value="${requestScope.chap.title}">
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label for="status" class="col-sm-2 col-form-label">Status <span style="color:red">*</span></label>
                                                <c:if test="${chap.status}">
                                                    <div class="col-sm-10">
                                                    <div class="form-check form-check-inline">
                                                        Done
                                                        <input type="hidden" name="status" value="finished">
                                                    </div>
                                                </div>
                                                </c:if>
                                                <c:if test="${!chap.status}">
                                                    <div class="col-sm-10">
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="status" id="status1" value="finished" ${requestScope.chap.status? "checked" : null} >
                                                        <label class="form-check-label" for="status1">Finished</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="status" id="status2" value="unfinished" ${(!requestScope.chap.status)? "checked" : null} >
                                                        <label class="form-check-label" for="status2">Unfinished</label>
                                                    </div>
                                                </div>
                                                </c:if>
                                            </div>
                                            <div class="col-12">
                                                <label for="content" class="form-label">Content<span style="color:red">*</span></label>
                                                <div class="col-12">
                                                    <textarea class="form-control" style="white-space: pre-line;min-height: 20em;resize: vertical" id="content" name="content" rows="20" aria-label="With textarea">${requestScope.chap.content}</textarea>
                                                </div>
                                            </div>
                                            <div class="col-auto mt-5">
                                                <button id="bootstrap-overrides" type="submit" name="service" class="btn btn-primary">${service}</button>
                                            </div>
                                            <div class="col-md-4">
                                                <h6 class="text-center">
                                                    <c:if test="${message !=null}">
                                                        ${message}
                                                    </c:if>
                                                </h6>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </div>
        <!-- Scripts -->
        <jsp:include page="/views/base/userFootImport.jsp"/>
        <script>
            tinymce.init({
      selector: 'textarea',
      plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
      toolbar: 'undo redo | blocks | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
      tinycomments_mode: 'embedded',
      tinycomments_author: 'Author name',
      mergetags_list: [
        { value: 'First.Name', title: 'First Name' },
        { value: 'Email', title: 'Email' },
      ]
    });
        </script>
    </body>
</html>

