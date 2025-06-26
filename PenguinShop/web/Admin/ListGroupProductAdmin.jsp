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
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách sản phẩm</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Sản phẩm</a></li>
                                            <li class="breadcrumb-item active">Danh sách nhóm sản phẩm</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Tổng số sản phẩm <span class="text-muted fw-normal ms-2">(${totalProduct})</span></h5>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                                    <div>
                                        <a type="button" class="btn btn-light" href="addGroupProduct">
                                            <i class="bx bx-plus me-1"></i> Thêm sản phẩm mới
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm sản phẩm</h5>
                                        <form method="get" action="listGroupProduct">
                                            <div class="row g-3">
                                                <div class="col-md-3">
                                                    <label for="productName" class="form-label">Tên sản phẩm</label>
                                                    <input type="text" class="form-control" id="productName" name="productName" 
                                                           placeholder="Nhập tên sản phẩm..." value="${param.productName}">
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="brand" class="form-label">Thương hiệu</label>
                                                    <select class="form-select" id="brand" name="brand">
                                                        <option value="">Tất cả thương hiệu</option>
                                                        <c:forEach var="brand" items="${brandList}">
                                                            <option value="${brand.brandName}" ${param.brand == brand.brandName ? 'selected' : ''}>
                                                                ${brand.brandName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="type" class="form-label">Loại sản phẩm</label>
                                                    <select class="form-select" id="type" name="type">
                                                        <option value="">Tất cả loại</option>
                                                        <c:forEach var="type" items="${typeList}">
                                                            <option value="${type.typeName}" ${param.type == type.typeName ? 'selected' : ''}>
                                                                ${type.typeName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="cate" class="form-label">Danh mục</label>
                                                    <select class="form-select" id="cate" name="cate">
                                                        <option value="">Tất cả danh mục</option>
                                                        <c:forEach var="category" items="${categoryList}">
                                                            <option value="${category.categoryName}" ${param.cate == category.categoryName ? 'selected' : ''}>
                                                                ${category.categoryName}
                                                            </option>
                                                        </c:forEach>
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
                                        <th scope="col">Tên sản phẩm</th>
                                        <th scope="col">Mã SKU</th>
                                        <th scope="col">Danh mục</th>
                                        <th scope="col">Thương hiệu</th>
                                        <th scope="col">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listP}" var="product">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="contacusercheck${product.productId}">
                                                    <label class="form-check-label" for="contacusercheck${product.productId}"></label>
                                                </div>
                                            </th>
                                            <td>
                                                <img src="../api/img/${product.imageMainProduct}" alt="" class="avatar-sm rounded-circle me-2">
                                                <a class="text-body">${product.productName}</a>
                                            </td>
                                            <td>${product.sku}</td>
                                            <td>
                                                <c:forEach var="category" items="${product.categories}" varStatus="loop">
                                                    ${category.categoryName}${loop.last ? '' : ', '}
                                                </c:forEach>
                                            </td>
                                            <td>${product.brand.brandName}</td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" href="addAttributeProduct?productID=${product.productId}">Thêm thuộc tính</a></li>
                                                        <li><a class="dropdown-item" href="galleryProduct?productID=${product.productId}">Xem ảnh sản phẩm</a></li>
                                                        <li><a class="dropdown-item" href="editGroupProduct?productId=${product.productId}">Chỉnh sửa sản phẩm</a></li>
                                                        <li><a class="dropdown-item" href="listProductAdmin?productName=${product.productName}">Xem list sản phẩm</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="row">
                            <div class="col-sm-12 col-md-5">
                                <div class="dataTables_info" role="status" aria-live="polite">
                                    Hiển thị từ <strong>${startRecord}</strong> đến <strong>${endRecord}</strong> trong tổng số <strong>${totalRecords}</strong> kết quả
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination justify-content-end">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <c:choose>
                                                <c:when test="${currentPage == 1}">
                                                    <span class="page-link"><i class="mdi mdi-chevron-left"></i></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <a class="page-link" href="?page=${currentPage - 1}&productName=${param.productName}&brand=${param.brand}&type=${param.type}&cate=${param.cate}">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1&productName=${param.productName}&brand=${param.brand}&type=${param.type}&cate=${param.cate}">1</a>
                                            </li>
                                            <c:if test="${currentPage > 4}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            </c:if>
                                            <c:forEach var="i" begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" 
                                                       end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <span class="page-link">${i}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="page-link" href="?page=${i}&productName=${param.productName}&brand=${param.brand}&type=${param.type}&cate=${param.cate}">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages - 2}">
                                            <c:if test="${currentPage < totalPages - 3}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${totalPages}&productName=${param.productName}&brand=${param.brand}&type=${param.type}&cate=${param.cate}">${totalPages}</a>
                                            </li>
                                        </c:if>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}>
                                            <c:choose>
                                                <c:when test="${currentPage == totalPages}">
                                                    <span class="page-link"><i class="mdi mdi-chevron-right"></i></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="page-link" href="?page=${currentPage + 1}&productName=${param.productName}&brand=${param.brand}&type=${param}&cate=${param.cate}">
                                                        <i class="mdi mdi-chevron-right"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
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
                function clearForm() {
                    document.getElementById("productName").value = "";
                    document.getElementById("brand").value = "";
                    document.getElementById("type").value = "";
                    document.getElementById("cate").value = "";
                    window.location = "listGroupProduct";}
            </script>


        </div>
    </body>
</html>