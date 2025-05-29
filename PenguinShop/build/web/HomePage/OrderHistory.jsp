<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <style>
            /* Table Styles */
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                background-color: white;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            .order-table th {
                background-color: #AE1C9A;
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: bold;
                font-size: 16px;
            }

            .order-table td {
                padding: 15px;
                border-bottom: 1px solid #dee2e6;
                vertical-align: top;
            }

            .order-table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .order-table tbody tr:last-child td {
                border-bottom: none;
            }

            .order-date {
                font-weight: bold;
                color: #333;
            }

            .order-status {
                padding: 5px 10px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                display: inline-block;
                min-width: 80px;
            }

            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-processing {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .status-shipped {
                background-color: #d4edda;
                color: #155724;
            }

            .status-delivered {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .status-cancelled {
                background-color: #f8d7da;
                color: #721c24;
            }

            .order-total {
                font-weight: bold;
                color: #AE1C9A;
                font-size: 16px;
            }

            .view-details-btn {
                background-color: #AE1C9A;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-size: 14px;
            }

            .view-details-btn:hover {
                background-color: #8e1680;
            }

            .order-details {
                display: none;
                background-color: #f8f9fa;
                padding: 15px;
                margin-top: 10px;
                border-radius: 6px;
                border-left: 4px solid #AE1C9A;
            }

            .detail-item {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #dee2e6;
            }

            .detail-item:last-child {
                margin-bottom: 0;
                padding-bottom: 0;
                border-bottom: none;
            }

            .detail-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 4px;
                margin-right: 15px;
            }

            .detail-info {
                flex: 1;
            }

            .detail-info p {
                margin: 3px 0;
                color: #333;
            }

            .search-form {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            }

            /* Pagination styles */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin: 30px 0;
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .pagination li {
                margin: 0 5px;
            }

            .pagination li a {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                text-decoration: none;
                color: #333;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .pagination li.active a {
                background-color: #AE1C9A;
                color: white;
                border-color: #AE1C9A;
            }

            .pagination li a:hover:not(.active) {
                background-color: #f8f9fa;
            }

            .pagination .prev a, .pagination .next a {
                width: auto;
                padding: 0 15px;
            }

            .pagination .disabled a {
                color: #adb5bd;
                pointer-events: none;
                background-color: #f8f9fa;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .order-table {
                    font-size: 14px;
                }
                
                .order-table th,
                .order-table td {
                    padding: 10px 8px;
                }
                
                .search-form {
                    padding: 15px;
                }
                
                .search-form form {
                    flex-direction: column;
                    gap: 15px !important;
                }
                
                .search-form label {
                    margin-bottom: 5px;
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
                        <div class="tab-pane" id="v-pills-review" role="tabpanel" aria-labelledby="v-pills-review-tab" tabindex="0">
                            <div class="orders-section">
                                
                                <!-- Search Form -->
                                <div class="search-form">
                                    <form method="get" action="" style="display: flex; align-items: center; gap: 15px;">
                                        <label for="fromDate" style="font-size: 16px; font-weight: bold;">Từ ngày:</label>
                                        <input type="date" id="fromDate" name="from" style="height: 36px;padding: 5px; border: 1px solid #ccc; border-radius: 4px;">

                                        <label for="toDate" style="font-size: 16px; font-weight: bold;">Đến ngày:</label>
                                        <input type="date" id="toDate" name="to" style="height: 36px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;">

                                        <button type="submit" style="background-color: #AE1C9A; font-size: 14px; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                                            Tìm kiếm
                                        </button>
                                    </form>
                                </div>

                                <!-- Orders Table -->
                                <table class="order-table">
                                    <thead>
                                        <tr>
                                            <th>Ngày đặt hàng</th>
                                            <th>Địa chỉ giao hàng</th>
                                            <th>Trạng thái</th>
                                            <th>Số lượng SP</th>
                                            <th>Tổng tiền</th>
                                            <th>Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}" varStatus="orderStatus">
                                            <tr>
                                                <td>
                                                    <span style="font-size: 13px; font-weight: bold; vertical-align: central" class="order-date">${fn:substringBefore(order.orderDate, '.')}</span>
                                                </td>
                                                <td>
                                                    <div style="font-size: 13px ; font-weight: bold" style="max-width: 200px; word-wrap: break-word;">
                                                        ${order.shippingAddress}
                                                    </div>
                                                </td>
                                                <td>
                                                    <span style="font-size: 13px ; font-weight: bold ; padding: 0px !important" class="order-status status-${fn:toLowerCase(order.stringOrderStatus)}">
                                                        ${order.stringOrderStatus}
                                                    </span>
                                                </td>
                                                <td style="font-size: 13px ; font-weight: bold;" style="text-align: center;">
                                                    ${order.orderDetails.size()} sản phẩm
                                                </td>
                                                <td>
                                                    <span style="font-size: 13px ; font-weight: bold" class="order-total">${order.total} VND</span>
                                                </td>
                                                <td>
                                                    <button class="view-details-btn" onclick="toggleOrderDetails(${orderStatus.index})">
                                                        Xem chi tiết
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="padding: 0;">
                                                    <div id="orderDetails_${orderStatus.index}" class="order-details">
                                                        <h5 style="margin-bottom: 15px; color: #AE1C9A;">Chi tiết đơn hàng</h5>
                                                        <c:forEach var="detail" items="${order.orderDetails}">
                                                            <div class="detail-item">
                                                                <a href="productdetail?id=${detail.variant.variantID}">
                                                                <img class="detail-image" 
                                                                     src="api/img/${detail.variant.product.imageMainProduct}" 
                                                                     alt="${detail.variant.product.productName}" 
                                                                     >
                                                                <div class="detail-info">
                                                                    <p><strong>Sản phẩm:</strong> ${detail.variant.product.productName}</p>
                                                                    <p><strong>Số lượng:</strong> ${detail.quantity_product}</p>
                                                                    <p><strong>Giá:</strong> <span style="color: #AE1C9A; font-weight: bold;">${detail.price} VND</span></p>
                                                                </div>
                                                                </a>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <div class="pagination-container">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="prev">
                                                <a href="#" data-page="${currentPage - 1}"><i class="fa fa-angle-left"></i> Trang trước</a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="#" data-page="${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="next">
                                                <a href="#" data-page="${currentPage + 1}">Trang sau <i class="fa fa-angle-right"></i></a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--------------- footer-section --------------->
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />

        <script>
            function toggleOrderDetails(index) {
                const detailsDiv = document.getElementById('orderDetails_' + index);
                const button = event.target;
                
                if (detailsDiv.style.display === 'none' || detailsDiv.style.display === '') {
                    detailsDiv.style.display = 'block';
                    button.textContent = 'Ẩn chi tiết';
                } else {
                    detailsDiv.style.display = 'none';
                    button.textContent = 'Xem chi tiết';
                }
            }

            // Pagination handling
            document.querySelectorAll('.pagination a').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const page = this.getAttribute('data-page');
                    if (page) {
                        // Add your pagination logic here
                        window.location.href = `?page=${page}`;
                    }
                });
            });
        </script>

    </body>
</html>