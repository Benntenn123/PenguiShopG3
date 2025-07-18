<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="Common/Css.jsp"/>
    <title>Chỉnh sửa thông tin Admin</title>
</head>
<body>
<div id="layout-wrapper">
    <jsp:include page="Common/Header.jsp"/>
    <jsp:include page="Common/LeftSideBar.jsp"/>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Chỉnh sửa thông tin Admin</h4>
                            </div>
                            <div class="card-body">
                                <form method="post" action="editProfileAdmin" enctype="multipart/form-data" autocomplete="off">
                                    <div class="row">
                                        <div class="col-md-4 text-center">
                                            <c:choose>
                                                <c:when test="${not empty admin.image_user}">
                                                    <img id="avatarPreview" src="../api/img/${uAdmin.image_user}" alt="Ảnh đại diện" class="img-thumbnail mb-2" style="max-width: 150px; display: block;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img id="avatarPreview" src="" alt="Ảnh đại diện" class="img-thumbnail mb-2" style="max-width: 150px; display: none;">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="mb-3">
                                                <label for="image_user" class="form-label">Đổi ảnh đại diện</label>
                                                <input type="file" class="form-control" id="image_user" name="image_user" accept="image/*">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="mb-3">
                                                <label for="fullName" class="form-label">Họ tên</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" value="${uAdmin.fullName}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" value="${uAdmin.email}" required readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="phone" name="phone" value="${uAdmin.phone}" autocomplete="off">
                                            </div>
                                            <div class="mb-3">
                                                <label for="birthday" class="form-label">Ngày sinh</label>
                                                <input type="date" class="form-control" id="birthday" name="birthday" value="${uAdmin.birthday}">
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Địa chỉ</label>
                                                <input type="text" class="form-control" id="address" name="address" value="${uAdmin.address}">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            <button type="button" class="btn btn-outline-secondary ms-2" id="reloadProfileBtn">Tải lại</button>
                                            <a href="profile" class="btn btn-secondary ms-2">Quay lại</a>
                                        </div>
                                    </div>
                                </form>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger mt-3">${error}</div>
                                </c:if>
                                <c:if test="${not empty ms}">
                                    <div class="alert alert-success mt-3">${ms}</div>
                                </c:if>
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
</div>
<script>
// Preview avatar
document.getElementById('image_user').addEventListener('change', function(e) {
    const file = e.target.files[0];
    const preview = document.getElementById('avatarPreview');
    if (file) {
        const reader = new FileReader();
        reader.onload = function(ev) {
            preview.src = ev.target.result;
            preview.style.display = 'block';
        };
        reader.readAsDataURL(file);
    } else {
        // Lấy lại src ban đầu từ biến JS
        preview.src = window._avatarInitSrc || '';
        preview.style.display = window._avatarInitSrc ? 'block' : 'none';
    }
});

// Lưu lại data ban đầu từ session vào biến JS
window._profileInit = {
    fullName: "${admin.fullName}",
    email: "${admin.email}",
    phone: "${admin.phone}",
    birthday: "${admin.birthday}",
    address: "${admin.address}",
};
window._avatarInitSrc = "${not empty admin.image_user ? '../api/img/' : ''}${not empty admin.image_user ? admin.image_user : ''}";

// Nút reload: reset form về data ban đầu
document.getElementById('reloadProfileBtn').addEventListener('click', function() {
    // Reload lại trang để lấy lại data từ session (admin)
    window.location.reload();
});
</script>
</body>
</html>
