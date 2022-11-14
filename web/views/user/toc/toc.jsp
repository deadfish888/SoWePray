<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-lg-4 col-xlg-3 col-md-4">
    <div class="card">
        <div class="card-body profile-card">
            <c:forEach items="${requestScope.volumes}" var="volume">
                <h3 class="card-title mt-2"> 
                    <a target="_blank" href="../../BookDetail?id=${book.id}"><i class="fa fa-external-link-square" aria-hidden="true"></i></a>
                        ${book.title}
                    <a href="./AddChapter?id=${book.id}&vid=${volume.id}"><i class="fa fa-plus-square" aria-hidden="true"></i></a>
                </h3>
                <h4 class="card-subtitle">
                    <ul class="list-group list-group-flush">
                        <c:forEach items="${requestScope.chapters}" var="chapter">
                            <c:if test="${chapter.volumeId==volume.id}">
                                <li class="list-group-item">
                                    <a href="./TOC?id=${book.id}&cid=${chapter.id}">   ${chapter.title}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </h4>
            </c:forEach>
        </div>
    </div>
</div>