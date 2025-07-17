<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .activity-feed .activity-item {
                padding-bottom: 1.5rem;
                position: relative;
            }

            .activity-feed .activity-item:not(:last-child):before {
                content: '';
                position: absolute;
                left: 1.125rem;
                top: 2.5rem;
                bottom: -0.5rem;
                width: 2px;
                background-color: #e9ecef;
            }

            .activity-icon {
                width: 2.25rem;
                height: 2.25rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
            }

            .activity-title {
                font-size: 0.9rem;
                font-weight: 600;
            }

            .activity-desc {
                font-size: 0.8rem;
                line-height: 1.4;
            }
        </style>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết khách hàng</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="customers">Khách hàng</a></li>
                                            <li class="breadcrumb-item active">Chi tiết khách hàng</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Customer Info -->
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start">
                                            <div class="flex-shrink-0 me-4">
                                                <img src="../api/img/${customer.image_user}" style="width: 10.5rem !important; height: 10.5rem !important" alt="" class="avatar-lg rounded-circle">
                                            </div>
                                            <div class="flex-grow-1">
                                                <h5 class="font-size-16 mb-1">${customer.fullName}</h5>
                                                <p class="text-muted mb-2">ID: #${customer.userID}</p>
                                                <div class="d-flex flex-wrap gap-2">
                                                    <span class="badge bg-primary-subtle text-primary">${customer.role.roleName}</span>
                                                    <c:if test="${customer.status_account eq 1}">
                                                        <span class="badge bg-success-subtle text-success">Hoạt động</span>
                                                    </c:if>
                                                    <c:if test="${customer.status_account eq 0}">
                                                        <span class="badge bg-danger-subtle text-danger">Tạm khóa</span>
                                                    </c:if>
                                                    <c:if test="${customer.status_account eq 2}">
                                                        <span class="badge bg-danger-subtle text-danger">Chưa kích hoạt</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="flex-shrink-0">
                                                <div class="dropdown">
                                                    <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        
                                                        <li><a class="dropdown-item" href="banAccount?accountID=${customer.userID}"><i class="bx bx-block me-2"></i>Khóa tài khoản</a></li>
                                                        
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Thông tin liên hệ</h5>
                                        <div class="table-responsive">
                                            <table class="table table-borderless mb-0">
                                                <tbody>
                                                    <tr>
                                                        <td class="ps-0" style="width: 40%;">Email:</td>
                                                        <td class="text-muted">${customer.email}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="ps-0">Số điện thoại:</td>
                                                        <td class="text-muted">${customer.phone}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="ps-0">Ngày tham gia:</td>
                                                        <td class="text-muted">
                                                            ${customer.created_at}
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tabs -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" data-bs-toggle="tab" href="#addresses" role="tab">
                                                    <i class="bx bx-map font-size-20"></i>
                                                    <span class="d-none d-sm-block">Địa chỉ</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-bs-toggle="tab" href="#orders" role="tab">
                                                    <i class="bx bx-package font-size-20"></i>
                                                    <span class="d-none d-sm-block">Đơn hàng gần nhất</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-bs-toggle="tab" href="#activities" role="tab">
                                                    <i class="bx bx-time font-size-20"></i>
                                                    <span class="d-none d-sm-block">Hoạt động</span>
                                                </a>
                                            </li>
                                        </ul>

                                        <div class="tab-content p-3 text-muted">
                                            <!-- Addresses Tab -->
                                            <div class="tab-pane active" id="addresses" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                                            <h5 class="card-title">Danh sách địa chỉ</h5>
                                                            
                                                        </div>
                                                        <c:forEach items="${addresses}" var="address" varStatus="status">
                                                            <div class="card border">
                                                                <div class="card-body p-3">
                                                                    <div class="d-flex justify-content-between">
                                                                        <div>
                                                                            <h6 class="mb-1">
                                                                                ${address.fullName}
                                                                                <c:if test="${address.isDefault eq 1}">
                                                                                    <span class="badge bg-success-subtle text-success ms-2">Mặc định</span>
                                                                                </c:if>
                                                                            </h6>
                                                                            <p class="text-muted mb-1">${address.phone}</p>
                                                                            <p class="text-muted mb-0">${address.addessDetail}</p>
                                                                            <small class="text-muted">${address.city}</small>
                                                                        </div>
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <c:if test="${empty addresses}">
                                                            <div class="text-center py-4">
                                                                <i class="bx bx-map font-size-48 text-muted"></i>
                                                                <p class="text-muted mt-2">Chưa có địa chỉ nào được thêm</p>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Orders Tab -->
                                            <div class="tab-pane" id="orders" role="tabpanel">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <h5 class="card-title">5 đơn hàng gần nhất</h5>
                                                    <a href="#" class="btn btn-light btn-sm">Xem tất cả</a>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table table-nowrap mb-0">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th scope="col">Mã đơn hàng</th>
                                                                <th scope="col">Ngày đặt</th>
                                                                <th scope="col">Tổng tiền</th>
                                                                <th scope="col">Trạng thái</th>
                                                                <th scope="col">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${recentOrders}" var="order">
                                                                <tr>
                                                                    <td><a href="#" class="text-body fw-bold">#${order.orderID}</a></td>
                                                                    <td>${order.orderDate}</td>
                                                                    <td>${order.total}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${order.orderStatus eq 4}">
                                                                                <span class="badge bg-warning-subtle text-warning">Chờ xử lý</span>
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus eq 5}">
                                                                                <span class="badge bg-info-subtle text-info">Đã xác nhận</span>
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus eq 2}">
                                                                                <span class="badge bg-primary-subtle text-primary">Đang giao</span>
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus eq 1}">
                                                                                <span class="badge bg-success-subtle text-success">Đã giao</span>
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus eq 0}">
                                                                                <span class="badge bg-danger-subtle text-danger">Đã hủy</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <a href="#" class="btn btn-light btn-sm">Xem chi tiết</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <c:if test="${empty recentOrders}">
                                                    <div class="text-center py-4">
                                                        <i class="bx bx-package font-size-48 text-muted"></i>
                                                        <p class="text-muted mt-2">Chưa có đơn hàng nào</p>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Activities Tab -->
                                            <div class="tab-pane" id="activities" role="tabpanel">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <h5 class="card-title">5 hoạt động gần nhất</h5>
                                                </div>
                                                <div class="activity-feed">
                                                    <c:forEach items="${recentActivities}" var="activity">
                                                        <div class="activity-item d-flex">
                                                            
                                                            <div class="flex-grow-1">
                                                                <h6 class="activity-title mb-1">${activity.action}</h6>
                                                                <p class="activity-desc text-muted mb-1">${activity.description}</p>
                                                                <small class="text-muted">
                                                                    ${activity.logDate}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <c:if test="${empty recentActivities}">
                                                    <div class="text-center py-4">
                                                        <i class="bx bx-time font-size-48 text-muted"></i>
                                                        <p class="text-muted mt-2">Chưa có hoạt động nào</p>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
            <!-- end main content-->
        </div>
        <!-- END layout-wrapper -->

        <!-- Right Sidebar -->
        <jsp:include page="Common/RightSideBar.jsp"/>

        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

    </body>
</html>