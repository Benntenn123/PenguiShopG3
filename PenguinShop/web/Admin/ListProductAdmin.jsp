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
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>

            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách sản phẩm</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Sản phẩm</a></li>
                                            <li class="breadcrumb-item active">Danh sách sản phẩm</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Tổng số sản phẩm <span class="text-muted fw-normal ms-2">(${totalProduct})</span></h5>


                                </div>
                                <div class="mb-3">
                                    <h5 class="card-title">Sản phẩm đang bán <span class="text-muted fw-normal ms-2">(${activePro})</span></h5>
                                </div>
                                <div class="mb-3">
                                    <h5 class="card-title">Sản phẩm dừng bán <span class="text-muted fw-normal ms-2">(${notactivePro})</span></h5>
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

                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm sản phẩm</h5>
                                        <form method="get" action="">
                                            <div class="row g-3">
                                                <div class="col-md-3">
                                                    <label for="productName" class="form-label">Tên sản phẩm</label>
                                                    <input type="text" class="form-control" id="productName" name="productName" 
                                                           placeholder="Nhập tên sản phẩm..." value="${param.productName}">
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="color" class="form-label">Màu sắc</label>
                                                    <select class="form-select" id="color" name="color">
                                                        <option value="">Tất cả màu</option>
                                                        <c:forEach var="color" items="${colorList}">
                                                            <option value="${color.colorName}" ${param.color == color.colorName ? 'selected' : ''}>
                                                                ${color.colorName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="size" class="form-label">Kích cỡ</label>
                                                    <select class="form-select" id="size" name="size">
                                                        <option value="">Tất cả kích cỡ</option>
                                                        <c:forEach var="size" items="${sizeList}">
                                                            <option value="${size.sizeName}" ${param.size == size.sizeName ? 'selected' : ''}>
                                                                ${size.sizeName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="status" class="form-label">Trạng thái tồn kho</label>
                                                    <select class="form-select" name="status">
                                                        <option value="">Tất cả trạng thái</option>
                                                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Còn hàng</option>
                                                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Hết hàng</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="quantity" class="form-label">Số lượng tối thiểu</label>
                                                    <input type="number" class="form-control" id="quantity" name="quantity" 
                                                           placeholder="Nhập số lượng..." value="${param.quantity}" min="0">
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
                                        <th scope="col">Tên sản phẩm</th>
                                        <th scope="col">Cỡ</th>
                                        <th scope="col">Màu</th>
                                        <th scope="col">Tình trạng</th>
                                        <th scope="col">Giá thành</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listP}" var="list">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="contacusercheck1">
                                                    <label class="form-check-label" for="contacusercheck1"></label>
                                                </div>
                                            </th>
                                            <td>
                                                <img src="../api/img/${list.product.imageMainProduct}" alt="" class="avatar-sm rounded-circle me-2">
                                                <a href="variant_details?variantID=${list.variantID}" class="text-body">${list.product.productName}</a>
                                            </td>
                                            <td>${list.size.sizeName}</td>
                                            <td>${list.color.colorName}</td>
                                            <td>${list.stockStatus eq "1" ?'Đang kinh doanh':'Ngừng kinh doanh'}
                                            </td>
                                            <td><fmt:formatNumber value="${list.price}" type="currency" currencyCode="VND"/>
                                            </td>
                                            <td>${list.quantity}
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
                        <a class="page-link" href="?page=${currentPage - 1}&productName=${param.productName}&color=${param.color}&size=${param.size}&status=${param.status}&quantity=${param.quantity}&type=${param.type}&brand=${param.brand}&cate=${param.cate}" tabindex="-1">
                            <i class="mdi mdi-chevron-left"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
            </li>

            <!-- First page -->
            <c:if test="${currentPage > 3}">
                <li class="page-item">
                    <a class="page-link" href="?page=1&productName=${param.productName}&color=${param.color}&size=${param.size}&status=${param.status}&quantity=${param.quantity}&type=${param.type}&brand=${param.brand}&cate=${param.cate}">1</a>
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
                            <a class="page-link" href="?page=${i}&productName=${param.productName}&color=${param.color}&size=${param.size}&status=${param.status}&quantity=${param.quantity}&type=${param.type}&brand=${param.brand}&cate=${param.cate}">${i}</a>
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
                    <a class="page-link" href="?page=${totalPages}&productName=${param.productName}&color=${param.color}&size=${param.size}&status=${param.status}&quantity=${param.quantity}&type=${param.type}&brand=${param.brand}&cate=${param.cate}">${totalPages}</a>
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
                        <a class="page-link" href="?page=${currentPage + 1}&productName=${param.productName}&color=${param.color}&size=${param.size}&status=${param.status}&quantity=${param.quantity}&type=${param.type}&brand=${param.brand}&cate=${param.cate}">
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
        </div>



        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
    function clearForm(){
        document.getElementById('productName').value = '';
        document.getElementById('color').value = '';
        document.getElementById('size').value = '';
        document.getElementById('quantity').value = '';
        document.getElementById('type').value = '';
        document.getElementById('brand').value = '';
        document.getElementById('cate').value = '';
        document.querySelector('form').submit();
        
    };
</script>
    </body>
</html>
