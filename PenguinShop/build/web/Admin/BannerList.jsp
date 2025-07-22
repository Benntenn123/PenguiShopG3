<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
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
                                    <h4 class="mb-sm-0 font-size-18">Danh sách Banner</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý Banner</a></li>
                                            <li class="breadcrumb-item active">Danh sách Banner</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Add Banner Button -->
                        <div class="row mb-3">
                            <div class="col-12">
                                <a class="btn btn-primary" href="addBanner">
                                    <i class="bx bx-plus me-1"></i>Thêm Banner
                                </a>
                            </div>
                        </div>
                        <!-- Banner Table -->
                        <div class="table-responsive mb-4">
                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Tên Banner</th>
                                        <th scope="col">Hình ảnh</th>
                                        <th scope="col">Href</th>
                                        <th scope="col">Tình trạng</th>
                                        <th scope="col">Ngày tạo</th>
                                        <th scope="col">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bannerList}" var="banner">
                                        <tr>
                                            <td>${banner.bannerID}</td>
                                            <td>${banner.bannerName}</td>
                                            <td>
                                                <c:if test="${not empty banner.bannerLink}">
                                                    <img src="../api/img/${banner.bannerLink}" alt="Banner" style="max-width:120px;max-height:60px;"/>
                                                </c:if>
                                            </td>
                                            <td><a href="${banner.bannerHref}" target="_blank">${banner.bannerHref}</a></td>
                                            <td>
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" 
                                                           <c:if test="${banner.bannerStatus == 1}">checked</c:if>
                                                           onchange="toggleBannerStatus(${banner.bannerID}, ${banner.bannerStatus})"
                                                           style="width: 2.5rem; height: 1.25rem;">
                                                </div>
                                            </td>
                                            <td><fmt:formatDate value="${banner.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" href="editBanner?id=${banner.bannerID}">Sửa thông tin</a></li>
                                                        <li><a class="dropdown-item" href="deleteBanner?id=${banner.bannerID}" onclick="return confirm('Bạn có chắc muốn xóa banner này?');">Xóa</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <style>
            .form-check-input:checked {
                background-color: #28a745 !important;
                border-color: #28a745 !important;
            }
            .form-check-input:not(:checked) {
                background-color: #6c757d !important;
                border-color: #6c757d !important;
            }
        </style>
        <script>
            function toggleBannerStatus(bannerID, currentStatus) {
                var newStatus = currentStatus == 1 ? 0 : 1;
                fetch('api/bannerStatus', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: bannerID, status: newStatus })
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Cập nhật trạng thái thất bại!');
                    }
                })
                .catch(() => {
                    alert('Có lỗi xảy ra khi cập nhật trạng thái!');
                });
            }
        </script>
    </body>
</html>
