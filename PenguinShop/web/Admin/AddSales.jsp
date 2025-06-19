<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>Thêm Sales</title>
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
                                    <h4 class="mb-sm-0 font-size-18">Thêm Sales</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="sales_list">Quản lý Sales</a></li>
                                            <li class="breadcrumb-item active">Thêm Sales</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Form Add Sales -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-4">Thông tin Sales</h5>
                                        <c:if test="${not empty sessionScope.error}">
                                            <div class="alert alert-danger">${sessionScope.error}</div>
                                            <c:remove var="error" scope="session"/>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.success}">
                                            <div class="alert alert-success">${sessionScope.success}</div>
                                            <c:remove var="success" scope="session"/>
                                        </c:if>
                                        <form id="addSalesForm" action="addSales" method="post" enctype="multipart/form-data">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <input type="hidden" name="dit" value="hẹ hẹ"/>
                                                    <label for="fullName" class="form-label">Họ tên <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${param.email}" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="phone" name="phone" value="${param.phone}" required pattern="[0-9]{10,15}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" id="password" name="password" required minlength="6">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="birthday" class="form-label">Ngày sinh</label>
                                                    <input type="date" class="form-control" id="birthday" name="birthday" value="${param.birthday}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="image_user" class="form-label">Ảnh đại diện</label>
                                                    <input type="file" class="form-control" id="image_user" name="image_user" accept="image/*">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status_account" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                                    <select class="form-select" id="status_account" name="status_account" required>
                                                        <option value="1" ${param.status_account == '1' ? 'selected' : ''}>Hoạt động</option>
                                                        <option value="0" ${param.status_account == '0' ? 'selected' : ''}>Không hoạt động</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <input type="hidden" name="roleID" value="3">
                                            <div class="mt-4">
                                                <button type="submit" class="btn btn-primary">Thêm Sales</button>
                                                <a href="listSales" class="btn btn-secondary">Hủy</a>
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
            // Client-side validation
            document.getElementById('addSalesForm').addEventListener('submit', function(e) {
                let phone = document.getElementById('phone').value;
                let password = document.getElementById('password').value;
                if (!/^[0-9]{10,15}$/.test(phone)) {
                    e.preventDefault();
                    alert('Số điện thoại phải chứa 10-15 chữ số!');
                }
                if (password.length < 6) {
                    e.preventDefault();
                    alert('Mật khẩu phải ít nhất 6 ký tự!');
                }
            });
        </script>
    </body>
</html>
