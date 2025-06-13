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
                                    <h4 class="mb-sm-0 font-size-18">Danh sách người dùng</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Người dùng</a></li>
                                            <li class="breadcrumb-item active">Danh sách người dùng</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Số lượng người dùng <span class="text-muted fw-normal ms-2">(${totalRecords})</span></h5>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                                    <div>
                                        <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                data-bs-whatever="@mdo"><i class="bx bx-plus me-1"></i> Thêm tài khoản mới</button>
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
                                        <h5 class="card-title mb-3">Tìm kiếm người dùng</h5>
                                        <form method="get" action="">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="searchName" class="form-label">Tên người dùng</label>
                                                    <input type="text" class="form-control" id="searchName" name="fullname" 
                                                           placeholder="Nhập tên người dùng..." value="${param.searchName}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="searchEmail" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="searchEmail" name="email" 
                                                           placeholder="Nhập email..." value="${param.searchEmail}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="searchPhone" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="searchPhone" name="phone" 
                                                           placeholder="Nhập số điện thoại..." value="${param.searchPhone}">
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
                                        <th scope="col">Tên</th>
                                        <th scope="col">Số điện thoại</th>
                                        <th scope="col">Địa chỉ email</th>
                                        <th scope="col">Quyền truy cập</th>
                                        <th style="width: 80px; min-width: 80px;">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="list">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="contacusercheck1">
                                                    <label class="form-check-label" for="contacusercheck1"></label>
                                                </div>
                                            </th>
                                            <td>
                                                <img src="../api/img/${list.image_user}" alt="" class="avatar-sm rounded-circle me-2">
                                                <a href="customer_details?userID=${list.userID}" class="text-body">${list.fullName}</a>
                                            </td>
                                            <td>${list.phone}</td>
                                            <td>${list.email}</td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <a href="#" class="badge bg-primary-subtle text-primary">${list.role.roleName}</a>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
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
                                                    <a class="page-link" href="?page=${currentPage - 1}&searchName=${param.searchName}&searchEmail=${param.searchEmail}&searchPhone=${param.searchPhone}" tabindex="-1">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        
                                        <!-- First page -->
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&searchName=${param.searchName}&searchEmail=${param.searchEmail}&searchPhone=${param.searchPhone}">1</a>
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
                                                        <a class="page-link" href="?page=${i}&searchName=${param.searchName}&searchEmail=${param.searchEmail}&searchPhone=${param.searchPhone}">${i}</a>
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
                                                <a class="page-link" href="?page=${totalPages}&searchName=${param.searchName}&searchEmail=${param.searchEmail}&searchPhone=${param.searchPhone}">${totalPages}</a>
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
                                                    <a class="page-link" href="?page=${currentPage + 1}&searchName=${param.searchName}&searchEmail=${param.searchEmail}&searchPhone=${param.searchPhone}">
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
        
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="userForm" action="hehe" method="post">
                            <div class="mb-3">
                                <label for="recipient-name" class="col-form-label">Recipient:</label>
                                <input type="text" class="form-control" id="recipient-name">
                            </div>
                            <div class="mb-3">
                                <label for="message-text" class="col-form-label">Message:</label>
                                <textarea class="form-control" id="message-text"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" id="btn-submitForm" form="userForm" class="btn btn-primary">Send message</button>
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
                document.getElementById('searchEmail').value = '';
                document.getElementById('searchPhone').value = '';
                // Reload page without parameters
                window.location.href = window.location.pathname;
            });
        </script>
    </body>
</html>