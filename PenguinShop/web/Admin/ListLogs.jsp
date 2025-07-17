<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="Common/Css.jsp"/>
    <title>Quản lý Log hệ thống</title>
</head>
<body>
<div id="layout-wrapper">
    <jsp:include page="Common/Header.jsp"/>
    <jsp:include page="Common/LeftSideBar.jsp"/>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                            <h4 class="mb-sm-0 font-size-18">Quản lý Log hệ thống</h4>
                        </div>
                    </div>
                </div>
                <form method="get" class="row g-3 mb-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="fullName" placeholder="Tên người dùng" value="${param.fullName}">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="email" placeholder="Email" value="${param.email}">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="phone" placeholder="Số điện thoại" value="${param.phone}">
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </div>
                </form>
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>STT</th>
                                    <th>Tên người dùng</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Hành động</th>
                                    <th>Mô tả</th>
                                    <th>Thời gian</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty logs}">
                                        <c:forEach var="log" items="${logs}" varStatus="loop">
                                            <tr>
                                                <td>${log.logID}</td>
                                                <td>${log.user.fullName}</td>
                                                <td>${log.user.email}</td>
                                                <td>${log.user.phone}</td>
                                                <td>${log.action}</td>
                                                <td>${log.description}</td>
                                                <td>${log.logDate}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="7" class="text-center">Không có dữ liệu log</td></tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination -->
                        <c:if test="${totalPages > 0}">
                            <nav aria-label="Log pagination">
                                <ul class="pagination justify-content-center mt-3">
                                    <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                                        <a class="page-link" href="?fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&from=${param.from}&to=${param.to}&page=${currentPage - 1}" tabindex="-1">&laquo;</a>
                                    </li>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                                            <a class="page-link" href="?fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&from=${param.from}&to=${param.to}&page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
                                        <a class="page-link" href="?fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&from=${param.from}&to=${param.to}&page=${currentPage + 1}">&raquo;</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Common/RightSideBar.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>
</body>
</html>
