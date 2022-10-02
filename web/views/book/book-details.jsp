
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Book</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <link rel="stylesheet" href="assets/css/StarRating.css" />
        <link rel="stylesheet" href="assets/css/rateButton.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
    </head>
    <body class="is-preload">
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
            <jsp:include page="/views/base/menu.jsp" />

            <!-- Main -->
            <div id="main">
                <div class="inner">
                    <h1 style="margin: 0 0 0 0;">${book.getTitle()}
                        <c:if test="${book.issale()}">
                            <span class="pull-right">
                                <del>$${book.getPrice()}</del> 
                                $${Math.round(book.getPrice())/100}
                            </span>
                        </c:if> 
                        <c:if test="${!book.issale()}">
                            <span class="pull-right">$${book.getPrice()}</span>
                        </c:if>
                    </h1>
                    <h2> ${book.getAuthor()} </h2>

                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.getImage()}" class="img-fluid" alt="${book.getImage()}">
                                <div style="text-align: center;">
                                    <span class="fa fa-eye"></span>
                                    <span class="title">${book.getViews()}</span>
                                </div>
                            </div>

                            <div class="col-md-7">
                                <h2 style="margin: 0 0 0.8em 0;"><i>Category: ${category}</i></h2>
                                <p>
                                    ${book.getDescription()}
                                </p>
                                <div class="row">        
                                    
                                    <c:if test="${sessionScope.user != null}">
                                        <c:if test="${requestScope.own}">
                                        <form>
                                            <div class="col-sm-6">
                                                <input type="button" class="primary" value="Read">
                                            </div>
                                        </form>
                                        </c:if>
                                        <c:if test="${!own}">
                                        <input type="button" class="primary btn-primary" data-toggle="modal" data-target="#purchase" value="Buy"/>
                                        <span style="color: red"></span>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sessionScope.user == null}">
                                        <form action="Login" method="GET">
                                            <div class="col-sm-6">
                                                <input type="submit" class="primary" value="Buy">
                                            </div>
                                        </form>
                                    </c:if>

                                    <div class="modal fade" id="purchase" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <form action="User/Purchase" method="post" id="purchaseForm" name="purchaseForm" onsubmit="return validatePassword()">
                                                    <div class="modal-header">
                                                        <h3 class="modal-title">Purchase</h3>
                                    </form>    
                                    <form action="Favourite" method="POST">
                                         <div class="col-sm-4">
                                             
                                             <input type="submit" class="primary" value="Add to Favorite">                                 
                                            <input type="hidden" name="bId" value="${book.getId()}">
                                         </div>
                                    </form>
                                    <form action="Report" method="POST">
                                          <div class="col-sm-4"> 
                                              <input type="submit" class="primary" value="Report">                                 
                                            <input type="hidden" name="bId" value="${book.getId()}">
                                          </div>   
                                    </form>      
                                         
                                </div>
                                            <c:choose >
                                                <c:when test="${sessionScope.user!=null}" > 
                                                <form action="Rating" method="POST">        
                                                    <div class="rate">
                                                        <input type="radio" id="star5" name="getRate" value="5" />
                                                        <label for="star5" title="text">5</label>
                                                        <input type="radio" id="star4" name="getRate" value="4" />
                                                        <label for="star4" title="text">4</label>
                                                        <input type="radio" id="star3" name="getRate" value="3" />
                                                        <label for="star3" title="text">3</label>
                                                        <input type="radio" id="star2" name="getRate" value="2" />
                                                        <label for="star2" title="text">2</label>
                                                        <input type="radio" id="star1" name="getRate" value="1" />
                                                        <label for="star1" title="text">1</label>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="wrapper row">
                                                            <table style="width: 80%; margin: auto">
                                                                <tr>
                                                                    <th>
                                                                        Book
                                                                    </th>
                                                                    <td>
                                                                        ${book.title}
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>
                                                                        Price
                                                                    </th>
                                                                    <td>
                                                                        ${book.price}
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>
                                                                        Password
                                                                    </th>
                                                                    <td>
                                                                        <input type="password" name="password"/>
                                                                        <div style="color: red" id="purchase-pass-noti"></div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer" style="text-align: center">
                                                        <button type="button" class="primary btn-primary text-center" data-dismiss="modal" style="width: auto; padding: 0 1em">Cancel</button>
                                                        <input type="hidden" id="pass" value="${sessionScope.user.password}"/>
                                                        <input type="hidden" name="amount" value="${book.price}"/>
                                                        <input type="hidden" name="bookId" value="${book.id}"/>
                                                        <input type="hidden" name="bookTitle" value="${book.title}"/>
                                                        <input type="submit" class="primary text-center" value="Confirm"/>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!--                                    <form action="User/Purchase" method="POST">
                                                                             <div class="col-sm-6">
                                                                                <input type="hidden" name="bookId" value="${book.getId()}">
                                                                                 <input type="submit" class="primary" value="Buy">          
                                                                             </div>
                                                                        </form>-->
                                </div>
                                <c:choose >
                                    <c:when test="${sessionScope.user!=null}" > 
                                        <form action="Rating" method="POST">        
                                            <div class="rate">
                                                <input type="radio" id="star5" name="getRate" value="5" />
                                                <label for="star5" title="text">5</label>
                                                <input type="radio" id="star4" name="getRate" value="4" />
                                                <label for="star4" title="text">4</label>
                                                <input type="radio" id="star3" name="getRate" value="3" />
                                                <label for="star3" title="text">3</label>
                                                <input type="radio" id="star2" name="getRate" value="2" />
                                                <label for="star2" title="text">2</label>
                                                <input type="radio" id="star1" name="getRate" value="1" />
                                                <label for="star1" title="text">1</label>
                                            </div>
                                            <div><button type="submit" class="submitRate" name="gRate">Rate</button></div>
                                        </form>   
                                    </c:when>
                                </c:choose>    
                                <div><input type="hidden" name="bId" value="${book.getId()}"></div>    
                                <div>Book rating: ${book.getRating()} </div>
                            </div>
                            
                            <div class="col-md-3">
                                <form role="form" action="Comment" method="GET">
                                    <div class="form-group">
                                        <textarea class="form-control" name="comment" placeholder="Write your comment here..."></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Send</button>
                                </form> 
                            </div>
<!--                            <div class="col-md-7">
                                <%--<c:forEach var=></c:forEach>--%>
                            </div>   -->
                            <br>
                        </div>           
                    </div>
                    <br>
                    <br>
                    <div class="container-fluid">
                        <h2 class="h2">Similar Products</h2>

                        <!-- Products -->
                        <section class="tiles">
                            <c:forEach items="${requestScope.sames}" var="same">
                                <article class="style1">
                                    <span class="image">
                                        <img src="${same.getImage()}" alt="${same.getImage()}" style="height: 391px;" />
                                    </span>
                                    <a href="BookDetail?id=${same.getId()}">
                                        <h2>${same.getTitle()}</h2>

                                        <c:if test="${same.issale()}">
                                            <p>
                                                <del>$${same.getPrice()}</del> 
                                                <strong>$5.00</strong>
                                            </p>
                                        </c:if>
                                        <c:if test="${!same.issale()}">
                                            <p><strong>$${same.getPrice()}</strong></p>
                                        </c:if>
                                    </a>
                                </article>
                            </c:forEach>
                        </section>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li><span class="fa fa-github"></span> <a href="https://github.com/nekon0/SoWePray">Our Project</a></li>
                            <li><span class="fa fa-map-pin"></span> <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7"> DE336, FBT University</a></li>
                        </ul>
                    </section>

                    <ul class="copyright">
                        <li> HLV </li>
                    </ul>
                </div>
            </footer>

        </div>

        <!-- Scripts -->
        <script>

            function validatePassword() {
                let pass = document.forms["purchaseForm"]["pass"].value;
                let x = document.forms["purchaseForm"]["password"].value;
                if (pass !== x) {
                    document.getElementById("purchase-pass-noti").innerHTML = "Wrong password";
                    return false;
                }
            }

        </script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>
