<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách Sales</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý Sales</a></li>
                                            <li class="breadcrumb-item active">Danh sách Sales</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Search Form -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm Sales</h5>
                                        <form method="get" action="listSales">
                                            <div class="row g-3">
                                                <div class="col-md-3">
                                                    <label for="fullName" class="form-label">Họ tên</label>
                                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}">
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="email" class="form-label">Email</label>
                                                    <input type="text" class="form-control" id="email" name="email" value="${param.email}">
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="phone" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="phone" name="phone" value="${param.phone}">
                                                </div>
                                                <div class="col-md-3 d-flex align-items-end">
                                                    <button type="submit" class="btn btn-primary me-2">
                                                        <i class="bx bx-search me-1"></i>Tìm kiếm
                                                    </button>
                                                    <a href="listSales" class="btn btn-secondary">Xóa bộ lọc</a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Add Sales Button -->
                        <div class="row mb-3">
                            <div class="col-12">
                                <a class="btn btn-primary" href="addSales">
                                    <i class="bx bx-plus me-1"></i>Thêm Sales
                                </a>
                            </div>
                        </div>

                        <!-- Sales Table -->
                        <div class="table-responsive mb-4">
                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Họ tên</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Số điện thoại</th>
                                        <th scope="col">Ngày tạo</th>                                        
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col">Tổng quyền</th>
                                        <th scope="col">Quyền</th>
                                        <th scope="col">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${salesList}" var="user">
                                        <tr>
                                            <td>${user.userID}</td>
                                            <td>${user.fullName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td>${user.created_at}</td>
                                            <td>
                                                <span class="badge ${user.status_account == 1 ? 'bg-success' : 'bg-danger'}">
                                                    <c:choose>
                                                        <c:when test="${user.status_account == 1}">Hoạt động</c:when>
                                                        <c:otherwise>Không hoạt động</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>${user.permissionCount} quyền</td>
                                            <td>${user.role.roleName}</td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#viewSalesModal" onclick="viewSales(${user.userID})">Xem chi tiết</a></li>
                                                        <li><a class="dropdown-item" href="editSales?id=${user.userID}">Sửa thông tin</a></li>
                                                        <li><a class="dropdown-item" href="manage_role_permissions?roleId=${user.roleID}">Quản lí quyền</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Modal Chi tiết Sales -->
                        <div class="modal fade" id="viewSalesModal" tabindex="-1" aria-labelledby="viewSalesModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="viewSalesModalLabel">Chi tiết Sales</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="salesDetailBody">
                                            <p>Đang tải...</p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
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

        <script>
            function viewSales(userId) {
                var modal = new bootstrap.Modal(document.getElementById('viewSalesModal'));
                document.getElementById('salesDetailBody').innerHTML = '<p>Đang tải...</p>';
                modal.show();
                fetch('../api/salesDetail?id=' + userId)
                    .then(res => res.json())
                    .then(data => {
                        if (!data || !data.userID) {
                            document.getElementById('salesDetailBody').innerHTML = '<p>Không tìm thấy thông tin Sales.</p>';
                            return;
                        }

                        var html = '';
                        html += '<div class="row">';
                        html += '  <div class="col-md-4 text-center">';
                        if (data.image_user) {
                            html += '    <img src="../api/img/' + data.image_user + '" alt="Ảnh đại diện" class="img-thumbnail mb-2" style="max-width: 150px;">';
                        }
                        html += '    <h5>' + data.fullName + '</h5>';
                        html += '    <span class="badge ' + (data.status_account == 1 ? 'bg-success' : 'bg-danger') + '">' + (data.status_account == 1 ? 'Hoạt động' : 'Không hoạt động') + '</span>';
                        html += '  </div>';
                        html += '  <div class="col-md-8">';
                        html += '    <table class="table table-borderless">';
                        html += '      <tr><th>Email:</th><td>' + (data.email || '') + '</td></tr>';
                        html += '      <tr><th>Số điện thoại:</th><td>' + (data.phone || '') + '</td></tr>';
                        html += '      <tr><th>Ngày sinh:</th><td>' + (data.birthday || '') + '</td></tr>';
                        html += '      <tr><th>Địa chỉ:</th><td>' + (data.address || '') + '</td></tr>';
                        html += '      <tr><th>Ngày tạo:</th><td>' + (data.created_at || '') + '</td></tr>';
                        html += '      <tr><th>Quyền:</th><td>' + ((data.role && data.role.roleName) ? data.role.roleName : '') + '</td></tr>';
                        html += '      <tr><th>Danh sách quyền truy cập:</th><td>';
                        html += '        <div style="max-height: 150px; overflow-y: auto; border: 1px solid #ccc; padding: 6px; border-radius: 4px;">';
                        html += '          <ul class="mb-0" style="padding-left: 20px;">';
                        (data.permissions || []).forEach(function(p) {
                            html += '<li>' + p.permissionName + '</li>';
                        });
                        html += '          </ul>';
                        html += '        </div>';
                        html += '      </td></tr>';
                        html += '    </table>';
                        html += '  </div>';
                        html += '</div>';

                        document.getElementById('salesDetailBody').innerHTML = html;
                    })
                    .catch(() => {
                        document.getElementById('salesDetailBody').innerHTML = '<p>Không tìm thấy thông tin Sales.</p>';
                    });
            }

            document.getElementById('viewSalesModal').addEventListener('hidden.bs.modal', function () {
                document.body.classList.remove('modal-open');
                document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
            });
        </script>
    </body>
</html>
