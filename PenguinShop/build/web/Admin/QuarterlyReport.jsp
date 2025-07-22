<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>Báo cáo quý</title>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>

            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Báo cáo thống kê quý</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="TrangChu">Trang chủ</a></li>
                                            <li class="breadcrumb-item active">Báo cáo quý</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Filter Section -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form method="get" action="quarterly-report" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">Năm</label>
                                                <select class="form-select" name="year">
                                                    <c:forEach var="y" begin="2020" end="2030">
                                                        <option value="${y}" ${currentYear == y ? 'selected' : ''}>${y}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Quý</label>
                                                <select class="form-select" name="quarter">
                                                    <option value="1" ${currentQuarter == 1 ? 'selected' : ''}>Quý 1 (T1-T3)</option>
                                                    <option value="2" ${currentQuarter == 2 ? 'selected' : ''}>Quý 2 (T4-T6)</option>
                                                    <option value="3" ${currentQuarter == 3 ? 'selected' : ''}>Quý 3 (T7-T9)</option>
                                                    <option value="4" ${currentQuarter == 4 ? 'selected' : ''}>Quý 4 (T10-T12)</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3 d-flex align-items-end">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search"></i> Xem báo cáo
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Summary Cards với dữ liệu thực -->
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Doanh thu quý</span>
                                                <h4 class="mb-3">
                                                    <c:choose>
                                                        <c:when test="${not empty quarterlyRevenue and quarterlyRevenue > 0}">
                                                            <fmt:formatNumber value="${quarterlyRevenue}" type="number" maxFractionDigits="0" />đ
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có dữ liệu</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <div class="avatar-md mx-auto">
                                                    <span class="avatar-title rounded-circle bg-light">
                                                        <i class="bx bx-trending-up font-size-24 text-primary"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Chi phí nhập hàng</span>
                                                <h4 class="mb-3 text-danger">
                                                    <c:choose>
                                                        <c:when test="${not empty quarterlyImportCost and quarterlyImportCost > 0}">
                                                            <fmt:formatNumber value="${quarterlyImportCost}" type="number" maxFractionDigits="0" />đ
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có dữ liệu</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <div class="avatar-md mx-auto">
                                                    <span class="avatar-title rounded-circle bg-light">
                                                        <i class="bx bx-trending-down font-size-24 text-danger"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Lợi nhuận quý</span>
                                                <c:choose>
                                                    <c:when test="${not empty quarterlyRevenue and not empty quarterlyImportCost and quarterlyRevenue > 0 and quarterlyImportCost >= 0}">
                                                        <c:set var="profit" value="${quarterlyRevenue - quarterlyImportCost}" />
                                                        <h4 class="mb-3 ${profit >= 0 ? 'text-success' : 'text-danger'}">
                                                            <fmt:formatNumber value="${profit}" type="number" maxFractionDigits="0" />đ
                                                        </h4>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <h4 class="mb-3 text-muted">Không có dữ liệu</h4>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-6 text-end">
                                                <div class="avatar-md mx-auto">
                                                    <span class="avatar-title rounded-circle bg-light">
                                                        <i class="bx bx-bar-chart-alt-2 font-size-24 text-success"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card card-h-100">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <span class="text-muted mb-3 lh-1 d-block text-truncate">Số đơn hàng</span>
                                                <h4 class="mb-3">
                                                    <c:choose>
                                                        <c:when test="${not empty quarterlyOrderCount and quarterlyOrderCount > 0}">
                                                            ${quarterlyOrderCount}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có dữ liệu</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h4>
                                            </div>
                                            <div class="col-6 text-end">
                                                <div class="avatar-md mx-auto">
                                                    <span class="avatar-title rounded-circle bg-light">
                                                        <i class="bx bx-receipt font-size-24 text-info"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Charts Section -->
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Thu chi theo tháng trong quý</h5>
                                        <div id="revenue-expense-chart" data-colors='["#34c38f", "#f46a6a"]' class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Tỷ lệ lợi nhuận</h5>
                                        <div id="profit-chart" data-colors='["#556ee6", "#f1b44c"]' class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Top Products Section -->
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Top 5 sản phẩm bán chạy nhất</h4>
                                        <i class="bx bx-trending-up text-success font-size-24"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-borderless align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>STT</th>
                                                        <th>Sản phẩm</th>
                                                        <th>Số lượng bán</th>
                                                        <th>Doanh thu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Sample data for top selling products -->
                                                    <c:choose>
                                                        <c:when test="${not empty topSellingProducts}">
                                                            <c:forEach var="product" items="${topSellingProducts}" varStatus="status">
                                                                <tr>
                                                                    <td>
                                                                        <span class="badge badge-soft-success font-size-12">
                                                                            ${status.index + 1}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="avatar-sm me-3">
                                                                                <img src="../api/img/${product.productImage}" alt="${product.productName}" 
                                                                                     class="img-fluid rounded" style="width: 40px; height: 40px; object-fit: cover;">
                                                                            </div>
                                                                            <div>
                                                                                <h6 class="mb-0 font-size-14">${product.productName}</h6>
                                                                                <p class="text-muted mb-0 font-size-12">${product.variantName}</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <h6 class="mb-0">${product.totalQuantity}</h6>
                                                                    </td>
                                                                    <td>
                                                                        <h6 class="mb-0 text-success">
                                                                            <fmt:formatNumber value="${product.totalRevenue}" type="number" maxFractionDigits="0" />đ
                                                                        </h6>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="4" class="text-center text-muted py-4">
                                                                    <i class="bx bx-info-circle font-size-18 me-2"></i>
                                                                    Không có dữ liệu sản phẩm bán chạy
                                                                </td>
                                                            </tr>

                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="card-header align-items-center d-flex">
                                        <h4 class="card-title mb-0 flex-grow-1">Top 5 sản phẩm bán chậm nhất</h4>
                                        <i class="bx bx-trending-down text-warning font-size-24"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-borderless align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>STT</th>
                                                        <th>Sản phẩm</th>
                                                        <th>Số lượng bán</th>
                                                        <th>Doanh thu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Sample data for slow selling products -->
                                                    <c:choose>
                                                        <c:when test="${not empty slowSellingProducts}">
                                                            <c:forEach var="product" items="${slowSellingProducts}" varStatus="status">
                                                                <tr>
                                                                    <td>
                                                                        <span class="badge badge-soft-warning font-size-12">
                                                                            ${status.index + 1}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="avatar-sm me-3">
                                                                                <img src="../api/img/${product.productImage}" alt="${product.productName}" 
                                                                                     class="img-fluid rounded" style="width: 40px; height: 40px; object-fit: cover;">
                                                                            </div>
                                                                            <div>
                                                                                <h6 class="mb-0 font-size-14">${product.productName}</h6>
                                                                                <p class="text-muted mb-0 font-size-12">${product.variantName}</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <h6 class="mb-0">${product.totalQuantity}</h6>
                                                                    </td>
                                                                    <td>
                                                                        <h6 class="mb-0 text-warning">
                                                                            <fmt:formatNumber value="${product.totalRevenue}" type="number" maxFractionDigits="0" />đ
                                                                        </h6>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="4" class="text-center text-muted py-4">
                                                                    <i class="bx bx-info-circle font-size-18 me-2"></i>
                                                                    Không có dữ liệu sản phẩm bán chậm
                                                                </td>
                                                            </tr>
                                                        <td><span class="badge badge-soft-warning font-size-12">5</span></td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div class="avatar-sm me-3">
                                                                    <div class="avatar-title bg-dark rounded font-size-16">TL</div>
                                                                </div>
                                                                <div>
                                                                    <h6 class="mb-0 font-size-14">Thắt lưng</h6>
                                                                    <p class="text-muted mb-0 font-size-12">Da - Đen</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><h6 class="mb-0">18</h6></td>
                                                        <td><h6 class="mb-0 text-warning">900,000đ</h6></td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Detailed Tables -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title mb-0">Chi tiết thu chi theo tháng</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Tháng</th>
                                                        <th>Doanh thu</th>
                                                        <th>Chi phí nhập hàng</th>
                                                        <th>Lợi nhuận</th>
                                                        <th>Số đơn hàng</th>
                                                        <th>Số phiếu nhập</th>
                                                        <th>Tỷ lệ lợi nhuận</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${not empty monthlyReports}">
                                                            <c:forEach var="monthly" items="${monthlyReports}" varStatus="status">
                                                                <tr>
                                                                    <td>
                                                                        <strong>Tháng ${monthly.month}/${monthly.year}</strong>
                                                                    </td>
                                                                    <td class="text-success">
                                                                        <fmt:formatNumber value="${monthly.revenue}" type="number" maxFractionDigits="0" />đ
                                                                    </td>
                                                                    <td class="text-danger">
                                                                        <fmt:formatNumber value="${monthly.importCost}" type="number" maxFractionDigits="0" />đ
                                                                    </td>
                                                                    <td class="${monthly.profit >= 0 ? 'text-success' : 'text-danger'}">
                                                                        <fmt:formatNumber value="${monthly.profit}" type="number" maxFractionDigits="0" />đ
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge badge-soft-info">${monthly.orderCount}</span>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge badge-soft-warning">${monthly.importOrderCount}</span>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${monthly.revenue > 0}">
                                                                                <c:set var="profitRate" value="${(monthly.profit / monthly.revenue) * 100}" />
                                                                                <span class="${profitRate >= 0 ? 'text-success' : 'text-danger'}">
                                                                                    <fmt:formatNumber value="${profitRate}" type="number" maxFractionDigits="1" />%
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted">-</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Sample data when no real data available -->
                                                            <tr>
                                                                <td><strong>Tháng 7/2025</strong></td>
                                                                <td class="text-success">15,000,000đ</td>
                                                                <td class="text-danger">9,000,000đ</td>
                                                                <td class="text-success">6,000,000đ</td>
                                                                <td><span class="badge badge-soft-info">45</span></td>
                                                                <td><span class="badge badge-soft-warning">12</span></td>
                                                                <td><span class="text-success">40.0%</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Tháng 8/2025</strong></td>
                                                                <td class="text-success">17,000,000đ</td>
                                                                <td class="text-danger">10,000,000đ</td>
                                                                <td class="text-success">7,000,000đ</td>
                                                                <td><span class="badge badge-soft-info">50</span></td>
                                                                <td><span class="badge badge-soft-warning">14</span></td>
                                                                <td><span class="text-success">41.2%</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td><strong>Tháng 9/2025</strong></td>
                                                                <td class="text-success">19,000,000đ</td>
                                                                <td class="text-danger">11,000,000đ</td>
                                                                <td class="text-success">8,000,000đ</td>
                                                                <td><span class="badge badge-soft-info">55</span></td>
                                                                <td><span class="badge badge-soft-warning">16</span></td>
                                                                <td><span class="text-success">42.1%</span></td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            // Dữ liệu từ backend
// Dữ liệu từ backend
            var monthlyRevenue = [
            <c:forEach var="monthly" items="${monthlyReports}" varStatus="loop">
                ${monthly.revenue != null ? monthly.revenue : 0}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];
            var monthlyExpense = [
            <c:forEach var="monthly" items="${monthlyReports}" varStatus="loop">
                ${monthly.importCost != null ? monthly.importCost : 0}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];
            var monthLabels = [
            <c:forEach var="monthly" items="${monthlyReports}" varStatus="loop">
            "T${monthly.month}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];
            var hasData = ${not empty monthlyReports ? 'true' : 'false'};
            var quarterlyRevenue = ${quarterlyRevenue != null ? quarterlyRevenue : 0};
            var quarterlyImportCost = ${quarterlyImportCost != null ? quarterlyImportCost : 0};

// Debug dữ liệu
            console.log('monthlyRevenue:', monthlyRevenue);
            console.log('monthlyExpense:', monthlyExpense);
            console.log('monthLabels:', monthLabels);
            console.log('hasData:', hasData);
            console.log('quarterlyRevenue:', quarterlyRevenue);
            console.log('quarterlyImportCost:', quarterlyImportCost);

// Hàm lấy màu từ data-colors
            function getChartColorsArray(elementId) {
                try {
                    var element = document.querySelector(elementId);
                    if (!element) {
                        console.warn('Element not found for ID:', elementId);
                        return elementId === '#revenue-expense-chart' ? ['#34c38f', '#f46a6a'] : ['#556ee6', '#f1b44c'];
                    }
                    var colorsAttr = element.getAttribute('data-colors');
                    if (!colorsAttr) {
                        console.warn('data-colors attribute not found for:', elementId);
                        return elementId === '#revenue-expense-chart' ? ['#34c38f', '#f46a6a'] : ['#556ee6', '#f1b44c'];
                    }
                    var colors = JSON.parse(colorsAttr);
                    if (!Array.isArray(colors)) {
                        console.warn('Invalid data-colors format for:', elementId);
                        return elementId === '#revenue-expense-chart' ? ['#34c38f', '#f46a6a'] : ['#556ee6', '#f1b44c'];
                    }
                    return colors.map(function (value) {
                        var newValue = value.replace(/\s/g, '');
                        if (newValue.indexOf(',') === -1) {
                            var color = getComputedStyle(document.documentElement).getPropertyValue(newValue);
                            return color ? color.trim() : newValue;
                        } else {
                            var val = newValue.split(',');
                            if (val.length === 2) {
                                var rgbaColor = getComputedStyle(document.documentElement).getPropertyValue(val[0]);
                                return 'rgba(' + rgbaColor.trim() + ',' + val[1] + ')';
                            }
                            return newValue;
                        }
                    });
                } catch (e) {
                    console.error('Error in getChartColorsArray for ' + elementId + ':', e);
                    return elementId === '#revenue-expense-chart' ? ['#34c38f', '#f46a6a'] : ['#556ee6', '#f1b44c'];
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                if (typeof ApexCharts === 'undefined') {
                    console.error('ApexCharts is not defined');
                    document.querySelector('#revenue-expense-chart').innerHTML = '<div class="text-center py-5"><h5 class="text-muted">Lỗi: ApexCharts không được tải</h5></div>';
                    document.querySelector('#profit-chart').innerHTML = '<div class="text-center py-5"><h5 class="text-muted">Lỗi: ApexCharts không được tải</h5></div>';
                    return;
                }

                // Revenue-Expense Chart
                if (hasData && monthLabels.length > 0) {
                    var optionsRevenueExpense = {
                        series: [{
                                name: 'Doanh thu',
                                data: monthlyRevenue
                            }, {
                                name: 'Chi phí nhập hàng',
                                data: monthlyExpense
                            }],
                        chart: {
                            type: 'bar',
                            height: 350,
                            toolbar: {show: true}
                        },
                        colors: getChartColorsArray('#revenue-expense-chart'),
                        plotOptions: {
                            bar: {
                                horizontal: false,
                                columnWidth: '55%',
                                endingShape: 'rounded'
                            }
                        },
                        dataLabels: {enabled: false},
                        stroke: {
                            show: true,
                            width: 2,
                            colors: ['transparent']
                        },
                        xaxis: {
                            categories: monthLabels,
                            title: {text: 'Tháng'}
                        },
                        yaxis: {
                            title: {text: 'Số tiền (VND)'},
                            labels: {
                                formatter: function (val) {
                                    return val.toLocaleString();
                                }
                            }
                        },
                        fill: {opacity: 1},
                        tooltip: {
                            shared: true,
                            intersect: false,
                            y: {
                                formatter: function (val) {
                                    return val.toLocaleString() + " đ";
                                }
                            }
                        },
                        legend: {position: 'top'}
                    };
                    try {
                        new ApexCharts(document.querySelector('#revenue-expense-chart'), optionsRevenueExpense).render();
                    } catch (e) {
                        console.error('Error rendering revenue-expense-chart:', e);
                        document.querySelector('#revenue-expense-chart').innerHTML = '<div class="text-center py-5"><h5 class="text-muted">Lỗi khi vẽ biểu đồ</h5></div>';
                    }
                } else {
                    document.querySelector('#revenue-expense-chart').innerHTML = '<div class="text-center py-5"><h5 class="text-muted">Không có dữ liệu để hiển thị biểu đồ</h5></div>';
                }

                // Profit Chart
                var profit = quarterlyRevenue - quarterlyImportCost;
                var profitLabel = profit >= 0 ? 'Lợi nhuận' : 'Lỗ';
                var profitValue = Math.abs(profit);

                var optionsProfit = {
                    series: [quarterlyImportCost, profitValue],
                    chart: {
                        type: 'donut',
                        height: 350
                    },
                    labels: ['Chi phí', profitLabel],
                    colors: getChartColorsArray('#profit-chart'),
                    dataLabels: {
                        enabled: true,
                        formatter: function (val) {
                            return val.toFixed(1) + "%";
                        }
                    },
                    tooltip: {
                        y: {
                            formatter: function (val) {
                                return val.toLocaleString() + " đ";
                            }
                        }
                    },
                    legend: {position: 'bottom'}
                };

                try {
                    new ApexCharts(document.querySelector('#profit-chart'), optionsProfit).render();
                } catch (e) {
                    console.error('Error rendering profit-chart:', e);
                    document.querySelector('#profit-chart').innerHTML = '<div class="text-center py-5"><h5 class="text-muted">Lỗi khi vẽ biểu đồ</h5></div>';
                }
            });
        </script>
    </body>
</html>
