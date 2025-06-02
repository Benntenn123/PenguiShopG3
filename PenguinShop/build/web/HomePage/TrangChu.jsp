<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <!--        <section class="product flash-sale">
                        <div class="container">
                            <div class="section-title">
                                <h5>Flash Sale</h5>
                                <div class="countdown-section">
                                    <div class="countdown-items">
                                        <span id="day" class="number" style="color: red;">0</span>
                                        <span class="text">Days</span>
                                    </div>
                                    <div class="countdown-items">
                                        <span id="hour" class="number" style="color: skyblue;">0</span>
                                        <span class="text">Hours</span>
                                    </div>
                                    <div class="countdown-items">
                                        <span id="minute" class="number" style="color: green;">0</span>
                                        <span class="text">Minutes</span>
                                    </div>
                                    <div class="countdown-items">
                                        <span id="second" class="number" style="color: red;">0</span>
                                        <span class="text">seconds</span>
                                    </div>
                                </div>
                                <a href="flash-sale.html" class="view">View All</a>
                            </div>
                            <div class="flash-sale-section">
                                <div class="row g-5">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-wrapper" data-aos="fade-right" data-aos-duration="100">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-5.webp"
                                                     alt="product-img">
                                                <div class="product-cart-items">
                                                    <a href="#" class="cart cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                    <a href="wishlist.html" class="favourite cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="#AE1C9A" />
                                                            <path
                                                                d="M14.6928 12.3935C13.5057 12.54 12.512 13.0197 11.671 13.8546C10.9155 14.6016 10.4615 15.3926 10.201 16.4216C9.73957 18.2049 10.0745 19.9626 11.1835 21.6141C11.8943 22.6723 12.8135 23.6427 14.4993 25.1221C15.571 26.0632 18.8422 28.8096 19.0022 28.9011C19.1511 28.989 19.2069 29 19.5232 29C19.8395 29 19.8953 28.989 20.0442 28.9011C20.2042 28.8096 23.4828 26.0595 24.5471 25.1221C26.2404 23.6354 27.1521 22.6687 27.8629 21.6141C28.9719 19.9626 29.3068 18.2049 28.8454 16.4216C28.5849 15.3926 28.1309 14.6016 27.3754 13.8546C26.6237 13.1113 25.8199 12.6828 24.7667 12.4631C24.2383 12.3533 23.2632 12.3423 22.8018 12.4448C21.5142 12.7194 20.528 13.3529 19.6274 14.4808L19.5232 14.609L19.4227 14.4808C18.5333 13.3749 17.562 12.7414 16.3228 12.4631C15.9544 12.3789 15.1059 12.3423 14.6928 12.3935ZM15.9357 13.5104C16.9926 13.6935 17.9044 14.294 18.6263 15.2864C18.7491 15.4585 18.9017 15.6636 18.9613 15.7478C19.2367 16.1286 19.8098 16.1286 20.0851 15.7478C20.1447 15.6636 20.2973 15.4585 20.4201 15.2864C21.4062 13.9315 22.7795 13.2944 24.2755 13.4958C25.9352 13.7191 27.2303 14.8616 27.7252 16.5424C28.116 17.8717 27.9448 19.2668 27.234 20.5228C26.6386 21.5738 25.645 22.676 23.9145 24.203C23.0772 24.939 19.5567 27.9198 19.5232 27.9198C19.486 27.9198 15.9804 24.95 15.1319 24.203C12.4711 21.8557 11.4217 20.391 11.1686 18.6736C11.0049 17.5641 11.2393 16.3703 11.8087 15.4292C12.6646 14.0121 14.3318 13.2358 15.9357 13.5104Z"
                                                                fill="#000" />
                                                            </svg>
            
                                                        </span>
                                                    </a>
                                                    <a href="compaire.html" class="compaire cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                </div>
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
                                                    <a href="product-info.html" class="product-details">Leather Dress Shoes
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$22.99</span>
                                                        <span class="new-price">$13.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-cart-btn">
                                                <a href="cart.html" class="product-btn">Add To Cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-wrapper" data-aos="fade-right" data-aos-duration="200">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-3.webp"
                                                     alt="product-img">
                                                <div class="product-cart-items">
                                                    <a href="#" class="cart cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                    <a href="wishlist.html" class="favourite cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="#AE1C9A" />
                                                            <path
                                                                d="M14.6928 12.3935C13.5057 12.54 12.512 13.0197 11.671 13.8546C10.9155 14.6016 10.4615 15.3926 10.201 16.4216C9.73957 18.2049 10.0745 19.9626 11.1835 21.6141C11.8943 22.6723 12.8135 23.6427 14.4993 25.1221C15.571 26.0632 18.8422 28.8096 19.0022 28.9011C19.1511 28.989 19.2069 29 19.5232 29C19.8395 29 19.8953 28.989 20.0442 28.9011C20.2042 28.8096 23.4828 26.0595 24.5471 25.1221C26.2404 23.6354 27.1521 22.6687 27.8629 21.6141C28.9719 19.9626 29.3068 18.2049 28.8454 16.4216C28.5849 15.3926 28.1309 14.6016 27.3754 13.8546C26.6237 13.1113 25.8199 12.6828 24.7667 12.4631C24.2383 12.3533 23.2632 12.3423 22.8018 12.4448C21.5142 12.7194 20.528 13.3529 19.6274 14.4808L19.5232 14.609L19.4227 14.4808C18.5333 13.3749 17.562 12.7414 16.3228 12.4631C15.9544 12.3789 15.1059 12.3423 14.6928 12.3935ZM15.9357 13.5104C16.9926 13.6935 17.9044 14.294 18.6263 15.2864C18.7491 15.4585 18.9017 15.6636 18.9613 15.7478C19.2367 16.1286 19.8098 16.1286 20.0851 15.7478C20.1447 15.6636 20.2973 15.4585 20.4201 15.2864C21.4062 13.9315 22.7795 13.2944 24.2755 13.4958C25.9352 13.7191 27.2303 14.8616 27.7252 16.5424C28.116 17.8717 27.9448 19.2668 27.234 20.5228C26.6386 21.5738 25.645 22.676 23.9145 24.203C23.0772 24.939 19.5567 27.9198 19.5232 27.9198C19.486 27.9198 15.9804 24.95 15.1319 24.203C12.4711 21.8557 11.4217 20.391 11.1686 18.6736C11.0049 17.5641 11.2393 16.3703 11.8087 15.4292C12.6646 14.0121 14.3318 13.2358 15.9357 13.5104Z"
                                                                fill="#000" />
                                                            </svg>
            
                                                        </span>
                                                    </a>
                                                    <a href="compaire.html" class="compaire cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                </div>
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
                                                    <a href="product-info.html" class="product-details">Trendy Bucket Hat
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$39.99</span>
                                                        <span class="new-price">$23.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-cart-btn">
                                                <a href="cart.html" class="product-btn">Add To Cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-wrapper" data-aos="fade-right" data-aos-duration="300">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-6.webp"
                                                     alt="product-img">
                                                <div class="product-cart-items">
                                                    <a href="#" class="cart cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                    <a href="wishlist.html" class="favourite cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="#AE1C9A" />
                                                            <path
                                                                d="M14.6928 12.3935C13.5057 12.54 12.512 13.0197 11.671 13.8546C10.9155 14.6016 10.4615 15.3926 10.201 16.4216C9.73957 18.2049 10.0745 19.9626 11.1835 21.6141C11.8943 22.6723 12.8135 23.6427 14.4993 25.1221C15.571 26.0632 18.8422 28.8096 19.0022 28.9011C19.1511 28.989 19.2069 29 19.5232 29C19.8395 29 19.8953 28.989 20.0442 28.9011C20.2042 28.8096 23.4828 26.0595 24.5471 25.1221C26.2404 23.6354 27.1521 22.6687 27.8629 21.6141C28.9719 19.9626 29.3068 18.2049 28.8454 16.4216C28.5849 15.3926 28.1309 14.6016 27.3754 13.8546C26.6237 13.1113 25.8199 12.6828 24.7667 12.4631C24.2383 12.3533 23.2632 12.3423 22.8018 12.4448C21.5142 12.7194 20.528 13.3529 19.6274 14.4808L19.5232 14.609L19.4227 14.4808C18.5333 13.3749 17.562 12.7414 16.3228 12.4631C15.9544 12.3789 15.1059 12.3423 14.6928 12.3935ZM15.9357 13.5104C16.9926 13.6935 17.9044 14.294 18.6263 15.2864C18.7491 15.4585 18.9017 15.6636 18.9613 15.7478C19.2367 16.1286 19.8098 16.1286 20.0851 15.7478C20.1447 15.6636 20.2973 15.4585 20.4201 15.2864C21.4062 13.9315 22.7795 13.2944 24.2755 13.4958C25.9352 13.7191 27.2303 14.8616 27.7252 16.5424C28.116 17.8717 27.9448 19.2668 27.234 20.5228C26.6386 21.5738 25.645 22.676 23.9145 24.203C23.0772 24.939 19.5567 27.9198 19.5232 27.9198C19.486 27.9198 15.9804 24.95 15.1319 24.203C12.4711 21.8557 11.4217 20.391 11.1686 18.6736C11.0049 17.5641 11.2393 16.3703 11.8087 15.4292C12.6646 14.0121 14.3318 13.2358 15.9357 13.5104Z"
                                                                fill="#000" />
                                                            </svg>
            
                                                        </span>
                                                    </a>
                                                    <a href="compaire.html" class="compaire cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                </div>
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
                                                    <a href="product-info.html" class="product-details">Stylish Statement Earrings
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$39.99</span>
                                                        <span class="new-price">$26.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-cart-btn">
                                                <a href="cart.html" class="product-btn">Add To Cart</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-wrapper" data-aos="fade-right" data-aos-duration="400">
                                            <div class="product-img">
                                                <img src="./assets/images/homepage-one/product-img/product-img-9.webp"
                                                     alt="product-img">
                                                <div class="product-cart-items">
                                                    <a href="#" class="cart cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M12 14.4482V16.5664H12.5466H13.0933V15.3957V14.2204L15.6214 16.7486L18.1496 19.2767L18.5459 18.8759L18.9468 18.4796L16.4186 15.9514L13.8904 13.4232H15.0657H16.2364V12.8766V12.33H14.1182H12V14.4482Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M23.4345 12.8766V13.4232H24.6052H25.7805L23.2523 15.9514L20.7241 18.4796L21.125 18.8759L21.5213 19.2767L24.0495 16.7486L26.5776 14.2204V15.3957V16.5664H27.1243H27.6709V14.4482V12.33H25.5527H23.4345V12.8766Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M15.6078 23.5905L13.0933 26.1096V24.9343V23.7636H12.5466H12V25.8818V28H14.1182H16.2364V27.4534V26.9067H15.0657H13.8904L16.4186 24.3786L18.9468 21.8504L18.5596 21.4632C18.35 21.2491 18.1633 21.076 18.1496 21.076C18.1359 21.076 16.9926 22.2103 15.6078 23.5905Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M21.1113 21.4632L20.7241 21.8504L23.2523 24.3786L25.7805 26.9067H24.6052H23.4345V27.4534V28H25.5527H27.6709V25.8818V23.7636H27.1243H26.5776V24.9343V26.1096L24.0586 23.5905C22.6783 22.2103 21.535 21.076 21.5213 21.076C21.5076 21.076 21.3209 21.2491 21.1113 21.4632Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                    <a href="wishlist.html" class="favourite cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="#AE1C9A" />
                                                            <path
                                                                d="M14.6928 12.3935C13.5057 12.54 12.512 13.0197 11.671 13.8546C10.9155 14.6016 10.4615 15.3926 10.201 16.4216C9.73957 18.2049 10.0745 19.9626 11.1835 21.6141C11.8943 22.6723 12.8135 23.6427 14.4993 25.1221C15.571 26.0632 18.8422 28.8096 19.0022 28.9011C19.1511 28.989 19.2069 29 19.5232 29C19.8395 29 19.8953 28.989 20.0442 28.9011C20.2042 28.8096 23.4828 26.0595 24.5471 25.1221C26.2404 23.6354 27.1521 22.6687 27.8629 21.6141C28.9719 19.9626 29.3068 18.2049 28.8454 16.4216C28.5849 15.3926 28.1309 14.6016 27.3754 13.8546C26.6237 13.1113 25.8199 12.6828 24.7667 12.4631C24.2383 12.3533 23.2632 12.3423 22.8018 12.4448C21.5142 12.7194 20.528 13.3529 19.6274 14.4808L19.5232 14.609L19.4227 14.4808C18.5333 13.3749 17.562 12.7414 16.3228 12.4631C15.9544 12.3789 15.1059 12.3423 14.6928 12.3935ZM15.9357 13.5104C16.9926 13.6935 17.9044 14.294 18.6263 15.2864C18.7491 15.4585 18.9017 15.6636 18.9613 15.7478C19.2367 16.1286 19.8098 16.1286 20.0851 15.7478C20.1447 15.6636 20.2973 15.4585 20.4201 15.2864C21.4062 13.9315 22.7795 13.2944 24.2755 13.4958C25.9352 13.7191 27.2303 14.8616 27.7252 16.5424C28.116 17.8717 27.9448 19.2668 27.234 20.5228C26.6386 21.5738 25.645 22.676 23.9145 24.203C23.0772 24.939 19.5567 27.9198 19.5232 27.9198C19.486 27.9198 15.9804 24.95 15.1319 24.203C12.4711 21.8557 11.4217 20.391 11.1686 18.6736C11.0049 17.5641 11.2393 16.3703 11.8087 15.4292C12.6646 14.0121 14.3318 13.2358 15.9357 13.5104Z"
                                                                fill="#000" />
                                                            </svg>
            
                                                        </span>
                                                    </a>
                                                    <a href="compaire.html" class="compaire cart-item">
                                                        <span>
                                                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                            <rect width="40" height="40" rx="20" fill="white" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M18.8948 10.6751C18.8948 11.0444 18.8829 11.3502 18.871 11.3502C18.8591 11.3502 18.6645 11.3859 18.4461 11.4336C14.674 12.1959 11.8588 15.1779 11.3346 18.966C11.2115 19.8316 11.2632 21.1499 11.4498 22.0314C11.9223 24.2867 13.3875 26.4031 15.3252 27.642L15.5515 27.7849L16.1114 27.364C16.4171 27.1337 16.6712 26.9352 16.6712 26.9193C16.6712 26.9074 16.572 26.8439 16.4529 26.7803C15.8453 26.4627 15.0552 25.8274 14.5191 25.2278C13.5026 24.0882 12.8514 22.6984 12.641 21.2372C12.5655 20.6972 12.5655 19.6251 12.641 19.1129C12.8038 18.0289 13.185 17.0044 13.7568 16.1071C14.4715 14.9913 15.5594 14.0145 16.7507 13.4149C17.3542 13.1132 18.192 12.8273 18.7678 12.724L18.8948 12.7002V13.2561C18.8948 13.5618 18.9028 13.812 18.9147 13.812C18.9544 13.812 21.4361 11.9339 21.4361 11.9061C21.4361 11.8783 18.9544 10.0001 18.9147 10.0001C18.9028 10.0001 18.8948 10.3019 18.8948 10.6751Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="#181818" />
                                                            <path
                                                                d="M24.219 12.9662C23.9133 13.1965 23.6671 13.399 23.679 13.4149C23.6909 13.4347 23.81 13.5102 23.949 13.5856C25.1124 14.2448 26.1964 15.3566 26.8675 16.5914C27.2725 17.334 27.614 18.414 27.7092 19.2558C27.7887 19.9189 27.741 21.0585 27.614 21.662C27.066 24.2589 25.2593 26.3514 22.7657 27.2806C22.452 27.3957 21.6023 27.63 21.4911 27.63C21.4474 27.63 21.4355 27.5307 21.4355 27.0741C21.4355 26.7684 21.4276 26.5182 21.4157 26.5182C21.376 26.5182 18.8943 28.3963 18.8943 28.4241C18.8943 28.4519 21.376 30.3301 21.4157 30.3301C21.4276 30.3301 21.4355 30.0283 21.4355 29.6551V28.984L21.5864 28.9602C21.9557 28.9006 23 28.6187 23.3415 28.4837C26.4386 27.2726 28.559 24.5884 28.9997 21.3166C29.1149 20.4748 29.0633 19.1565 28.8806 18.2988C28.4081 16.0435 26.9429 13.9271 25.0052 12.6882L24.7789 12.5453L24.219 12.9662Z"
                                                                fill="black" fill-opacity="0.2" />
                                                            </svg>
                                                        </span>
                                                    </a>
                                                </div>
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
                                                    <a href="product-info.html" class="product-details">Rainbow Sequin Dress
                                                    </a>
                                                    <div class="price">
                                                        <span class="price-cut">$29.99</span>
                                                        <span class="new-price">$16.99</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-cart-btn">
                                                <a href="cart.html" class="product-btn">Add To Cart</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>-->
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
            <button class="partnership-chat-button" id="partnershipChatToggle">
                <svg viewBox="0 0 24 24">
                <path d="M12 2C13.1 2 14 2.9 14 4C14 5.1 13.1 6 12 6C10.9 6 10 5.1 10 4C10 2.9 10.9 2 12 2ZM21 9V7L15 1L9 7V9C9 10.1 9.9 11 11 11V16L12 17L13 16V11C14.1 11 15 10.1 15 9V7H21M7 10.5C7 9.7 6.3 9 5.5 9S4 9.7 4 10.5 4.7 12 5.5 12 7 11.3 7 10.5M20 10.5C20 9.7 19.3 9 18.5 9S17 9.7 17 10.5 17.7 12 18.5 12 20 11.3 20 10.5M12 20C12 21.1 11.1 22 10 22H6C4.9 22 4 21.1 4 20V18H8V20H12M20 18V20C20 21.1 19.1 22 18 22H14C12.9 22 12 21.1 12 20V18H20Z"/>
                </svg>
            </button>
            <!--------------- flash-section-end--------------->
            <div class="partnership-chat-window" id="partnershipChatWindow">
                <div class="partnership-chat-header">
                    <button class="partnership-close-btn" id="partnershipCloseChat">&times;</button>
                    <h3 style="font-size: 16px !important;
                        color: white">🤝 Hỗ trợ cộng tác</h3>
                    <p style="font-size: 16px !important;
                       color: white">Gửi thông tin để chúng tôi liên hệ!</p>
                </div>

                <div class="partnership-chat-form">
                    <div style="font-size: 16px !important;
                         color: white" class="partnership-success-message" id="partnershipSuccessMessage">
                        ✅ Cảm ơn bạn! Chúng tôi đã nhận được thông tin và sẽ liên hệ lại trong thời gian sớm nhất.
                    </div>

                    <form id="partnershipSupportForm">
                        <div  class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipFullName">Họ và tên *</label>
                            <input style="font-size: 16px !important;" type="text" id="partnershipFullName" name="fullName" required placeholder="Nhập họ tên của bạn">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipPhone">Số điện thoại *</label>
                            <input style="font-size: 16px !important;" type="tel" id="partnershipPhone" name="phone" required placeholder="Nhập số điện thoại">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipEmail">Email *</label>
                            <input style="font-size: 16px !important;" type="email" id="partnershipEmail" name="email" required placeholder="Nhập địa chỉ email">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipIssueType">Vấn đề gặp phải *</label>
                            <select style="font-size: 16px !important;" id="partnershipIssueType" name="issueType" required>
                                <option value="">-- Chọn loại vấn đề --</option>
                                <option value="account">Trạng thái tài khoản</option>
                                <option value="purchase">Vấn đề mua hàng</option>
                                <option value="payment">Vấn đề thanh toán</option>
                                <option value="shipping">Vấn đề giao hàng</option>
                                <option value="refund">Hoàn tiền/Đổi trả</option>
                                <option value="technical">Lỗi kỹ thuật</option>
                                <option value="other">Vấn đề khác</option>
                            </select>
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipDescription">Nội dung mô tả *</label>
                            <textarea style="font-size: 16px !important;" id="partnershipDescription" name="description" required placeholder="Mô tả chi tiết vấn đề bạn đang gặp phải..."></textarea>
                        </div>

                        <button style="font-size: 16px !important;" type="submit" class="partnership-submit-btn">
                            📨 Gửi thông tin
                        </button>
                    </form>
                </div>
            </div>
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
                supportForm.addEventListener('submit', (e) => {
                    e.preventDefault();

                    // Get form data
                    const formData = new FormData(supportForm);
                    const data = Object.fromEntries(formData);

                    // Show success message
                    successMessage.classList.add('show');

                    // Reset form
                    supportForm.reset();

                    // Hide success message after 5 seconds
                    setTimeout(() => {
                        successMessage.classList.remove('show');
                    }, 5000);

                    // Log data (in real app, send to server)
                    console.log('Support request:', data);
                });

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

            console.log('Button clicked:', { userId, productId, variantId }); // Debug
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
            data: { action: 'getColors', productId: productId },
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
            data: { action: 'getSizes', productId: productId },
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
                        $priceSpan.text(response.price || 'Liên hệ');
                        $stockStatus.text(response.quantity > 0 ? 'Còn hàng' : 'Hết hàng');
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
        if (isAddingToCart) return;
        isAddingToCart = true;

        console.log('addToCart called with:', { userID, productID, variantID });
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
                            wrapper.find('.new-price').text(response.variant.price.toFixed(2) + ' VND');
                            wrapper.find('.stock-status')
                                .text(response.variant.quantity > 0 ? 'Còn hàng' : 'Hết hàng')
                                .css('color', response.variant.quantity > 0 ? '#28a745' : '#dc3545');
                            wrapper.find('.product-btn')
                                .attr('data-variant-id', response.variant.variantID)
                                .prop('disabled', response.variant.quantity === 0)
                                .css({
                                    'pointer-events': response.variant.quantity === 0 ? 'none' : 'auto',
                                    'opacity': response.variant.quantity === 0 ? 0.6 : 1
                                });
                            wrapper.find('.product-details, .product-img a')
                                .attr('href', 'productdetail?id=' + response.variant.variantID);
                        } else {
                            toastr.error(response.message || 'Không tìm thấy biến thể!');
                            wrapper.find('.product-btn')
                                .prop('disabled', true)
                                .css({ 'pointer-events': 'none', 'opacity': 0.6 });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log('getVariant error:', status, error);
                        toastr.error('Lỗi kết nối server: ' + error);
                        wrapper.find('.product-btn')
                            .prop('disabled', true)
                            .css({ 'pointer-events': 'none', 'opacity': 0.6 });
                    }
                });
            } else {
                wrapper.find('.product-btn')
                    .prop('disabled', true)
                    .css({ 'pointer-events': 'none', 'opacity': 0.6 });
            }
        });
    });
</script>




        </body>
    </html>
