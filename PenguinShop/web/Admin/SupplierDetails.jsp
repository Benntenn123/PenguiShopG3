<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .supplier-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 25px;
            }
            
            .info-card {
                transition: transform 0.2s ease-in-out;
            }
            
            .info-card:hover {
                transform: translateY(-2px);
            }
            
            .stats-card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            
            .stats-card:hover {
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
                transform: translateY(-2px);
            }
            
            .import-order-item {
                border-left: 4px solid #667eea;
                padding: 15px;
                margin-bottom: 15px;
                background: #f8f9fa;
                border-radius: 0 8px 8px 0;
                transition: all 0.3s ease;
            }
            
            .import-order-item:hover {
                background: #e9ecef;
                border-left-color: #5a6fd8;
            }
            
            .amount-display {
                font-size: 1.2rem;
                font-weight: bold;
                color: #28a745;
            }
            
            .supplier-info-table td {
                padding: 12px 15px;
                border-bottom: 1px solid #dee2e6;
            }
            
            .supplier-info-table td:first-child {
                font-weight: 600;
                background-color: #f8f9fa;
                width: 180px;
            }
        </style>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <!-- Breadcrumb -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết nhà cung cấp</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="TrangChu.jsp">Trang chủ</a></li>
                                            <li class="breadcrumb-item"><a href="supplier">Nhà cung cấp</a></li>
                                            <li class="breadcrumb-item active">Chi tiết</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Message Alert -->
                        <jsp:include page="Common/Message.jsp"/>

                        <!-- Supplier Header -->
                        <div class="supplier-header">
                            <div class="row align-items-center">
                                <div class="col-lg-8">
                                    <h2 class="mb-2">
                                        <i class="mdi mdi-office-building me-3"></i>
                                        ${supplier.supplierName}
                                    </h2>
                                    <p class="mb-0 opacity-75">
                                        <c:if test="${not empty supplier.contactName}">
                                            <i class="mdi mdi-account-circle me-2"></i>Người liên hệ: ${supplier.contactName}
                                        </c:if>
                                    </p>
                                </div>
                                <div class="col-lg-4 text-lg-end text-start mt-3 mt-lg-0">
                                    <a href="EditSupplier?id=${supplier.supplierID}" class="btn btn-light btn-lg me-2">
                                        <i class="mdi mdi-pencil me-2"></i>Chỉnh sửa
                                    </a>
                                    <a href="supplier" class="btn btn-outline-light btn-lg">
                                        <i class="mdi mdi-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Statistics Cards -->
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card stats-card text-center">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm flex-shrink-0 me-3">
                                                <div class="avatar-title bg-primary-subtle text-primary rounded-circle fs-3">
                                                    <i class="mdi mdi-package-variant"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <p class="text-muted mb-2">Tổng số đơn nhập</p>
                                                <h4 class="mb-0">${totalImportOrders}</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card stats-card text-center">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm flex-shrink-0 me-3">
                                                <div class="avatar-title bg-success-subtle text-success rounded-circle fs-3">
                                                    <i class="mdi mdi-cash"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <p class="text-muted mb-2">Tổng giá trị nhập</p>
                                                <h4 class="mb-0">
                                                    <fmt:formatNumber value="${totalImportValue}" type="currency" 
                                                                    currencyCode="VND" pattern="#,##0 ₫"/>
                                                </h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card stats-card text-center">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm flex-shrink-0 me-3">
                                                <div class="avatar-title bg-info-subtle text-info rounded-circle fs-3">
                                                    <i class="mdi mdi-calendar-check"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <p class="text-muted mb-2">Đơn nhập gần nhất</p>
                                                <h5 class="mb-0">
                                                    <c:choose>
                                                        <c:when test="${not empty recentImportOrders}">
                                                            <fmt:formatDate value="${recentImportOrders[0].importDate}" 
                                                                          pattern="dd/MM/yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa có</c:otherwise>
                                                    </c:choose>
                                                </h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Supplier Information -->
                            <div class="col-lg-6">
                                <div class="card info-card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">
                                            <i class="mdi mdi-information me-2"></i>Thông tin nhà cung cấp
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-borderless supplier-info-table mb-0">
                                                <tbody>
                                                    <tr>
                                                        <td><i class="mdi mdi-office-building text-primary me-2"></i>Tên công ty</td>
                                                        <td>${supplier.supplierName}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><i class="mdi mdi-account-circle text-primary me-2"></i>Người liên hệ</td>
                                                        <td>${not empty supplier.contactName ? supplier.contactName : 'Chưa cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><i class="mdi mdi-phone text-primary me-2"></i>Số điện thoại</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty supplier.phone}">
                                                                    <a href="tel:${supplier.phone}" class="text-decoration-none">
                                                                        ${supplier.phone}
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>Chưa cập nhật</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><i class="mdi mdi-email text-primary me-2"></i>Email</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty supplier.email}">
                                                                    <a href="mailto:${supplier.email}" class="text-decoration-none">
                                                                        ${supplier.email}
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>Chưa cập nhật</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><i class="mdi mdi-map-marker text-primary me-2"></i>Địa chỉ</td>
                                                        <td>${not empty supplier.address ? supplier.address : 'Chưa cập nhật'}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><i class="mdi mdi-note-text text-primary me-2"></i>Ghi chú</td>
                                                        <td>${not empty supplier.note ? supplier.note : 'Không có ghi chú'}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Recent Import Orders -->
                            <div class="col-lg-6">
                                <div class="card info-card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5 class="card-title mb-0">
                                            <i class="mdi mdi-package-variant-closed me-2"></i>5 lần nhập hàng gần nhất
                                        </h5>
                                        <c:if test="${totalImportOrders > 5}">
                                            <a href="#" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                                        </c:if>
                                    </div>
                                    <div class="card-body">
                                        <c:choose>
                                            <c:when test="${not empty recentImportOrders}">
                                                <c:forEach var="order" items="${recentImportOrders}">
                                                    <div class="import-order-item">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1">
                                                                    <i class="mdi mdi-receipt me-2"></i>
                                                                    Đơn nhập #${order.importOrderID}
                                                                </h6>
                                                                <p class="mb-1 text-muted">
                                                                    <i class="mdi mdi-calendar-clock me-1"></i>
                                                                    <fmt:formatDate value="${order.importDate}" 
                                                                                  pattern="dd/MM/yyyy HH:mm"/>
                                                                </p>
                                                                <c:if test="${not empty order.note}">
                                                                    <p class="mb-0 text-muted small">
                                                                        <i class="mdi mdi-note-text me-1"></i>
                                                                        ${order.note}
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                            <div class="text-end">
                                                                <span class="amount-display">
                                                                    <fmt:formatNumber value="${order.totalImportAmount}" 
                                                                                    type="currency" currencyCode="VND" 
                                                                                    pattern="#,##0 ₫"/>
                                                                </span>
                                                                <br>
                                                                <a href="import-order-details?id=${order.importOrderID}" 
                                                                   class="btn btn-sm btn-outline-primary mt-1">
                                                                    <i class="mdi mdi-eye"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center py-4">
                                                    <i class="mdi mdi-package-variant-closed-remove text-muted" style="font-size: 48px;"></i>
                                                    <p class="text-muted mt-3 mb-0">Chưa có đơn nhập hàng nào</p>
                                                    <a href="import-order-add?supplierId=${supplier.supplierID}" 
                                                       class="btn btn-primary btn-sm mt-2">
                                                        <i class="mdi mdi-plus me-2"></i>Tạo đơn nhập hàng
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
        </div>

        <jsp:include page="Common/Js.jsp"/>
    </body>
</html>
