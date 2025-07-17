<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            /* Product color selector */
            .product-color-selector {
                margin: 20px 0;
                max-width: 300px;
            }
            .product-color-selector p {
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }
            .color-item, .size-item {
                margin-bottom: 8px;
            }
            .color-item input[type="checkbox"], .size-item input[type="checkbox"] {
                margin-right: 8px;
                accent-color: #AE1C9A;
                width: 18px;
                height: 18px;
                cursor: pointer;
                vertical-align: middle;
            }
            .color-item label, .size-item label {
                font-size: 16px;
                color: #444;
                cursor: pointer;
                vertical-align: middle;
            }
            .color-item input[type="checkbox"]:checked + label, 
            .size-item input[type="checkbox"]:checked + label {
                font-weight: bold;
                color: #AE1C9A;
            }

            /* Review styles */
            .review-summary {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
            }
            .average-rating {
                text-align: center;
            }
            .average-rating h2 {
                color: #AE1C9A;
                font-size: 36px;
                margin-bottom: 5px;
            }
            .average-rating .fa-star {
                color: #ffc107;
            }
            .review-wrapper {
                margin-top: 20px;
            }
            .review-item {
                border-bottom: 1px solid #e9ecef;
                padding: 20px 0;
                opacity: 1;
                transform: none;
            }
            .review-item.new-item {
                opacity: 0;
                transform: translateY(20px);
                transition: opacity 0.3s ease, transform 0.3s ease;
            }
            .review-item.new-item.visible {
                opacity: 1;
                transform: translateY(0);
            }
            .reviewer-info {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            .reviewer-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 15px;
                object-fit: cover;
            }
            .reviewer-details h6 {
                margin: 0;
                color: #333;
                font-size: 16px;
            }
            .rating {
                color: #ffc107;
                margin: 5px 0;
            }
            .review-date {
                color: #6c757d;
                font-size: 14px;
            }
            .review-content p {
                margin-bottom: 15px;
            }
            .review-images {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .review-image {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 4px;
                cursor: pointer;
                transition: transform 0.3s ease;
            }
            .review-image:hover {
                transform: scale(1.05);
            }
            .no-reviews {
                text-align: center;
                padding: 40px;
                color: #6c757d;
            }
            .rating-overview {
                display: flex;
                gap: 30px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
            }
            .rating-bars {
                flex-grow: 1;
                padding: 10px 0;
            }
            .rating-bar-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                gap: 10px;
            }
            .rating-bar-item .stars {
                min-width: 60px;
                color: #666;
            }
            .rating-bar-item .fa-star {
                color: #ffc107;
            }
            .progress {
                flex-grow: 1;
                height: 8px;
                background-color: #e9ecef;
                border-radius: 4px;
                overflow: hidden;
            }
            .progress-bar {
                background: linear-gradient(45deg, #AE1C9A, #e83e8c);
                transition: width 0.6s ease;
            }
            .rating-bar-item .count {
                min-width: 40px;
                text-align: right;
                color: #666;
            }
            .load-more-btn {
                display: block;
                margin: 20px auto;
                padding: 10px 30px;
                background: #AE1C9A;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .load-more-btn:hover {
                background: #8e1680;
            }
            .load-more-btn.loading {
                pointer-events: none;
                opacity: 0.7;
            }
            .review-filter {
                margin: 20px 0;
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 15px;
            }
            .filter-options {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .filter-btn {
                padding: 8px 16px;
                border: 1px solid #dee2e6;
                border-radius: 20px;
                background: white;
                color: #666;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 5px;
            }
            .filter-btn .count {
                color: #999;
            }
            .filter-btn:hover {
                border-color: #AE1C9A;
                color: #AE1C9A;
            }
            .filter-btn.active {
                background: #AE1C9A;
                color: white;
                border-color: #AE1C9A;
            }
            .filter-btn.active .count {
                color: rgba(255, 255, 255, 0.8);
            }
            @media (max-width: 768px) {
                .filter-options {
                    gap: 8px;
                }
                .filter-btn {
                    padding: 6px 12px;
                    font-size: 13px;
                }
            }
            /* Style cho nút Mô tả sản phẩm và Đánh giá */
            .nav-tabs {
                border-bottom: 2px solid #ddd;
            }
            .nav-tabs .nav-link {
                color: #333;
                font-weight: 500;
                padding: 12px 20px;
                border: none;
                border-radius: 0;
                background: none;
                transition: all 0.3s;
            }
            .nav-tabs .nav-link:hover {
                color: #AE1C9A;
                border-bottom: 2px solid #AE1C9A;
            }
            .nav-tabs .nav-link.active {
                color: #AE1C9A;
                border-bottom: 2px solid #AE1C9A;
                font-weight: 600;
            }
        </style>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>

        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <!--------------- products-info-section--------------->
        <section class="product product-info">
            <div class="container">
                <div class="blog-bradcrum">
                    <span><a href="trangchu">Trang Chủ</a></span>
                    <span class="devider">/</span>
                    <span><a href="search">Cửa Hàng</a></span>
                    <span class="devider">/</span>
                    <span ><a style="font-weight: bold; color: #AE1C9A" href="#">Chi Tiết Sản Phẩm</a></span>
                </div>
                <div class="product-info-section">
                    <div class="row ">
                        <div class="col-md-6">
                            <div class="product-info-img" data-aos="fade-right">
                                <div class="swiper product-top">
                                    <!--                                <div class="product-discount-content">
                                                                        <h4>-50%</h4>
                                                                    </div>-->
                                    <div class="swiper-wrapper">
                                        <c:forEach var="image" items="${image}">

                                            <div class="swiper-slide slider-top-img">
                                                <img src="api/img/${image}"
                                                     alt="img">
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                                <div class="swiper product-bottom">
                                    <div class="swiper-wrapper">
                                        <c:forEach var="image" items="${image}">
                                            <div class="swiper-slide slider-bottom-img">
                                                <img src="api/img/${image}"
                                                     alt="img">
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="product-info-content" data-aos="fade-left">

                                <h5>${pv.product.productName}
                                </h5>
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
                                    <!--                                <span class="text">6 Reviews</span>-->
                                </div>
                                <div class="price">
                                    <!--                                <span class="price-cut">$9.99</span>-->
                                    <span class="new-price">${pv.price} VND</span>
                                </div>
                                <p class="content-paragraph">
                                    ${pv.product.description}</p>
                                <hr>
                                <!--                            <div class="product-availability">
                                                                <span>Availabillity : </span>
                                                                <span class="inner-text">132 Products Available</span>
                                                            </div>-->
                                <div class="product-size">
                                    <p>Chọn Kích Cỡ:</p>
                                    <div class="size-section">
                                        <c:forEach var="sizePro" items="${sizePro}">
                                            <div class="size-item">
                                                <input type="checkbox" name="sizes" value="${sizePro.sizeName}" id="size-${sizePro.sizeName}">
                                                <label for="size-${sizePro.sizeName}">Cỡ ${sizePro.sizeName}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="product-color-selector">
                                    <p>Chọn Màu Sắc:</p>
                                    <c:forEach var="colorPro" items="${colorPro}">
                                        <div class="color-item">
                                            <input type="checkbox" name="colors" value="${colorPro.colorName}" id="color-${colorPro.colorName}">
                                            <label for="color-${colorPro.colorName}">${colorPro.colorName}</label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="product-quantity">
                                   
                                    <a href="#" class="shop-btn" onclick="addToCart('${sessionScope.user.userID}', '${pv.product.productId}', '${pv.variantID}')">
                                        <span>
                                            <svg width="14" height="14" viewBox="0 0 14 14" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M8.25357 3.32575C8.25357 4.00929 8.25193 4.69283 8.25467 5.37583C8.25576 5.68424 8.31536 5.74439 8.62431 5.74439C9.964 5.74603 11.3031 5.74275 12.6428 5.74603C13.2728 5.74767 13.7397 6.05663 13.9246 6.58104C14.2209 7.42098 13.614 8.24232 12.6762 8.25052C11.5919 8.25982 10.5075 8.25271 9.4232 8.25271C9.17714 8.25271 8.93107 8.25216 8.68501 8.25271C8.2913 8.2538 8.25412 8.29154 8.25412 8.69838C8.25357 10.0195 8.25686 11.3412 8.25248 12.6624C8.25029 13.2836 7.92603 13.7544 7.39891 13.9305C6.56448 14.2088 5.75848 13.6062 5.74863 12.6821C5.73824 11.7251 5.74645 10.7687 5.7459 9.81173C5.7459 9.41965 5.74754 9.02812 5.74535 8.63604C5.74371 8.30849 5.69012 8.2538 5.36204 8.25326C4.02235 8.25162 2.68321 8.25545 1.34352 8.25107C0.719613 8.24943 0.249902 7.93008 0.0710952 7.40348C-0.212153 6.57065 0.388245 5.75916 1.31017 5.74658C2.14843 5.73564 2.98669 5.74384 3.82495 5.74384C4.30779 5.74384 4.79062 5.74384 5.274 5.74384C5.72184 5.7433 5.7459 5.71869 5.7459 5.25716C5.7459 3.95406 5.74317 2.65096 5.74699 1.34786C5.74863 0.720643 6.0625 0.253102 6.58799 0.0704598C7.40875 -0.213893 8.21803 0.370671 8.25248 1.27349C8.25303 1.29154 8.25303 1.31013 8.25303 1.32817C8.25357 1.99531 8.25357 2.66026 8.25357 3.32575Z"
                                                fill="white" />
                                            </svg>
                                        </span>
                                        <span>Thêm vào giỏ hàng</span>
                                    </a>
                                </div>
                                <hr>
                                <div class="product-details">
                                    <p class="category">Danh mục: <c:forEach var="cate" items="${cate}"><span class="inner-text">${cate.categoryName}</span></c:forEach></p>
                                    <p class="tags">Tags :<c:forEach var="tag" items="${tag}"> <span class="inner-text">${tag.tagName} , </span></c:forEach></p>
                                    <p class="sku">SKU : <span class="inner-text">${pv.product.sku}</span></p>
                                </div>
                                <hr>

                                <div class="product-share">
                                    <p>Chia sẻ:</p>
                                    <div class="social-icons">
                                        <a href="https://www.facebook.com/sharer/sharer.php?u=<%= request.getRequestURL() %>" target="_blank">
                                            <span class="facebook">
                                                <svg width="10" height="16" viewBox="0 0 10 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M3 16V9H0V6H3V4C3 1.3 4.7 0 7.1 0C8.3 0 9.2 0.1 9.5 0.1V2.9H7.8C6.5 2.9 6.2 3.5 6.2 4.4V6H10L9 9H6.3V16H3Z" fill="#3E75B2" />
                                                </svg>
                                            </span>
                                        </a>
                                        <a href="https://www.linkedin.com/shareArticle?mini=true&url=<%= request.getRequestURL() %>&title=Check%20this%20out!" target="_blank">
                                            <span class="linkedin">
                                                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M14.8 0H1.2C0.54 0 0 0.54 0 1.2V14.8C0 15.46 0.54 16 1.2 16H14.8C15.46 16 16 15.46 16 14.8V1.2C16 0.54 15.46 0 14.8 0ZM4.7 13.6H2.2V6H4.7V13.6ZM3.5 5C2.68 5 2 4.32 2 3.5C2 2.68 2.68 2 3.5 2C4.32 2 5 2.68 5 3.5C5 4.32 4.32 5 3.5 5ZM13.6 13.6H11.1V9.8C11.1 8.6 11.1 7.3 9.7 7.3C8.3 7.3 8.2 8.4 8.2 9.7V13.6H5.7V6H8.2V7.1C8.6 6.4 9.5 5.8 10.7 5.8C13.2 5.8 13.6 7.4 13.6 9.4V13.6Z" fill="#0077B5" />
                                                </svg>
                                            </span>
                                        </a>
                                        <a href="https://twitter.com/intent/tweet?url=<%= request.getRequestURL() %>&text=Check%20this%20out!" target="_blank">
                                            <span class="twitter">
                                                <svg width="18" height="14" viewBox="0 0 18 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M17.0722 1.60052C16.432 1.88505 15.7562 2.06289 15.0448 2.16959C15.7562 1.74278 16.3253 1.06701 16.5742 0.248969C15.8985 0.640206 15.1515 0.924742 14.3335 1.10258C13.6933 0.426804 12.7686 0 11.7727 0C9.85206 0 8.28711 1.56495 8.28711 3.48557C8.28711 3.7701 8.32268 4.01907 8.39382 4.26804C5.51289 4.12577 2.9165 2.73866 1.17371 0.604639C0.889175 1.13814 0.71134 1.70722 0.71134 2.34742C0.71134 3.5567 1.31598 4.62371 2.27629 5.26392C1.70722 5.22835 1.17371 5.08608 0.675773 4.83711V4.87268C0.675773 6.5799 1.88505 8.00258 3.48557 8.32268C3.20103 8.39382 2.88093 8.42938 2.56082 8.42938C2.34742 8.42938 2.09845 8.39382 1.88505 8.35825C2.34742 9.74536 3.62784 10.7768 5.15722 10.7768C3.94794 11.7015 2.45412 12.2706 0.818041 12.2706C0.533505 12.2706 0.248969 12.2706 0 12.2351C1.56495 13.2309 3.37887 13.8 5.37062 13.8C11.8082 13.8 15.3294 8.46495 15.3294 3.84124C15.3294 3.69897 15.3294 3.52113 15.3294 3.37887C16.0052 2.9165 16.6098 2.31186 17.0722 1.60052Z" fill="#3FD1FF" />
                                                </svg>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- products-info-end--------------->

        <!--------------- products-details-section--------------->
        <section class="product product-description">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <nav>
                            <div style="font-size: 18px" class="nav nav-tabs" id="nav-tab" role="tablist">
                                <button  class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="false">Mô tả sản phẩm</button>
                                <button class="nav-link active" id="nav-review-tab" data-bs-toggle="tab" data-bs-target="#nav-review" type="button" role="tab" aria-controls="nav-review" aria-selected="true">Đánh giá</button>
                            </div>
                        </nav>
                        <div class="tab-content" id="nav-tabContent">
                            <div style="font-size: 16px; margin-top: 30px" class="tab-pane fade" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                ${pv.product.full_description}
                            </div>
                            <div class="tab-pane fade show active" id="nav-review" role="tabpanel" aria-labelledby="nav-review-tab">
                                <div class="review-summary">
                                    <div class="rating-overview">
                                        <div class="average-rating text-center">
                                            <h2>${averageRating}/5 <i class="fas fa-star"></i></h2>
                                            <p>${totalFeedbacks} đánh giá</p>
                                        </div>
                                        <div class="review-filter">
                                            <div style="font-size:18px" class="filter-options">
                                                <button class="filter-btn active" data-rating="0">
                                                    Tất cả
                                                    <span class="count">(${totalFeedbacks})</span>
                                                </button>
                                                <button class="filter-btn" data-rating="5">
                                                    5 Sao
                                                    <span class="count">(0)</span>
                                                </button>
                                                <button class="filter-btn" data-rating="4">
                                                    4 Sao
                                                    <span class="count">(0)</span>
                                                </button>
                                                <button class="filter-btn" data-rating="3">
                                                    3 Sao
                                                    <span class="count">(0)</span>
                                                </button>
                                                <button class="filter-btn" data-rating="2">
                                                    2 Sao
                                                    <span class="count">(0)</span>
                                                </button>
                                                <button class="filter-btn" data-rating="1">
                                                    1 Sao
                                                    <span class="count">(0)</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-wrapper"></div>
                                <!-- Modal hiển thị ảnh lớn -->
                                <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="imageModalLabel">Hình ảnh đánh giá</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>
                                            <div class="modal-body">
                                                <img src="" class="img-fluid" id="modalImage" alt="Hình ảnh lớn">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- products-details-end--------------->

        <!--------------- weekly-section--------------->
        <section class="product weekly-sale product-weekly footer-padding">
            <div class="container">
                <div class="section-title">
                    <h5>Có thể bạn sẽ quan tâm</h5>
                    <a href="#" class="view">Xem tất cả</a>
                </div>
                <div class="weekly-sale-section">
                    <div class="row g-5">
                        <c:forEach var="relatedProduct" items="${relatedProduct}">
                            <div class="col-lg-3 col-md-6">
                                <div class="product-wrapper" data-aos="fade-up">
                                    <div class="product-img">
                                        <img src="api/img/${relatedProduct.product.imageMainProduct}" style="width: 308px; height: 313px; object-fit: fill; display: block; margin: 0;" 
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
                                            <a href="productdetail?id=${relatedProduct.product.productId}" class="product-details" 
                                               style="display: block; height: 40px; line-height: 20px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 100%; font-size: 16px;">
                                                ${relatedProduct.product.productName}
                                            </a>
                                            <div class="price">
                                                <!--                                            <span class="price-cut">$32.99</span>-->
                                                <span class="new-price">${relatedProduct.price}VND</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-cart-btn">
                                        <a href="cart.html" class="product-btn">Thêm giỏ hàng</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- weekly-section-end--------------->
        <jsp:include page="Common/Footer.jsp"/>
        <!--------------- footer-section--------------->
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <script>
document.addEventListener('DOMContentLoaded', function () {
    const variantId = "${pv.variantID}";
    let currentPage = 1;
    const pageSize = 5; // Số lượng feedback mỗi trang
    let canLoadMore = true;
    let currentRating = 0; // Mặc định là tab Tất cả
    let isLoading = false;
    let isAddingToCart = false; // Debounce flag for addToCart

    // Add to Cart function
    window.addToCart = function(userID, productID, variantID) {
        if (isAddingToCart) return;
        isAddingToCart = true;

        // Kiểm tra xem người dùng đã chọn màu và kích cỡ chưa
        const selectedColors = document.querySelectorAll('input[name="colors"]:checked');
        const selectedSizes = document.querySelectorAll('input[name="sizes"]:checked');

        if (selectedColors.length === 0 || selectedSizes.length === 0) {
            showErrorToast('Vui lòng chọn màu sắc và kích cỡ trước khi thêm vào giỏ hàng');
            isAddingToCart = false;
            return;
        }

        console.log('addToCart called with:', {userID, productID, variantID});
        if (!variantID || variantID === 'undefined') {
            showErrorToast('Vui lòng chọn màu và size!');
            isAddingToCart = false;
            return;
        }

        jQuery.ajax({
            url: 'addCart',
            type: 'POST',
            data: {
                userID: userID,
                productID: productID,
                variantID: variantID,
                quantity: 1
            },
            success: function (response) {
                console.log('addCart response:', response);
                if (response.status === 'success') {
                    toastr.success('Đã thêm sản phẩm vào giỏ hàng!');
                } else if (response.status === 'not_logged_in') {
                    toastr.error('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
                    setTimeout(() => {
                        window.location.href = 'login';
                    }, 1500);
                } else {
                    toastr.error(response.message || 'Lỗi khi thêm sản phẩm vào giỏ hàng!');
                }
                isAddingToCart = false;
            },
            error: function (xhr, status, error) {
                console.log('addCart error:', status, error);
                showErrorToast('Lỗi kết nối server: ' + error);
                isAddingToCart = false;
            }
        });
    };

    // Định nghĩa hàm showImageInModal trong phạm vi toàn cục
    window.showImageInModal = function (imageSrc) {
        const modalImage = document.getElementById('modalImage');
        if (modalImage) {
            modalImage.src = imageSrc;
            const modal = new bootstrap.Modal(document.getElementById('imageModal'));
            modal.show();
        } else {
            console.error('Không tìm thấy phần tử modalImage');
        }
    };

   

    function createReviewElement(feedback) {
        const div = document.createElement('div');
        div.className = 'review-item new-item';

        const date = new Date(feedback.feedbackDate);
        const formattedDate = date.toLocaleDateString('vi-VN');

        let ratingStars = '';
        for (let i = 0; i < 5; i++) {
            ratingStars += '<i class="fa' + (i < feedback.rating ? 's' : 'r') + ' fa-star"></i>';
        }

        let imagesHtml = '';
        if (feedback.images && Array.isArray(feedback.images) && feedback.images.length > 0) {
            imagesHtml = '<div class="review-images">';
            feedback.images.forEach(function (image) {
                if (image) {
                    const imageSrc = 'api/img/' + image;
                    imagesHtml += '<img src="' + imageSrc + '" alt="Hình ảnh đánh giá" class="review-image" data-image-src="' + imageSrc + '">';
                }
            });
            imagesHtml += '</div>';
        }

        const avatarSrc = feedback.user && feedback.user.image_user ?
            'api/img/' + feedback.user.image_user :
            '/images/default-avatar.png'; // Sử dụng đường dẫn cục bộ cho ảnh mặc định

        div.innerHTML =
            '<div class="reviewer-info">' +
            '<img src="' + avatarSrc + '" alt="Avatar người dùng" class="reviewer-avatar">' +
            '<div class="reviewer-details">' +
            '<h6>' + (feedback.user && feedback.user.fullName ? feedback.user.fullName : 'Ẩn danh') + '</h6>' +
            '<div class="rating">' +
            ratingStars +
            '<span class="rating-value" style="margin-left: 10px; color: #AE1C9A; font-weight: bold;">' + feedback.rating + ' Sao</span>' +
            '</div>' +
            '<span class="review-date">' + formattedDate + '</span>' +
            '</div>' +
            '</div>' +
            '<div class="review-content">' +
            '<p>' + (feedback.comment || 'Không có bình luận') + '</p>' +
            imagesHtml +
            '</div>';

        // Thêm sự kiện click cho ảnh động
        const images = div.querySelectorAll('.review-image');
        images.forEach(img => {
            img.addEventListener('click', () => {
                const src = img.getAttribute('data-image-src');
                window.showImageInModal(src);
            });
        });

        return div;
    }

    function loadRatingDistribution() {
        fetch('api/feedback?action=getRatingDistribution&variantId=' + variantId)
            .then(response => response.json())
            .then(data => {
                console.log('Phản hồi phân bố đánh giá:', data);
                if (!data || !data.hasOwnProperty('total') || !data.distribution) {
                    console.error('Dữ liệu phân bố đánh giá không hợp lệ:', data);
                    return;
                }
                updateFilterCounts({
                    distribution: data.distribution,
                    total: data.total
                });
            })
            .catch(error => console.error('Lỗi khi tải phân bố đánh giá:', error));
    }

    function loadFeedbacks(resetPage) {
        if (isLoading || !canLoadMore) return;
        isLoading = true;

        // Luôn xóa toàn bộ nội dung cũ khi load feedback mới
        const reviewWrapper = document.querySelector('.review-wrapper');
        reviewWrapper.innerHTML = '';

        if (resetPage) {
            currentPage = 1;
            canLoadMore = true;
        }

        fetch('api/feedback?action=getFeedbacks&variantId=' + variantId +
                '&page=' + currentPage +
                '&pageSize=' + pageSize +
                '&rating=' + currentRating)
            .then(response => response.json())
            .then(data => {
                console.log('Phản hồi đánh giá:', data);
                const feedbacksContainer = document.querySelector('.review-wrapper');
                const total = data.total || 0;

                if (data.feedbacks && data.feedbacks.length > 0) {
                    data.feedbacks.forEach(feedback => {
                        const reviewDiv = createReviewElement(feedback);
                        feedbacksContainer.appendChild(reviewDiv);
                        requestAnimationFrame(() => {
                            reviewDiv.classList.add('visible');
                        });
                    });

                    // Log trước khi tăng currentPage
                    console.log('Total:', total, 'CurrentPage:', currentPage, 'PageSize:', pageSize, 'Hiển thị nút Xem thêm:', total > currentPage * pageSize);

                    // Thêm nút Xem thêm nếu còn feedback
                    if (total > currentPage * pageSize) {
                        const newLoadMoreBtn = document.createElement('button');
                        newLoadMoreBtn.className = 'load-more-btn';
                        newLoadMoreBtn.innerHTML = 'Xem thêm đánh giá';
                        newLoadMoreBtn.addEventListener('click', () => loadFeedbacks(false));
                        feedbacksContainer.appendChild(newLoadMoreBtn);
                    }

                    // Tăng currentPage sau khi kiểm tra nút
                    currentPage++;
                } else {
                    if (resetPage) {
                        feedbacksContainer.innerHTML = '<div class="no-reviews"><p>Không có đánh giá nào cho mức sao này.</p></div>';
                    }
                }

                isLoading = false;
            })
            .catch(error => {
                console.error('Lỗi khi tải đánh giá:', error);
                isLoading = false;
            });
    }

    function updateFilterCounts(distribution) {
        document.querySelectorAll('.filter-btn').forEach(btn => {
            const rating = parseInt(btn.dataset.rating);
            const countSpan = btn.querySelector('.count');
            if (!countSpan) {
                console.error('Không tìm thấy phần tử .count trong nút lọc:', btn);
                return;
            }
            const count = rating === 0 ? distribution.total :
                (distribution.distribution && distribution.distribution[rating - 1] !== undefined ? distribution.distribution[rating - 1] : 0);
            countSpan.textContent = '(' + count + ')';
        });
    }

    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            if (btn.classList.contains('active')) return;

            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            currentRating = parseInt(btn.dataset.rating);
            loadFeedbacks(true);
        });
    });

    // Gọi API khi tab Đánh giá được hiển thị
    document.querySelector('#nav-review-tab').addEventListener('shown.bs.tab', function () {
        console.log('Tab Đánh giá được hiển thị');
        loadRatingDistribution();
        loadFeedbacks(true);
    });

    // Tải dữ liệu ban đầu
    loadRatingDistribution();
    loadFeedbacks(true);

    // Add to cart handler
    document.querySelector('.shop-btn').addEventListener('click', function(e) {
        e.preventDefault();
        const userID = '${sessionScope.user.userID}';
        const productID = '${pv.product.productId}';
        const variantID = '${pv.variantID}';
        window.addToCart(userID, productID, variantID);
    });

    
});
</script>
    </body>
</html>
