<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <style>
            .order-container {
                overflow: hidden;
                max-height: 130px;
                transition: max-height 0.6s ease-in-out;
                border-radius: 8px;
                margin: 10px 0;
            }

            .order-container.expanded {
                max-height: 1000px;
            }

            .hidden-detail {
                display: none;
            }

            .order-detail-item {
                background-color: white;
                padding: 15px;
                margin: 8px 0;
                border-radius: 6px;
                box-shadow: 0px 2px 4px rgba(0,0,0,0.05);
            }

            .order-detail-item p {
                margin: 5px 0;
                color: #333;
            }

            .view-more-btn {
                background-color: #AE1C9A;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .view-more-btn:hover {
                background-color: #AE1C9A;
            }

            .order-wrapper {
                border: 1px solid #dee2e6;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                background-color: white;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            }

            .order-date {
                color: #6c757d;
                font-size: 0.9em;
            }

            .order-info {
                margin: 15px 0;
                line-height: 1.6;
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
            .order-wrapper {
                overflow: hidden;
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
                                <div class="row g-5">
                                    <div style="font-size: 18px;margin-bottom: 20px;">
                                        <form method="get" action="" style="display: flex; align-items: center; gap: 10px;">
                                            <label for="fromDate" style="font-size: 16px; font-weight: bold;">Từ ngày:</label>
                                            <input type="date" id="fromDate" name="from" style="height: 36px;padding: 5px; border: 1px solid #ccc; border-radius: 4px;">

                                            <label for="toDate" style="font-size: 16px; font-weight: bold;">Đến ngày:</label>
                                            <input type="date" id="toDate" name="to" style="height: 36px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;">

                                            <button type="submit" style="background-color: #AE1C9A; color: white; border: none; padding: 4px 15px; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                                                Tìm kiếm
                                            </button>
                                        </form>
                                    </div>
                                    <c:forEach var="order" items="${orders}">
                                        <div class="col-md-11">
                                            <div style="width: 950px" class="order-wrapper">
                                                <div class="order-header">
                                                    <div class="order-date">
                                                        <p style="color: black; font-weight: bold">Đơn hàng ngày : ${fn:substringBefore(order.orderDate, '.')}</p>

                                                    </div>
                                                    <div class="</div>row">
                                                        <div style="font-size: 16px" class="order-info col-m</div>d-6">
                                                            <strong>Địa chỉ:</strong> ${order.shippingAddress}
                                                            <br />
                                                            <strong>Trạng thái:</strong> ${order.stringOrderStatus}
                                                        </div>
                                                        <div style="font-size: 16px" class="order-info col-md-6">
                                                            <strong>Tổng hóa đơn :</strong> ${order.total} VND
                                                            <br />
                                                            <strong>Số lượng: </strong> ${order.orderDetails.size()} sản phẩm 
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- OrderDetail list -->
                                                <div class="order-container">
                                                    <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                                                        <div class="order-detail-item ${status.index > 0 ? 'hidden-detail' : ''}">
                                                            <div class="row">
                                                                <div class="product-image col-md-2">
                                                                    <img width="100px" src="${detail.variant.product.imageMainProduct}" alt="${detail.variant.product.productName}" onerror="this.src='assets/images/no-image.jpg'">
                                                                </div>
                                                                <div class="product-info col-md-9">
                                                                    <p><strong>Sản phẩm:</strong> ${detail.variant.product.productName}</p>
                                                                    <p><strong>Số lượng:</strong> ${detail.quantity_product}</p>
                                                                    <p><strong>Giá:</strong> ${detail.price}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <c:if test="${order.orderDetails.size() > 1}">
                                                    <div class="order-actions">
                                                        <button style="font-size: 16px" class="view-more-btn">Xem thêm</button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Pagination -->
                                <div class="pagination-container">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="next">
                                                <a href="#" data-page="${currentPage - 1}">Trang trước <i class="fa fa-angle-left"></i></a>
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
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.view-more-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        const wrapper = button.closest('.order-wrapper');
                        const container = wrapper.querySelector('.order-container');

                        // Hiện tất cả các hidden detail
                        container.querySelectorAll('.hidden-detail').forEach(el => {
                            el.style.display = 'block';
                        });

                        // Thêm class để mở rộng chiều cao
                        container.classList.add('expanded');

                        // Ẩn nút
                        button.style.display = 'none';
                    });
                });
            });
        </script>
        <script>
    document.addEventListener('DOMContentLoaded', function () {
        const links = document.querySelectorAll('a[data-page]');

        links.forEach(link => {
            const page = link.getAttribute('data-page');
            const url = new URL(window.location.href);
            url.searchParams.set('page', page);
            link.setAttribute('href', url.pathname + '?' + url.searchParams.toString());
        });
    });
</script>



    </body>
</html>