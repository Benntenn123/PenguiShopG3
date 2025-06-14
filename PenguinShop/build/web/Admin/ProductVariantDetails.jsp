<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            /* Base Styles */
            .product-detail-reset * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .product-detail-body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
                line-height: 1.6;
            }

            .product-detail-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Header Styles */
            .product-detail-header {
                color: white;
                padding: 15px 0;
                margin-bottom: 25px;
                border-radius: 8px;
            }

            .product-detail-header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .product-detail-back-btn {
                background: rgba(255,255,255,0.2);
                color: black;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: background 0.2s;
            }

            .product-detail-back-btn:hover {
                background: rgba(255,255,255,0.3);
            }

            .product-detail-breadcrumb {
                color: black;
                font-size: 14px;
            }

            .product-detail-breadcrumb a {
                color: black;
                text-decoration: none;
            }

            .product-detail-breadcrumb a:hover {
                color: #5156be;
            }

            /* Main Content */
            .product-detail-main-content {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
                margin-bottom: 30px;
            }

            .product-detail-image-section {
                background: white;
                border-radius: 8px;
                width: 600px;
                height: 800px;
                padding: 20px;
                box-shadow: 0 2px 5px rgba(0.1,0.1,0.1,0.1);
            }

            .product-detail-image {
                width: 100%;
                height: 650px;
                object-fit: cover;
                border-radius: 6px;
                border: 1px solid #eee;
            }

            .product-detail-info-section {
                background: white;
                border-radius: 8px;
                height: 800px;
                padding: 25px;
                box-shadow: 0 2px 5px rgba(0.1,0.1,0.1,0.1);
            }

            .product-detail-title {
                font-size: 24px;
                color: #333;
                margin-bottom: 25px;
                font-weight: 600;
            }

            .product-detail-meta-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 20px;
            }

            .product-detail-meta-item {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .product-detail-meta-label {
                font-size: 12px;
                color: #666;
                text-transform: uppercase;
                font-weight: 500;
            }

            .product-detail-meta-value {
                font-size: 16px;
                color: #333;
                font-weight: 500;
            }

            .product-detail-brand-logo {
                width: 80px;
                height: 40px;
                object-fit: contain;
                border-radius: 4px;
                border: 1px solid #eee;
            }

            .product-detail-color-swatch {
                width: 30px;
                height: 30px;
                border-radius: 4px;
                border: 2px solid #ddd;
            }

            .product-detail-price {
                font-size: 20px;
                color: #5156be;
                font-weight: 700;
                margin: 15px 0;
            }

            .product-detail-description {
                color: #666;
                max-height: 350px;
                line-height: 1.6;
                margin-bottom: 20px;
            }

            /* Action Buttons */
            .product-detail-actions {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .product-detail-btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                text-align: center;
                transition: all 0.2s;
            }

            .product-detail-btn-primary {
                background: #5156be;
                color: white;
            }

            .product-detail-btn-primary:hover {
                background: #4a4fb8;
            }

            .product-detail-btn-secondary {
                background: #f8f9fa;
                color: #5156be;
                border: 1px solid #5156be;
            }

            .product-detail-btn-secondary:hover {
                background: #5156be;
                color: white;
            }

            /* Variants Section */
            .product-detail-variants-section {
                background: white;
                border-radius: 8px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .product-detail-section-title {
                font-size: 18px;
                color: #333;
                margin-bottom: 20px;
                font-weight: 600;
                border-bottom: 2px solid #5156be;
                padding-bottom: 8px;
            }

            .product-detail-variants-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 15px;
            }

            .product-detail-variant-item {
                border: 1px solid #eee;
                border-radius: 6px;
                padding: 15px;
                transition: all 0.2s;
                position: relative;
            }

            .product-detail-variant-item:hover {
                border-color: #5156be;
                box-shadow: 0 2px 8px rgba(81, 86, 190, 0.1);
            }

            .product-detail-variant-item.current {
                border-color: #5156be;
                background: #f8f9ff;
            }

            .product-detail-variant-item.current::before {
                content: "Đang xem";
                position: absolute;
                top: -8px;
                right: 10px;
                background: #5156be;
                color: white;
                font-size: 10px;
                padding: 2px 8px;
                border-radius: 4px;
            }

            .product-detail-variant-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 10px;
            }

            .product-detail-variant-info {
                flex: 1;
            }

            .product-detail-variant-title {
                font-size: 14px;
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
            }

            .product-detail-variant-sku {
                font-size: 11px;
                color: #666;
                margin-bottom: 8px;
            }

            .product-detail-variant-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 4px;
                border: 1px solid #eee;
                margin-left: 10px;
            }

            .product-detail-variant-details {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                align-items: center;
                margin-bottom: 10px;
            }

            .product-detail-variant-color {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .product-detail-variant-color-swatch {
                width: 16px;
                height: 16px;
                border-radius: 3px;
                border: 1px solid #ddd;
            }

            .product-detail-variant-size {
                background: #f0f0f0;
                color: #333;
                font-size: 11px;
                padding: 2px 6px;
                border-radius: 3px;
                font-weight: 500;
            }

            .product-detail-variant-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .product-detail-variant-price {
                font-size: 14px;
                font-weight: 600;
                color: #5156be;
            }

            .product-detail-variant-stock {
                font-size: 11px;
                color: #666;
            }

            .product-detail-variant-stock.low {
                color: #e74c3c;
            }

            .product-detail-variant-stock.out {
                color: #c0392b;
                font-weight: 600;
            }

            /* Related Products */
            .product-detail-related-section {
                background: white;
                border-radius: 8px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .product-detail-related-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
            }

            .product-detail-related-item {
                border: 1px solid #eee;
                border-radius: 6px;
                overflow: hidden;
                transition: transform 0.2s;
            }

            .product-detail-related-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .product-detail-related-image {
                width: 100%;
                height: 150px;
                object-fit: cover;
            }

            .product-detail-related-info {
                padding: 15px;
            }

            .product-detail-related-title {
                font-size: 14px;
                color: #333;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .product-detail-related-meta {
                font-size: 12px;
                color: #666;
                margin-bottom: 8px;
            }

            .product-detail-related-price {
                font-size: 14px;
                color: #5156be;
                font-weight: 600;
            }

            /* Thumbnail Gallery */
            .product-thumbnail-gallery {
                margin-top: 15px;
            }

            .thumbnail-list {
                display: flex;
                gap: 10px;
                overflow-x: auto; /* Thêm thanh cuộn ngang */
                padding: 10px 0;
                scroll-behavior: smooth;
                -webkit-overflow-scrolling: touch; /* Tối ưu cho cảm ứng */
            }

            .thumbnail-item {
                flex: 0 0 auto;
                width: 80px;
                height: 80px;
                border-radius: 8px;
                overflow: hidden;
                border: 2px solid transparent;
                cursor: pointer;
                transition: all 0.3s ease;
                opacity: 0.7;
            }

            .thumbnail-item:hover {
                opacity: 1;
                transform: scale(1.05);
            }

            .thumbnail-item.active {
                border-color: #007bff;
                opacity: 1;
                box-shadow: 0 0 10px rgba(0,123,255,0.3);
            }

            .thumbnail-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .product-detail-main-content {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .product-detail-header-content {
                    flex-direction: column;
                    gap: 10px;
                    text-align: center;
                }

                .product-detail-meta-grid {
                    grid-template-columns: 1fr;
                }

                .product-detail-variants-grid {
                    grid-template-columns: 1fr;
                }

                .product-detail-related-grid {
                    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                    gap: 15px;
                }

                .product-detail-image {
                    height: 300px;
                }

                .thumbnail-item {
                    width: 60px;
                    height: 60px;
                }
            }
            .stock-active {
                color: #28a745;
                font-weight: 500;
            }
            .stock-inactive {
                color: #dc3545;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <div class="product-detail-body">
                            <div class="product-detail-header">
                                <div class="product-detail-header-content">
                                    <a style="font-weight: 600" href="listProductAdmin" class="product-detail-back-btn">
                                        ← Quay lại danh sách
                                    </a>
                                    <div style="font-weight: 600" class="product-detail-breadcrumb">
                                        <a href="#">Sản phẩm</a> / <a style="font-weight: 600" href="#">${pv.product.productName}</a> / Chi tiết
                                    </div>
                                </div>
                            </div>

                            <div class="product-detail-container">
                                <div class="product-detail-main-content">
                                    <div class="product-detail-image-section">
                                        <img src="../api/img/${pv.product.imageMainProduct}" alt="${pv.product.productName}" class="product-detail-image">
                                        <div class="product-thumbnail-gallery">
                                            <div class="thumbnail-list">

                                                <!-- Các ảnh phụ (giả định từ additionalImages hoặc mẫu) -->
                                                <c:forEach var="image" items="${image}" varStatus="status">
                                                    <div class="thumbnail-item" onclick="changeMainImage('${image}', ${status.index + 1})">
                                                        <img src="../api/img/${image}" alt="Additional Image ${status.index + 1}" class="thumbnail-image">
                                                    </div>
                                                </c:forEach>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="product-detail-info-section">
                                        <h1 class="product-detail-title">${pv.product.productName}</h1>

                                        <div class="product-detail-meta-grid">
                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Thương hiệu</span>
                                                <img src="../api/img/${pv.product.brand.logo}" alt="${pv.product.brand.brandName}" class="product-detail-brand-logo">
                                            </div>

                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Màu sắc</span>
                                                <div style="display: flex; align-items: center; gap: 10px;">
                                                    <span style="font-size: 18px" class="product-detail-meta-value">${pv.color.colorName}</span>
                                                </div>
                                            </div>

                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Kích cỡ</span>
                                                <span class="product-detail-meta-value">Size ${pv.size.sizeName}</span>
                                            </div>

                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Mã sản phẩm</span>
                                                <span class="product-detail-meta-value">${pv.product.sku}</span>
                                            </div>

                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Tồn kho</span>
                                                <span class="product-detail-meta-value">
                                                    ${pv.quantity} - 
                                                    <c:choose>
                                                        <c:when test="${pv.stockStatus == 1}">
                                                            <span class="stock-active">Đang kinh doanh</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="stock-inactive">Đã ngừng kinh doanh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>


                                            <div class="product-detail-meta-item">
                                                <span class="product-detail-meta-label">Danh mục</span>
                                                <c:forEach var="cate" items="${cate}">
                                                    <span class="product-detail-meta-value">${cate.categoryName}</span>
                                                </c:forEach>
                                            </div>

                                        </div>

                                        <div class="product-detail-price"><fmt:formatNumber value="${pv.price}" type="currency" currencyCode="VND"/></div>

                                        <div class="product-detail-description">
                                            ${pv.product.full_description}
                                        </div>

                                        <div class="product-detail-actions">
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalChange"
                                                    data-bs-whatever="@mdo">Chỉnh sửa</button>
                                            <a href="../productdetail?id=${pv.variantID}" class="btn btn-primary" style="background-color: white; color: black">Xem trên shop</a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Variants của cùng sản phẩm cha -->
                                <div class="product-detail-variants-section">
                                    <h2 class="product-detail-section-title">Các loại khác của ${pv.product.productName}</h2>
                                    <div class="product-detail-variants-grid">
                                        <!-- Variant hiện tại -->
                                        <c:forEach var="list" items="${list}">
                                            <div class="product-detail-variant-item ${list.variantID == pv.variantID ? 'current' : ''}">
                                                <a href="variant_details?variantID=${list.variantID}">
                                                    <div class="product-detail-variant-header">
                                                        <div class="product-detail-variant-info">
                                                            <div class="product-detail-variant-title">${list.product.productName} - ${list.color.colorName} - Size ${list.size.sizeName}</div>
                                                            <div class="product-detail-variant-sku">SKU: ${list.product.sku}</div>
                                                        </div>
                                                        <img src="../api/img/${list.product.imageMainProduct}" alt="${list.color.colorName} ${list.size.sizeName}" class="product-detail-variant-image">
                                                    </div>
                                                    <div class="product-detail-variant-details">
                                                        <div class="product-detail-variant-color">
                                                            <span>${list.color.colorName}</span>
                                                        </div>
                                                        <div class="product-detail-variant-size">Size ${list.size.sizeName}</div>
                                                    </div>
                                                    <div class="product-detail-variant-footer">
                                                        <div class="product-detail-variant-price"><fmt:formatNumber value="${list.price}" type="currency" currencyCode="VND"/></div>
                                                        <div class="product-detail-variant-stock ${list.quantity <= 10 ? 'low' : ''} ${list.quantity == 0 ? 'out' : ''}">
                                                            ${list.quantity == 0 ? 'Hết hàng' : 'Còn '.concat(list.quantity)}
                                                        </div>
                                                    </div>

                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalChange" tabindex="-1" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Chỉnh sửa ${pv.product.productName}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="userForm" action="update_variant" method="post">
                            <div class="mb-3">
                                <label for="recipient-name" class="col-form-label">Tình trạng: </label>
                                <select style="width: 380px; border-radius: 8px;
                                        border: 0.3px solid #5156be; color: #5156be;
                                        padding: 8px" id="select-all" name="stockStatus">
                                    <option value="" ${pv.stockStatus == '' ? 'selected' : ''}>Chọn trạng thái</option>
                                    <option value="1" ${pv.stockStatus == '1' ? 'selected' : ''}>Đang kinh doanh</option>
                                    <option value="0" ${pv.stockStatus == '0' ? 'selected' : ''}>Dừng kinh doanh</option>
                                </select>

                            </div>
                            <input type="hidden" name="variantID" value="${pv.variantID}"/>
                            <div class="mb-3">
                                <label for="message-text" class="col-form-label">Số lượng:</label>
                                <textarea class="form-control" name="quantity" id="message-text">${pv.quantity}</textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button onclick="submitForm()" type="button" class="btn btn-primary">Thay đổi</button>
                    </div>
                </div>
            </div>
        </div>                            

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            function submitForm() {
                document.getElementById('userForm').submit();
            }
            function changeMainImage(imagePath, index) {
                const mainImage = document.querySelector('.product-detail-image');
                if (imagePath.includes('http')) {
                    mainImage.src = imagePath;
                } else {
                    mainImage.src = '../api/img/' + imagePath;
                }

                const thumbnails = document.querySelectorAll('.thumbnail-item');
                thumbnails.forEach(thumb => thumb.classList.remove('active'));
                thumbnails[index].classList.add('active');

                thumbnails[index].scrollIntoView({
                    behavior: 'smooth',
                    block: 'nearest',
                    inline: 'center'
                });
            }

            document.addEventListener('keydown', function (event) {
                const thumbnails = document.querySelectorAll('.thumbnail-item');
                const activeThumbnail = document.querySelector('.thumbnail-item.active');
                const activeIndex = Array.from(thumbnails).indexOf(activeThumbnail);

                if (event.key === 'ArrowLeft' && activeIndex > 0) {
                    thumbnails[activeIndex - 1].click();
                } else if (event.key === 'ArrowRight' && activeIndex < thumbnails.length - 1) {
                    thumbnails[activeIndex + 1].click();
                }
            });
        </script>
    </body>
</html>