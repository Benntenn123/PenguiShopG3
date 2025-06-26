<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .promotion-table th, .promotion-table td {
                vertical-align: middle;
            }
            .status-active {
                color: green;
                font-weight: bold;
            }
            .status-inactive {
                color: red;
                font-weight: bold;
            }
            .product-count {
                cursor: pointer;
                color: blue;
                text-decoration: underline;
            }
            .modal-dialog {
                max-width: 80vw;
            }
            .modal-body {
                max-height: 60vh;
                overflow-y: auto;
            }
            .edit-modal .modal-dialog {
                max-width: 600px;
            }
        </style>
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
                                    <h4 class="mb-sm-0 font-size-18">Quản Lý Khuyến Mãi</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="#">Khuyến Mãi</a></li>
                                            <li class="breadcrumb-item active">Danh Sách</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <h5 class="card-title">Tổng số khuyến mãi <span class="text-muted fw-normal ms-2">(${totalPromotions})</span></h5>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                                    <div>
                                        <a type="button" class="btn btn-light" href="addPromotion">
                                            <i class="bx bx-plus me-1"></i> Thêm khuyến mãi mới
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive mb-4">
                            <table style="min-height: 150px" class="table align-middle datatable dt-responsive table-check nowrap promotion-table" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 50px;">
                                            <div class="form-check font-size-16">
                                                <input type="checkbox" class="form-check-input" id="checkAll">
                                                <label class="form-check-label" for="checkAll"></label>
                                            </div>
                                        </th>
                                        <th scope="col">Mã KM</th>
                                        <th scope="col">Tên Khuyến Mãi</th>
                                        <th scope="col">Loại Giảm</th>
                                        <th scope="col">Giá Trị</th>
                                        <th scope="col">Ngày Bắt Đầu</th>
                                        <th scope="col">Ngày Kết Thúc</th>
                                        <th scope="col">Số Lượng áp dụng</th>
                                        <th scope="col">Trạng Thái</th>
                                        <th scope="col">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="promotion" items="${promotions}">
                                        <tr>
                                            <th scope="row">
                                                <div class="form-check font-size-16">
                                                    <input type="checkbox" class="form-check-input" id="promotioncheck${promotion.promotionID}">
                                                    <label class="form-check-label" for="promotioncheck${promotion.promotionID}"></label>
                                                </div>
                                            </th>
                                            <td>${promotion.promotionID}</td>
                                            <td>${promotion.promotionName}</td>
                                            <td>${promotion.discountType == 'PERCENTAGE' ? 'Phần trăm' : 'Cố định'}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${promotion.discountType == 'PERCENTAGE'}">
                                                        ${promotion.discountValue} %
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${promotion.discountValue}" type="currency" currencySymbol="₫"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${promotion.startDate}</td>
                                            <td>${promotion.endDate}</td>
                                            <td>
                                                <span class="product-count" data-bs-toggle="modal" data-bs-target="#productModal${promotion.promotionID}">
                                                    ${promotion.totalCount} sản phẩm
                                                </span>
                                            </td>
                                            <td>
                                                <span class="${promotion.isActive == 1 ? 'status-active' : 'status-inactive'}">
                                                    ${promotion.isActive == 1 ? 'Hoạt động' : 'Ngừng hoạt động'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li><a class="dropdown-item" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#editModal${promotion.promotionID}">Sửa</a></li>
                                                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="toggleStatus(${promotion.promotionID}, ${promotion.isActive})">
                                                                ${promotion.isActive == 1 ? 'Ngưng' : 'Kích hoạt'}
                                                            </a></li>
                                                            <li><a class="dropdown-item" href="javascript:void(0);">Thêm sản phẩm giảm giá</a></li>
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
                                                    <a class="page-link" href="?page=${currentPage - 1}">
                                                        <i class="mdi mdi-chevron-left"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <c:if test="${currentPage > 3}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=1">1</a>
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
                                                        <a class="page-link" href="?page=${i}">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages - 2}">
                                            <c:if test="${currentPage < totalPages - 3}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                                </c:if>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${totalPages}">${totalPages}</a>
                                            </li>
                                        </c:if>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <c:choose>
                                                <c:when test="${currentPage == totalPages}">
                                                    <span class="page-link"><i class="mdi mdi-chevron-right"></i></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <a class="page-link" href="?page=${currentPage + 1}">
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

            <!-- Modal hiển thị variant -->
            <c:forEach var="promotion" items="${promotions}">
                <div class="modal fade" id="productModal${promotion.promotionID}" tabindex="-1" aria-labelledby="productModalLabel${promotion.promotionID}" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="productModalLabel${promotion.promotionID}">Danh Sách Variant - ${promotion.promotionName}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Tên Sản Phẩm</th>
                                            <th>Màu sắc</th>
                                            <th>Kích Cỡ</th>
                                            <th>Giá</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="variant" items="${promotion.variant}">
                                            <tr>
                                                <td>${variant.product.productName}</td>
                                                <td>${variant.color.colorName}</td>
                                                <td>${variant.size.sizeName}</td>
                                                <td><fmt:formatNumber value="${variant.price}" type="currency" currencySymbol="₫"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Modal chỉnh sửa khuyến mãi -->
            <c:forEach var="promotion" items="${promotions}">
                <div class="modal fade edit-modal" id="editModal${promotion.promotionID}" tabindex="-1" aria-labelledby="editModalLabel${promotion.promotionID}" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel${promotion.promotionID}">Chỉnh Sửa Khuyến Mãi - ${promotion.promotionName}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="promotion" method="post">
                                    <input type="hidden" name="promotionID" value="${promotion.promotionID}">

                                    <!-- Các trường khác giữ nguyên -->
                                    <div class="mb-3">
                                        <label for="promotionName${promotion.promotionID}" class="form-label">Tên Khuyến Mãi</label>
                                        <input type="text" class="form-control" id="promotionName${promotion.promotionID}" name="promotionName" 
                                               value="${promotion.promotionName}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="discountType${promotion.promotionID}" class="form-label">Loại Giảm</label>
                                        <select class="form-select" id="discountType${promotion.promotionID}" name="discountType" required>
                                            <option value="PERCENTAGE" ${promotion.discountType == 'PERCENTAGE' ? 'selected' : ''}>Phần trăm</option>
                                            <option value="FIXED" ${promotion.discountType == 'FIXED' ? 'selected' : ''}>Cố định</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="discountValue${promotion.promotionID}" class="form-label">Giá Trị Giảm</label>
                                        <input type="number" step="0.01" class="form-control" id="discountValue${promotion.promotionID}" name="discountValue" 
                                               value="${promotion.discountValue}" required>
                                    </div>

                                    <!-- Phần sửa chính: Format ngày giờ đúng cách -->
                                    <div class="mb-3">
                                        <label for="startDate${promotion.promotionID}" class="form-label">Ngày Bắt Đầu</label>
                                        <input type="datetime-local" class="form-control" id="startDate${promotion.promotionID}" name="startDate" 
                                               value="${fn:replace(fn:substring(promotion.startDate, 0, 16), ' ', 'T')}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="endDate${promotion.promotionID}" class="form-label">Ngày Kết Thúc</label>
                                        <input type="datetime-local" class="form-control" id="endDate${promotion.promotionID}" name="endDate" 
                                               value="${fn:replace(fn:substring(promotion.endDate, 0, 16), ' ', 'T')}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description${promotion.promotionID}" class="form-label">Mô Tả</label>
                                        <textarea class="form-control" id="description${promotion.promotionID}" name="description" rows="4">${promotion.description}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="isActive${promotion.promotionID}" class="form-label">Trạng Thái</label>
                                        <select class="form-select" id="isActive${promotion.promotionID}" name="isActive" required>
                                            <option value="1" ${promotion.isActive == 1 ? 'selected' : ''}>Hoạt động</option>
                                            <option value="0" ${promotion.isActive == 0 ? 'selected' : ''}>Ngừng hoạt động</option>
                                        </select>
                                    </div>

                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <jsp:include page="Common/RightSideBar.jsp"/>
            <jsp:include page="Common/Js.jsp"/>
            <jsp:include page="Common/Message.jsp"/>

            <!-- Thay thế phần script cũ bằng code này -->
            <script>
                function toggleStatus(promotionID, isActive) {
                    if (confirm('Bạn có chắc chắn muốn ' + (isActive == 1 ? 'ngưng' : 'kích hoạt') + ' khuyến mãi này?')) {
                        window.location.href = 'promotion?action=toggleStatus&promotionID=' + promotionID + '&isActive=' + isActive;
                    }
                }

                // Function để format date cho datetime-local input
                function formatDateForInput(dateString) {
                    if (!dateString || dateString.trim() === '') {
                        return '';
                    }

                    // Từ "2025-05-26 00:00:00.000" thành "2025-05-26T00:00"
                    const [datePart, timePart] = dateString.split(' ');
                    if (datePart && timePart) {
                        const timeOnly = timePart.substring(0, 5); // Lấy HH:mm
                        return `${datePart}T${timeOnly}`;
                                }
                                return '';
                            }
            </script>
    </body>
</html>