<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <jsp:include page="Common/Css.jsp"/>
        <style>
            .partnership-chat-button {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                border-radius: 50%;
                border: none;
                cursor: pointer;
                box-shadow: 0 8px 25px rgba(174, 28, 154, 0.4);
                transition: all 0.3s ease;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .partnership-chat-button:hover {
                transform: scale(1.1);
                box-shadow: 0 12px 30px rgba(174, 28, 154, 0.6);
            }

            .partnership-chat-button svg {
                width: 28px;
                height: 28px;
                fill: white;
            }

            /* Partnership Chat Window */
            .partnership-chat-window {
                position: fixed;
                bottom: 100px;
                right: 30px;
                width: 400px;
                height: 600px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.15);
                transform: translateY(20px) scale(0.9);
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                z-index: 999;
                overflow: hidden;
            }

            .partnership-chat-window.active {
                transform: translateY(0) scale(1);
                opacity: 1;
                visibility: visible;
            }

            .partnership-chat-header {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: white;
                padding: 20px;
                text-align: center;
                position: relative;
            }

            .partnership-chat-header h3 {
                font-size: 1.3rem;
                font-weight: 600;
            }

            .partnership-chat-header p {
                font-size: 0.9rem;
                opacity: 0.9;
                margin-top: 5px;
            }

            .partnership-close-btn {
                position: absolute;
                top: 15px;
                right: 15px;
                background: none;
                border: none;
                color: white;
                font-size: 1.5rem;
                cursor: pointer;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                transition: background 0.2s;
            }

            .partnership-close-btn:hover {
                background: rgba(255,255,255,0.2);
            }

            .partnership-chat-form {
                padding: 25px;
                height: calc(100% - 80px);
                overflow-y: auto;
            }

            .partnership-form-group {
                margin-bottom: 20px;
            }

            .partnership-form-group label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: 500;
                font-size: 0.95rem;
            }

            .partnership-form-group input,
            .partnership-form-group select,
            .partnership-form-group textarea {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e1e5e9;
                border-radius: 12px;
                font-size: 0.95rem;
                transition: border-color 0.3s, box-shadow 0.3s;
                font-family: inherit;
            }

            .partnership-form-group input:focus,
            .partnership-form-group select:focus,
            .partnership-form-group textarea:focus {
                outline: none;
                border-color: #AE1C9A;
                box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
            }

            .partnership-form-group textarea {
                resize: vertical;
                min-height: 80px;
            }

            .partnership-submit-btn {
                width: 100%;
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: white;
                border: none;
                padding: 15px;
                border-radius: 12px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
            }

            .partnership-submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(174, 28, 154, 0.3);
            }

            .partnership-submit-btn:active {
                transform: translateY(0);
            }

            /* Responsive */
            @media (max-width: 480px) {
                .partnership-chat-window {
                    width: calc(100vw - 20px);
                    height: calc(100vh - 40px);
                    bottom: 20px;
                    right: 10px;
                    left: 10px;
                    border-radius: 15px;
                }

                .partnership-chat-button {
                    bottom: 20px;
                    right: 20px;
                }
            }

            /* Success Message */
            .partnership-success-message {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
                padding: 15px;
                border-radius: 12px;
                margin-bottom: 20px;
                text-align: center;
                display: none;
            }

            .partnership-success-message.show {
                display: block;
            }
            .penguinshop-membership-section {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(135deg, #f8f9ff 0%, #eeebf7 100%);
                border-radius: 20px;
                padding: 40px;
                max-width: 1300px;
                margin: 0 auto;
                box-shadow: 0 10px 30px rgba(174, 28, 154, 0.1);
            }

            .penguinshop-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 30px;
            }

            .penguinshop-left-content {
                flex: 1;
            }

            .penguinshop-title {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 30px;
                line-height: 1.4;
            }

            .penguinshop-highlight-number {
                color: #AE1C9A;
                font-weight: 800;
            }

            .penguinshop-benefits-grid {
                display: flex;
                gap: 20px;
                flex-wrap: nowrap;
            }

            .penguinshop-benefit-card {
                background: #AE1C9A;
                color: white;
                padding: 20px 25px;
                border-radius: 15px;
                flex: 1;
                min-width: 180px;
                max-width: 200px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                box-shadow: 0 5px 20px rgba(174, 28, 154, 0.3);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .penguinshop-benefit-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(174, 28, 154, 0.4);
            }

            .penguinshop-benefit-icon {
                width: 24px;
                height: 24px;
                margin-bottom: 5px;
            }

            .penguinshop-benefit-title {
                font-weight: bold;
                font-size: 16px;
                line-height: 1.3;
            }

            .penguinshop-benefit-subtitle {
                font-size: 14px;
                opacity: 0.9;
                line-height: 1.2;
            }

            .penguinshop-multiplier {
                font-size: 48px;
                font-weight: 900;
                color: white;
                margin-left: 10px;
            }

            .penguinshop-right-content {
                flex-shrink: 0;
                text-align: center;
            }

            .penguinshop-activity-header {
                font-size: 18px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }

            .penguinshop-activity-text {
                background: white;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 20px;
                font-size: 14px;
                line-height: 1.6;
                color: #555;
                box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            }

            .penguinshop-join-button {
                background: #000;
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 25px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 10px;
            }

            .penguinshop-join-button:hover {
                background: #333;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .penguinshop-arrow {
                font-size: 18px;
            }

            @media (max-width: 768px) {
                .penguinshop-container {
                    flex-direction: column;
                    gap: 30px;
                }

                .penguinshop-benefits-grid {
                    flex-direction: column;
                    flex-wrap: nowrap;
                }

                .penguinshop-benefit-card {
                    max-width: none;
                }

                .penguinshop-membership-section {
                    padding: 30px 20px;
                }

                .penguinshop-title {
                    font-size: 20px;
                }
                .color-select, .size-select {
                    width: 100%;
                    height: 32px;
                    padding: 6px 10px;
                    border: 1.5px solid #e0e0e0;
                    border-radius: 6px;
                    font-size: 13px;
                    color: #333;
                    background-color: #fff;
                    background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="%23666" d="M2 0L0 2h4zm0 5L0 3h4z"/></svg>');
                    background-repeat: no-repeat;
                    background-position: right 8px center;
                    background-size: 12px;
                    appearance: none;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    outline: none;
                }

                .color-select:hover, .size-select:hover {
                    border-color: #ccc;
                }

                .color-select:focus, .size-select:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 0 2px rgba(0,123,255,0.15);
                }

                .color-select option, .size-select option {
                    padding: 8px;
                    font-size: 13px;
                }

                .color-select option[disabled], .size-select option[disabled] {
                    color: #999;
                }

            </style>
        </head>
        <body>

            <!--------------- header-section-end --------------->
            <jsp:include page="Common/Header.jsp"/>
            <!--------------- hero-section --------------->

            <section id="hero" class="hero">
                <div class="swiper hero-swiper">
                    <c:forEach items="${banner}" var="banner">
                        <div class="hero-wrapper">
                            <div class="swiper-slide" style="padding: 0 !important;
                                 margin: 0 !important;">
                                <img src="api/img/${banner.bannerLink}" style="width: 100vw;
                                     display: block;" />
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Nút trước và sau -->
                <button class="swiper-button-prev" style="position: absolute;
                        top: 70%;
                        left: 10px;
                        transform: translateY(-50%);
                        z-index: 10;"></button>
                <button class="swiper-button-next" style="position: absolute;
                        top: 70%;
                        right: 10px;
                        transform: translateY(-50%);
                        z-index: 10;"></button>
            </section>





            <!--------------- hero-section-end --------------->

            <!--------------- style-section --------------->
            <section style="margin-bottom: 50px" class="product-category">
                <div class="container">
                    <div class="section-title">
                        <h5>Danh mục sản phẩm</h5>

                    </div>
                    <div class="category-section">
                        <c:forEach var="cate" items="${cate}">
                            <div class="product-wrapper" data-aos="fade-right" data-aos-duration="200">
                                <div class="wrapper-img">
                                    <a href="search?cate=${cate.categoryId}">
                                        <img src="api/img/${cate.imageCategory}"style="width: 100px;
                                             height: 100px;
                                             border-radius: 50%;
                                             object-fit: cover;" alt="${cate.categoryName}"></a>
                                </div>
                                <div class="wrapper-info">
                                    <a href="search?cate=${cate.categoryId}" class="wrapper-details">${cate.categoryName}</a>
                                </div>
                            </div>
                        </c:forEach>    
                    </div>
                </div>
            </section>
            <section style="margin-bottom: 30px" class="product weekly-sale">
                <div class="container">
                    <div class="section-title">
                        <h5>Bán chạy nhất tuần</h5>
                        <a href="search" class="view">Xem tất cả</a>
                    </div>
                    <div class="weekly-sale-section">
                        <div class="row g-5">
                            <c:forEach var="top4Week" items="${top4Week}">
                                <div class="col-lg-3 col-md-6">
                                    <div style="height: 550px !important" class="product-wrapper" data-aos="fade-up">
                                        <div class="product-img">
                                            <a href="productdetail?id=${top4Week.variantID}">
                                                <img src="api/img/${top4Week.product.imageMainProduct}"
                                                     style="width: 308px;
                                                     height: 313px;
                                                     object-fit: fill;
                                                     display: block;
                                                     margin: 0;" 
                                                     alt="${top4Week.product.productName}">
                                            </a>
                                        </div>
                                        <div class="product-info">
                                            <div class="ratings">
                                                <span>
                                                    <svg width="75" height="15" viewBox="0 0 75 15" fill="none" xmlns="http://www.w3.org/2000/svg">...</svg>
                                                </span>
                                            </div>
                                            <div class="product-description">
                                                <a href="productdetail?id=${top4Week.variantID}" class="product-details" 
                                                   style="display: block;
                                                   height: 40px;
                                                   line-height: 20px;
                                                   overflow: hidden;
                                                   text-overflow: ellipsis;
                                                   white-space: nowrap;
                                                   width: 100%;
                                                   font-size: 16px;">
                                                    ${top4Week.product.productName}
                                                </a>

                                                <!-- Dropdown màu và size -->
                                                <div class="product-variants" style="display: flex;
                                                     gap: 20px;
                                                     margin: 8px 0;">
                                                    <div class="product-color" style="margin-bottom: 8px;">
                                                        <label style="font-size: 12px;
                                                               color: #666;
                                                               margin-bottom: 4px;
                                                               display: block;
                                                               font-weight: 500;">Màu:</label>
                                                        <select class="color-select" 
                                                                data-product-id="${top4Week.product.productId}"
                                                                style="width: 100%;
                                                                height: 32px;
                                                                padding: 6px 10px;
                                                                border: 1.5px solid #e0e0e0;
                                                                border-radius: 6px;
                                                                font-size: 13px;
                                                                color: #333;
                                                                background-color: #fff;
                                                                background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 4 5\"><path fill=\"%23666\" d=\"M2 0L0 2h4zm0 5L0 3h4z\"/></svg>');
                                                                background-repeat: no-repeat;
                                                                background-position: right 8px center;
                                                                background-size: 12px;
                                                                appearance: none;
                                                                cursor: pointer;
                                                                transition: all 0.2s ease;
                                                                outline: none;"
                                                                onchange="updateVariantDetails(${top4Week.product.productId}, this)">
                                                            <option value="" disabled selected style="color: #999;">Chọn màu</option>
                                                        </select>
                                                    </div>

                                                    <div class="product-size">
                                                        <label style="font-size: 12px;
                                                               color: #666;
                                                               margin-bottom: 4px;
                                                               display: block;
                                                               font-weight: 500;">Size:</label>
                                                        <select class="size-select" 
                                                                data-product-id="${top4Week.product.productId}"
                                                                style="width: 100%;
                                                                height: 32px;
                                                                padding: 6px 10px;
                                                                border: 1.5px solid #e0e0e0;
                                                                border-radius: 6px;
                                                                font-size: 13px;
                                                                color: #333;
                                                                background-color: #fff;
                                                                background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 4 5\"><path fill=\"%23666\" d=\"M2 0L0 2h4zm0 5L0 3h4z\"/></svg>');
                                                                background-repeat: no-repeat;
                                                                background-position: right 8px center;
                                                                background-size: 12px;
                                                                appearance: none;
                                                                cursor: pointer;
                                                                transition: all 0.2s ease;
                                                                outline: none;"
                                                                onchange="updateVariantDetails(${top4Week.product.productId}, this)">
                                                            <option value="" disabled selected style="color: #999;">Chọn size</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="price">
                                                    <span class="new-price"></span>
                                                    <span class="stock-status" style="font-size: 12px;
                                                          color: ${top4Week.quantity > 0 ? '#28a745' : '#dc3545'};
                                                          display: block;
                                                          margin-top: 4px;
                                                          font-weight: 500;"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-cart-btn">
                                            <a class="product-btn" 
                                               data-user-id="${user.userID}" 
                                               data-product-id="${top4Week.product.productId}" 
                                               data-variant-id="${top4Week.variantID}"
                                               <c:if test="${top4Week.quantity == 0}">disabled style="pointer-events: none;
                                                   opacity: 0.6;"</c:if>>
                                                   Thêm giỏ hàng
                                               </a>
                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="style-section">
                        <div class="row gy-4 gx-5 gy-lg-0">
                            <div class="col-lg-6">
                                <div class="product-wrapper wrapper-one" data-aos="fade-right" 
                                     style="background-image: url('api/img/Frame_87642_gmkefh.webp');
                                     background-size: cover;
                                     background-position: center;
                                     position: relative;">
                                    <div class="wrapper-info" style="left: -150px;
                                         width: 430px;
                                         position: relative;
                                         background-color: rgba(0, 0, 0, 0.3);
                                         border-radius: 20px;
                                         padding: 20px;">
                                        <span style="color: white;
                                              font-size: 24px;
                                              font-family: Arial, sans-serif;" class="wrapper-subtitle">MAN WEAR</span>
                                        <h4 style="color: white;
                                            font-family: Arial, sans-serif;" class="wrapper-details">MÙA HÈ KHÔNG NÓNG 
                                            <span style="color: white;" class="wrapper-inner-title">CÙNG PENGUIN</span> SHOP.
                                        </h4>
                                        <a href="product-sidebar.html" class="shop-btn">Mua ngay
                                            <span>
                                                <svg width="8" height="14" viewBox="0 0 8 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.45312" y="0.914062" width="9.25346" height="2.05632" transform="rotate(45 1.45312 0.914062)" fill="#A3CFFA" />
                                                <rect x="8" y="7.45703" width="9.25346" height="2.05632" transform="rotate(135 8 7.45703)" fill="#A3CFFA" />
                                                </svg>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="product-wrapper wrapper-two" data-aos="fade-up"
                                     style="background-image: url('api/img/Frame_87638_sleq2z.webp');
                                     background-size: cover;
                                     background-position: center;">
                                    <div class="wrapper-info" style="position: relative;
                                         background-color: rgba(0, 0, 0, 0.3);
                                         border-radius: 20px;
                                         padding: 20px;">
                                        <span style="color:white;" class="wrapper-subtitle">WOMEN ACTIVE</span>
                                        <h4 style="color:white;" class="wrapper-details">
                                            MÙA HÈ KHÔNG NÓNG
                                            <span style="color:white;" class="wrapper-inner-title">CÙNG PENGUIN</span>
                                            SHOP
                                        </h4>
                                        <a href="search" class="shop-btn">Mua ngay
                                            <span>
                                                <svg width="8" height="14" viewBox="0 0 8 14" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.45312" y="0.914062" width="9.25346" height="2.05632"
                                                      transform="rotate(45 1.45312 0.914062)" />
                                                <rect x="8" y="7.45703" width="9.25346" height="2.05632"
                                                      transform="rotate(135 8 7.45703)" />
                                                </svg>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="product brand" data-aos="fade-up">
                <div class="container">
                    <div class="section-title">
                        <h5>Sản phẩm thương hiệu</h5>
                        <a href="search" class="view">Xem tất cả</a>
                    </div>
                    <div class="brand-section">
                        <c:forEach var="brand" items="${brand}">
                            <div class="product-wrapper">
                                <div class="wrapper-img">
                                    <a href="search?brand=${brand.brandID}">
                                        <img src="api/img/${brand.logo}" style="height: 80px;
                                             width: auto;
                                             object-fit: contain;" alt="img">
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
            <!--------------- style-section-end --------------->
            <section class="product arrival">
                <div class="container">
                    <div class="section-title">
                        <h5>Hàng mới về</h5>
                        <a href="search?cate=11" class="view">Xem tất cả</a>
                    </div>
                    <div class="arrival-section">
                        <div class="row g-5">
                            <c:forEach var="newArrival" items="${newArrival}">
                                <div class="col-lg-3 col-sm-6">
                                    <div style="height: 550px !important" class="product-wrapper" data-aos="fade-up">
                                        <div class="product-img">
                                            <a href="productdetail?id=${newArrival.variantID}">
                                                <img src="api/img/${newArrival.product.imageMainProduct}" 
                                                     style="width: 308px;
                                                     height: 313px;
                                                     object-fit: fill;
                                                     display: block;
                                                     margin: 0;" 
                                                     alt="${newArrival.product.productName}">
                                            </a>   
                                        </div>

                                        <div class="product-info">
                                            <div class="ratings">
                                                <span>
                                                    <svg width="75" height="15" viewBox="0 0 75 15" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M7.5 0L9.18386 5.18237H14.6329L10.2245 8.38525L11.9084 13.5676L7.5 10.3647L3.09161 13.5676L4.77547 8.38525L0.367076 5.18237H5.81614L7.5 0Z" fill="#FFA800" />
                                                    <path d="M22.5 0L24.1839 5.18237H29.6329L25.2245 8.38525L26.9084 13.5676L22.5 10.3647L18.0916 13.5676L19.7755 8.38525L15.3671 5.18237H20.8161L22.5 0Z" fill="#FFA800" />
                                                    <path d="M37.5 0L39.1839 5.18237H44.6329L40.2245 8.38525L41.9084 13.5676L37.5 10.3647L33.0916 13.5676L34.7755 8.38525L30.3671 5.18237H35.8161L37.5 0Z" fill="#FFA800" />
                                                    <path d="M52.5 0L54.1839 5.18237H59.6329L55.2245 8.38525L56.9084 13.5676L52.5 10.3647L48.0916 13.5676L49.7755 8.38525L45.3671 5.18237H50.8161L52.5 0Z" fill="#FFA800" />
                                                    <path d="M67.5 0L69.1839 5.18237H74.6329L70.2245 8.38525L71.9084 13.5676L67.5 10.3647L63.0916 13.5676L64.7755 8.38525L60.3671 5.18237H65.8161L67.5 0Z" fill="#FFA800" />
                                                    </svg>
                                                </span>
                                            </div>
                                            <div class="product-description">
                                                <a href="productdetail?id=${newArrival.variantID}" class="product-details" 
                                                   style="display: block;
                                                   height: 40px;
                                                   line-height: 20px;
                                                   overflow: hidden;
                                                   text-overflow: ellipsis;
                                                   white-space: nowrap;
                                                   width: 100%;
                                                   font-size: 16px;">
                                                    ${newArrival.product.productName}
                                                </a>

                                                <!-- Dropdown màu và size -->
                                                <div class="product-variants" style="display: flex;
                                                     gap: 20px;
                                                     margin: 8px 0;">
                                                    <div class="product-color" style="margin-bottom: 8px;">
                                                        <label style="font-size: 12px;
                                                               color: #666;
                                                               margin-bottom: 4px;
                                                               display: block;
                                                               font-weight: 500;">Màu:</label>
                                                        <select class="color-select" 
                                                                data-product-id="${newArrival.product.productId}"
                                                                style="width: 100%;
                                                                height: 32px;
                                                                padding: 6px 10px;
                                                                border: 1.5px solid #e0e0e0;
                                                                border-radius: 6px;
                                                                font-size: 13px;
                                                                color: #333;
                                                                background-color: #fff;
                                                                background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 4 5\"><path fill=\"%23666\" d=\"M2 0L0 2h4zm0 5L0 3h4z\"/></svg>');
                                                                background-repeat: no-repeat;
                                                                background-position: right 8px center;
                                                                background-size: 12px;
                                                                appearance: none;
                                                                cursor: pointer;
                                                                transition: all 0.2s ease;
                                                                outline: none;"
                                                                onchange="updateVariantDetails(${newArrival.product.productId}, this)">
                                                            <option value="" disabled selected style="color: #999;">Chọn màu</option>
                                                        </select>
                                                    </div>

                                                    <div class="product-size">
                                                        <label style="font-size: 12px;
                                                               color: #666;
                                                               margin-bottom: 4px;
                                                               display: block;
                                                               font-weight: 500;">Size:</label>
                                                        <select class="size-select" 
                                                                data-product-id="${newArrival.product.productId}"
                                                                style="width: 100%;
                                                                height: 32px;
                                                                padding: 6px 10px;
                                                                border: 1.5px solid #e0e0e0;
                                                                border-radius: 6px;
                                                                font-size: 13px;
                                                                color: #333;
                                                                background-color: #fff;
                                                                background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 4 5\"><path fill=\"%23666\" d=\"M2 0L0 2h4zm0 5L0 3h4z\"/></svg>');
                                                                background-repeat: no-repeat;
                                                                background-position: right 8px center;
                                                                background-size: 12px;
                                                                appearance: none;
                                                                cursor: pointer;
                                                                transition: all 0.2s ease;
                                                                outline: none;"
                                                                onchange="updateVariantDetails(${newArrival.product.productId}, this)">
                                                            <option value="" disabled selected style="color: #999;">Chọn size</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="price">
                                                    <span class="new-price"></span>
                                                    <span class="stock-status" style="font-size: 12px;
                                                          display: block;
                                                          margin-top: 4px;
                                                          font-weight: 500;"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="product-cart-btn">
                                            <a class="product-btn" 
                                               data-user-id="${user.userID}" 
                                               data-product-id="${newArrival.product.productId}" 
                                               data-variant-id="${newArrival.variantID}"
                                               <c:if test="${newArrival.quantity == 0}">disabled style="pointer-events: none;
                                                   opacity: 0.6;"</c:if>>
                                                   Thêm giỏ hàng
                                               </a>
                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>
            <!--------------- category-section--------------->

            <!--------------- category-section-end--------------->

            <!--------------- brand-section--------------->

            <!--------------- brand-section-end--------------->

            <!--------------- arrival-section--------------->

            <!--------------- arrival-section-end--------------->

            <!--------------- flash-section--------------->
            <section class="product flash-sale">
                <div class="container">
                    <div class="section-title">
                        <h5>Flash Sale</h5>
                        <div class="countdown-section">
                            <div class="countdown-items">
                                <span id="day" class="number" style="color: red;">--</span>
                                <span class="text">Days</span>
                            </div>
                            <div class="countdown-items">
                                <span id="hour" class="number" style="color: skyblue;">--</span>
                                <span class="text">Hours</span>
                            </div>
                            <div class="countdown-items">
                                <span id="minute" class="number" style="color: green;">--</span>
                                <span class="text">Minutes</span>
                            </div>
                            <div class="countdown-items">
                                <span id="second" class="number" style="color: red;">--</span>
                                <span class="text">Seconds</span>
                            </div>
                        </div>
                        <a href="" class="view">Xem thêm</a>
                        <input type="hidden" id="endDate" value="${flashSale.endDate}"/>
                    </div>
                    <div class="flash-sale-section">
                        <div class="row g-5">
                            <c:if test="${not empty flashSale and not empty flashSale.variant}">
                                <c:forEach var="variant" items="${flashSale.variant}">
                                    <div class="col-lg-3 col-sm-6">
                                        <div style="height: 550px !important" class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <a href="productdetail?id=${variant.variantID}">
                                                    <img src="api/img/${variant.product.imageMainProduct}" 
                                                         style="width: 308px;
                                                         height: 313px;
                                                         object-fit: fill;
                                                         display: block;
                                                         margin: 0;" 
                                                         alt="${variant.product.productName}">
                                                </a>   
                                            </div>

                                            <div class="product-info">
                                                <div class="ratings">
                                                    <span>
                                                        <svg width="75" height="15" viewBox="0 0 75 15" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M7.5 0L9.18386 5.18237H14.6329L10.2245 8.38525L11.9084 13.5676L7.5 10.3647L3.09161 13.5676L4.77547 8.38525L0.367076 5.18237H5.81614L7.5 0Z" fill="#FFA800" />
                                                        <path d="M22.5 0L24.1839 5.18237H29.6329L25.2245 8.38525L26.9084 13.5676L22.5 10.3647L18.0916 13.5676L19.7755 8.38525L15.3671 5.18237H20.8161L22.5 0Z" fill="#FFA800" />
                                                        <path d="M37.5 0L39.1839 5.18237H44.6329L40.2245 8.38525L41.9084 13.5676L37.5 10.3647L33.0916 13.5676L34.7755 8.38525L30.3671 5.18237H35.8161L37.5 0Z" fill="#FFA800" />
                                                        <path d="M52.5 0L54.1839 5.18237H59.6329L55.2245 8.38525L56.9084 13.5676L52.5 10.3647L48.0916 13.5676L49.7755 8.38525L45.3671 5.18237H50.8161L52.5 0Z" fill="#FFA800" />
                                                        <path d="M67.5 0L69.1839 5.18237H74.6329L70.2245 8.38525L71.9084 13.5676L67.5 10.3647L63.0916 13.5676L64.7755 8.38525L60.3671 5.18237H65.8161L67.5 0Z" fill="#FFA800" />
                                                        </svg>
                                                    </span>
                                                </div>
                                                <div class="product-description">
                                                    <a href="productdetail?id=${variant.variantID}" class="product-details" 
                                                       style="display: block;
                                                       height: 40px;
                                                       line-height: 20px;
                                                       overflow: hidden;
                                                       text-overflow: ellipsis;
                                                       white-space: nowrap;
                                                       width: 100%;
                                                       font-size: 16px;">
                                                        ${variant.product.productName}
                                                    </a>

                                                    <!-- Dropdown màu và size -->
                                                    <div class="product-variants" style="display: flex;
                                                         gap: 20px;
                                                         margin: 8px 0;">
                                                        <div class="product-color" style="margin-bottom: 8px;">
                                                            <label style="font-size: 12px;
                                                                   color: #666;
                                                                   margin-bottom: 4px;
                                                                   display: block;
                                                                   font-weight: 500;">Màu:</label>
                                                            <input class="" 
                                                                   disabled=""
                                                                   style="width: 100px;
                                                                   height: 32px;
                                                                   padding: 6px 10px;
                                                                   border: 1.5px solid #e0e0e0;
                                                                   border-radius: 6px;
                                                                   font-size: 13px;
                                                                   color: #333;

                                                                   outline: none;"
                                                                   value="${variant.color.colorName}"
                                                                   />

                                                        </div>

                                                        <div class="product-size">
                                                            <label style="font-size: 12px;
                                                                   color: #666;
                                                                   margin-bottom: 4px;
                                                                   display: block;
                                                                   font-weight: 500;">Size:</label>
                                                            <input class="" 
                                                                   disabled=""
                                                                   style="width: 100px;
                                                                   height: 32px;
                                                                   padding: 6px 10px;
                                                                   border: 1.5px solid #e0e0e0;
                                                                   border-radius: 6px;
                                                                   font-size: 13px;
                                                                   color: #333;

                                                                   outline: none;"
                                                                   value="${variant.size.sizeName}"
                                                                   />
                                                        </div>
                                                    </div>

                                                    <div class="price">
                                                        <!-- Giá gốc -->
                                                        <c:set var="oldPrice" value="${variant.price}"/>
                                                        <!-- Tính giá sau giảm -->
                                                        <c:set var="discountPrice" value="${flashSale.discountType == 'PERCENTAGE' ? 
                                                                                            oldPrice * (1 - flashSale.discountValue / 100) : 
                                                                                            oldPrice - flashSale.discountValue}"/>
                                                        <span class="price-cut"><fmt:formatNumber value="${oldPrice}" type="currency" currencyCode="VND" pattern="#,##0"/>đ</span>
                                                        <span class="new-price"><fmt:formatNumber value="${discountPrice}" type="currency" currencyCode="VND" pattern="#,##0"/>đ</span>
                                                        <span class="stock-status" style="font-size: 12px;
                                                              display: block;
                                                              margin-top: 4px;
                                                              font-weight: 500;">
                                                            <c:choose>
                                                                <c:when test="${variant.quantity > 0}">Còn hàng</c:when>
                                                                <c:otherwise>Hết hàng</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="product-cart-btn">
                                                <a class="product-btn" 
                                                   data-user-id="${user.userID}" 
                                                   data-product-id="${variant.product.productId}" 
                                                   data-variant-id="${variant.variantID}"
                                                   <c:if test="${variant.quantity == 0}">disabled style="pointer-events: none;
                                                       opacity: 0.6;"</c:if>>
                                                       Thêm giỏ hàng
                                                   </a>
                                                </div>
                                            </div>
                                        </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty flashSale or empty flashSale.variant}">
                                <p>No Flash Sale available.</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </section>
            <!--------------- flash-section-end--------------->

            <!--------------- top-sell-section--------------->
            <section class="product top-selling">
                <div class="container">
                    <div class="section-title">
                        <h5>Sản phẩm hot</h5>
                        <a href="search?cate=9" class="view">Xem tất cả</a>
                    </div>
                    <div class="top-selling-section">
                        <div class="row g-5">
                            <c:forEach var="hot" items="${hot}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="product-wrapper" data-aos="fade-right">
                                        <div class="product-img">
                                            <a href="productdetail?id=${hot.variantID}">
                                                <img src="api/img/${hot.product.imageMainProduct}"
                                                     alt="product-img">
                                            </a>
                                        </div>
                                        <div class="product-info">
                                            <div class="ratings" style="margin-bottom: 8px !important;
                                                 height: 20px !important;
                                                 display: flex !important;
                                                 align-items: center !important;">
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
                                                <a href="productdetail?id=${hot.variantID}" class="product-details" 
                                                   style="display: block !important;
                                                   width: 100% !important;
                                                   max-width: 200px !important;
                                                   line-height: 18px !important;
                                                   overflow: hidden !important;
                                                   text-overflow: ellipsis !important;
                                                   white-space: nowrap !important;
                                                   height: 36px !important;
                                                   font-size: 14px !important;
                                                   margin-bottom: 8px !important;
                                                   color: #333 !important;
                                                   text-decoration: none !important;
                                                   display: flex !important;
                                                   align-items: center !important;">
                                                    ${hot.product.productName}
                                                </a>
                                                <div class="price" style="height: 24px !important;
                                                     display: flex !important;
                                                     align-items: center !important;
                                                     font-weight: 600 !important;">
                                                    <!--<span class="price-cut">$19.99</span>-->
                                                    <span class="new-price" style="font-size: 16px !important;
                                                          color: #e74c3c !important;
                                                          font-weight: 700 !important;">${hot.price}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>  
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>
            <!--------------- top-sell-section-end--------------->

            <!--------------- best-sell-section--------------->
            <section class="product best-seller">
                <div class="container">
                    <div class="best-selling-section">
                        <div class="section-title">
                            <h5>Nhãn hàng nổi bật</h5>
                            <a href="search" class="view">Xem tất cả</a>
                        </div>
                        <div class="best-selling-items">
                            <c:forEach var="sixbr" items="${sixbr}">
                                <div class="product-wrapper">
                                    <div class="wrapper-img">
                                        <a href="search?brand=${sixbr.brandID}">
                                            <img src="api/img/${sixbr.logo}" style="height: 80px;
                                                 width: auto;
                                                 object-fit: contain;" alt="img">
                                        </a>
                                    </div>
                                    <div class="wrapper-info">
                                        <a href="search?brand=${sixbr.brandID}" class="wrapper-details">${sixbr.brandName}</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>
            <!--------------- best-sell-section-end--------------->

            <!--------------- weekly-section--------------->

            <!--------------- weekly-section-end--------------->

            <!--------------- flash-section--------------->
            <!--        <section class="product best-product">
                        <div class="container">
                            <div class="section-title">
                                <h5>Flash Sale</h5>
                                <a href="flash-sale.html" class="view">View All</a>
                            </div>
                            <div class="best-product-section">
                                <div class="row g-4">
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-9.webp"
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
                                                    <a href="product-info.html" class="product-details">Half Sleeve Dress
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$12.99</span>
                                                        <span class="new-price">$6.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-10.webp"
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
                                                    <a href="product-info.html" class="product-details">Feminine Wrap coat
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$18.99</span>
                                                        <span class="new-price">$10.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-2.webp"
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
                                                    <a href="product-info.html" class="product-details">Black suit
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$10.99</span>
                                                        <span class="new-price">$8.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-4.webp"
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
                                                    <a href="product-info.html" class="product-details">Rainbow Party Dress
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$19.99</span>
                                                        <span class="new-price">$8.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-1.webp"
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
                                                    <a href="product-info.html" class="product-details">Rainbow Sequin Skart
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$15.99</span>
                                                        <span class="new-price">$7.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-11.webp"
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
                                                    <a href="product-info.html" class="product-details">Red Sequin Hat
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$13.99</span>
                                                        <span class="new-price">$7.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-13.webp"
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
                                                    <a href="product-info.html" class="product-details">Gradient Party Shirt
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$19.99</span>
                                                        <span class="new-price">$10.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-1.webp"
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
                                                    <a href="product-info.html" class="product-details">Flower Design Dress
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$19.99</span>
                                                        <span class="new-price">$8.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-12.webp"
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
                                                    <a href="product-info.html" class="product-details">Blue Suit
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$10.99</span>
                                                        <span class="new-price">$5.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-3.webp"
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
                                                    <a href="product-info.html" class="product-details">Blue Party Dress
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$9.99</span>
                                                        <span class="new-price">$6.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-6.webp"
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
                                                    <a href="product-info.html" class="product-details">White Hat
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$29.99</span>
                                                        <span class="new-price">$26.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4">
                                        <div class="product-wrapper" data-aos="fade-up">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-5.webp"
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
                                                    <a href="product-info.html" class="product-details">White Checked Shirt
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$19.99</span>
                                                        <span class="new-price">$16.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>-->
            <section style="margin-bottom: 200px" class="penguinshop-membership-section">
                <div class="penguinshop-container">
                    <div class="penguinshop-left-content">
                        <h2 class="penguinshop-title">
                            ĐẶC QUYỀN DÀNH CHO <span class="penguinshop-highlight-number">388,293</span> THÀNH VIÊN PENGUINSHOP
                        </h2>

                        <div class="penguinshop-benefits-grid">
                            <div class="penguinshop-benefit-card">
                                <svg class="penguinshop-benefit-icon" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                                </svg>
                                <div class="penguinshop-benefit-title">Mỗi bạn bè</div>
                                <div class="penguinshop-benefit-subtitle">hoàn tiền 10% PenguinCash</div>
                            </div>

                            <div class="penguinshop-benefit-card">
                                <div style="display: flex;
                                     align-items: center;">
                                    <div>
                                        <div class="penguinshop-benefit-title">Nếu sản phẩm có lỗi Hoàn tiền</div>
                                        <!--                                        <div class="penguinshop-benefit-subtitle">(X2 vào thứ 6)</div>-->
                                    </div>
                                    <div class="penguinshop-multiplier">X2</div>
                                </div>
                            </div>

                            <div class="penguinshop-benefit-card">
                                <svg class="penguinshop-benefit-icon" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                                </svg>
                                <div class="penguinshop-benefit-title">Quà tặng sinh nhật,</div>
                                <div class="penguinshop-benefit-subtitle">quà dịp đặc biệt</div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${empty user}">
                        <div class="penguinshop-right-content">

                            <a href="login" class="penguinshop-join-button">
                                GIA NHẬP PENGUINSHOP NGAY
                                <span class="penguinshop-arrow">→</span>
                            </a>
                        </div>
                    </c:if>
                </div>
            </section>
            
            <!--------------- footer-section--------------->
            <jsp:include page="Common/Footer.jsp"/>
            <!--------------- footer-section-end--------------->

            <jsp:include page="Common/Js.jsp"/>
            <jsp:include page="Common/Message.jsp"/>

            <!-- Thêm script thuần JS -->
            <script>
                document.addEventListener('DOMContentLoaded', function () {

                    var prevButton = document.querySelector('.swiper-button-prev');
                    var nextButton = document.querySelector('.swiper-button-next');
                    var slides = document.querySelectorAll('.swiper-slide');
                    var currentIndex = 0;

                    // Hàm hiển thị slide hiện tại
                    function showSlide(index) {
                        if (index < 0) {
                            currentIndex = slides.length - 1;
                        } else if (index >= slides.length) {
                            currentIndex = 0;
                        }
                        slides.forEach(function (slide, i) {
                            slide.style.display = i === currentIndex ? 'block' : 'none';
                        });
                    }

                    // Nút trước
                    prevButton.addEventListener('click', function () {
                        currentIndex--;
                        showSlide(currentIndex);
                    });

                    // Nút sau
                    nextButton.addEventListener('click', function () {
                        currentIndex++;
                        showSlide(currentIndex);
                    });

                    // Hiển thị slide đầu tiên khi tải trang
                    showSlide(currentIndex);
                });
            </script>
            <script>
                // Get elements
                const chatToggle = document.getElementById('partnershipChatToggle');
                const chatWindow = document.getElementById('partnershipChatWindow');
                const closeChat = document.getElementById('partnershipCloseChat');
                const supportForm = document.getElementById('partnershipSupportForm');
                const successMessage = document.getElementById('partnershipSuccessMessage');

                // Toggle chat window
                chatToggle.addEventListener('click', () => {
                    chatWindow.classList.add('active');
                });

                // Close chat window
                closeChat.addEventListener('click', () => {
                    chatWindow.classList.remove('active');
                });

                // Close when clicking outside
                document.addEventListener('click', (e) => {
                    if (!chatWindow.contains(e.target) && !chatToggle.contains(e.target)) {
                        chatWindow.classList.remove('active');
                    }
                });

                // Handle form submission


                // Hide success message when typing
                const inputs = supportForm.querySelectorAll('input, select, textarea');
                inputs.forEach(input => {
                    input.addEventListener('input', () => {
                        successMessage.classList.remove('show');
                    });
                });
            </script>
            <script>
                function handleSearch() {
                    // Lấy giá trị từ input có id="searchInput"
                    const searchInput = document.getElementById("searchInput").value.trim();

                    // Kiểm tra nếu input không rỗng
                    if (searchInput) {
                        // Điều hướng sang trang search?q= với giá trị input được mã hóa
                        window.location.href = `search?q=` + searchInput;
                    } else {
                        // Nếu input rỗng, hiển thị thông báo
                        alert("Vui lòng nhập từ khóa tìm kiếm!");
                    }
                }

            </script>
            <script>
                // Debounce flag for addToCart
                let isAddingToCart = false;

                $(document).ready(function () {
                    // Ensure jQuery is assigned to $j
                    if (typeof $j === 'undefined') {
                        window.$j = window.jQuery;
                    }
                    console.log('jQuery version:', $j && $j.fn && $j.fn.jquery);

                    // Load colors and sizes for each product
                    $('.color-select').each(function () {
                        const productId = $(this).data('product-id');
                        loadColors(productId, this);
                    });
                    $('.size-select').each(function () {
                        const productId = $(this).data('product-id');
                        loadSizes(productId, this);
                    });

                    // Add click event listener for "Thêm giỏ hàng" buttons
                    $j('.product-btn').click(function (e) {
                        e.preventDefault(); // Prevent default anchor behavior
                        const userId = $j(this).data('user-id');
                        const productId = $j(this).data('product-id');
                        const variantId = $j(this).data('variant-id');

                        console.log('Button clicked:', {userId, productId, variantId}); // Debug
                        addToCart(userId, productId, variantId);
                    });

                    // Trigger initial variant update for each product
                    $j('.product-wrapper').each(function () {
                        const productId = $j(this).find('.color-select').data('product-id');
                        const $select = $j(this).find('.color-select, .size-select');
                        if ($select.length > 0) {
                            updateVariantDetails(productId, $select[0]);
                        }
                    });
                });

                function loadColors(productId, select) {
                    const $colorSelect = $j(select);
                    $j.ajax({
                        url: 'getMaterial',
                        type: 'POST',
                        data: {action: 'getColors', productId: productId},
                        success: function (response) {
                            if (typeof response === 'string') {
                                try {
                                    response = JSON.parse(response);
                                } catch (e) {
                                    toastr.error('Lỗi dữ liệu trả về từ server!');
                                    return;
                                }
                            }

                            $colorSelect.empty();
                            $colorSelect.append('<option value="" disabled selected style="color: #999;">Chọn màu</option>');

                            response.colors.forEach(color => {
                                if (color && color.colorID && color.colorName) {
                                    $colorSelect.append($j('<option>', {
                                        value: color.colorID,
                                        text: color.colorName
                                    }));
                                } else {
                                    console.warn('Dữ liệu màu không hợp lệ:', color);
                                }
                            });

                            if (response.colors.length > 0) {
                                $colorSelect.prop('selectedIndex', 1);
                                $colorSelect.trigger('change');
                            }
                        },
                        error: function (xhr, status, error) {
                            toastr.error('Lỗi kết nối server: ' + error);
                        }
                    });
                }

                function loadSizes(productId, select) {
                    const $sizeSelect = $j(select);
                    $j.ajax({
                        url: 'getMaterial',
                        type: 'POST',
                        data: {action: 'getSizes', productId: productId},
                        success: function (response) {
                            if (typeof response === 'string') {
                                try {
                                    response = JSON.parse(response);
                                } catch (e) {
                                    toastr.error('Lỗi dữ liệu trả về từ server!');
                                    return;
                                }
                            }

                            if (response.status === 'success') {
                                $sizeSelect.find('option:not(:first)').remove();
                                response.sizes.forEach(size => {
                                    if (size && size.sizeID && size.sizeName) {
                                        $sizeSelect.append($j('<option>', {
                                            value: size.sizeID,
                                            text: size.sizeName
                                        }));
                                    } else {
                                        console.warn('Dữ liệu size không hợp lệ:', size);
                                    }
                                });

                                if (response.sizes.length > 0) {
                                    $sizeSelect.prop('selectedIndex', 1);
                                    $sizeSelect.trigger('change');
                                }
                            } else {
                                toastr.error(response.message || 'Không tìm thấy size!');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log('getSizes error:', status, error);
                            toastr.error('Lỗi kết nối server: ' + error);
                        }
                    });
                }
                function formatCurrencyVND(amount) {
                    if (isNaN(amount) || amount === null || amount === undefined) {
                        return 'Liên hệ';
                    }
                    return Number(amount).toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        minimumFractionDigits: 0,
                        maximumFractionDigits: 0
                    });
                }

                function updateVariantDetails(productId, select) {
                    const $colorSelect = $j(select).closest('.product-variants').find('.color-select');
                    const $sizeSelect = $j(select).closest('.product-variants').find('.size-select');
                    const $priceSpan = $j(select).closest('.product-info').find('.new-price');
                    const $stockStatus = $j(select).closest('.product-info').find('.stock-status');
                    const $addToCartBtn = $j(select).closest('.product-wrapper').find('.product-btn');

                    const colorId = $colorSelect.val();
                    const sizeId = $sizeSelect.val();

                    if (colorId && sizeId) {
                        $j.ajax({
                            url: 'getMaterial',
                            type: 'POST',
                            data: {
                                action: 'getVariantDetails',
                                productId: productId,
                                colorId: colorId,
                                sizeId: sizeId
                            },
                            success: function (response) {
                                if (typeof response === 'string') {
                                    try {
                                        response = JSON.parse(response);
                                    } catch (e) {
                                        toastr.error('Lỗi dữ liệu trả về từ server!');
                                        return;
                                    }
                                }

                                if (response.status === 'success') {
                                    // Format giá trước khi gán
                                    $priceSpan.text(formatCurrencyVND(response.price));
                                    $stockStatus.text(response.statuspro === "1" ? 'Còn hàng' : 'Hết hàng');
                                    $stockStatus.css('color', response.quantity > 0 ? '#28a745' : '#dc3545');
                                    if (response.quantity > 0) {
                                        $addToCartBtn.removeAttr('disabled').css({
                                            'pointer-events': 'auto',
                                            'opacity': 1
                                        });
                                    } else {
                                        $addToCartBtn.attr('disabled', true).css({
                                            'pointer-events': 'none',
                                            'opacity': 0.6
                                        });
                                    }
                                } else {
                                    toastr.error(response.message || 'Không tìm thấy thông tin biến thể!');
                                }
                            },
                            error: function (xhr, status, error) {
                                toastr.error('Lỗi kết nối server: ' + error);
                            }
                        });
                    }
                }

                function addToCart(userID, productID, variantID) {
                    if (isAddingToCart)
                        return;
                    isAddingToCart = true;

                    console.log('addToCart called with:', {userID, productID, variantID});
                    if (!variantID || variantID === 'undefined') {
                        toastr.error('Vui lòng chọn màu và size!');
                        isAddingToCart = false;
                        return;
                    }

                    $j.ajax({
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
                            toastr.error('Lỗi kết nối server: ' + error);
                            isAddingToCart = false;
                        }
                    });
                }

                document.addEventListener('DOMContentLoaded', function () {
                    if (typeof $j === 'undefined') {
                        window.$j = window.jQuery;
                    }
                    console.log('jQuery version:', $j && $j.fn && $j.fn.jquery);

                    $j('.color-select, .size-select').change(function () {
                        const productId = $j(this).data('product-id');
                        const colorId = $j(this).closest('.product-variants').find('.color-select').val();
                        const sizeId = $j(this).closest('.product-variants').find('.size-select').val();
                        const wrapper = $j(this).closest('.product-wrapper');

                        console.log('Change event - productId:', productId, 'colorId:', colorId, 'sizeId:', sizeId);

                        if (colorId && sizeId) {
                            $j.ajax({
                                url: 'getMaterial',
                                type: 'POST',
                                data: {
                                    action: 'getVariant',
                                    productId: productId,
                                    colorId: colorId,
                                    sizeId: sizeId
                                },
                                success: function (response) {
                                    console.log('getVariant response:', response);
                                    if (response.status === 'success') {
                                        wrapper.find('.new-price').text(formatCurrencyVND(response.variant.price));
                                        wrapper.find('.stock-status')
                                                .text(response.variant.statuspro === "1" ? 'Còn hàng' : 'Hết hàng')
                                                .css('color', response.variant.statuspro === "1" ? '#28a745' : '#dc3545');
                                        wrapper.find('.product-btn')
                                                .attr('data-variant-id', response.variant.variantID)
                                                .prop('disabled', response.variant.statuspro === "0")
                                                .css({
                                                    'pointer-events': response.variant.statuspro === "0" ? 'none' : 'auto',
                                                    'opacity': response.variant.statuspro === "0" ? 0.6 : 1
                                                });
                                        wrapper.find('.product-details, .product-img a')
                                                .attr('href', 'productdetail?id=' + response.variant.variantID);
                                    } else {
                                        toastr.error(response.message || 'Không tìm thấy biến thể!');
                                        wrapper.find('.product-btn')
                                                .prop('disabled', true)
                                                .css({'pointer-events': 'none', 'opacity': 0.6});
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.log('getVariant error:', status, error);
                                    toastr.error('Lỗi kết nối server: ' + error);
                                    wrapper.find('.product-btn')
                                            .prop('disabled', true)
                                            .css({'pointer-events': 'none', 'opacity': 0.6});
                                }
                            });
                        } else {
                            wrapper.find('.product-btn')
                                    .prop('disabled', true)
                                    .css({'pointer-events': 'none', 'opacity': 0.6});
                        }
                    });
                });
            </script>

            <script>
                const endDateStr = document.getElementById('endDate').value;
                const endDate = new Date(endDateStr);

                function updateCountdown() {
                    const now = new Date();
                    const timeDiff = endDate - now;

                    if (timeDiff <= 0) {
                        document.getElementById('day').textContent = '00';
                        document.getElementById('hour').textContent = '00';
                        document.getElementById('minute').textContent = '00';
                        document.getElementById('second').textContent = '00';
                        return;
                    }

                    const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                    const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
                    const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000);

                    document.getElementById('day').textContent = days.toString().padStart(2, '0');
                    document.getElementById('hour').textContent = hours.toString().padStart(2, '0');
                    document.getElementById('minute').textContent = minutes.toString().padStart(2, '0');
                    document.getElementById('second').textContent = seconds.toString().padStart(2, '0');
                }

                setInterval(updateCountdown, 1000);
                updateCountdown();
            </script>


        </body>
    </html>
