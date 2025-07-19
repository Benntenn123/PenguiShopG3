<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR Code Generator - PenguinShop Admin</title>
    
    <jsp:include page="Common/Css.jsp"/>
    
    <!-- FontAwesome Icons for QR Generator -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- QR Code JS Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
    
    <style>
        .product-card {
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border-color: #007bff;
        }
        
        .product-card.selected {
            border-color: #28a745;
            background-color: #f8fff8;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .variant-badge {
            font-size: 0.8em;
            margin: 2px;
        }
        
        .search-box {
            
            border-radius: 15px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
        }
        
        .stats-card {
            height: 130px;
            color: black;
            border-radius: 15px;
        }
        
        .qr-modal .modal-content {
            border-radius: 15px;
        }
        
        .qr-code-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            border: 2px solid #dee2e6;
        }
        
        .btn-generate {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-generate:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .btn-generate:disabled {
            opacity: 0.6;
            cursor: not-allowed;
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
            <!-- Header -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0 font-size-18">
                            <i class="fas fa-qrcode text-primary me-2"></i>
                            QR Code Generator
                        </h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="welcome">Dashboard</a></li>
                                <li class="breadcrumb-item active">QR Code Generator</li>
                            </ol>
                        </div>
                    </div>
                    <p class="text-muted">Tạo mã QR cho sản phẩm</p>
                </div>
            </div>
            
            <!-- Search và Stats -->
            <div class="row mb-4">
                <div class="col-lg-8">
                    <div class="search-box card">
                        <h5 class="mb-3"><i class="fas fa-search me-2"></i>Tìm kiếm sản phẩm</h5>
                        <form method="GET" action="QRCodeGenerator" id="searchForm">
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <input type="text" name="search" class="form-control form-control-lg" 
                                           placeholder="Nhập tên sản phẩm, thương hiệu, màu sắc..."
                                           value="${search}">
                                </div>
                                <div class="col-md-3 mb-2">
                                    <select name="pageSize" class="form-select form-select-lg" onchange="document.getElementById('searchForm').submit();">
                                        <option value="6" ${pageSize == 6 ? 'selected' : ''}>6 sp/trang</option>
                                        <option value="12" ${pageSize == 12 ? 'selected' : ''}>12 sp/trang</option>
                                        <option value="24" ${pageSize == 24 ? 'selected' : ''}>24 sp/trang</option>
                                        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50 sp/trang</option>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <button type="submit" class="btn btn-light btn-lg w-100">
                                        <i class="fas fa-search me-2"></i>Tìm kiếm
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card stats-card">
                        <div class="card-body text-center">
                            <h3 class="mb-0">${totalVariants}</h3>
                            <p class="mb-0">Sản phẩm tìm thấy</p>
                            <small>Có thể tạo QR code</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Selected Product Info -->
            <div id="selectedProductInfo" class="alert alert-info" style="display: none;">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h6 class="mb-1">Sản phẩm đã chọn:</h6>
                        <span id="selectedProductName"></span>
                    </div>
                    <div class="col-md-4 text-end">
                        <button class="btn btn-generate" id="generateQRBtn" onclick="generateQRCode()">
                            <i class="fas fa-qrcode me-2"></i>Tạo QR Code
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Product List -->
            <div class="row" id="productContainer">
                <c:forEach var="variant" items="${variants}">
                    <div class="col-lg-6 col-xl-4 mb-3">
                        <div class="card product-card h-100" onclick="selectProduct(this)" 
                             data-product-id="${variant.product.productId}"
                             data-variant-id="${variant.variantID}">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-3">
                                        <c:choose>
                                            <c:when test="${not empty variant.product.imageMainProduct}">
                                                <img src="../api/img/${variant.product.imageMainProduct}" 
                                                     class="product-image" alt="Product Image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-image text-muted fa-2x"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-9">
                                        <h6 class="card-title mb-2 text-truncate" title="${variant.product.productName}">
                                            ${variant.product.productName}
                                        </h6>
                                        
                                        <div class="mb-2">
                                            <c:if test="${not empty variant.color.colorName}">
                                                <span class="badge bg-primary variant-badge">
                                                    <i class="fas fa-palette me-1"></i>${variant.color.colorName}
                                                </span>
                                            </c:if>
                                            <c:if test="${not empty variant.size.sizeName}">
                                                <span class="badge bg-success variant-badge">
                                                    <i class="fas fa-ruler me-1"></i>Size ${variant.size.sizeName}
                                                </span>
                                            </c:if>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <small class="text-muted">Giá:</small>
                                                <div class="fw-bold text-primary">
                                                    <fmt:formatNumber value="${variant.price}" type="currency" currencyCode="VND"/>
                                                </div>
                                            </div>
                                            <div class="text-end">
                                                <small class="text-muted">Kho:</small>
                                                <div class="fw-bold ${variant.quantity <= 10 ? 'text-warning' : 'text-success'}">
                                                    ${variant.quantity} sp
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${not empty variant.product.brand.brandName}">
                                            <div class="mt-2">
                                                <small class="text-muted">
                                                    <i class="fas fa-tag me-1"></i>${variant.product.brand.brandName}
                                                </small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="row">
                    <div class="col-12">
                        <nav aria-label="QR Code Generator Pagination">
                            <ul class="pagination justify-content-center">
                                <!-- Previous Page -->
                                <c:if test="${hasPrevious}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${previousPage}&search=${search}&pageSize=${pageSize}">
                                            <i class="fas fa-chevron-left"></i> Trước
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${not hasPrevious}">
                                    <li class="page-item disabled">
                                        <span class="page-link"><i class="fas fa-chevron-left"></i> Trước</span>
                                    </li>
                                </c:if>
                                
                                <!-- Page Numbers -->
                                <c:choose>
                                    <c:when test="${totalPages <= 7}">
                                        <!-- Show all pages if 7 or fewer -->
                                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${pageNum}&search=${search}&pageSize=${pageSize}">
                                                    ${pageNum}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Show first page -->
                                        <li class="page-item ${1 == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=1&search=${search}&pageSize=${pageSize}">1</a>
                                        </li>
                                        
                                        <!-- Show dots if needed -->
                                        <c:if test="${currentPage > 4}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                        
                                        <!-- Show pages around current page -->
                                        <c:forEach begin="${currentPage > 4 ? currentPage - 2 : 2}" 
                                                   end="${currentPage < totalPages - 3 ? currentPage + 2 : totalPages - 1}" 
                                                   var="pageNum">
                                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${pageNum}&search=${search}&pageSize=${pageSize}">
                                                    ${pageNum}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        
                                        <!-- Show dots if needed -->
                                        <c:if test="${currentPage < totalPages - 3}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                        
                                        <!-- Show last page -->
                                        <li class="page-item ${totalPages == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${totalPages}&search=${search}&pageSize=${pageSize}">
                                                ${totalPages}
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                
                                <!-- Next Page -->
                                <c:if test="${hasNext}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${nextPage}&search=${search}&pageSize=${pageSize}">
                                            Sau <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${not hasNext}">
                                    <li class="page-item disabled">
                                        <span class="page-link">Sau <i class="fas fa-chevron-right"></i></span>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                        
                        <!-- Pagination Info -->
                        <div class="text-center text-muted">
                            <small>
                                Trang ${currentPage} / ${totalPages} 
                                (${totalVariants} sản phẩm)
                            </small>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- No Results -->
            <c:if test="${empty variants && not empty search}">
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Không tìm thấy sản phẩm</h5>
                    <p class="text-muted">Không có sản phẩm nào phù hợp với từ khóa "<strong>${search}</strong>"</p>
                    <a href="QRCodeGenerator" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>Xem tất cả sản phẩm
                    </a>
                </div>
            </c:if>
            
            <!-- Empty State -->
            <c:if test="${empty variants && empty search}">
                <div class="text-center py-5">
                    <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Chưa có sản phẩm nào</h5>
                    <p class="text-muted">Thêm sản phẩm vào hệ thống để tạo QR code</p>
                </div>
            </c:if>
            
                </div>
            </div>
        </div>
    </div>
    
    <!-- QR Code Modal -->
    <div class="modal fade qr-modal" id="qrModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-qrcode text-primary me-2"></i>
                        QR Code sản phẩm
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="qr-code-container">
                        <!-- QR Code sẽ được tạo động ở đây - canvas hoặc img -->
                        <div id="qr-display-area">
                            <canvas id="qr-canvas" width="256" height="256" style="display: none;"></canvas>
                        </div>
                        <h6 class="mt-3 mb-2" id="qrProductName"></h6>
                        <p class="text-muted mb-0" id="qrProductDetails"></p>
                    </div>
                    
                    <div class="mt-3">
                        <h6>Nội dung QR Code:</h6>
                        <pre class="bg-light p-3 rounded text-start" id="qrContent"></pre>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="downloadQRCode()">
                        <i class="fas fa-download me-2"></i>Tải xuống
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
    
    <script>
        let selectedProduct = null;
        let qr = null;
        
        function selectProduct(element) {
            // Remove previous selection
            document.querySelectorAll('.product-card').forEach(function(card) {
                card.classList.remove('selected');
            });
            
            // Add selection to current card
            element.classList.add('selected');
            
            // Get product data
            const productId = element.getAttribute('data-product-id');
            const variantId = element.getAttribute('data-variant-id');
            const productName = element.querySelector('.card-title').textContent.trim();
            
            selectedProduct = {
                productId: productId,
                variantId: variantId,
                name: productName,
                element: element
            };
            
            // Show selected product info
            document.getElementById('selectedProductName').textContent = productName;
            document.getElementById('selectedProductInfo').style.display = 'block';
            document.getElementById('generateQRBtn').disabled = false;
            
            // Scroll to selection info
            document.getElementById('selectedProductInfo').scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
        }
        
        function generateQRCode() {
            if (!selectedProduct) {
                alert('Vui lòng chọn một sản phẩm trước!');
                return;
            }
            
            // Disable button and show loading
            const btn = document.getElementById('generateQRBtn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang tạo...';
            
            // Tạm thời fallback to frontend generation để test
            console.log('🚀 Frontend QR Generation với payload:', {
                method: 'frontend_generation',
                productId: selectedProduct.productId,
                variantId: selectedProduct.variantId,
                productName: selectedProduct.name
            });
            const qrContent = "productID\n" + selectedProduct.productId + "\nvariantID\n" + selectedProduct.variantId + "\nquantity\n1";
            
            // Test frontend generation directly
            setTimeout(() => {
                try {
                    showQRModal(qrContent, null); // null = frontend generation
                    console.log('✅ Frontend QR generation successful với data:', {
                        qrContent: qrContent,
                        productId: selectedProduct.productId,
                        variantId: selectedProduct.variantId
                    });
                } catch (error) {
                    console.error('❌ Frontend QR generation failed:', error);
                    alert('Lỗi tạo QR: ' + error.message);
                } finally {
                    // Re-enable button
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-qrcode me-2"></i>Tạo QR Code';
                }
            }, 500);
            
            return; // Skip backend call for testing
            
            // Prepare data to send
            const formData = new FormData();
            formData.append('action', 'generateQR');
            formData.append('productID', selectedProduct.productId);
            formData.append('variantID', selectedProduct.variantId);
            
            // Send AJAX request
            console.log('🚀 Sending QR generation request...', {
                productID: selectedProduct.productId,
                variantID: selectedProduct.variantId
            });
            
            fetch('QRCodeGenerator', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                console.log('📡 Response status:', response.status);
                console.log('📡 Response headers:', response.headers);
                
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('📨 Response data:', data);
                
                if (data.success) {
                    console.log('QR Generation Method:', data.method);
                    
                    if (data.qrImage) {
                        // Backend generated QR image
                        showQRModal(data.qrContent, data.qrImage);
                    } else {
                        // Fallback to frontend generation
                        showQRModal(data.qrContent, null);
                    }
                } else {
                    alert('Lỗi khi tạo QR code: ' + data.error);
                }
            })
            .catch(error => {
                console.error('💥 Fetch error details:', error);
                console.error('💥 Error message:', error.message);
                console.error('💥 Error stack:', error.stack);
                alert('Lỗi kết nối: ' + error.message + '\n\nKiểm tra Console để biết thêm chi tiết.');
            })
            .finally(() => {
                // Re-enable button
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-qrcode me-2"></i>Tạo QR Code';
            });
        }
        
        function showQRModal(qrContent, qrImageData) {
            // Set content
            document.getElementById('qrContent').textContent = qrContent.replace(/\\n/g, '\n');
            document.getElementById('qrProductName').textContent = selectedProduct.name;
            document.getElementById('qrProductDetails').textContent = 
                'Product ID: ' + selectedProduct.productId + ' | Variant ID: ' + selectedProduct.variantId;
            
            const qrDisplayArea = document.getElementById('qr-display-area');
            
            if (qrImageData) {
                // Backend generated QR - hiển thị image từ server
                qrDisplayArea.innerHTML = `
                    <img src="${qrImageData}" 
                         alt="QR Code" 
                         style="width: 256px; height: 256px; border: 1px solid #ddd; border-radius: 8px;"
                         id="qr-image" />
                `;
                console.log('✅ Sử dụng QR Code từ Backend');
            } else {
                // Frontend generation fallback - dùng QRious library
                qrDisplayArea.innerHTML = '<canvas id="qr-canvas" width="256" height="256"></canvas>';
                const canvas = document.getElementById('qr-canvas');
                qr = new QRious({
                    element: canvas,
                    value: qrContent.replace(/\\n/g, '\n'),
                    size: 256,
                    background: 'white',
                    backgroundAlpha: 1,
                    foreground: 'black',
                    foregroundAlpha: 1,
                    level: 'M'
                });
                console.log('⚠️ Fallback: Sử dụng QR Code từ Frontend');
            }
            
            // Show modal
            const modalElement = document.getElementById('qrModal');
            const modal = new bootstrap.Modal(modalElement);
            modal.show();
        }
        
        function downloadQRCode() {
            const canvas = document.getElementById('qr-canvas');
            const image = document.getElementById('qr-image');
            
            if (canvas) {
                // Frontend generated QR (canvas)
                const link = document.createElement('a');
                link.download = 'qrcode-product-' + selectedProduct.productId + '-variant-' + selectedProduct.variantId + '.png';
                link.href = canvas.toDataURL();
                link.click();
            } else if (image) {
                // Backend generated QR (image)
                const link = document.createElement('a');
                link.download = 'qrcode-product-' + selectedProduct.productId + '-variant-' + selectedProduct.variantId + '.png';
                link.href = image.src;
                link.click();
            } else {
                alert('Không tìm thấy QR code để tải xuống!');
            }
        }
    </script>
</body>
</html>
