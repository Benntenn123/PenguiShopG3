<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .info-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }
            .info-card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 15px 20px;
                border-radius: 10px 10px 0 0;
                font-weight: 600;
            }
            .info-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #f0f0f0;
            }
            .info-item:last-child {
                border-bottom: none;
            }
            .info-label {
                font-weight: 600;
                color: #6c757d;
            }
            .info-value {
                font-weight: 500;
                color: #2c3e50;
            }
            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #f0f0f0;
            }
            .variant-badge {
                background: #e3f2fd;
                color: #1976d2;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.75rem;
                margin: 2px;
                display: inline-block;
            }
            .total-amount {
                background: linear-gradient(135deg, #4caf50 0%, #2e7d32 100%);
                color: white;
                padding: 15px 20px;
                border-radius: 10px;
                text-align: center;
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 20px;
            }
            .btn-detail {
                background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
                border: none;
                color: white;
                padding: 8px 16px;
                border-radius: 6px;
                font-size: 0.85rem;
                transition: all 0.3s ease;
            }
            .btn-detail:hover {
                background: linear-gradient(135deg, #1976d2 0%, #1565c0 100%);
                transform: translateY(-1px);
                color: white;
            }
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
            }
            .status-completed {
                background: #e8f5e8;
                color: #2e7d32;
            }
            .status-pending {
                background: #fff3e0;
                color: #f57c00;
            }
            .table-hover tbody tr:hover {
                background-color: #f8f9fa;
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
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết đơn nhập hàng #${importOrder.importOrderID}</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <li class="breadcrumb-item"><a href="ImportOrderList">Đơn nhập hàng</a></li>
                                            <li class="breadcrumb-item active">Chi tiết</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Message Alert -->
                        <jsp:include page="Common/Message.jsp"/>

                        <!-- Error Alert -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="mdi mdi-alert-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="row">
                            <!-- Order Information -->
                            <div class="col-lg-4">
                                <div class="info-card">
                                    <div class="info-card-header">
                                        <i class="mdi mdi-package-variant me-2"></i>Thông tin đơn nhập
                                    </div>
                                    <div style="padding: 10px" class="card-body">
                                        <div class="info-item">
                                            <span class="info-label">Mã đơn:</span>
                                            <span class="info-value">#${importOrder.importOrderID}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Nhà cung cấp:</span>
                                            <span class="info-value">
                                                <a href="SupplierDetails?id=${importOrder.supplierID}" class="text-primary">
                                                    ${importOrder.supplierName}
                                                </a>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Ngày nhập:</span>
                                            <span class="info-value">
                                                <fmt:formatDate value="${importOrder.importDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Trạng thái:</span>
                                            <span class="status-badge status-completed">Hoàn thành</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Ghi chú:</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${not empty importOrder.note}">
                                                        ${importOrder.note}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Total Amount -->
                                <div class="total-amount">
                                    <div>Tổng tiền nhập</div>
                                    <div style="font-size: 1.5rem; margin-top: 5px;">
                                        <fmt:formatNumber value="${importOrder.totalImportAmount}" 
                                                        type="currency" currencyCode="VND" 
                                                        pattern="#,##0 ₫"/>
                                    </div>
                                </div>

                                <!-- Quick Actions -->
                                <div class="card">
                                    <div class="card-header">
                                        <h6 class="mb-0">
                                            <i class="mdi mdi-flash me-2"></i>Thao tác nhanh
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-grid gap-2">
                                            <a href="supplier-details?id=${importOrder.supplierID}" class="btn btn-outline-primary btn-sm">
                                                <i class="mdi mdi-office-building me-2"></i>Xem nhà cung cấp
                                            </a>
                                            <a href="ImportOrderList?supplierId=${importOrder.supplierID}" class="btn btn-outline-info btn-sm">
                                                <i class="mdi mdi-history me-2"></i>Lịch sử nhập hàng
                                            </a>
                                            <a href="ImportOrderList" class="btn btn-outline-secondary btn-sm">
                                                <i class="mdi mdi-arrow-left me-2"></i>Quay lại danh sách
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Details -->
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h5 class="mb-0">
                                                <i class="mdi mdi-format-list-bulleted me-2"></i>Danh sách sản phẩm
                                            </h5>
                                            <span class="badge bg-primary">${fn:length(orderDetails)} sản phẩm</span>
                                        </div>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:choose>
                                            <c:when test="${empty orderDetails}">
                                                <div class="text-center py-4">
                                                    <i class="mdi mdi-package-variant-closed text-muted" style="font-size: 48px;"></i>
                                                    <p class="text-muted mt-3">Không có sản phẩm nào trong đơn nhập này</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th width="10%">Hình ảnh</th>
                                                                <th width="25%">Tên sản phẩm</th>
                                                                <th width="20%">Phân loại</th>
                                                                <th width="10%">Số lượng</th>
                                                                <th width="15%">Đơn giá</th>
                                                                <th width="15%">Thành tiền</th>
                                                                <th width="5%">Chi tiết</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="detail" items="${orderDetails}">
                                                                <tr>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${not empty detail.productImage}">
                                                                                <img src="${detail.productImage}" 
                                                                                     alt="${detail.productName}" 
                                                                                     class="product-image">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                                                    <i class="mdi mdi-image text-muted"></i>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="fw-bold">${detail.productName}</div>
                                                                        <c:if test="${not empty detail.productDescription}">
                                                                            <small class="text-muted">${detail.productDescription}</small>
                                                                        </c:if>
                                                                    </td>
                                                                    <td>
                                                                        <c:if test="${not empty detail.colorName}">
                                                                            <span class="variant-badge">
                                                                                <i class="mdi mdi-palette me-1"></i>${detail.colorName}
                                                                            </span>
                                                                        </c:if>
                                                                        <c:if test="${not empty detail.sizeName}">
                                                                            <span class="variant-badge">
                                                                                <i class="mdi mdi-resize me-1"></i>${detail.sizeName}
                                                                            </span>
                                                                        </c:if>
                                                                    </td>
                                                                    <td>
                                                                        <span class="fw-bold text-primary">${detail.quantity}</span>
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${detail.unitPrice}" 
                                                                                        type="currency" currencyCode="VND" 
                                                                                        pattern="#,##0 ₫"/>
                                                                    </td>
                                                                    <td>
                                                                        <span class="fw-bold text-success">
                                                                            <fmt:formatNumber value="${detail.quantity * detail.unitPrice}" 
                                                                                            type="currency" currencyCode="VND" 
                                                                                            pattern="#,##0 ₫"/>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <a href="variant_details?variantID=${detail.productID}" 
                                                                           class="btn btn-detail btn-sm" 
                                                                           title="Xem chi tiết sản phẩm"
                                                                           target="_blank">
                                                                            <i class="mdi mdi-eye"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                        <tfoot class="table-light">
                                                            <tr>
                                                                <th colspan="3">Tổng cộng:</th>
                                                                <th class="text-primary">
                                                                    <c:set var="totalQuantity" value="0"/>
                                                                    <c:forEach var="detail" items="${orderDetails}">
                                                                        <c:set var="totalQuantity" value="${totalQuantity + detail.quantity}"/>
                                                                    </c:forEach>
                                                                    ${totalQuantity}
                                                                </th>
                                                                <th colspan="2" class="text-success fw-bold fs-5">
                                                                    <fmt:formatNumber value="${importOrder.totalImportAmount}" 
                                                                                    type="currency" currencyCode="VND" 
                                                                                    pattern="#,##0 ₫"/>
                                                                </th>
                                                                <th></th>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
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
        
        <script>
            // Auto hide alerts
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    setTimeout(function() {
                        if (alert && alert.classList.contains('show')) {
                            const bsAlert = new bootstrap.Alert(alert);
                            bsAlert.close();
                        }
                    }, 5000);
                });
            });
        </script>
    </body>
</html>
