<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="Common/Css.jsp"/>
    <title>Thông tin cá nhân Admin</title>
</head>
<body>
<div id="layout-wrapper">
    <fmt:setLocale value="vi_VN"/>
    <jsp:include page="Common/Header.jsp"/>
    <jsp:include page="Common/LeftSideBar.jsp"/>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                            <h4 class="mb-sm-0 font-size-18">Thông tin cá nhân Admin</h4>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 text-center">
                                        <c:if test="${not empty admin.image_user}">
                                            <img src="../api/img/${admin.image_user}" alt="Ảnh đại diện" class="img-thumbnail mb-2" style="max-width: 150px;">
                                        </c:if>
                                        <h5>${admin.fullName}</h5>
                                        <span class="badge ${admin.status_account == 1 ? 'bg-success' : 'bg-danger'}">
                                            <c:choose>
                                                <c:when test="${admin.status_account == 1}">Hoạt động</c:when>
                                                <c:otherwise>Không hoạt động</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="col-md-8">
                                        <table class="table table-borderless">
                                            <tr><th>Email:</th><td>${admin.email}</td></tr>
                                            <tr><th>Số điện thoại:</th><td>${admin.phone}</td></tr>
                                            <tr><th>Ngày sinh:</th><td>${admin.birthday}</td></tr>
                                            <tr><th>Địa chỉ:</th><td>${admin.address}</td></tr>
                                            <tr><th>Ngày tạo:</th><td>${admin.created_at}</td></tr>
                                            <tr><th>Quyền:</th><td>${admin.role.roleName}</td></tr>
                                        </table>
                                        <div class="mt-3">
                                            <a href="changePasswordAdmin" class="btn btn-warning me-2">Đổi mật khẩu</a>
                                            <a href="editProfileAdmin" class="btn btn-primary me-2">Chỉnh sửa thông tin</a>
                                            <button type="button" class="btn btn-secondary" onclick="history.back();">Quay lại</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Common/RightSideBar.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>
</body>
</html>
