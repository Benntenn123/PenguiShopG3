
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>Sửa Profile Sales</title>
        <style>
            .avatar-preview {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #ddd;
                margin-bottom: 10px;
            }
        </style>
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
                                    <h4 class="mb-sm-0 font-size-18">Sửa Profile Sales</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="sales_list">Quản lý Sales</a></li>
                                            <li class="breadcrumb-item active">Sửa Profile</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Form Edit Profile -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-4">Thông tin cá nhân</h5>
                                        <c:if test="${not empty sessionScope.error}">
                                            <div class="alert alert-danger">${sessionScope.error}</div>
                                            <c:remove var="error" scope="session"/>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.success}">
                                            <div class="alert alert-success">${sessionScope.success}</div>
                                            <c:remove var="success" scope="session"/>
                                        </c:if>
                                        <form id="editSalesForm" action="editSales" method="post" enctype="multipart/form-data">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="fullName" class="form-label">Họ tên <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName != null ? fullName : user.fullName}" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${email != null ? email : user.email}" readonly>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="phone" name="phone" value="${phone != null ? phone : user.phone}" required pattern="[0-9]{10,12}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="password" class="form-label">Mật khẩu mới (để trống nếu không đổi)</label>
                                                    <input type="password" class="form-control" id="password" name="password" minlength="6">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="birthday" class="form-label">Ngày sinh</label>
                                                    <input type="date" class="form-control" id="birthday" name="birthday" value="${birthday != null ? birthday : (user.birthday != null ? user.birthday.toString() : '')}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="image_user" class="form-label">Ảnh đại diện</label>
                                                    <div>
                                                        <c:if test="${not empty user.image_user}">
                                                            <img src="${cloudinaryService.getImageUrl(user.image_user)}" alt="Avatar" class="avatar-preview" id="currentAvatar"/>
                                                        </c:if>
                                                        <c:if test="${empty user.image_user}">
                                                            <img src="/assets/images/default-avatar.png" alt="Avatar" class="avatar-preview" id="currentAvatar"/>
                                                        </c:if>
                                                        <input type="file" class="form-control mt-2" id="image_user" name="image_user" accept="image/*">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status_account" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                                    <select class="form-select" id="status_account" name="status_account" required>
                                                        <option value="1" ${status_account != null ? (status_account == '1' ? 'selected' : '') : (user.status_account == 1 ? 'selected' : '')}>Hoạt động</option>
                                                        <option value="0" ${status_account != null ? (status_account == '0' ? 'selected' : '') : (user.status_account == 0 ? 'selected' : '')}>Không hoạt động</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <input type="hidden" name="roleID" value="${user.roleID}">
                                            <div class="mt-4">
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                <a href="sales_list" class="btn btn-secondary">Hủy</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Form -->

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            // Preview ảnh
            document.getElementById('image_user').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        document.getElementById('currentAvatar').src = event.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Client-side validation
            document.getElementById('editSalesForm').addEventListener('submit', function(e) {
                const phone = document.getElementById('phone').value;
                const password = document.getElementById('password').value;
                if (!/^[0-9]{10,12}$/.test(phone)) {
                    e.preventDefault();
                    alert('Số điện thoại phải chứa 10-12 chữ số!');
                }
                if (password && password.length < 6) {
                    e.preventDefault();
                    alert('Mật khẩu phải ít nhất 6 ký tự!');
                }
            });
        </script>
    </body>
</html>
