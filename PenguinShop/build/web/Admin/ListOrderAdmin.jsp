<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách hóa đơn</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Hóa đơn</a></li>
                                            <li class="breadcrumb-item active">Danh sách hóa đơn</li>
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
                                        <h5 class="card-title mb-3">Tìm kiếm hóa đơn</h5>
                                        <form method="get" action="">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="productName" class="form-label">Mã hóa đơn</label>
                                                    <input type="text" class="form-control" id="orderID" name="orderID" 
                                                           placeholder="Nhập mã hóa đơn..." value="${param.orderID}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="from" class="form-label">Từ ngày</label>
                                                    <input type="date" class="form-control" id="from" name="from" 
                                                           value="${param.from}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="to" class="form-label">Đến ngày</label>
                                                    <input type="date" class="form-control" id="to" name="to" 
                                                           value="${param.to}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status" class="form-label">Trạng thái hóa đơn</label>
                                                    <select class="form-select" name="status">
                                                        <option value="">Tất cả trạng thái</option>
                                                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã Hủy</option>
                                                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Giao hàng thành công</option>
                                                        <option value="2" ${param.status == '2' ? 'selected' : ''}>Đang Giao</option>
                                                        <option value="3" ${param.status == '3' ? 'selected' : ''}>Hoàn Hàng</option>
                                                        <option value="4" ${param.status == '4' ? 'selected' : ''}>Đang Chờ Xử Lí</option>
                                                        <option value="5" ${param.status == '5' ? 'selected' : ''}>Đã Xác Nhận</option>

                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="user" class="form-label">Người dùng</label>
                                                    <input type="number" class="form-control" id="user" name="user" 
                                                           placeholder="Nhập email..." value="${param.email}" min="0">
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
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">

                                        <!-- end row -->

                                        <div class="table-responsive">
                                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                                <thead>
                                                    <tr class="bg-transparent">
                                                        <th style="width: 30px;">
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" name="check" class="form-check-input" id="checkAll">
                                                                <label class="form-check-label" for="checkAll"></label>
                                                            </div>
                                                        </th>
                                                        <th style="width: 120px;">ID</th>
                                                        <th>Ngày đặt</th>
                                                        <th>Người đặt</th>
                                                        <th>Tổng</th>
                                                        <th>Tình trạng</th>
                                                        <!--                                                        <th style="width: 150px;">Tải về</th>-->
                                                        <th style="width: 90px;">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${list}">
                                                        <tr>
                                                            <td>
                                                                <div class="form-check font-size-16">
                                                                    <input type="checkbox" class="form-check-input">
                                                                    <label class="form-check-label"></label>
                                                                </div>
                                                            </td>

                                                            <td><a href="orderDetailsAdmin?orderID=${order.orderID}" class="text-body fw-medium">#${order.orderID}</a> </td>
                                                            <td>
                                                                ${order.orderDate}
                                                            </td>
                                                            <td>${order.user.fullName}</td>

                                                            <td>
                                                                <fmt:formatNumber value="${order.total}" type="currency" currencyCode="VND"/>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.orderStatus == 0}">
                                                                        <div class="badge badge-soft-danger font-size-12">Đã hủy</div>
                                                                    </c:when>
                                                                    <c:when test="${order.orderStatus == 1}">
                                                                        <div class="badge badge-soft-success font-size-12">Giao hàng thành công</div>
                                                                    </c:when>
                                                                    <c:when test="${order.orderStatus == 2}">
                                                                        <div class="badge badge-soft-info font-size-12">Đang giao</div>
                                                                    </c:when>
                                                                    <c:when test="${order.orderStatus == 3}">
                                                                        <div class="badge badge-soft-warning font-size-12">Hoàn hàng</div>
                                                                    </c:when>
                                                                    <c:when test="${order.orderStatus == 4}">
                                                                        <div class="badge badge-soft-primary font-size-12">Đang chờ xử lý</div>
                                                                    </c:when>
                                                                    <c:when test="${order.orderStatus == 5}">
                                                                        <div class="badge badge-soft-secondary font-size-12">Đã xác nhận</div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="badge badge-soft-dark font-size-12">Không rõ</div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>

                                                            <td>
                                                                <div class="dropdown">
                                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                                        <li><a class="dropdown-item" href="orderDetailsAdmin?orderID=${order.orderID}">Xem Chi Tiết</a></li>
                                                                        <li><a class="dropdown-item" href="changeInformationOrder?orderID=${order.orderID}">Chỉnh sửa</a></li>
<!--                                                                        <li><a class="dropdown-item" href="#">Delete</a></li>-->
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                   
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- end table responsive -->
                                    </div>
                                    <!-- end card body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col -->
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-5">
                                <div class="dataTables_info" role="status" aria-live="polite">
                                    Hiển thị từ <strong>${startRecord}</strong> đến <strong>${endRecord}</strong> trong tổng số <strong>${totalRecords}</strong> kết quả
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination justify-content-end" id="pagination">

                                        <!-- Nút Previous -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <c:choose>
                                                <c:when test="${currentPage == 1}">
                                                    <span class="page-link" tabindex="-1" aria-disabled="true">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="page-link" href="?page=${currentPage - 1}&orderID=${param.orderID}&from=${param.from}&to=${param.to}&status=${param.status}&user=${param.user}">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>

                                        <!-- Trang đầu -->
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&orderID=${param.orderID}&from=${param.from}&to=${param.to}&status=${param.status}&user=${param.user}">1</a>
                                            </li>
                                            <c:if test="${currentPage > 4}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            </c:if>

                                        <!-- Trang lân cận -->
                                        <c:forEach var="i" begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <span class="page-link">${i}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="page-link" href="?page=${i}&orderID=${param.orderID}&from=${param.from}&to=${param.to}&status=${param.status}&user=${param.user}">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>

                                        <!-- Trang cuối -->
                                        <c:if test="${currentPage < totalPages - 2}">
                                            <c:if test="${currentPage < totalPages - 3}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${totalPages}&orderID=${param.orderID}&from=${param.from}&to=${param.to}&status=${param.status}&user=${param.user}">${totalPages}</a>
                                            </li>
                                        </c:if>

                                        <!-- Nút Next -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <c:choose>
                                                <c:when test="${currentPage == totalPages}">
                                                    <span class="page-link" aria-disabled="true">
                                                        <i class="mdi mdi-chevron-right"></i>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="page-link" href="?page=${currentPage + 1}&orderID=${param.orderID}&from=${param.from}&to=${param.to}&status=${param.status}&user=${param.user}">
                                                        <i class="mdi mdi-chevron-right"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- end row -->
                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->



            </div>

        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            function clearForm() {
                const form = document.querySelector('form');

                // Reset các input text, date, number
                form.querySelectorAll('input').forEach(input => {
                    if (input.type === 'text' || input.type === 'date' || input.type === 'number') {
                        input.value = '';
                    }
                });

                // Reset select về mặc định (giá trị rỗng)
                form.querySelectorAll('select').forEach(select => {
                    select.value = '';
                });

                // Submit lại form sau khi clear
                form.submit();
            }
        </script>

    </body>
</html>
