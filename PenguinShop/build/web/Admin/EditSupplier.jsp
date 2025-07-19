<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa nhà cung cấp - PenguinShop Admin</title>
        
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
            }
            
            .card-header {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
                border-radius: 8px 8px 0 0 !important;
                padding: 15px 20px;
            }
            
            .card-header h5 {
                margin: 0;
                font-weight: 600;
            }
            
            .form-label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
            }
            
            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 10px 15px;
                font-size: 14px;
                transition: all 0.3s ease;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: #f39c12;
                box-shadow: 0 0 0 0.2rem rgba(243, 156, 18, 0.25);
            }
            
            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                border: none;
                border-radius: 6px;
                padding: 10px 20px;
                font-weight: 500;
                font-size: 14px;
                color: white;
            }
            
            .btn-warning:hover {
                background: linear-gradient(135deg, #e67e22 0%, #d68910 100%);
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                color: white;
            }
            
            .btn-secondary {
                background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
                border: none;
                border-radius: 6px;
                padding: 10px 20px;
                font-weight: 500;
                font-size: 14px;
            }
            
            .btn-secondary:hover {
                background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }
            
            .btn-danger {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
                font-size: 14px;
            }
            
            .alert {
                border: none;
                border-radius: 8px;
                padding: 15px 20px;
            }
            
            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
            }
            
            .required {
                color: #e74c3c;
            }
            
            .form-floating > .form-control {
                height: calc(3.5rem + 2px);
                padding: 1rem 0.75rem;
            }
            
            .form-floating > label {
                padding: 1rem 0.75rem;
            }
            
            .input-group-text {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
                border: none;
            }
            
            .help-text {
                font-size: 12px;
                color: #6c757d;
                margin-top: 4px;
            }
            
            .info-card {
                background: linear-gradient(135deg, #e8f4fd 0%, #d1ecf1 100%);
                border: 1px solid #bee5eb;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 20px;
            }
            
            .info-card .info-item {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
            }
            
            .info-card .info-item:last-child {
                margin-bottom: 0;
            }
            
            .info-card .info-label {
                font-weight: 600;
                color: #0c5460;
                min-width: 120px;
            }
            
            .info-card .info-value {
                color: #155724;
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
                        <h1><i class="fas fa-edit me-2"></i>Chỉnh sửa nhà cung cấp</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="TrangChu.jsp">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="supplier">Nhà cung cấp</a></li>
                                <li class="breadcrumb-item"><a href="supplier?action=view&id=${supplier.supplierID}">Chi tiết</a></li>
                                <li class="breadcrumb-item active">Chỉnh sửa</li>
                            </ol>
                        </nav>
                    </div>
                    <div>
                        <a href="supplier?action=view&id=${supplier.supplierID}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                    </div>
                </div>
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-building me-2"></i>Thông tin nhà cung cấp</h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="supplier" novalidate>
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="supplierID" value="${supplier.supplierID}">
                                
                                <div class="row">
                                    <!-- Supplier Name -->
                                    <div class="col-md-6 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="supplierName" name="supplierName" 
                                                   value="${supplier.supplierName}" placeholder="Tên nhà cung cấp" required>
                                            <label for="supplierName">
                                                Tên nhà cung cấp <span class="required">*</span>
                                            </label>
                                        </div>
                                        <div class="help-text">Tên công ty hoặc cơ sở kinh doanh</div>
                                    </div>
                                    
                                    <!-- Contact Name -->
                                    <div class="col-md-6 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="contactName" name="contactName" 
                                                   value="${supplier.contactName}" placeholder="Tên người liên hệ">
                                            <label for="contactName">Tên người liên hệ</label>
                                        </div>
                                        <div class="help-text">Họ tên người phụ trách</div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <!-- Phone -->
                                    <div class="col-md-6 mb-3">
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                            <div class="form-floating">
                                                <input type="tel" class="form-control" id="phone" name="phone" 
                                                       value="${supplier.phone}" placeholder="Số điện thoại">
                                                <label for="phone">Số điện thoại</label>
                                            </div>
                                        </div>
                                        <div class="help-text">VD: 0123456789 hoặc (024) 3456 7890</div>
                                    </div>
                                    
                                    <!-- Email -->
                                    <div class="col-md-6 mb-3">
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                            <div class="form-floating">
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       value="${supplier.email}" placeholder="Email">
                                                <label for="email">Địa chỉ email</label>
                                            </div>
                                        </div>
                                        <div class="help-text">Email liên hệ chính thức</div>
                                    </div>
                                </div>
                                
                                <!-- Address -->
                                <div class="mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </span>
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="address" name="address" 
                                                   value="${supplier.address}" placeholder="Địa chỉ">
                                            <label for="address">Địa chỉ</label>
                                        </div>
                                    </div>
                                    <div class="help-text">Địa chỉ trụ sở chính hoặc kho hàng</div>
                                </div>
                                
                                <!-- Note -->
                                <div class="mb-4">
                                    <div class="form-floating">
                                        <textarea class="form-control" id="note" name="note" 
                                                  placeholder="Ghi chú" style="height: 100px">${supplier.note}</textarea>
                                        <label for="note">Ghi chú</label>
                                    </div>
                                    <div class="help-text">Thông tin bổ sung về nhà cung cấp</div>
                                </div>
                                
                                <!-- Form Actions -->
                                <div class="d-flex justify-content-between">
                                    <button type="button" class="btn btn-danger" 
                                            onclick="confirmDelete(${supplier.supplierID}, '${supplier.supplierName}')">
                                        <i class="fas fa-trash me-2"></i>Xóa nhà cung cấp
                                    </button>
                                    
                                    <div class="d-flex gap-3">
                                        <a href="supplier?action=view&id=${supplier.supplierID}" class="btn btn-secondary">
                                            <i class="fas fa-times me-2"></i>Hủy
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-save me-2"></i>Cập nhật
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column - Info -->
                <div class="col-lg-4">
                    <!-- Current Info -->
                    <div class="info-card">
                        <h6 class="mb-3">
                            <i class="fas fa-info-circle me-2"></i>Thông tin hiện tại
                        </h6>
                        
                        <div class="info-item">
                            <span class="info-label">Mã NCC:</span>
                            <span class="info-value">#${supplier.supplierID}</span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Tạo lúc:</span>
                            <span class="info-value">
                                <c:if test="${not empty supplier.createdAt}">
                                    <fmt:formatDate value="${supplier.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </c:if>
                            </span>
                        </div>
                        
                        <div class="info-item">
                            <span class="info-label">Cập nhật:</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${not empty supplier.updatedAt}">
                                        <fmt:formatDate value="${supplier.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </c:when>
                                    <c:otherwise>
                                        Chưa có
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">
                                <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="importorder?action=create&supplierID=${supplier.supplierID}" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>Tạo đơn nhập
                                </a>
                                <a href="supplier?action=view&id=${supplier.supplierID}" class="btn btn-info btn-sm">
                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                </a>
                                <c:if test="${not empty supplier.email}">
                                    <a href="mailto:${supplier.email}" class="btn btn-success btn-sm">
                                        <i class="fas fa-envelope me-2"></i>Gửi email
                                    </a>
                                </c:if>
                                <c:if test="${not empty supplier.phone}">
                                    <a href="tel:${supplier.phone}" class="btn btn-warning btn-sm">
                                        <i class="fas fa-phone me-2"></i>Gọi điện
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Warning Card -->
                    <div class="card border-warning">
                        <div class="card-body">
                            <h6 class="card-title text-warning">
                                <i class="fas fa-exclamation-triangle me-2"></i>Chú ý
                            </h6>
                            <ul class="mb-0 small">
                                <li>Thay đổi thông tin nhà cung cấp có thể ảnh hưởng đến các đơn nhập hàng</li>
                                <li>Kiểm tra kỹ thông tin liên hệ trước khi lưu</li>
                                <li>Việc xóa nhà cung cấp sẽ ảnh hưởng đến dữ liệu liên quan</li>
                            </ul>
                        </div>
                    </div>
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
            
            // Form validation
            (function() {
                'use strict';
                
                const form = document.querySelector('form[novalidate]');
                
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    
                    form.classList.add('was-validated');
                }, false);
                
                // Real-time validation for required fields
                const requiredFields = form.querySelectorAll('[required]');
                requiredFields.forEach(function(field) {
                    field.addEventListener('blur', function() {
                        if (field.value.trim() === '') {
                            field.setCustomValidity('Trường này là bắt buộc');
                        } else {
                            field.setCustomValidity('');
                        }
                    });
                    
                    field.addEventListener('input', function() {
                        if (field.value.trim() !== '') {
                            field.setCustomValidity('');
                        }
                    });
                });
                
                // Email validation
                const emailField = document.getElementById('email');
                if (emailField) {
                    emailField.addEventListener('blur', function() {
                        if (emailField.value !== '' && !emailField.validity.valid) {
                            emailField.setCustomValidity('Vui lòng nhập địa chỉ email hợp lệ');
                        } else {
                            emailField.setCustomValidity('');
                        }
                    });
                }
                
                // Phone validation (basic)
                const phoneField = document.getElementById('phone');
                if (phoneField) {
                    phoneField.addEventListener('blur', function() {
                        const phonePattern = /^[\d\s\(\)\-\+\.]{10,15}$/;
                        if (phoneField.value !== '' && !phonePattern.test(phoneField.value)) {
                            phoneField.setCustomValidity('Vui lòng nhập số điện thoại hợp lệ');
                        } else {
                            phoneField.setCustomValidity('');
                        }
                    });
                }
            })();
            
            // Auto hide alerts
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    setTimeout(function() {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000);
                });
            });
        </script>
    </body>
</html>
