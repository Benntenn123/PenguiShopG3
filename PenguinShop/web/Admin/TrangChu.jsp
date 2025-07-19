
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
                                    <h4 class="mb-sm-0 font-size-18">Thống kê</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Trang chủ</a></li>
                                            <li class="breadcrumb-item active">Thống kê</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <!-- card -->
                                <div class="card card-h-100">
                                    <!-- card body -->
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Doanh thu tháng</span>
                                                <h4 class="mb-3">
                                                    $<span class="counter-value" data-target="${totalRevenueThisMonth}">
                                                        <fmt:formatNumber value="${totalRevenueThisMonth}" type="number" maxFractionDigits="2" />
                                                    </span>đ
                                                    

                                                </h4>
                                            </div>

                                            <div class="col-6 text-end">
<!--                                                <a href="revenueDetails" class="text-muted">
                                                    <i data-feather="arrow-right-circle" class="font-size-24"></i>
                                                </a>-->
                                            </div>
                                        </div>
<!--                                        <div class="text-nowrap">
                                            <span class="badge bg-success-subtle text-success">+$20.9k</span>
                                            <span class="ms-1 text-muted font-size-13">Since last week</span>
                                        </div>-->
                                    </div><!-- end card body -->
                                </div><!-- end card -->
                            </div><!-- end col -->

                            <div class="col-xl-3 col-md-6">
                                <!-- card -->
                                <div class="card card-h-100">
                                    <!-- card body -->
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Số hóa đơn</span>
                                                <h4 class="mb-3">
                                                    <span class="counter-value" data-target="${orderList.size()}">${orderList.size()}</span>
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <a href="listOrderAdmin?orderID=&from=2025-07-01&to=2025-07-30&status=&user=" class="text-muted">
                                                    <i data-feather="arrow-right-circle" class="font-size-24"></i>
                                                </a>
                                            </div>
                                        </div>
<!--                                        <div class="text-nowrap">
                                            <span class="badge bg-danger-subtle text-danger">-29 Trades</span>
                                            <span class="ms-1 text-muted font-size-13">Since last week</span>
                                        </div>-->
                                    </div><!-- end card body -->
                                </div><!-- end card -->
                            </div><!-- end col-->

                            <div class="col-xl-3 col-md-6">
                                <!-- card -->
                                <div class="card card-h-100">
                                    <!-- card body -->
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Người dùng mới</span>
                                                <h4 class="mb-3">
                                                    <span class="counter-value" data-target="${userList.size()}">${userList.size()}</span
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <a href="listCustomerAdmin" class="text-muted">
                                                    <i data-feather="arrow-right-circle" class="font-size-24"></i>
                                                </a>
                                            </div>
                                        </div>
<!--                                        <div class="text-nowrap">
                                            <span class="badge bg-success-subtle text-success">+ $2.8k</span>
                                            <span class="ms-1 text-muted font-size-13">Since last week</span>
                                        </div>-->
                                    </div><!-- end card body -->
                                </div><!-- end card -->
                            </div><!-- end col -->

                            <div class="col-xl-3 col-md-6">
                                <!-- card -->
                                <div class="card card-h-100">
                                    <!-- card body -->
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Số lượng đánh giá</span>
                                                <h4 class="mb-3">
                                                    <span class="counter-value" data-target="${feedbackList.size()}">${feedbackList.size()}</span>
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <a href="feedbackList" class="text-muted">
                                                    <i data-feather="arrow-right-circle" class="font-size-24"></i>
                                                </a>
                                            </div>
                                        </div>
<!--                                        <div class="text-nowrap">
                                            <span class="badge bg-success-subtle text-success">+2.95%</span>
                                            <span class="ms-1 text-muted font-size-13">Since last week</span>
                                        </div>-->
                                    </div><!-- end card body -->
                                </div><!-- end card -->
                            </div><!-- end col -->    
                        </div><!-- end row-->

                        

                        <div class="row">
                            <div class="col-xl-12 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Doanh thu theo tháng</h5>
                                        <div id="revenue-chart" data-colors='["#5156be"]' class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Số hóa đơn theo tháng</h5>
                                        <div id="order-chart" data-colors='["#34c38f"]' class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Người dùng mới theo tháng</h5>
                                        <div id="user-chart" data-colors='["#f1b44c"]' class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row-->

                        <div class="row">
                            <!-- end col -->

                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Đơn hàng gần đây</h4>

                                    </div><!-- end card header -->

                                    <div class="card-body px-0">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="transactions-all-tab" role="tabpanel">
                                                <div class="table-responsive px-3" data-simplebar style="max-height: 352px;">
                                                    <table class="table align-middle table-nowrap table-borderless">
                                                        <tbody>
                                                            <c:forEach var="latestOrders" items="${latestOrders}">
                                                                <tr>
                                                                    <td style="width: 50px;">
                                                                        <div class="font-size-22 text-success">
                                                                            <i class="bx bx-box d-block"></i>
                                                                        </div>
                                                                    </td>

                                                                    <td>
                                                                        <div>
                                                                            <h5 class="font-size-14 mb-1">Hóa đơn #${latestOrders.orderID}</h5>
                                                                            <p class="text-muted mb-0 font-size-12">${latestOrders.orderDate}</p>
                                                                        </div>
                                                                    </td>

                                                                    <td>
                                                                        <div class="text-end">
                                                                            <h5 class="font-size-14 mb-0">
                                                                                <fmt:formatNumber value="${latestOrders.total}" type="number" maxFractionDigits="2" /> đ
                                                                            </h5>

                                                                            <p class="text-muted mb-0 font-size-12">${latestOrders.name_receiver}</p>
                                                                        </div>
                                                                    </td>


                                                                </tr>
                                                            </c:forEach>     
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!-- end tab pane -->
                                            <div class="tab-pane" id="transactions-buy-tab" role="tabpanel">
                                                <div class="table-responsive px-3" data-simplebar style="max-height: 352px;">
                                                    <table class="table align-middle table-nowrap table-borderless">
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 50px;">
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">14 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.016 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$125.20</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">18 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.018 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$145.80</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy LTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">16 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">1.88 LTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$94.22</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">15 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.56 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$112.34</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">17 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.42 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$84.32</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">15 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.56 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$112.34</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="width: 50px;">
                                                                    <div class="font-size-22 text-success">
                                                                        <i class="bx bx-down-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Buy BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">14 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.016 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$125.20</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>


                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!-- end tab pane -->
                                            <div class="tab-pane" id="transactions-sell-tab" role="tabpanel">
                                                <div class="table-responsive px-3" data-simplebar style="max-height: 352px;">
                                                    <table class="table align-middle table-nowrap table-borderless">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">15 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.56 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$112.34</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="width: 50px;">
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">14 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.016 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$125.20</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">18 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.018 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$145.80</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">15 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.56 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$112.34</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell LTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">16 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">1.88 LTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$94.22</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">17 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.42 ETH</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$84.32</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>



                                                            <tr>
                                                                <td style="width: 50px;">
                                                                    <div class="font-size-22 text-danger">
                                                                        <i class="bx bx-up-arrow-circle d-block"></i>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div>
                                                                        <h5 class="font-size-14 mb-1">Sell BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">14 Mar, 2021</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 mb-0">0.016 BTC</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Coin Value</p>
                                                                    </div>
                                                                </td>

                                                                <td>
                                                                    <div class="text-end">
                                                                        <h5 class="font-size-14 text-muted mb-0">$125.20</h5>
                                                                        <p class="text-muted mb-0 font-size-12">Amount</p>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!-- end tab pane -->
                                        </div>
                                        <!-- end tab content -->
                                    </div>
                                    <!-- end card body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col -->

                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Hoạt động gần đây</h4>

                                    </div><!-- end card header -->

                                    <div class="card-body px-0">
                                        <div class="px-3" data-simplebar style="max-height: 352px;">
                                            <ul class="list-unstyled activity-wid mb-0">
                                                <c:forEach var="latestRequests" items="${latestRequests}">
                                                    <li class="activity-list activity-border">
                                                        <div class="activity-icon avatar-md">
                                                            <span class="avatar-title bg-warning-subtle text-warning rounded-circle">
                                                                <i class="bx bx-bitcoin font-size-24"></i>
                                                            </span>
                                                        </div>
                                                        <div class="timeline-list-item">
                                                            <div class="d-flex">
                                                                <div class="flex-grow-1 overflow-hidden me-4">
                                                                    <h5 class="font-size-14 mb-1">${latestRequests.email_request}</h5>
                                                                    <p class="text-truncate text-muted font-size-13">${latestRequests.requestDate}</p>
                                                                </div>
                                                                <div class="flex-shrink-0 text-end me-3">
                                                                    <h6 class="mb-1">${latestRequests.requestType}</h6>
                                                                    <div style="max-width: 200px" class="font-size-13">${latestRequests.response}</div>
                                                                </div>

                                                                <a href="responseSupport?requestID=${latestRequests.requestID}">
                                                                    <i data-feather="arrow-right-circle"></i> Phản hồi
                                                                </a>

                                                            </div>
                                                        </div> 
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>    
                                    </div>
                                    <!-- end card body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col -->
                        </div><!-- end row -->
                    </div>
                    <!-- container-fluid -->
                </div>
                <!-- End Page-content -->


                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6">
                                <script>document.write(new Date().getFullYear())</script> © Minia.
                            </div>
                            <div class="col-sm-6">
                                <div class="text-sm-end d-none d-sm-block">
                                    Design & Develop by <a href="#!" class="text-decoration-underline">Themesbrand</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
            <!-- end main content-->

        </div>
        <div class="right-bar">
            <div data-simplebar class="h-100">
                <div class="rightbar-title d-flex align-items-center p-3">

                    <h5 class="m-0 me-2">Theme Customizer</h5>

                    <a href="javascript:void(0);" class="right-bar-toggle ms-auto">
                        <i class="mdi mdi-close noti-icon"></i>
                    </a>
                </div>

                <!-- Settings -->
                <hr class="m-0" />

                <div class="p-4">
                    <h6 class="mb-3">Layout</h6>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout"
                               id="layout-vertical" value="vertical">
                        <label class="form-check-label" for="layout-vertical">Vertical</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout"
                               id="layout-horizontal" value="horizontal">
                        <label class="form-check-label" for="layout-horizontal">Horizontal</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2">Layout Mode</h6>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-mode"
                               id="layout-mode-light" value="light">
                        <label class="form-check-label" for="layout-mode-light">Light</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-mode"
                               id="layout-mode-dark" value="dark">
                        <label class="form-check-label" for="layout-mode-dark">Dark</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2">Layout Width</h6>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-width"
                               id="layout-width-fuild" value="fuild" onchange="document.body.setAttribute('data-layout-size', 'fluid')">
                        <label class="form-check-label" for="layout-width-fuild">Fluid</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-width"
                               id="layout-width-boxed" value="boxed" onchange="document.body.setAttribute('data-layout-size', 'boxed')">
                        <label class="form-check-label" for="layout-width-boxed">Boxed</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2">Layout Position</h6>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-position"
                               id="layout-position-fixed" value="fixed" onchange="document.body.setAttribute('data-layout-scrollable', 'false')">
                        <label class="form-check-label" for="layout-position-fixed">Fixed</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-position"
                               id="layout-position-scrollable" value="scrollable" onchange="document.body.setAttribute('data-layout-scrollable', 'true')">
                        <label class="form-check-label" for="layout-position-scrollable">Scrollable</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2">Topbar Color</h6>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="topbar-color"
                               id="topbar-color-light" value="light" onchange="document.body.setAttribute('data-topbar', 'light')">
                        <label class="form-check-label" for="topbar-color-light">Light</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="topbar-color"
                               id="topbar-color-dark" value="dark" onchange="document.body.setAttribute('data-topbar', 'dark')">
                        <label class="form-check-label" for="topbar-color-dark">Dark</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2 sidebar-setting">Sidebar Size</h6>

                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-size"
                               id="sidebar-size-default" value="default" onchange="document.body.setAttribute('data-sidebar-size', 'lg')">
                        <label class="form-check-label" for="sidebar-size-default">Default</label>
                    </div>
                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-size"
                               id="sidebar-size-compact" value="compact" onchange="document.body.setAttribute('data-sidebar-size', 'md')">
                        <label class="form-check-label" for="sidebar-size-compact">Compact</label>
                    </div>
                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-size"
                               id="sidebar-size-small" value="small" onchange="document.body.setAttribute('data-sidebar-size', 'sm')">
                        <label class="form-check-label" for="sidebar-size-small">Small (Icon View)</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2 sidebar-setting">Sidebar Color</h6>

                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-color"
                               id="sidebar-color-light" value="light" onchange="document.body.setAttribute('data-sidebar', 'light')">
                        <label class="form-check-label" for="sidebar-color-light">Light</label>
                    </div>
                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-color"
                               id="sidebar-color-dark" value="dark" onchange="document.body.setAttribute('data-sidebar', 'dark')">
                        <label class="form-check-label" for="sidebar-color-dark">Dark</label>
                    </div>
                    <div class="form-check sidebar-setting">
                        <input class="form-check-input" type="radio" name="sidebar-color"
                               id="sidebar-color-brand" value="brand" onchange="document.body.setAttribute('data-sidebar', 'brand')">
                        <label class="form-check-label" for="sidebar-color-brand">Brand</label>
                    </div>

                    <h6 class="mt-4 mb-3 pt-2">Direction</h6>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-direction"
                               id="layout-direction-ltr" value="ltr">
                        <label class="form-check-label" for="layout-direction-ltr">LTR</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="layout-direction"
                               id="layout-direction-rtl" value="rtl">
                        <label class="form-check-label" for="layout-direction-rtl">RTL</label>
                    </div>

                </div>

            </div> <!-- end slimscroll-menu-->
        </div>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            // Convert backend List<MonthValue> to JS arrays for each chart
            var revenueList = [
                <c:forEach var="mv" items="${revenueList}" varStatus="loop">
                    ${mv.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            var orderList = [
                <c:forEach var="mv" items="${orderList}" varStatus="loop">
                    ${mv.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            var userList = [
                <c:forEach var="mv" items="${userList}" varStatus="loop">
                    ${mv.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            var months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

            document.addEventListener('DOMContentLoaded', function () {
                if (typeof ApexCharts !== 'undefined') {
                    // Chart 1: Doanh thu
                    var optionsRevenue = {
                        series: [{ name: 'Doanh thu', data: revenueList }],
                        chart: { type: 'line', height: 350, toolbar: { show: true } },
                        colors: getChartColorsArray('#revenue-chart'),
                        stroke: { curve: 'smooth', width: 3 },
                        xaxis: { categories: months, title: { text: 'Tháng' } },
                        yaxis: { title: { text: 'Doanh thu (VND)' }, labels: { formatter: function(val) { return val.toLocaleString(); } } },
                        tooltip: { shared: true, intersect: false },
                        legend: { position: 'top' }
                    };
                    new ApexCharts(document.querySelector('#revenue-chart'), optionsRevenue).render();

                    // Chart 2: Số hóa đơn
                    var optionsOrder = {
                        series: [{ name: 'Số hóa đơn', data: orderList }],
                        chart: { type: 'line', height: 350, toolbar: { show: true } },
                        colors: getChartColorsArray('#order-chart'),
                        stroke: { curve: 'smooth', width: 3 },
                        xaxis: { categories: months, title: { text: 'Tháng' } },
                        yaxis: { title: { text: 'Số hóa đơn' } },
                        tooltip: { shared: true, intersect: false },
                        legend: { position: 'top' }
                    };
                    new ApexCharts(document.querySelector('#order-chart'), optionsOrder).render();

                    // Chart 3: Người dùng mới
                    var optionsUser = {
                        series: [{ name: 'Người dùng mới', data: userList }],
                        chart: { type: 'line', height: 350, toolbar: { show: true } },
                        colors: getChartColorsArray('#user-chart'),
                        stroke: { curve: 'smooth', width: 3 },
                        xaxis: { categories: months, title: { text: 'Tháng' } },
                        yaxis: { title: { text: 'Người dùng mới' } },
                        tooltip: { shared: true, intersect: false },
                        legend: { position: 'top' }
                    };
                    new ApexCharts(document.querySelector('#user-chart'), optionsUser).render();
                }
            });
        </script>
        <!-- Mini chart scripts removed -->
    </body>
</html>
