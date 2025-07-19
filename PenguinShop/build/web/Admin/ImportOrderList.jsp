<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <!-- Breadcrumb -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">
                                        <c:choose>
                                            <c:when test="${not empty selectedSupplier}">
                                                Lịch sử nhập hàng - ${selectedSupplier.supplierName}
                                            </c:when>
                                            <c:otherwise>
                                                Danh sách đơn nhập hàng
                                            </c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <c:if test="${not empty selectedSupplier}">
                                                <li class="breadcrumb-item"><a href="SupplierList">Nhà cung cấp</a></li>
                                                <li class="breadcrumb-item"><a href="supplier-details?id=${selectedSupplier.supplierID}">Chi tiết</a></li>
                                                <li class="breadcrumb-item active">Lịch sử nhập hàng</li>
                                            </c:if>
                                            <c:if test="${empty selectedSupplier}">
                                                <li class="breadcrumb-item active">Đơn nhập hàng</li>
                                            </c:if>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Message Alert -->
                        <jsp:include page="Common/Message.jsp"/>

                        <!-- Error Alert -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="mdi mdi-alert-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="row align-items-center">
                                            <div class="col-md-6">
                                                <h5 class="card-title mb-0">
                                                    <c:choose>
                                                        <c:when test="${not empty selectedSupplier}">
                                                            <i class="mdi mdi-history me-2"></i>Lịch sử nhập hàng
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="mdi mdi-package-variant me-2"></i>Danh sách đơn nhập hàng
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h5>
                                            </div>
                                            <div class="col-md-6 text-end">
                                                <c:if test="${not empty selectedSupplier}">
                                                    <a href="AddImportOrder?supplierId=${selectedSupplier.supplierID}" class="btn btn-primary">
                                                        <i class="mdi mdi-plus me-2"></i>Tạo đơn nhập mới
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty selectedSupplier}">
                                                    <a href="AddImportOrder" class="btn btn-primary">
                                                        <i class="mdi mdi-plus me-2"></i>Tạo đơn nhập hàng
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <!-- Search and Filter -->
                                        <form method="get" action="ImportOrderList" class="row g-3 mb-3">
                                            <c:if test="${not empty supplierId}">
                                                <input type="hidden" name="supplierId" value="${supplierId}">
                                            </c:if>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="search" 
                                                       placeholder="Tìm kiếm..." value="${search}">
                                            </div>
                                            <c:if test="${empty selectedSupplier}">
                                                <div class="col-md-3">
                                                    <select class="form-select" name="supplierId" onchange="this.form.submit()">
                                                        <option value="">-- Tất cả nhà cung cấp --</option>
                                                        <c:forEach var="supplier" items="${suppliers}">
                                                            <option value="${supplier.supplierID}" 
                                                                    ${supplierId == supplier.supplierID ? 'selected' : ''}>
                                                                ${supplier.supplierName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </c:if>
                                            <div class="col-md-2">
                                                <select class="form-select" name="sortBy">
                                                    <option value="importDate" ${sortBy == 'importDate' ? 'selected' : ''}>Ngày nhập</option>
                                                    <option value="totalAmount" ${sortBy == 'totalAmount' ? 'selected' : ''}>Tổng tiền</option>
                                                    <option value="supplierName" ${sortBy == 'supplierName' ? 'selected' : ''}>Nhà cung cấp</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2">
                                                <select class="form-select" name="sortDir">
                                                    <option value="DESC" ${sortDir == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                                    <option value="ASC" ${sortDir == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                                </select>
                                            </div>
                                            <div class="col-md-1">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="mdi mdi-magnify"></i>
                                                </button>
                                            </div>
                                        </form>

                                        <!-- Import Orders Table -->
                                        <c:choose>
                                            <c:when test="${not empty importOrders}">
                                                <div class="table-responsive">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>Mã đơn</th>
                                                                <c:if test="${empty selectedSupplier}">
                                                                    <th>Nhà cung cấp</th>
                                                                </c:if>
                                                                <th>Ngày nhập</th>
                                                                <th>Tổng tiền</th>
                                                                <th>Ghi chú</th>
                                                                <th>Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="order" items="${importOrders}">
                                                                <tr>
                                                                    <td>
                                                                        <strong>#${order.importOrderID}</strong>
                                                                    </td>
                                                                    <c:if test="${empty selectedSupplier}">
                                                                        <td>
                                                                            <a href="SupplierDetails?id=${order.supplierID}">
                                                                                ${order.supplierName}
                                                                            </a>
                                                                        </td>
                                                                    </c:if>
                                                                    <td>
                                                                        <fmt:formatDate value="${order.importDate}" 
                                                                                      pattern="dd/MM/yyyy HH:mm"/>
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${order.totalImportAmount}" 
                                                                                        type="currency" currencyCode="VND" 
                                                                                        pattern="#,##0 ₫"/>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${not empty order.note}">
                                                                                ${order.note}
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted">--</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <a href="ImportOrderDetails?id=${order.importOrderID}" 
                                                                           class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                                                            <i class="mdi mdi-eye"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <!-- Pagination -->
                                                <c:if test="${totalPages > 1}">
                                                    <div class="row">
                                                        <div class="col-sm-12 col-md-5">
                                                            <div class="dataTables_info">
                                                                Hiển thị ${((currentPage - 1) * pageSize) + 1} 
                                                                đến ${currentPage * pageSize > totalRecords ? totalRecords : currentPage * pageSize} 
                                                                của ${totalRecords} kết quả
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-7">
                                                            <div class="dataTables_paginate paging_simple_numbers float-end">
                                                                <ul class="pagination">
                                                                    <c:if test="${currentPage > 1}">
                                                                        <li class="paginate_button page-item previous">
                                                                            <a href="?page=${currentPage - 1}&search=${search}&supplierId=${supplierId}&sortBy=${sortBy}&sortDir=${sortDir}" 
                                                                               class="page-link">‹</a>
                                                                        </li>
                                                                    </c:if>
                                                                    
                                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                                        <c:if test="${i == currentPage}">
                                                                            <li class="paginate_button page-item active">
                                                                                <span class="page-link">${i}</span>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${i != currentPage}">
                                                                            <li class="paginate_button page-item">
                                                                                <a href="?page=${i}&search=${search}&supplierId=${supplierId}&sortBy=${sortBy}&sortDir=${sortDir}" 
                                                                                   class="page-link">${i}</a>
                                                                            </li>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    
                                                                    <c:if test="${currentPage < totalPages}">
                                                                        <li class="paginate_button page-item next">
                                                                            <a href="?page=${currentPage + 1}&search=${search}&supplierId=${supplierId}&sortBy=${sortBy}&sortDir=${sortDir}" 
                                                                               class="page-link">›</a>
                                                                        </li>
                                                                    </c:if>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center py-4">
                                                    <i class="mdi mdi-package-variant-closed-remove text-muted" style="font-size: 48px;"></i>
                                                    <p class="text-muted mt-3 mb-0">
                                                        <c:choose>
                                                            <c:when test="${not empty selectedSupplier}">
                                                                Chưa có đơn nhập hàng nào cho ${selectedSupplier.supplierName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Chưa có đơn nhập hàng nào
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <c:if test="${not empty selectedSupplier}">
                                                        <a href="AddImportOrder?supplierId=${selectedSupplier.supplierID}" 
                                                           class="btn btn-primary btn-sm mt-2">
                                                            <i class="mdi mdi-plus me-2"></i>Tạo đơn nhập hàng đầu tiên
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
        </div>

        <jsp:include page="Common/Js.jsp"/>
    </body>
</html>
