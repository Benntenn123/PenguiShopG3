<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <jsp:include page="Common/Css.jsp"/>
        <style>
            .price-filter {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0e0e0;
            }

            .filter-title {
                margin: 0 0 16px 0;
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .price-inputs {
                display: flex;
                gap: 12px;
                align-items: flex-end;
            }

            .input-group {
                flex: 1;
            }

            .input-group label {
                display: block;
                font-size: 13px;
                color: #666;
                margin-bottom: 6px;
                font-weight: 500;
            }

            .price-input {
                width: 100%;
                padding: 10px 12px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
                outline: none;
                background: #fafafa;
            }

            .price-input:focus {
                border-color: #007bff;
                background: white;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
            }

            .price-input::placeholder {
                color: #aaa;
                font-size: 13px;
            }

            /* Pagination Styles */
            .pagination-wrapper {
                margin-top: 50px;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
                gap: 8px;
                align-items: center;
            }

            .pagination li {
                display: inline-block;
            }

            .pagination a, .pagination span {
                display: inline-block;
                padding: 12px 16px;
                text-decoration: none;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                color: #333;
                font-weight: 500;
                transition: all 0.3s ease;
                min-width: 48px;
                text-align: center;
                background: white;
            }

            .pagination a:hover {
                background: #AE1C9A;
                color: white;
                border-color: #AE1C9A;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(174, 28, 154, 0.3);
            }

            .pagination .active span {
                background: #AE1C9A;
                color: white;
                border-color: #AE1C9A;
                box-shadow: 0 2px 8px rgba(174, 28, 154, 0.3);
            }

            .pagination .disabled span {
                color: #ccc;
                cursor: not-allowed;
                background: #f8f9fa;
                border-color: #e9ecef;
            }

            .pagination .prev-next {
                font-size: 14px;
                padding: 12px 20px;
            }

            .pagination-info {
                margin-right: 30px;
                color: #666;
                font-size: 14px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .pagination-wrapper {
                    flex-direction: column;
                    gap: 20px;
                }

                .pagination {
                    flex-wrap: wrap;
                    justify-content: center;
                }

                .pagination a, .pagination span {
                    padding: 10px 12px;
                    min-width: 40px;
                    font-size: 14px;
                }

                .pagination .prev-next {
                    padding: 10px 16px;
                }
            }

            @media (max-width: 480px) {
                .price-inputs {
                    flex-direction: column;
                    gap: 16px;
                }

                .pagination a, .pagination span {
                    padding: 8px 10px;
                    min-width: 36px;
                    font-size: 13px;
                }
            }
        </style>
    </head>
    <body>


        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <!--------------- products-sidebar-section--------------->
        <section class="product product-sidebar footer-padding">
            <div class="container">
                <div class="row g-5">
                    <div class="col-lg-3">
                        <form method="get" action="search">
                            <div class="sidebar" data-aos="fade-right">
                                <div class="sidebar-section">
                                    <div class="sidebar-wrapper">
                                        <h5 class="wrapper-heading">Danh mục Sản Phẩm</h5>
                                        <div class="sidebar-item">
                                            <ul class="sidebar-list">
                                                <c:forEach var="cate" items="${cate}">
                                                    <li>
                                                        <input type="checkbox" value="${cate.categoryId}" id="cate" name="cate">
                                                        <label for="cate">${cate.categoryName}</label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="price-filter-section">
                                        <h5 class="filter-title">Lọc Theo Giá</h5>
                                        <div class="price-input-container">
                                            <div class="input-group">
                                                <label for="from">Giá Từ (VNĐ):</label>
                                                <input type="number" id="from" name="from" class="price-input" placeholder="0" min="0">
                                            </div>
                                            <div class="input-group">
                                                <label for="to">Giá Đến (VNĐ):</label>
                                                <input type="number" id="to" name="to" class="price-input" placeholder="1000000" min="0">
                                            </div>
                                        </div>

                                    </div>
                                    <hr>
                                    <div class="sidebar-wrapper">
                                        <h5 class="wrapper-heading">Nhãn Hàng</h5>
                                        <div class="sidebar-item">
                                            <ul class="sidebar-list">
                                                <c:forEach var="br" items="${br}">
                                                    <li>
                                                        <input value="${br.brandID}" type="checkbox" id="brand" name="brand">
                                                        <label for="brand">${br.brandName}
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="sidebar-wrapper">
                                        <h5 class="wrapper-heading">Màu Sắc</h5>
                                        <div class="sidebar-item">
                                            <ul class="sidebar-list">
                                                <c:forEach var="color" items="${color}">
                                                    <li>
                                                        <input value="${color.colorID}" type="checkbox" id="color" name="color">
                                                        <label for="color">${color.colorName}</label>
                                                    </li>
                                                </c:forEach>

                                            </ul>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="sidebar-wrapper">
                                        <h5 class="wrapper-heading">Kích cỡ</h5>
                                        <div class="sidebar-item">
                                            <ul class="sidebar-list">
                                                <c:forEach var="size" items="${size}">
                                                    <li>
                                                        <input value="${size.sizeID}" type="checkbox" id="size" name="size">
                                                        <label for="size">${size.sizeName}</label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: flex;
                                     justify-content: center; align-content: center" class="search-button">
                                    <button style="padding:10px 50px; background-color: #AE1C9A;border-radius: 8px
                                            ;margin-top: 20px; color: white; font-size: 20px; " type="submit">Tìm Kiếm</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-9">
                        <div class="product-sidebar-section" data-aos="fade-up">
                            <div class="row g-5">
                                <div class="col-lg-12">
                                    <div class="product-sorting-section">
                                        <div class="result">
                                            <p>Tìm thấy <span>${totalResult} Kết quả</span></p>
                                        </div>

                                    </div>
                                </div>
                                   
                                <c:if test="${empty user}">
                                    <div class="col-lg-12">
                                        <div class="product-deal-section" data-aos="fade-up">
                                            <h5 class="wrapper-heading">THAM GIA CÙNG PENGUIN SHOP ĐỂ NHẬN NHIỀU ưu ĐÃI</h5>
                                            <a href="login" class="shop-btn">BẮT ĐẦU</a>
                                        </div>
                                    </div>
                                </c:if>
                                <c:forEach var="item" items="${list}">
                                <div class="col-lg-4 col-sm-6">
                                    <div class="product-wrapper" data-aos="fade-up">
                                        <div class="product-img">
                                            <img src="api/img/${item.product.imageMainProduct}" style="width: 308px; height: 313px; object-fit: fill; display: block; margin: 0;"
                                                 alt="product-img">
                                            
                                        </div>
                                        <div class="product-info">
                                            <div class="ratings">
                                                <span>
                                                    <svg width="75" height="15" viewBox="0 0 75 15" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                    <path
                                                        d="M7.5 0L9.18386 5.18237H14.6329L10.2245 8.38525L11.9084 13.5676L7.5 10.3647L3.09161 13.5676L4.77547 8.38525L0.367076 5.18237H5.81614L7.5 0Z"
                                                        fill="#FFA800" />
                                                    <path
                                                        d="M22.5 0L24.1839 5.18237H29.6329L25.2245 8.38525L26.9084 13.5676L22.5 10.3647L18.0916 13.5676L19.7755 8.38525L15.3671 5.18237H20.8161L22.5 0Z"
                                                        fill="#FFA800" />
                                                    <path
                                                        d="M37.5 0L39.1839 5.18237H44.6329L40.2245 8.38525L41.9084 13.5676L37.5 10.3647L33.0916 13.5676L34.7755 8.38525L30.3671 5.18237H35.8161L37.5 0Z"
                                                        fill="#FFA800" />
                                                    <path
                                                        d="M52.5 0L54.1839 5.18237H59.6329L55.2245 8.38525L56.9084 13.5676L52.5 10.3647L48.0916 13.5676L49.7755 8.38525L45.3671 5.18237H50.8161L52.5 0Z"
                                                        fill="#FFA800" />
                                                    <path
                                                        d="M67.5 0L69.1839 5.18237H74.6329L70.2245 8.38525L71.9084 13.5676L67.5 10.3647L63.0916 13.5676L64.7755 8.38525L60.3671 5.18237H65.8161L67.5 0Z"
                                                        fill="#FFA800" />
                                                    </svg>
                                                </span>
                                            </div>
                                            <div class="product-description">
                                                <a style="display: block; height: 40px; line-height: 20px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 100%; font-size: 16px;"
                                                    href="productdetail?id=${item.variantID}" class="product-details">${item.product.productName}
                                                </a>
                                                <div class="price">
<!--                                                    <span class="price-cut">$36.99</span>-->
                                                    <span class="new-price">${item.price} VND</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-cart-btn">
                                            <a href="cart.html" class="product-btn">Thêm giỏ hàng</a>
                                        </div>
                                    </div>
                                </div>
                                </c:forEach>

                                <!-- Pagination Section -->
                                <div class="col-lg-12">
                                    <div class="pagination-wrapper">
                                        <div class="pagination-info">
                                            <span>Hiển thị ${(currentPage-1)*pageSize + 1} - ${currentPage*pageSize > totalResult ? totalResult : currentPage*pageSize} trong tổng số ${totalResult} sản phẩm</span>
                                        </div>
                                        <c:if test="${totalPages > 1}">
                                            <ul class="pagination">
                                                <!-- Previous Button -->
                                                <c:if test="${currentPage > 1}">
                                                    <li>
                                                        <a href="#" onclick="goToPage(${currentPage - 1})" class="prev-next">
                                                            « Trước
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${currentPage <= 1}">
                                                    <li class="disabled">
                                                        <span class="prev-next">« Trước</span>
                                                    </li>
                                                </c:if>

                                                <!-- Page Numbers -->
                                                <c:choose>
                                                    <c:when test="${totalPages <= 7}">
                                                        <!-- Show all pages if total pages <= 7 -->
                                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                                            <c:choose>
                                                                <c:when test="${currentPage == i}">
                                                                    <li class="active">
                                                                        <span>${i}</span>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li>
                                                                        <a href="#" onclick="goToPage(${i})">${i}</a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Show first page -->
                                                        <c:if test="${currentPage > 3}">
                                                            <li>
                                                                <a href="#" onclick="goToPage(1)">1</a>
                                                            </li>
                                                            <c:if test="${currentPage > 4}">
                                                                <li class="disabled">
                                                                    <span>...</span>
                                                                </li>
                                                            </c:if>
                                                        </c:if>

                                                        <!-- Show pages around current page -->
                                                        <c:forEach begin="${currentPage <= 3 ? 1 : currentPage - 2}" 
                                                                   end="${currentPage >= totalPages - 2 ? totalPages : currentPage + 2}" var="i">
                                                            <c:choose>
                                                                <c:when test="${currentPage == i}">
                                                                    <li class="active">
                                                                        <span>${i}</span>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li>
                                                                        <a href="#" onclick="goToPage(${i})">${i}</a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>

                                                        <!-- Show last page -->
                                                        <c:if test="${currentPage < totalPages - 2}">
                                                            <c:if test="${currentPage < totalPages - 3}">
                                                                <li class="disabled">
                                                                    <span>...</span>
                                                                </li>
                                                            </c:if>
                                                            <li>
                                                                <a href="#" onclick="goToPage(${totalPages})">${totalPages}</a>
                                                            </li>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- Next Button -->
                                                <c:if test="${currentPage < totalPages}">
                                                    <li>
                                                        <a href="#" onclick="goToPage(${currentPage + 1})" class="prev-next">
                                                            Sau »
                                                        </a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${currentPage >= totalPages}">
                                                    <li class="disabled">
                                                        <span class="prev-next">Sau »</span>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- products-sidebar-section-end--------------->

        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp"/>
        <!--------------- footer-section--------------->
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        
        
        <!--------------- footer-section-end--------------->






    </body>
</html>