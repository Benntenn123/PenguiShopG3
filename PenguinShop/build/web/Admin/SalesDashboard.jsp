<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
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
                                    <h4 class="mb-sm-0 font-size-18">Thống kê Sales</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <li class="breadcrumb-item active">Thống kê Sales</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <span class="text-muted mb-3 lh-1 d-block text-truncate">Số hóa đơn trong ngày</span>
                                        <h4 class="mb-3">
                                            <span class="counter-value" data-target="${ordersToday}">${ordersToday}</span>
                                        </h4>
                                        <a href="/PenguinShop/admin/listOrderAdmin?from=<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <span class="text-muted mb-3 lh-1 d-block text-truncate">Tổng request trong ngày</span>
                                        <h4 class="mb-3">
                                            <span class="counter-value" data-target="${requestsToday}">${requestsToday}</span>
                                        </h4>
                                        <a href="/PenguinShop/admin/listRequestSupport?startDate=<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <span class="text-muted mb-3 lh-1 d-block text-truncate">Request đã xử lý</span>
                                        <h4 class="mb-3">
                                            <span class="counter-value" data-target="${requestsProcessedToday}">${requestsProcessedToday}</span>
                                        </h4>
                                        <a href="/PenguinShop/admin/listRequestSupport?startDate=<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>&status=1" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <span class="text-muted mb-3 lh-1 d-block text-truncate">Request chưa xử lý</span>
                                        <h4 class="mb-3">
                                            <span class="counter-value" data-target="${requestsUnprocessedToday}">${requestsUnprocessedToday}</span>
                                        </h4>
                                        <a href="/PenguinShop/admin/listRequestSupport?startDate=<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>&status=0" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row-->

                        <div class="row">
                            <div class="col-xl-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">Top 5 hóa đơn mới nhất</h5>
                                            <a href="/PenguinShop/admin/listOrderAdmin" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                        </div>
                                        <div class="table-responsive" style="max-height: 350px;">
                                            <table class="table table-striped align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>Mã hóa đơn</th>
                                                        <th>Khách hàng</th>
                                                        <th>Ngày tạo</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${recentOrders}">
                                                        <tr>
                                                            <td>${order.orderID}</td>
                                                            <td>${order.user != null ? order.user.fullName : ''}</td>
                                                            <td>${order.orderDate}</td>
                                                            <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.orderStatus == 0}">Đã hủy</c:when>
                                                                    <c:when test="${order.orderStatus == 1}">Giao hàng thành công</c:when>
                                                                    <c:when test="${order.orderStatus == 2}">Đang giao</c:when>
                                                                    <c:when test="${order.orderStatus == 3}">Hoàn hàng</c:when>
                                                                    <c:when test="${order.orderStatus == 4}">Đang chờ xử lí</c:when>
                                                                    <c:when test="${order.orderStatus == 5}">Đã xác nhận</c:when>
                                                                    <c:otherwise>Không xác định</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">Top 5 request mới nhất</h5>
                                            <a href="/PenguinShop/admin/listRequestSupport" class="btn btn-link p-0">Xem thêm <i class="mdi mdi-arrow-right"></i></a>
                                        </div>
                                        <div class="table-responsive" style="max-height: 350px;">
                                            <table class="table table-striped align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>Mã request</th>
                                                        <th>Khách hàng</th>
                                                        <th>Ngày tạo</th>
                                                        <th>Trạng thái</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="req" items="${recentRequests}">
                                                        <tr>
                                                            <td>${req.requestID}</td>
                                                            <td>${req.name_request}</td>
                                                            <td>${req.requestDate}</td>
                                                            <td>
                                                                <c:if test="${req.requestStatus == 0}">Chưa phản hồi</c:if>
                                                                <c:if test="${req.requestStatus == 1}">Đã phản hồi</c:if>
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
                        <!-- end row-->
                    </div>
                </div>
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
            <jsp:include page="Common/Js.jsp"/>
            <jsp:include page="Common/Message.jsp"/>
        </div>
    </body>
</html>
