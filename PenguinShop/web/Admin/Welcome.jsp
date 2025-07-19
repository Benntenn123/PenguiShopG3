<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <jsp:include page="Common/Css.jsp"/>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <div class="row justify-content-center">
                            <div class="col-md-7 col-lg-5">
                                <div class="card mt-5">
                                    <div class="card-body text-center">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.uAdmin}">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.uAdmin.image_user}">
                                                        <img class="avatar mb-3" style="width:90px;height:90px;border-radius:50%;object-fit:cover;border:3px solid #66a6ff;" src="../api/img/${sessionScope.uAdmin.image_user}" alt="Avatar"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="avatar mb-3" style="width:90px;height:90px;border-radius:50%;object-fit:cover;border:3px solid #66a6ff;" src="/assets/images/default-avatar.png" alt="Avatar"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <h2 class="welcome-title mb-2">Xin chào, ${sessionScope.uAdmin.fullName}!</h2>
                                                <div class="welcome-desc mb-4">Chào mừng bạn đã đăng nhập vào hệ thống quản trị PenguinShop.</div>
                                                <div class="d-flex flex-wrap justify-content-center gap-2 mb-3">
                                                    <form action="/PenguinShop/admin/profile" method="get">
                                                        <button class="btn btn-primary" type="submit">Xem hồ sơ</button>
                                                    </form>
                                                    <form action="/PenguinShop/admin/changePasswordAdmin" method="get">
                                                        <button class="btn btn-warning" type="submit">Đổi mật khẩu</button>
                                                    </form>
                                                    <form action="/PenguinShop/admin/editProfileAdmin" method="get">
                                                        <button class="btn btn-info" type="submit">Chỉnh thông tin</button>
                                                    </form>
                                                    <form action="/PenguinShop/admin/logoutAdmin" method="post">
                                                        <button class="btn btn-danger" type="submit">Đăng xuất</button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <h2 class="welcome-title mb-2">Chào mừng!</h2>
                                                <div class="welcome-desc mb-4">Bạn cần đăng nhập để sử dụng các chức năng quản trị. Vui lòng nhấn nút bên dưới để đăng nhập vào hệ thống.</div>
                                                <form action="/PenguinShop/loginAdmin" method="get">
                                                    <button class="btn btn-primary" type="submit">Đăng nhập</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
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
