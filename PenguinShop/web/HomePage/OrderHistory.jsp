<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="css/order-status.css"> <!-- Link tới file CSS riêng -->
        <style>
            /* Enhanced Table Styles */
            .orders-container {
                background-color: #f8f9fa;
                min-height: 100vh;
                padding: 20px 0;
            }

            .order-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                margin-bottom: 20px;
                overflow: hidden;
                transition: all 0.3s ease;
                border: 1px solid #e3e6f0;
            }

            .order-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.12);
            }

            .order-header {
                background: linear-gradient(135deg, #AE1C9A 0%, #d63384 100%);
                color: white;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }

            .order-info {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .order-id {
                font-size: 18px;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .order-date {
                font-size: 14px;
                opacity: 0.9;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .order-actions {
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: wrap;
            }

            .order-body {
                padding: 25px;
            }

            .order-summary {
                display: grid;
                grid-template-columns: 1fr 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .summary-item {
                text-align: center;
                padding: 15px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            .summary-item i {
                font-size: 24px;
                color: #AE1C9A;
                margin-bottom: 8px;
            }

            .summary-label {
                font-size: 12px;
                color: #6c757d;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .summary-value {
                font-size: 16px;
                font-weight: bold;
                color: #2c3e50;
                margin-top: 5px;
            }

            .order-total {
                font-size: 20px;
                font-weight: bold;
                color: #AE1C9A;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #e9ecef;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .btn-primary {
                background: linear-gradient(135deg, #AE1C9A 0%, #d63384 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(174, 28, 154, 0.3);
            }

            .btn-success {
                background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
                color: white;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 184, 148, 0.3);
            }

            .btn-warning {
                background: linear-gradient(135deg, #fdcb6e 0%, #e17055 100%);
                color: white;
            }

            .btn-warning:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(253, 203, 110, 0.3);
            }

            .btn-danger {
                background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%);
                color: white;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(253, 121, 168, 0.3);
            }

            .btn-outline {
                background: transparent;
                border: 2px solid #AE1C9A;
                color: #AE1C9A;
            }

            .btn-outline:hover {
                background: #AE1C9A;
                color: white;
            }

            .order-details {
                display: none;
                margin-top: 20px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid #AE1C9A;
            }

            .detail-item {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 15px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
            }

            .detail-item:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .detail-item:last-child {
                margin-bottom: 0;
            }

            .detail-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                margin-right: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .detail-info {
                flex: 1;
            }

            .detail-info h6 {
                margin: 0 0 8px 0;
                color: #2c3e50;
                font-weight: bold;
                font-size: 16px;
            }

            .detail-info p {
                margin: 4px 0;
                color: #6c757d;
                font-size: 14px;
            }

            .detail-price {
                color: #AE1C9A !important;
                font-weight: bold !important;
                font-size: 16px !important;
            }

            .search-form {
                background: white;
                padding: 25px;
                border-radius: 12px;
                margin-bottom: 30px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
            }

            .search-form h5 {
                margin-bottom: 20px;
                color: #2c3e50;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .form-row {
                display: flex;
                gap: 20px;
                align-items: end;
                flex-wrap: wrap;
            }

            .form-group {
                flex: 1;
                min-width: 200px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #495057;
            }

            .form-group input {
                width: 100%;
                padding: 12px;
                border: 2px solid #e9ecef;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                outline: none;
                border-color: #AE1C9A;
                box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
            }

            .form-group textarea {
                width: 100%;
                padding: 12px;
                border: 2px solid #e9ecef;
                border-radius: 6px;
                font-size: 14px;
                resize: vertical;
                transition: all 0.3s ease;
            }

            .form-group textarea:focus {
                outline: none;
                border-color: #AE1C9A;
                box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 60px 30px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            }

            .empty-state i {
                font-size: 64px;
                color: #e9ecef;
                margin-bottom: 20px;
            }

            .empty-state h4 {
                color: #6c757d;
                margin-bottom: 10px;
            }

            .empty-state p {
                color: #adb5bd;
            }

            /* Pagination */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin: 40px 0;
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .pagination li a {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 45px;
                height: 45px;
                padding: 0 15px;
                text-decoration: none;
                color: #495057;
                font-weight: 500;
                transition: all 0.3s ease;
                border-right: 1px solid #e9ecef;
            }

            .pagination li:last-child a {
                border-right: none;
            }

            .pagination li.active a {
                background: #AE1C9A;
                color: white;
            }

            .pagination li a:hover:not(.active) {
                background: #f8f9fa;
                color: #AE1C9A;
            }

            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                backdrop-filter: blur(5px);
            }

            .modal-content {
                background-color: white;
                margin: 5% auto;
                padding: 30px;
                border-radius: 12px;
                width: 90%;
                max-width: 800px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                animation: modalSlideIn 0.3s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid #e9ecef;
            }

            .modal-header h4 {
                margin: 0;
                color: #2c3e50;
            }

            .close {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: #adb5bd;
                transition: color 0.3s ease;
            }

            .close:hover {
                color: #495057;
            }

            /* Additional styles for star rating */
            .star-rating {
                display: flex;
                gap: 5px;
                margin: 10px 0;
            }

            .star-rating i {
                font-size: 24px;
                cursor: pointer;
                transition: all 0.2s ease;
                color: #e9ecef;
            }

            .star-rating i:hover {
                transform: scale(1.1);
            }

            /* Enhanced alert styles */
            .alert {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                min-width: 300px;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                animation: slideInRight 0.3s ease-out;
            }

            @keyframes slideInRight {
                from {
                    opacity: 0;
                    transform: translateX(100%);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .alert-success {
                background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
                color: white;
            }

            .alert-error {
                background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%);
                color: white;
            }

            .alert-info {
                background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
                color: white;
            }

            /* Enhanced button hover effects */
            .btn::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                border-radius: 50%;
                background: rgba(255,255,255,0.3);
                transition: all 0.3s ease;
                transform: translate(-50%, -50%);
            }

            .btn:hover::before {
                width: 100%;
                height: 100%;
            }

            /* Loading states */
            .btn:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }

            .btn:disabled:hover {
                transform: none;
                box-shadow: none;
            }

            .pagination li.disabled span {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 45px;
                height: 45px;
                padding: 0 15px;
                color: #adb5bd;
                font-weight: 600;
                background-color: #f8f9fa;
                border-right: 1px solid #e9ecef;
            }

            /* Image upload and preview styles */
            .image-upload-container {
                margin-top: 15px;
            }

            .image-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }

            .preview-image {
                position: relative;
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 6px;
                border: 2px solid #e9ecef;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .remove-image {
                position: absolute;
                top: -8px;
                right: -8px;
                background: #e84393;
                color: white;
                border: none;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 12px;
                transition: all 0.3s ease;
            }

            .remove-image:hover {
                background: #fd79a8;
                transform: scale(1.1);
            }

            /* Additional styles for multi-product review modal */
            .product-review {
                border-bottom: 1px solid #e9ecef;
                padding: 20px 0;
            }

            .product-review:last-child {
                border-bottom: none;
            }

            .product-review-header {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 15px;
            }

            .product-review-header img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 6px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .product-review-header h6 {
                margin: 0;
                font-size: 16px;
                color: #2c3e50;
                font-weight: bold;
            }

            .product-review-header p {
                margin: 4px 0 0 0;
                font-size: 14px;
                color: #6c757d;
            }

            @media (max-width: 768px) {
                .order-summary {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }

                .order-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .order-actions {
                    width: 100%;
                    justify-content: flex-start;
                }

                .form-row {
                    flex-direction: column;
                    gap: 15px;
                }

                .form-group {
                    min-width: unset;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .btn {
                    justify-content: center;
                    width: 100%;
                }

                .detail-item {
                    flex-direction: column;
                    text-align: center;
                    gap: 15px;
                }

                .detail-image {
                    margin-right: 0;
                    margin-bottom: 10px;
                }

                .preview-image {
                    width: 80px;
                    height: 80px;
                }
            }
        </style>
    </head>
    <body>
        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp" />

        <!---------------user-profile-section--------------->
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">
                    <div class="user-dashboard">
                        <jsp:include page="Common/CommonUser.jsp" />
                        <div class="nav-content" id="v-pills-tabContent" style="flex: 1 0%;">
                            <div class="tab-pane orders-container" id="v-pills-review" role="tabpanel" aria-labelledby="v-pills-review-tab" tabindex="0">

                                <!-- Display Success/Error Messages -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success">
                                        <i class="fas fa-check-circle"></i> ${successMessage}
                                    </div>
                                    <c:remove var="successMessage" scope="session"/>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-error">
                                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                    </div>
                                    <c:remove var="errorMessage" scope="session"/>
                                </c:if>

                                <!-- Search Form -->
                                <div class="search-form">
                                    <h5 style="font-size: 20px"><i class="fas fa-search"></i> Tìm kiếm đơn hàng</h5>
                                    <form method="get" action="">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label style="font-size: 16px" for="fromDate">Từ ngày:</label>
                                                <input type="date" id="fromDate" name="from" value="${param.from}">
                                            </div>
                                            <div class="form-group">
                                                <label style="font-size: 16px" for="toDate">Đến ngày:</label>
                                                <input type="date" id="toDate" name="to" value="${param.to}">
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search"></i> Tìm kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <!-- Orders List -->
                                <c:choose>
                                    <c:when test="${empty orders}">
                                        <div class="empty-state">
                                            <i class="fas fa-shopping-bag"></i>
                                            <h4>Không có đơn hàng nào</h4>
                                            <p>Bạn chưa có đơn hàng nào trong khoảng thời gian này.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="order" items="${orders}" varStatus="orderStatus">
                                            <div class="order-card">
                                                <!-- Order Header -->
                                                <div class="order-header">
                                                    <div class="order-info">
                                                        <div class="order-id">
                                                            <i class="fas fa-receipt"></i>
                                                            Đơn hàng #${order.orderID}
                                                        </div>
                                                        <div class="order-date">
                                                            <i class="far fa-calendar-alt"></i>
                                                            ${order.orderDate}
                                                        </div>
                                                    </div>
                                                    <div style="font-size: 16px" class="order-actions">
                                                        <c:set var="cssClass" value="status-Loi" />
                                                        <c:if test="${order.orderStatus == 0}">
                                                            <c:set var="cssClass" value="status-DaHuy" />
                                                        </c:if>
                                                        <c:if test="${order.orderStatus == 3}">
                                                            <c:set var="cssClass" value="status-GiaoHangThanhCong" />
                                                        </c:if>
                                                        <c:if test="${order.orderStatus == 2}">
                                                            <c:set var="cssClass" value="status-DangGiao" />
                                                        </c:if>
                                                        <c:if test="${order.orderStatus == 4}">
                                                            <c:set var="cssClass" value="status-HoanHang" />
                                                        </c:if>
                                                        <c:if test="${order.orderStatus == 1}">
                                                            <c:set var="cssClass" value="status-DangChoXuLi" />
                                                        </c:if>
                                                        <c:if test="${order.orderStatus == 5}">
                                                            <c:set var="cssClass" value="status-DaXacNhan" />
                                                        </c:if>
                                                        <span class="order-status ${cssClass}">
                                                            <c:if test="${order.orderStatus == 0}">
                                                                <i class="fas fa-times-circle"></i> Đã Hủy
                                                            </c:if>
                                                            <c:if test="${order.orderStatus == 3}">
                                                                <i class="fas fa-check-circle"></i> Giao Hàng Thành công
                                                            </c:if>
                                                            <c:if test="${order.orderStatus == 2}">
                                                                <i class="fas fa-truck"></i> Đang Giao
                                                            </c:if>
                                                            <c:if test="${order.orderStatus == 4}">
                                                                <i class="fas fa-undo"></i> Hoàn Hàng
                                                            </c:if>
                                                            <c:if test="${order.orderStatus == 1}">
                                                                <i class="fas fa-clock"></i> Đang Chờ Xử Lí
                                                            </c:if>
                                                            <c:if test="${order.orderStatus == 5}">
                                                                <i class="fas fa-cog fa-spin"></i> Đã Xác Nhận
                                                            </c:if>
                                                            <c:if test="${order.orderStatus != 0 && order.orderStatus != 3 && order.orderStatus != 2 && order.orderStatus != 4 && order.orderStatus != 1 && order.orderStatus != 5}">
                                                                <i class="fas fa-exclamation-circle"></i> Lỗi
                                                            </c:if>
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- Order Body -->
                                                <div class="order-body">
                                                    <!-- Order Summary -->
                                                    <div class="order-summary">
                                                        <div class="summary-item">
                                                            <i class="fas fa-map-marker-alt"></i>
                                                            <div class="summary-label">Địa chỉ giao hàng</div>
                                                            <div class="summary-value">${order.shippingAddress}</div>
                                                        </div>
                                                        <div class="summary-item">
                                                            <i class="fas fa-boxes"></i>
                                                            <div class="summary-label">Số lượng sản phẩm</div>
                                                            <div class="summary-value">${order.orderDetails.size()} sản phẩm</div>
                                                        </div>
                                                        <div class="summary-item">
                                                            <i class="fas fa-money-bill-wave"></i>
                                                            <div class="summary-label">Tổng tiền</div>
                                                            <div class="summary-value order-total">${order.total} VND</div>
                                                        </div>
                                                    </div>

                                                    <!-- Action Buttons -->
                                                    <div class="action-buttons">
                                                        <button class="btn btn-primary" onclick="toggleOrderDetails(${orderStatus.index})">
                                                            <i class="fas fa-eye"></i> Xem chi tiết
                                                        </button>

                                                        <c:if test="${order.orderStatus == 3}">
                                                            <button class="btn btn-warning" onclick="openReviewModal(${order.orderID})">
                                                                <i class="fas fa-star"></i> Đánh giá
                                                            </button>
                                                        </c:if>

                                                        <c:if test="${order.orderStatus == 1 || order.orderStatus == 5}">
                                                            <button class="btn btn-danger" onclick="cancelOrder(${order.orderID})">
                                                                <i class="fas fa-times"></i> Hủy đơn hàng
                                                            </button>
                                                        </c:if>

                                                        <c:if test="${order.orderStatus == 2}">
                                                            <button class="btn btn-success" onclick="trackOrder(${order.orderID})">
                                                                <i class="fas fa-map-marked-alt"></i> Theo dõi đơn hàng
                                                            </button>
                                                        </c:if>

                                                        <button class="btn btn-outline">
                                                            <i class="fas fa-download"></i> Xuất hóa đơn
                                                        </button>
                                                    </div>

                                                    <!-- Order Details -->
                                                    <div id="orderDetails_${orderStatus.index}" class="order-details">
                                                        <h5 style="margin-bottom: 20px; color: #AE1C9A; display: flex; align-items: center; gap: 10px;">
                                                            <i class="fas fa-list-ul"></i> Chi tiết đơn hàng
                                                        </h5>
                                                        <c:forEach var="detail" items="${order.orderDetails}">
                                                            <div class="detail-item">
                                                                <a href="productdetail?id=${detail.variant.variantID}" style="text-decoration: none; color: inherit;">
                                                                    <img class="detail-image" 
                                                                         src="api/img/${detail.variant.product.imageMainProduct}" 
                                                                         alt="${detail.variant.product.productName}">
                                                                </a>
                                                                <div class="detail-info">
                                                                    <h6>${detail.variant.product.productName}</h6>
                                                                    <p><i class="fas fa-cubes"></i> <strong>Số lượng:</strong> ${detail.quantity_product}</p>
                                                                    <p><i class="fas fa-tag"></i> <strong>Giá:</strong> <span class="detail-price">${detail.price} VND</span></p>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="pagination-container">
                                        <ul class="pagination">
                                            <c:if test="${currentPage > 1}">
                                                <li>
                                                    <a href="?page=${currentPage - 1}${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">
                                                        <i class="fas fa-chevron-left"></i> 
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:if test="${currentPage > 3}">
                                                <li><a href="?page=1${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">1</a></li>
                                                <li class="disabled"><span>...</span></li>
                                            </c:if>

                                            <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}">
                                                <c:if test="${i >= 1 && i <= totalPages}">
                                                    <c:if test="${i == currentPage}">
                                                        <li class="active"><a href="?page=${i}${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">${i}</a></li>
                                                    </c:if>
                                                    <c:if test="${i != currentPage}">
                                                        <li><a href="?page=${i}${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">${i}</a></li>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${currentPage + 2 < totalPages}">
                                                <li class="disabled"><span>...</span></li>
                                                <li><a href="?page=${totalPages}${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">${totalPages}</a></li>
                                            </c:if>

                                            <c:if test="${currentPage < totalPages}">
                                                <li>
                                                    <a href="?page=${currentPage + 1}${not empty param.from ? '&from=' + param.from : ''}${not empty param.to ? '&to=' + param.to : ''}">
                                                        <i class="fas fa-chevron-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Review Modal -->
        <div id="reviewModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 style="font-size: 25px"><i class="fas fa-star"></i> Đánh giá sản phẩm</h4>
                    <button class="close" onclick="closeReviewModal()">×</button>
                </div>
                <div class="modal-body">
                    <form id="reviewForm" enctype="multipart/form-data">
                        <input type="hidden" name="orderId" id="orderId">
                        <div id="productReviews"></div>
                        <div class="action-buttons" style="margin-top: 20px; padding-top: 0; border-top: none;">
                            <button type="button" class="btn btn-primary" onclick="submitReview()">
                                <i class="fas fa-paper-plane"></i> Gửi tất cả đánh giá
                            </button>
                            <button type="button" class="btn btn-outline" onclick="closeReviewModal()">
                                <i class="fas fa-times"></i> Hủy bỏ
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--------------- footer-section --------------->
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />

        <script>
            let selectedImages = {}; // Store images per variantId
            let selectedRatings = {}; // Store ratings per variantId

            function toggleOrderDetails(index) {
                const detailsDiv = document.getElementById('orderDetails_' + index);
                const button = event.target.closest('button');
                const icon = button.querySelector('i');

                if (detailsDiv.style.display === 'none' || detailsDiv.style.display === '') {
                    detailsDiv.style.display = 'block';
                    button.innerHTML = '<i class="fas fa-eye-slash"></i> Ẩn chi tiết';
                } else {
                    detailsDiv.style.display = 'none';
                    button.innerHTML = '<i class="fas fa-eye"></i> Xem chi tiết';
                }
            }

            function cancelOrder(orderID) {
                if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) {
                    const button = event.target.closest('button');
                    const originalText = button.innerHTML;

                    button.innerHTML = '<div class="loading"></div> Đang hủy...';
                    button.disabled = true;

                    setTimeout(() => {
                        alert('Đơn hàng đã được hủy thành công!');
                        location.reload();
                    }, 2000);
                }
            }

            function trackOrder(orderID) {
                alert('Chức năng theo dõi đơn hàng sẽ được phát triển trong phiên bản tiếp theo!');
            }

            async function openReviewModal(orderId) {
                document.getElementById('reviewModal').style.display = 'block';
                document.getElementById('orderId').value = orderId;
                selectedImages = {};
                selectedRatings = {};
                const productReviewsDiv = document.getElementById('productReviews');
                productReviewsDiv.innerHTML = '<div class="loading">Đang tải sản phẩm...</div>';

                try {
                    // Fetch order details
                    const response = await fetch(`/PenguinShop/api/order-details?orderId=${orderId}`);
                    const orderDetails = await response.json();

                    if (!orderDetails || orderDetails.length === 0) {
                        productReviewsDiv.innerHTML = '<p>Không có sản phẩm để đánh giá.</p>';
                        return;
                    }

                    productReviewsDiv.innerHTML = '';
                    orderDetails.forEach((detail, index) => {
                        const productReview = document.createElement('div');
                        productReview.className = 'product-review';
                        productReview.innerHTML = `
                            <div class="product-review-header">
                                <img src="api/img/${detail.imageMainProduct}" alt="${detail.productName}">
                                <div>
                                    <h6>${detail.productName}</h6>
                                    <p>Kích cỡ: ${detail.sizeName}, Màu: ${detail.colorName}</p>
                                </div>
                            </div>
                            <input type="hidden" name="variantId[]" value="${detail.variantId}">
                            <div class="form-group">
                                <label style="font-size: 18px">Đánh giá:</label>
                                <div class="star-rating" data-variant-id="${detail.variantId}">
                                    <i class="far fa-star" data-rating="1"></i>
                                    <i class="far fa-star" data-rating="2"></i>
                                    <i class="far fa-star" data-rating="3"></i>
                                    <i class="far fa-star" data-rating="4"></i>
                                    <i class="far fa-star" data-rating="5"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <label style="font-size: 18px" for="comment_${detail.variantId}">Nhận xét:</label>
                                <textarea id="comment_${detail.variantId}" name="comment[]" rows="4" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                            </div>
                            <div class="form-group image-upload-container">
                                <label style="font-size: 18px" for="images_${detail.variantId}">Hình ảnh (tối đa 5 ảnh):</label>
                                <input type="file" id="images_${detail.variantId}" name="images_${detail.variantId}[]" accept="image/*" multiple>
                                <div id="imagePreview_${detail.variantId}" class="image-preview"></div>
                            </div>
                        `;
                        productReviewsDiv.appendChild(productReview);

                        // Initialize star rating for this product
                        const starRatingDiv = productReview.querySelector('.star-rating');
                        starRatingDiv.querySelectorAll('i').forEach((star, starIndex) => {
                            star.addEventListener('click', () => {
                                selectedRatings[detail.variantId] = starIndex + 1;
                                updateStarDisplay(detail.variantId);
                            });
                            star.addEventListener('mouseover', () => {
                                highlightStars(detail.variantId, starIndex + 1);
                            });
                        });
                        starRatingDiv.addEventListener('mouseleave', () => {
                            updateStarDisplay(detail.variantId);
                        });

                        // Handle image upload for this product
                        const imageInput = productReview.querySelector(`#images_${detail.variantId}`);
                        imageInput.addEventListener('change', function () {
                            const files = Array.from(this.files);
                            const previewContainer = document.getElementById(`imagePreview_${detail.variantId}`);

                            if (!selectedImages[detail.variantId]) {
                                selectedImages[detail.variantId] = [];
                            }

                            if (selectedImages[detail.variantId].length + files.length > 5) {
                                alert('Chỉ được tải lên tối đa 5 ảnh cho mỗi sản phẩm!');
                                this.value = '';
                                return;
                            }

                            files.forEach(file => {
                                if (!file.type.startsWith('image/')) {
                                    alert('Vui lòng chỉ tải lên file ảnh!');
                                    this.value = '';
                                    return;
                                }
                                selectedImages[detail.variantId].push(file);
                            });

                            // Update previews
                            previewContainer.innerHTML = '';
                            selectedImages[detail.variantId].forEach((file, fileIndex) => {
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    const imgContainer = document.createElement('div');
                                    imgContainer.style.position = 'relative';
                                    const img = document.createElement('img');
                                    img.src = e.target.result;
                                    img.className = 'preview-image';
                                    imgContainer.appendChild(img);

                                    const removeBtn = document.createElement('button');
                                    removeBtn.className = 'remove-image';
                                    removeBtn.innerHTML = '×';
                                    removeBtn.onclick = () => {
                                        selectedImages[detail.variantId].splice(fileIndex, 1);
                                        imgContainer.remove();
                                        const dataTransfer = new DataTransfer();
                                        selectedImages[detail.variantId].forEach(f => dataTransfer.items.add(f));
                                        imageInput.files = dataTransfer.files;
                                    };
                                    imgContainer.appendChild(removeBtn);

                                    previewContainer.appendChild(imgContainer);
                                };
                                reader.readAsDataURL(file);
                            });
                        });
                    });
                } catch (err) {
                    console.error('Error fetching order details:', err);
                    productReviewsDiv.innerHTML = '<p>Lỗi khi tải danh sách sản phẩm.</p>';
                }
            }

            function closeReviewModal() {
                document.getElementById('reviewModal').style.display = 'none';
                selectedImages = {};
                selectedRatings = {};
                document.getElementById('productReviews').innerHTML = '';
                document.getElementById('reviewForm').reset();
            }

            async function submitReview() {
                const orderId = document.getElementById('orderId').value;
                const variantIds = Array.from(document.querySelectorAll('input[name="variantId[]"]')).map(input => input.value);
                const ratings = Array.from(document.querySelectorAll('.star-rating')).map((div, index) => selectedRatings[variantIds[index]] || 0);
                const comments = Array.from(document.querySelectorAll('textarea[name="comment[]"]')).map(textarea => textarea.value);

                // Validate inputs
                for (let i = 0; i < variantIds.length; i++) {
                    if (ratings[i] === 0) {
                        alert(`Vui lòng chọn số sao đánh giá cho sản phẩm ${i + 1}!`);
                        return;
                    }
                    if (!comments[i].trim()) {
                        alert(`Vui lòng nhập nhận xét cho sản phẩm ${i + 1}!`);
                        return;
                    }
                }

                const submitBtn = event.target;
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<div class="loading"></div> Đang gửi...';
                submitBtn.disabled = true;

                try {
                    const formData = new FormData();
                    formData.append('orderId', orderId);
                    variantIds.forEach((variantId, index) => {
                        formData.append('variantId[]', variantId);
                        formData.append('rating[]', ratings[index]);
                        formData.append('comment[]', comments[index]);
                        if (selectedImages[variantId]) {
                            selectedImages[variantId].forEach(file => {
                                formData.append(`images_${variantId}[]`, file);
                            });
                        }
                    });

                    const response = await fetch('/PenguinShop/api/submit-review', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) {
                        throw new Error('Failed to submit reviews');
                    }

                    setTimeout(() => {
                        alert('Cảm ơn bạn đã đánh giá sản phẩm!');
                        closeReviewModal();
                        location.reload();
                    }, 1000);
                } catch (err) {
                    console.error('Submission error:', err);
                    alert('Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại.');
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }
            }

            function updateStarDisplay(variantId) {
                document.querySelectorAll(`.star-rating[data-variant-id="${variantId}"] i`).forEach((star, index) => {
                    if (index < selectedRatings[variantId]) {
                        star.className = 'fas fa-star';
                        star.style.color = '#ffc107';
                    } else {
                        star.className = 'far fa-star';
                        star.style.color = '#e9ecef';
                    }
                });
            }

            function highlightStars(variantId, rating) {
                document.querySelectorAll(`.star-rating[data-variant-id="${variantId}"] i`).forEach((star, index) => {
                    if (index < rating) {
                        star.className = 'fas fa-star';
                        star.style.color = '#ffc107';
                    } else {
                        star.className = 'far fa-star';
                        star.style.color = '#e9ecef';
                    }
                });
            }

            window.addEventListener('click', function (event) {
                const modal = document.getElementById('reviewModal');
                if (event.target === modal) {
                    closeReviewModal();
                }
            });

            document.addEventListener('DOMContentLoaded', function () {
                setTimeout(() => {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(alert => {
                        alert.style.transition = 'opacity 0.5s ease';
                        alert.style.opacity = '0';
                        setTimeout(() => {
                            alert.remove();
                        }, 500);
                    });
                }, 5000);
            });

            function smoothScrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }

            document.getElementById('fromDate').addEventListener('change', function () {
                const toDate = document.getElementById('toDate');
                if (toDate.value && this.value > toDate.value) {
                    alert('Ngày bắt đầu không thể lớn hơn ngày kết thúc!');
                    this.value = '';
                }
            });

            document.getElementById('toDate').addEventListener('change', function () {
                const fromDate = document.getElementById('fromDate');
                if (fromDate.value && this.value < fromDate.value) {
                    alert('Ngày kết thúc không thể nhỏ hơn ngày bắt đầu!');
                    this.value = '';
                }
            });

            document.querySelector('.search-form form').addEventListener('submit', function () {
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<div class="loading"></div> Đang tìm...';
                submitBtn.disabled = true;

                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 1000);
            });

            function addTooltips() {
                const tooltips = {
                    '.btn-danger': 'Hủy đơn hàng này',
                    '.btn-warning': 'Đánh giá sản phẩm',
                    '.btn-success': 'Theo dõi vận chuyển',
                    '.btn-outline': 'Tải xuống hóa đơn PDF'
                };

                Object.keys(tooltips).forEach(selector => {
                    document.querySelectorAll(selector).forEach(element => {
                        element.title = tooltips[selector];
                    });
                });
            }

            document.addEventListener('DOMContentLoaded', addTooltips);
        </script>
    </body>
</html>