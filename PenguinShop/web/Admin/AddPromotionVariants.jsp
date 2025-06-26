<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .table-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
        .search-form {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div id="layout-wrapper">
        <jsp:include page="Common/Header.jsp"/>
        <jsp:include page="Common/LeftSideBar.jsp"/>

        <div class="main-content">
            <fmt:setLocale value="vi_VN" />
            <div class="page-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0 font-size-18">Quản Lý Variant Khuyến Mãi</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="promotion">Khuyến Mãi</a></li>
                                        <li class="breadcrumb-item active">Thêm Variant</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-container">
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${sessionScope.errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                <c:remove var="errorMessage" scope="session"/>
                            </div>
                        </c:if>

                        <form class="search-form" action="${pageContext.request.contextPath}/admin/promotionVariant" method="get">
                            <input type="hidden" name="promotionID" value="${promotionID}">
                            <div class="row">
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="productName" placeholder="Tên sản phẩm" value="${param.productName}">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="colorName" placeholder="Màu sắc" value="${param.colorName}">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="sizeName" placeholder="Kích cỡ" value="${param.sizeName}">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="stockStatus" placeholder="Trạng thái kho" value="${param.stockStatus}">
                                </div>
                                
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                 </div>
                                <div class="col-md-2">
                                      <a href="${pageContext.request.contextPath}/admin/promotionVariant?promotionID=${promotionID}" class="btn btn-secondary">Xóa bộ lọc</a>
                                </div>
                            </div>
                        </form>

                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Chọn</th>
                                    <th>Sản Phẩm</th>
                                    <th>Màu Sắc</th>
                                    <th>Kích Cỡ</th>
                                    <th>Giá</th>
                                    <th>Số Lượng</th>
                                    <th>Trạng Thái Kho</th>
                                    <th>Loại Sản Phẩm</th>
                                    <th>Thương Hiệu</th>
                                    <th>Danh Mục</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${variants}" var="variant">
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="variant-checkbox" 
                                                   data-variant-id="${variant.variantID}"
                                                   ${variantIDs.contains(variant.variantID) ? 'checked' : ''}>
                                        </td>
                                        <td>${variant.product.productName}</td>
                                        <td>${variant.color.colorName}</td>
                                        <td>${variant.size.sizeName}</td>
                                        <td><fmt:formatNumber value="${variant.price}" type="number" groupingUsed="true" maxFractionDigits="0" /></td>
                                        <td>${variant.quantity}</td>
                                        <td>${variant.stockStatus}</td>
                                        <td>${variant.product.type.typeName}</td>
                                        <td>${variant.product.brand.brandName}</td>
                                        <td>${variant.product.category.categoryName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${page > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/promotionVariant?promotionID=${promotionID}&page=${page - 1}&productName=${param.productName}&colorName=${param.colorName}&sizeName=${param.sizeName}&stockStatus=${param.stockStatus}&quantity=${param.quantity}&productTypeName=${param.productTypeName}&brandName=${param.brandName}&categoryName=${param.categoryName}">Trước</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == page ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/promotionVariant?promotionID=${promotionID}&page=${i}&productName=${param.productName}&colorName=${param.colorName}&sizeName=${param.sizeName}&stockStatus=${param.stockStatus}&quantity=${param.quantity}&productTypeName=${param.productTypeName}&brandName=${param.brandName}&categoryName=${param.categoryName}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${page < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/promotionVariant?promotionID=${promotionID}&page=${page + 1}&productName=${param.productName}&colorName=${param.colorName}&sizeName=${param.sizeName}&stockStatus=${param.stockStatus}&quantity=${param.quantity}&productTypeName=${param.productTypeName}&brandName=${param.brandName}&categoryName=${param.categoryName}">Sau</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>

                        <div class="text-end">
                            <a href="${pageContext.request.contextPath}/promotion" class="btn btn-secondary">Quay Lại</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <script>
            // Đảm bảo jQuery được load trước khi dùng
            jQuery(document).ready(function($) {
                $('.variant-checkbox').on('change', function() {
                    const variantID = $(this).data('variant-id');
                    const promotionID = ${promotionID};
                    const action = $(this).is(':checked') ? 'add' : 'remove';
                    const $checkbox = $(this);

                    $.ajax({
                        url: '${pageContext.request.contextPath}/admin/promotionVariant',
                        type: 'POST',
                        data: {
                            action: action,
                            promotionID: promotionID,
                            variantID: variantID
                        },
                        success: function(response) {
                            if (typeof response === 'string') {
                                try {
                                    
                                    response = JSON.parse(response);
                                    toastr.success('Update variant cho promotion thành công!');
                                } catch (e) {
                                    toastr.error('Lỗi dữ liệu trả về từ server!');
                                    $checkbox.prop('checked', !$checkbox.is(':checked'));
                                    return;
                                }
                            }

                            if (!response.success) {
                                toastr.error('Lỗi: ' + (response.error || 'Không thể cập nhật liên kết variant.'));
                                $checkbox.prop('checked', !$checkbox.is(':checked'));
                            }
                        },
                        error: function(xhr, status, error) {
                            toastr.error('Lỗi kết nối server: ' + error);
                            $checkbox.prop('checked', !$checkbox.is(':checked'));
                        }
                    });
                });
            });
        </script>
    </body>
</html>