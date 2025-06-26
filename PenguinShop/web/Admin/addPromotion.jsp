<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-container .form-label {
            font-weight: bold;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div id="layout-wrapper">
        <jsp:include page="Common/Header.jsp"/>
        <jsp:include page="Common/LeftSideBar.jsp"/>

        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0 font-size-18">Thêm Khuyến Mãi Mới</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="promotion">Khuyến Mãi</a></li>
                                        <li class="breadcrumb-item active">Thêm Mới</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-container">
                        <form action="addPromotion" method="post" id="addPromotionForm">
                            <input type="hidden" name="action" value="add">

                            <div class="mb-3">
                                <label for="promotionName" class="form-label">Tên Khuyến Mãi</label>
                                <input type="text" class="form-control" id="promotionName" name="promotionName" required>
                                <c:if test="${not empty errors.promotionName}">
                                    <span class="error-message">${errors.promotionName}</span>
                                </c:if>
                                <c:if test="${not empty errors.general}">
                                    <span class="error-message">${errors.general}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="discountType" class="form-label">Loại Giảm</label>
                                <select class="form-select" id="discountType" name="discountType" required>
                                    <option value="PERCENTAGE">Phần trăm</option>
                                    <option value="FIXED">Cố định</option>
                                </select>
                                <c:if test="${not empty errors.discountType}">
                                    <span class="error-message">${errors.discountType}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="discountValue" class="form-label">Giá Trị Giảm</label>
                                <input type="number" step="0.01" class="form-control" id="discountValue" name="discountValue" required>
                                <c:if test="${not empty errors.discountValue}">
                                    <span class="error-message">${errors.discountValue}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="startDate" class="form-label">Ngày Bắt Đầu</label>
                                <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                                <c:if test="${not empty errors.startDate}">
                                    <span class="error-message">${errors.startDate}</span>
                                </c:if>
                                <c:if test="${not empty errors.date}">
                                    <span class="error-message">${errors.date}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="endDate" class="form-label">Ngày Kết Thúc</label>
                                <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                                <c:if test="${not empty errors.endDate}">
                                    <span class="error-message">${errors.endDate}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="isActive" class="form-label">Trạng Thái</label>
                                <select class="form-select" id="isActive" name="isActive" required>
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Ngừng hoạt động</option>
                                </select>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary">Thêm Khuyến Mãi</button>
                                <a href="promotion" class="btn btn-secondary">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <script>
            document.getElementById('addPromotionForm').addEventListener('submit', function(e) {
                const startDate = new Date(document.getElementById('startDate').value);
                const endDate = new Date(document.getElementById('endDate').value);
                const discountValue = parseFloat(document.getElementById('discountValue').value);

                if (endDate <= startDate) {
                    e.preventDefault();
                    alert('Ngày kết thúc phải lớn hơn ngày bắt đầu.');
                }

                if (discountValue <= 0) {
                    e.preventDefault();
                    alert('Giá trị giảm phải lớn hơn 0.');
                }
            });
        </script>
    </body>
</html>