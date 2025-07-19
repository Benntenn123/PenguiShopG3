<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết nhà cung cấp - PenguinShop Admin</title>
        
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .main-content {
                margin-left: 250px;
                padding: 20px;
                min-height: 100vh;
            }
            
            .content-header {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }
            
            .content-header h1 {
                color: #2c3e50;
                margin: 0;
                font-size: 24px;
                font-weight: 600;
            }
            
            .breadcrumb {
                background: none;
                padding: 0;
                margin: 10px 0 0 0;
            }
            
            .card {
                border: none;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                border-radius: 8px;
                margin-bottom: 20px;
            }
            
            .card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 8px 8px 0 0 !important;
                padding: 15px 20px;
            }
            
            .card-header h5 {
                margin: 0;
                font-weight: 600;
            }
            
            .info-item {
                display: flex;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #e9ecef;
            }
            
            .info-item:last-child {
                border-bottom: none;
            }
            
            .info-label {
                font-weight: 600;
                color: #495057;
                width: 150px;
                flex-shrink: 0;
            }
            
            .info-value {
                color: #212529;
                flex-grow: 1;
            }
            
            .info-icon {
                width: 20px;
                margin-right: 10px;
                color: #667eea;
                flex-shrink: 0;
            }
            
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
            }
            
            .btn-primary:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }
            
            .btn-secondary {
                background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
            }
            
            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
            }
            
            .btn-danger {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
            }
            
            .stats-card {
                background: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                text-align: center;
                height: 100%;
            }
            
            .stats-number {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            
            .stats-label {
                color: #6c757d;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .stats-success {
                color: #28a745;
            }
            
            .stats-info {
                color: #17a2b8;
            }
            
            .stats-warning {
                color: #ffc107;
            }
            
            .alert {
                border: none;
                border-radius: 8px;
                padding: 15px 20px;
            }
            
            .table {
                margin-bottom: 0;
            }
            
            .table th {
                background-color: #f8f9fa;
                color: #2c3e50;
                font-weight: 600;
                border-top: none;
                padding: 12px;
                font-size: 14px;
            }
            
            .table td {
                padding: 12px;
                vertical-align: middle;
                border-top: 1px solid #dee2e6;
                font-size: 14px;
            }
            
            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: #6c757d;
            }
            
            .empty-state i {
                font-size: 48px;
                margin-bottom: 15px;
                color: #dee2e6;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <jsp:include page="Common/Sidebar.jsp"/>
        
        <div class="main-content">
            <!-- Content Header -->
            <div class="content-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1><i class="fas fa-truck me-2"></i>Chi tiết nhà cung cấp</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="TrangChu.jsp">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="supplier">Nhà cung cấp</a></li>
                                <li class="breadcrumb-item active">${supplier.supplierName}</li>
                            </ol>
                        </nav>
                    </div>
                    <div>
                        <a href="supplier" class="btn btn-secondary me-2">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                        <a href="supplier?action=edit&id=${supplier.supplierID}" class="btn btn-warning me-2">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                        </a>
                        <button type="button" class="btn btn-danger" 
                                onclick="confirmDelete(${supplier.supplierID}, '${supplier.supplierName}')">
                            <i class="fas fa-trash me-2"></i>Xóa
                        </button>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Left Column - Supplier Info -->
                <div class="col-lg-8">
                    <!-- Basic Information -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h5>
                        </div>
                        <div class="card-body">
                            <div class="info-item">
                                <i class="fas fa-building info-icon"></i>
                                <span class="info-label">Tên nhà cung cấp:</span>
                                <span class="info-value"><strong>${supplier.supplierName}</strong></span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-user info-icon"></i>
                                <span class="info-label">Người liên hệ:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty supplier.contactName}">
                                            ${supplier.contactName}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có thông tin</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-phone info-icon"></i>
                                <span class="info-label">Số điện thoại:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty supplier.phone}">
                                            <a href="tel:${supplier.phone}" class="text-decoration-none">${supplier.phone}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có thông tin</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-envelope info-icon"></i>
                                <span class="info-label">Email:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty supplier.email}">
                                            <a href="mailto:${supplier.email}" class="text-decoration-none">${supplier.email}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có thông tin</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-map-marker-alt info-icon"></i>
                                <span class="info-label">Địa chỉ:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty supplier.address}">
                                            ${supplier.address}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có thông tin</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-calendar-plus info-icon"></i>
                                <span class="info-label">Ngày tạo:</span>
                                <span class="info-value">
                                    <c:if test="${not empty supplier.createdAt}">
                                        <fmt:formatDate value="${supplier.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </c:if>
                                </span>
                            </div>
                            
                            <div class="info-item">
                                <i class="fas fa-calendar-edit info-icon"></i>
                                <span class="info-label">Cập nhật cuối:</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty supplier.updatedAt}">
                                            <fmt:formatDate value="${supplier.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <c:if test="${not empty supplier.note}">
                                <div class="info-item">
                                    <i class="fas fa-sticky-note info-icon"></i>
                                    <span class="info-label">Ghi chú:</span>
                                    <span class="info-value">${supplier.note}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Import Orders History -->
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5><i class="fas fa-history me-2"></i>Lịch sử nhập hàng</h5>
                                <a href="importorder?supplierID=${supplier.supplierID}" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i>Tạo đơn nhập
                                </a>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty importOrders}">
                                    <div class="empty-state">
                                        <i class="fas fa-file-invoice"></i>
                                        <h6>Chưa có đơn nhập hàng nào</h6>
                                        <p class="text-muted">Nhà cung cấp này chưa có đơn nhập hàng nào.</p>
                                        <a href="importorder?action=create&supplierID=${supplier.supplierID}" class="btn btn-primary">
                                            <i class="fas fa-plus me-2"></i>Tạo đơn nhập đầu tiên
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã đơn</th>
                                                    <th>Ngày nhập</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Ghi chú</th>
                                                    <th class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${importOrders}">
                                                    <tr>
                                                        <td><strong>#${order.importOrderID}</strong></td>
                                                        <td>
                                                            <fmt:formatDate value="${order.importDate}" pattern="dd/MM/yyyy"/>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty order.totalImportAmount}">
                                                                <fmt:formatNumber value="${order.totalImportAmount}" 
                                                                                type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty order.note}">
                                                                    ${order.note}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Không có</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="importorder?action=view&id=${order.importOrderID}" 
                                                               class="btn btn-info btn-sm">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Statistics -->
                <div class="col-lg-4">
                    <!-- Quick Stats -->
                    <div class="stats-card mb-4">
                        <div class="stats-number stats-success">5</div>
                        <div class="stats-label">Đơn nhập trong tháng</div>
                    </div>
                    
                    <div class="stats-card mb-4">
                        <div class="stats-number stats-info">₫15,500,000</div>
                        <div class="stats-label">Tổng giá trị nhập</div>
                    </div>
                    
                    <div class="stats-card mb-4">
                        <div class="stats-number stats-warning">3 ngày</div>
                        <div class="stats-label">Lần nhập gần nhất</div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-bolt me-2"></i>Thao tác nhanh</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="importorder?action=create&supplierID=${supplier.supplierID}" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Tạo đơn nhập mới
                                </a>
                                <a href="supplier?action=edit&id=${supplier.supplierID}" class="btn btn-warning">
                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa thông tin
                                </a>
                                <c:if test="${not empty supplier.email}">
                                    <a href="mailto:${supplier.email}" class="btn btn-info">
                                        <i class="fas fa-envelope me-2"></i>Gửi email
                                    </a>
                                </c:if>
                                <c:if test="${not empty supplier.phone}">
                                    <a href="tel:${supplier.phone}" class="btn btn-success">
                                        <i class="fas fa-phone me-2"></i>Gọi điện
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Card -->
                    <c:if test="${not empty supplier.contactName || not empty supplier.phone || not empty supplier.email}">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-address-card me-2"></i>Thông tin liên hệ</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty supplier.contactName}">
                                    <p class="mb-2">
                                        <i class="fas fa-user me-2 text-muted"></i>
                                        <strong>${supplier.contactName}</strong>
                                    </p>
                                </c:if>
                                <c:if test="${not empty supplier.phone}">
                                    <p class="mb-2">
                                        <i class="fas fa-phone me-2 text-muted"></i>
                                        <a href="tel:${supplier.phone}" class="text-decoration-none">${supplier.phone}</a>
                                    </p>
                                </c:if>
                                <c:if test="${not empty supplier.email}">
                                    <p class="mb-0">
                                        <i class="fas fa-envelope me-2 text-muted"></i>
                                        <a href="mailto:${supplier.email}" class="text-decoration-none">${supplier.email}</a>
                                    </p>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa nhà cung cấp <strong id="supplierName"></strong>?</p>
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Chú ý:</strong> Việc xóa nhà cung cấp sẽ ảnh hưởng đến các đơn nhập hàng liên quan.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <form method="post" action="supplier" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="supplierID" id="deleteSupplierID">
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-2"></i>Xóa
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            function confirmDelete(supplierID, supplierName) {
                document.getElementById('deleteSupplierID').value = supplierID;
                document.getElementById('supplierName').textContent = supplierName;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            }
        </script>
    </body>
</html>
