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

                        <!-- Start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách yêu cầu khách hàng</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listRequestSupport">Yêu cầu người dùng</a></li>
                                            <li class="breadcrumb-item active">Danh sách yêu cầu khách hàng</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End page title -->

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Tổng số yêu cầu <span class="text-muted fw-normal ms-2">(${totalRequests})</span></h5>
                                </div>
                                <div class="mb-3">
                                    <h5 class="card-title">Yêu cầu chưa xử lý <span class="text-muted fw-normal ms-2">(${pendingRequests})</span></h5>
                                </div>
                                <div class="mb-3">
                                    <h5 class="card-title">Yêu cầu đã xử lý <span class="text-muted fw-normal ms-2">(${processedRequests})</span></h5>
                                </div>
                            </div>
                        </div>
                        <!-- End row -->

                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm yêu cầu khách hàng</h5>
                                        <form method="GET" action="listRequestSupport">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="email" class="form-label">Email khách hàng</label>
                                                    <input type="email" class="form-control" id="email" name="email" 
                                                           placeholder="Nhập email..." value="${param.email}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="phone" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="phone" name="phone" 
                                                           placeholder="Nhập số điện thoại..." value="${param.phone}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="status" class="form-label">Trạng thái</label>
                                                    <select class="form-control" id="statusRequest" name="status">
                                                        <option value="">Tất cả trạng thái</option>
                                                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Đã xử lý</option>
                                                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Chưa xử lý</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="startDate" class="form-label">Từ ngày</label>
                                                    <input type="date" class="form-control" id="startDate" name="startDate" 
                                                           value="${param.startDate}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="endDate" class="form-label">Đến ngày</label>
                                                    <input type="date" class="form-control" id="endDate" name="endDate" 
                                                           value="${param.endDate}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="type" class="form-label">Loại vấn đề</label>
                                                    <select class="form-control" id="requestType" name="requestType">
                                                        <option value="">Tất cả loại vấn đề</option>
                                                        <option value="Trạng thái tài khoản" ${param.type == 'Trạng thái tài khoản' ? 'selected' : ''}>Trạng thái tài khoản</option>
                                                        <option value="Vấn đề mua hàng" ${param.type == 'Vấn đề mua hàng' ? 'selected' : ''}>Vấn đề mua hàng</option>
                                                        <option value="Vấn đề thanh toán" ${param.type == 'Vấn đề thanh toán' ? 'selected' : ''}>Vấn đề thanh toán</option>
                                                        <option value="Vấn đề giao hàng" ${param.type == 'Vấn đề giao hàng' ? 'selected' : ''}>Vấn đề giao hàng</option>
                                                        <option value="Hoàn tiền/Đổi trả" ${param.type == 'Hoàn tiền/Đổi trả' ? 'selected' : ''}>Hoàn tiền/Đổi trả</option>
                                                        <option value="Lỗi kỹ thuật" ${param.type == 'Lỗi kỹ thuật' ? 'selected' : ''}>Lỗi kỹ thuật</option>
                                                        <option value="Vấn đề khác" ${param.type == 'Vấn đề khác' ? 'selected' : ''}>Vấn đề khác</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="bx bx-search me-1"></i>Tìm kiếm
                                                    </button>
                                                    <button type="button" class="btn btn-light ms-2" onclick="clearForm()">
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
                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; width: 100%;">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 50px;">
                                            <div class="form-check font-size-16">
                                                <input type="checkbox" class="form-check-input" id="checkAll">
                                                <label class="form-check-label" for="checkAll"></label>
                                            </div>
                                        </th>
                                        <th scope="col">ID</th>
                                        <th scope="col">Thời gian</th>
                                        <th scope="col">Email gửi</th>
                                        <th scope="col">Số điện thoại</th>
                                        <th scope="col">Vấn đề</th>
                                        <th scope="col">Tình trạng</th>
                                        <th scope="col">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestList}" var="request">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="requestcheck${request.requestID}">
                                                    <label class="form-check-label" for="requestcheck${request.requestID}"></label>
                                                </div>
                                            </th>
                                            <td>${request.requestID}</td>
                                            <td>
                                                ${request.requestDate}
                                            </td>
                                            <td>${request.email_request}</td>
                                            <td>${request.phone_request}</td>
                                            <td>${request.requestType}</td>
                                            <td>
                                                <c:choose>

                                                    <c:when test="${request.requestStatus == '0'}">
                                                        <span class="badge bg-primary">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${request.requestStatus == '1'}">
                                                        <span class="badge bg-success">Đã xử lý</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" href="requestDetails?requestID=${request.requestID}">Xem chi tiết</a></li>
                                                        <li><a class="dropdown-item" href="responseSupport?requestID=${request.requestID}">Phản Hồi</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- End table -->
                        </div>
                        <!-- End table responsive -->

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
                                                    <a class="page-link" href="?page=${currentPage - 1}&email=${param.email}&phone=${param.phone}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}&requestType=${param.requestType}" tabindex="-1">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>

                                        <!-- First page -->
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&email=${param.email}&phone=${param.phone}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}&requestType=${param.requestType}">1</a>
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
                                                        <a class="page-link" href="?page=${i}&email=${param.email}&phone=${param.phone}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}&requestType=${param.requestType}">${i}</a>
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
                                                <a class="page-link" href="?page=${totalPages}&email=${param.email}&phone=${param.phone}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}&requestType=${param.requestType}">${totalPages}</a>
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
                                                    <a class="page-link" href="?page=${currentPage + 1}&email=${param.email}&phone=${param.phone}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}&requestType=${param.requestType}">
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

            <jsp:include page="Common/RightSideBar.jsp"/>
            <jsp:include page="Common/Js.jsp"/>
            <jsp:include page="Common/Message.jsp"/>
            <script>
                function clearForm() {
                    document.getElementById('email').value = '';
                    document.getElementById('phone').value = '';
                    document.getElementById('statusRequest').value = '';
                    document.getElementById('startDate').value = '';
                    document.getElementById('endDate').value = '';
                    document.getElementById('requestType').value = '';
                    document.querySelector('form').submit();
                }
            </script>
    </body>
</html>
