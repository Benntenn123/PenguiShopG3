
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
                                    <h4 class="mb-sm-0 font-size-18">Quản lý quyền của vai trò</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý quyền</a></li>
                                            <li class="breadcrumb-item active">Gán quyền cho vai trò</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Chọn vai trò</h5>
                                        <form method="get" action="manage_role_permissions">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="roleId" class="form-label">Vai trò</label>
                                                    <select class="form-select" id="roleId" name="roleId" onchange="this.form.submit()">
                                                        <option value="">Chọn vai trò...</option>
                                                        <c:forEach var="role" items="${roleList}">
                                                            <c:if test="${role.roleID != 2}">
                                                                <option value="${role.roleID}" ${param.roleId == role.roleID ? 'selected' : ''}>
                                                                    ${role.roleName}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>

                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty param.roleId}">
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title mb-3">Thêm quyền mới</h5>
                                            <form method="post" action="manage_role_permissions">
                                                <input type="hidden" name="roleId" value="${param.roleId}">
                                                <input type="hidden" name="action" value="add">
                                                <div class="row g-3">
                                                    <div class="col-md-4">
                                                        <label for="permissionId" class="form-label">Quyền</label>
                                                        <select class="form-select" id="permissionId" name="permissionId" required>
                                                            <option value="">Chọn quyền...</option>
                                                            <c:forEach var="perm" items="${availablePermissions}">
                                                                <c:if test="${param.roleId == '1' or perm.modules.moduleID != 3}">
                                                                    <option value="${perm.permissionID}">${perm.permissionName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>

                                                    </div>
                                                    <div style="display: flex; align-items: flex-end" class="col-md-2">
                                                        <label class="form-label">&nbsp;</label>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="bx bx-plus me-1"></i>Thêm
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive mb-4">
                                <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Tên quyền</th>
                                            <th scope="col">URL</th>
                                            <th scope="col">Module</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${rolePermissions}" var="perm">
                                            <tr>
                                                <td>${perm.permissionID}</td>
                                                <td>${perm.permissionName}</td>
                                                <td>${perm.url_permisson}</td>
                                                <td>${perm.modules.moduleName}</td>
                                                <td>
                                                    <button class="btn btn-link text-danger" data-bs-toggle="modal" 
                                                            data-bs-target="#confirmDeleteModal" 
                                                            onclick="setDeleteParams(${param.roleId}, ${perm.permissionID})">
                                                        <i class="bx bx-trash"></i> Xóa
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <div class="row">
                                <div class="col-sm-12 col-md-5">
                                    <div class="dataTables_info" role="status" aria-live="polite">
                                        Hiển thị từ <strong>${startRecord}</strong> đến <strong>${endRecord}</strong> trong tổng số <strong>${totalRecords}</strong> kết quả
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-7">
                                    <div class="dataTables_paginate paging_simple_numbers">
                                        <ul class="pagination justify-content-end" id="pagination">
                                            <!-- Previous Button -->
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <c:choose>
                                                    <c:when test="${currentPage == 1}">
                                                        <span class="page-link" tabindex="-1" aria-disabled="true">
                                                            <i class="mdi mdi-chevron-left"></i>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="page-link" href="?roleId=${param.roleId}&page=${currentPage - 1}" tabindex="-1">
                                                            <i class="mdi mdi-chevron-left"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>

                                            <!-- First page -->
                                            <c:if test="${currentPage > 3}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?roleId=${param.roleId}&page=1">1</a>
                                                </li>
                                                <c:if test="${currentPage > 4}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                            </c:if>

                                            <!-- Page Numbers around current page -->
                                            <c:forEach var="i" begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" 
                                                       end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <c:choose>
                                                        <c:when test="${i == currentPage}">
                                                            <span class="page-link">${i}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="page-link" href="?roleId=${param.roleId}&page=${i}">${i}</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:forEach>

                                            <!-- Last page -->
                                            <c:if test="${currentPage < totalPages - 2}">
                                                <c:if test="${currentPage < totalPages - 3}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                                <li class="page-item">
                                                    <a class="page-link" href="?roleId=${param.roleId}&page=${totalPages}">${totalPages}</a>
                                                </li>
                                            </c:if>

                                            <!-- Next Button -->
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <c:choose>
                                                    <c:when test="${currentPage == totalPages}">
                                                        <span class="page-link" aria-disabled="true">
                                                            <i class="mdi mdi-chevron-right"></i>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="page-link" href="?roleId=${param.roleId}&page=${currentPage + 1}">
                                                            <i class="mdi mdi-chevron-right"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- End Pagination -->

                        </c:if>

                        <!-- Modal Xác nhận Xóa -->
                        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="confirmDeleteModalLabel">Xác nhận xóa quyền</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc muốn xóa quyền này khỏi vai trò?
                                    </div>
                                    <div class="modal-footer">
                                        <form method="post" action="manage_role_permissions" id="deleteForm">
                                            <input type="hidden" name="roleId" id="deleteRoleId">
                                            <input type="hidden" name="permissionId" id="deletePermissionId">
                                            <input type="hidden" name="action" value="remove">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-danger">Xóa</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            function setDeleteParams(roleId, permissionId) {
                document.getElementById('deleteRoleId').value = roleId;
                document.getElementById('deletePermissionId').value = permissionId;
            }
        </script>
    </body>
</html>
