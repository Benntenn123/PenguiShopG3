<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách nhóm quyền</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quyền truy cập</a></li>
                                            <li class="breadcrumb-item active">Danh sách nhóm quyền</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Số lượng nhóm quyền <span class="text-muted fw-normal ms-2">(${totalRole})</span></h5>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                                    <div>
                                        <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#roleModal"
                                                data-bs-whatever="add"><i class="bx bx-plus me-1"></i> Thêm nhóm quyền mới</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        <!-- Search Form -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm nhóm quyền</h5>
                                        <form method="get" action="">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="searchName" class="form-label">Tên nhóm quyền</label>
                                                    <input type="text" class="form-control" id="searchName" name="roleName" 
                                                           placeholder="Nhập tên nhóm quyền..." value="${param.roleName}">
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="bx bx-search me-1"></i>Tìm kiếm
                                                    </button>
                                                    <button type="button" class="btn btn-light ms-2" id="clearSearch">
                                                        <i class="bx bx-refresh me-1"></i>Xóa bộ lọc
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Search Form -->

                        <div class="table-responsive mb-4">
                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 50px;">
                                            <div class="form-check font-size-16">
                                                <input type="checkbox" class="form-check-input" id="checkAll">
                                                <label class="form-check-label" for="checkAll"></label>
                                            </div>
                                        </th>
                                        <th scope="col">ID</th>
                                        <th scope="col">Tên nhóm quyền</th>
                                        <th style="width: 80px; min-width: 80px;">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${role}" var="role">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="contacusercheck${role.roleID}">
                                                    <label class="form-check-label" for="contacusercheck${role.roleID}"></label>
                                                </div>
                                            </th>                                   
                                            <td>${role.roleID}</td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <a style="font-size: 16px" href="#" class="badge bg-primary-subtle text-primary">${role.roleName}</a>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item edit-role" href="#" data-bs-toggle="modal" data-bs-target="#roleModal" 
                                                               data-role-id="${role.roleID}" data-role-name="${role.roleName}">Sửa</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- end table -->
                        </div>
                        <!-- end table responsive -->

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
                                                    <a class="page-link" href="?page=${currentPage - 1}&roleName=${param.roleName}" tabindex="-1">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        
                                        <!-- First page -->
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&roleName=${param.roleName}">1</a>
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
                                                        <a class="page-link" href="?page=${i}&roleName=${param.roleName}">${i}</a>
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
                                                <a class="page-link" href="?page=${totalPages}&roleName=${param.roleName}">${totalPages}</a>
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
                                                    <a class="page-link" href="?page=${currentPage + 1}&roleName=${param.roleName}">
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

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
            <!-- end main content-->
        </div>
        <!-- END layout-wrapper -->
        
        <!-- Role Modal for Add/Edit -->
        <div class="modal fade" id="roleModal" tabindex="-1" aria-labelledby="roleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="roleModalLabel">Thêm nhóm quyền mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="roleForm" action="roles" method="post">
                            <input type="hidden" id="roleId" name="roleId">
                            <div class="mb-3">
                                <label for="roleName" class="col-form-label">Tên nhóm quyền:</label>
                                <input type="text" class="form-control" id="roleName" name="roleName" required>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" id="btn-submitForm" form="roleForm" class="btn btn-primary">Lưu</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Sidebar -->
        <jsp:include page="Common/RightSideBar.jsp"/>

        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        
        <script>
            // Clear search form
            document.getElementById('clearSearch').addEventListener('click', function() {
                document.getElementById('searchName').value = '';
                window.location.href = window.location.pathname;
            });

            // Handle modal for add/edit
            document.addEventListener('DOMContentLoaded', function() {
                const roleModal = document.getElementById('roleModal');
                roleModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const action = button.getAttribute('data-bs-whatever');
                    const modalTitle = roleModal.querySelector('.modal-title');
                    const roleIdInput = roleModal.querySelector('#roleId');
                    const roleNameInput = roleModal.querySelector('#roleName');
                    const form = roleModal.querySelector('#roleForm');

                    if (action === 'add') {
                        modalTitle.textContent = 'Thêm nhóm quyền mới';
                        roleIdInput.value = '';
                        roleNameInput.value = '';
                        form.action = 'roles?action=add';
                    } else {
                        modalTitle.textContent = 'Sửa nhóm quyền';
                        const roleId = button.getAttribute('data-role-id');
                        const roleName = button.getAttribute('data-role-name');
                        roleIdInput.value = roleId;
                        roleNameInput.value = roleName;
                        form.action = 'roles?action=edit';
                    }
                });
            });
        </script>
    </body>
</html>