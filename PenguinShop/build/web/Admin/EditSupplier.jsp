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
                background-color: #5156be;
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 6px;
                font-weight: 500;
            }
            .btn-save:hover {
                background-color: #5156be;
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
                transform: translateY(-1px);
            }
            .card {
                border: none;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                border-radius: 10px;
            }
            .card-header {
                color: black;
                border-radius: 10px 10px 0 0 !important;
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
                                    <h4 class="mb-sm-0 font-size-18">Chỉnh sửa nhà cung cấp</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <li class="breadcrumb-item"><a href="SupplierList">Nhà cung cấp</a></li>
                                            <li class="breadcrumb-item"><a href="supplier-details?id=${supplier.supplierID}">Chi tiết</a></li>
                                            <li class="breadcrumb-item active">Chỉnh sửa</li>
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

                        <div class="form-container">
                            <div class="card">
                                <div class="card-header">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm flex-shrink-0 me-3">
                                            <div class="avatar-title bg-white text-primary rounded-circle fs-3">
                                                <i class="mdi mdi-office-building"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h5 class="mb-1">Chỉnh sửa thông tin nhà cung cấp</h5>
                                            <p class="mb-0">Cập nhật thông tin liên hệ và chi tiết nhà cung cấp</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <form action="EditSupplier" method="post">
                                        <input type="hidden" name="supplierID" value="${supplier.supplierID}">
                                        
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-label">Tên nhà cung cấp <span class="required">*</span></label>
                                                    <input type="text" class="form-control" name="supplierName" 
                                                           value="${supplier.supplierName}" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-label">Tên người liên hệ</label>
                                                    <input type="text" class="form-control" name="contactName" 
                                                           value="${supplier.contactName}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-label">Số điện thoại</label>
                                                    <input type="tel" class="form-control" name="phoneNumber" 
                                                           value="${supplier.phone}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" class="form-control" name="email" 
                                                           value="${supplier.email}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="form-group">
                                                    <label class="form-label">Địa chỉ</label>
                                                    <textarea class="form-control" name="address" rows="3">${supplier.address}</textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12">
                                                <div class="form-group">
                                                    <label class="form-label">Ghi chú</label>
                                                    <textarea class="form-control" name="notes" rows="3">${supplier.note}</textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="text-end mt-4">
                                            <a href="SupplierDetails?id=${supplier.supplierID}" class="btn btn-cancel me-2">
                                                <i class="mdi mdi-close me-2"></i>Hủy
                                            </a>
                                            <button type="submit" class="btn btn-save">
                                                <i class="mdi mdi-check me-2"></i>Cập nhật
                                            </button>
                                        </div>
                                    </form>
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
            // Form validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const supplierName = document.querySelector('input[name="supplierName"]').value.trim();
                
                if (!supplierName) {
                    e.preventDefault();
                    alert('Vui lòng nhập tên nhà cung cấp!');
                    return;
                }
                
                // Show loading
                const submitBtn = document.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="mdi mdi-loading mdi-spin me-2"></i>Đang cập nhật...';
                submitBtn.disabled = true;
                
                // Restore button if form validation fails
                setTimeout(() => {
                    if (!this.checkValidity()) {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }
                }, 100);
            });

            // Phone number formatting
            document.querySelector('input[name="phoneNumber"]').addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 11) value = value.substr(0, 11);
                e.target.value = value;
            });
        </script>
    </body>
</html>
