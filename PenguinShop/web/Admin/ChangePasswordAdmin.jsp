<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="Common/Css.jsp"/>
    <title>Đổi mật khẩu Admin</title>
</head>
<body>
<div id="layout-wrapper">
    <jsp:include page="Common/Header.jsp"/>
    <jsp:include page="Common/LeftSideBar.jsp"/>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Đổi mật khẩu Admin</h4>
                            </div>
                            <div class="card-body">
                                <form method="post" action="changePasswordAdmin" autocomplete="off">
                                    <div class="mb-3">
                                        <label for="oldPassword" class="form-label">Mật khẩu hiện tại</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                                            <button type="button" class="btn btn-outline-secondary" id="toggleOldPassword" tabindex="-1" title="Hiện/ẩn mật khẩu">
                                                <span id="iconOldPassword" class="fa fa-eye"></span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="8">
                                            <button type="button" class="btn btn-outline-secondary" id="toggleNewPassword" tabindex="-1" title="Hiện/ẩn mật khẩu">
                                                <span id="iconNewPassword" class="fa fa-eye"></span>
                                            </button>
                                            <button type="button" class="btn btn-outline-secondary" id="randomPasswordBtn" tabindex="-1">Random</button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="8">
                                            <button type="button" class="btn btn-outline-secondary" id="toggleConfirmPassword" tabindex="-1" title="Hiện/ẩn mật khẩu">
                                                <span id="iconConfirmPassword" class="fa fa-eye"></span>
                                            </button>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                    <a href="ProfileAdmin.jsp" class="btn btn-secondary ms-2">Quay lại</a>
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<script>
function randomPassword() {
    const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lower = 'abcdefghijklmnopqrstuvwxyz';
    const digits = '0123456789';
    const special = '!@#$%^&*()_+-=~[]{}|;:,.<>?';
    let password = '';
    // Đảm bảo có ít nhất 1 ký tự mỗi loại
    password += upper[Math.floor(Math.random() * upper.length)];
    password += lower[Math.floor(Math.random() * lower.length)];
    password += special[Math.floor(Math.random() * special.length)];
    password += digits[Math.floor(Math.random() * digits.length)];
    // Thêm các ký tự còn lại (tổng 8 ký tự)
    const all = upper + lower + digits + special;
    for (let i = 4; i < 8; i++) {
        password += all[Math.floor(Math.random() * all.length)];
    }
    // Trộn ngẫu nhiên chuỗi
    password = password.split('').sort(() => 0.5 - Math.random()).join('');
    return password;
}

document.getElementById('randomPasswordBtn').addEventListener('click', function() {
    const pwd = randomPassword();
    document.getElementById('newPassword').value = pwd;
    document.getElementById('confirmPassword').value = pwd;
});

// Toggle show/hide password for newPassword
document.getElementById('toggleNewPassword').addEventListener('click', function() {
    const input = document.getElementById('newPassword');
    const icon = document.getElementById('iconNewPassword');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
});
// Toggle show/hide password for confirmPassword
document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
    const input = document.getElementById('confirmPassword');
    const icon = document.getElementById('iconConfirmPassword');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
});

// Toggle show/hide password for oldPassword
document.getElementById('toggleOldPassword').addEventListener('click', function() {
    const input = document.getElementById('oldPassword');
    const icon = document.getElementById('iconOldPassword');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
});
</script>
</body>
</html>
