<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .form-container {
                max-width: 800px;
                margin: 0 auto;
            }
            .required {
                color: red;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .form-label {
                font-weight: 600;
                margin-bottom: 0.5rem;
            }
            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }
            .btn-save {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 6px;
                font-weight: 500;
            }
            .btn-save:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                transform: translateY(-1px);
                color: white;
            }
            .btn-cancel {
                background: #6c757d;
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 6px;
                font-weight: 500;
            }
            .btn-cancel:hover {
                background: #545b62;
                color: white;
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
                                    <h4 class="mb-sm-0 font-size-18">Thêm nhà cung cấp mới</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <li class="breadcrumb-item"><a href="SupplierList">Nhà cung cấp</a></li>
                                            <li class="breadcrumb-item active">Thêm mới</li>
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

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="mdi mdi-office-building me-2"></i>Thông tin nhà cung cấp</h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="AddSupplier" novalidate id="supplierForm">
                                <input type="hidden" name="action" value="add">
                                
                                <div class="row">
                                    <!-- Supplier Name -->
                                    <div class="col-md-6 mb-3">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="supplierName" name="supplierName" 
                                                   value="${param.supplierName}" placeholder="Tên nhà cung cấp" required>
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
                                                   value="${param.contactName}" placeholder="Tên người liên hệ">
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
                                                       value="${param.phone}" placeholder="Số điện thoại">
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
                                                       value="${param.email}" placeholder="Email">
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
                                                   value="${param.address}" placeholder="Địa chỉ">
                                            <label for="address">Địa chỉ</label>
                                        </div>
                                    </div>
                                    <div class="help-text">Địa chỉ trụ sở chính hoặc kho hàng</div>
                                </div>
                                
                                <!-- Note -->
                                <div class="mb-4">
                                    <div class="form-floating">
                                        <textarea class="form-control" id="note" name="note" 
                                                  placeholder="Ghi chú" style="height: 100px">${param.note}</textarea>
                                        <label for="note">Ghi chú</label>
                                    </div>
                                    <div class="help-text">Thông tin bổ sung về nhà cung cấp</div>
                                </div>
                                
                                <!-- Form Actions -->
                                <div class="d-flex justify-content-end gap-3">
                                    <a href="supplier" class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Hủy
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Lưu nhà cung cấp
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Info Card -->
                    <div class="card mt-4">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-info-circle text-info me-2"></i>Lưu ý khi thêm nhà cung cấp
                            </h6>
                            <ul class="mb-0">
                                <li><strong>Tên nhà cung cấp</strong> là thông tin bắt buộc</li>
                                <li>Nhập đầy đủ thông tin liên hệ để dễ dàng quản lý</li>
                                <li>Email và số điện thoại sẽ được sử dụng cho việc liên hệ tự động</li>
                                <li>Sau khi thêm thành công, bạn có thể tạo đơn nhập hàng từ nhà cung cấp này</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Common/RightSideBar.jsp"/>
</div>
<jsp:include page="Common/Message.jsp"/>
<jsp:include page="Common/Js.jsp"/>

<script>
    // Form validation
    (function() {
        'use strict';
        
        const form = document.querySelector('form[novalidate]');
        if (form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        }
        
        // Real-time validation for required fields
        const requiredFields = document.querySelectorAll('[required]');
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
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (emailField.value !== '' && !emailPattern.test(emailField.value)) {
                    emailField.setCustomValidity('Vui lòng nhập địa chỉ email hợp lệ');
                } else {
                    emailField.setCustomValidity('');
                }
            });
            
            emailField.addEventListener('input', function() {
                // Clear error when user starts typing
                if (emailField.value === '') {
                    emailField.setCustomValidity('');
                }
            });
        }
        
        // Phone validation
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
            
            phoneField.addEventListener('input', function() {
                // Clear error when user starts typing
                if (phoneField.value === '') {
                    phoneField.setCustomValidity('');
                }
            });
        }
    })();
</script>
</body>
</html>
