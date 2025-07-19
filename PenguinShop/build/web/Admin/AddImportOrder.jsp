<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .product-search-container {
                position: relative;
            }

            .product-suggestions {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                max-height: 300px;
                overflow-y: auto;
                z-index: 1000;
                display: none;
            }

            .product-suggestion-item {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .product-suggestion-item:hover {
                background-color: #f8f9fa;
            }

            .product-suggestion-item:last-child {
                border-bottom: none;
            }

            .product-avatar {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                object-fit: cover;
            }

            .product-info h6 {
                margin: 0;
                font-size: 14px;
                font-weight: 600;
                color: #333;
            }

            .product-info small {
                color: #6c757d;
                font-size: 12px;
            }

            .product-price {
                font-weight: 600;
                color: #28a745;
            }

            .import-items-table {
                background: white;
                border-radius: 8px;
                overflow: hidden;
            }

            .import-item-row {
                background: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 10px;
                transition: all 0.3s ease;
            }

            .import-item-row:hover {
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .remove-item-btn {
                background: #dc3545;
                border: none;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .remove-item-btn:hover {
                background: #c82333;
                transform: scale(1.1);
            }

            .total-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px;
                border-radius: 10px;
                margin-top: 20px;
            }

            .total-amount {
                font-size: 24px;
                font-weight: bold;
            }

            .form-floating > .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-add-product {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-add-product:hover {
                background: linear-gradient(135deg, #218838 0%, #1ba085 100%);
                transform: translateY(-1px);
                color: white;
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
                        <!-- Breadcrumb -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Tạo đơn nhập hàng</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="welcomeAdmin">Trang chủ</a></li>
                                            <li class="breadcrumb-item"><a href="ImportOrderList">Đơn nhập hàng</a></li>
                                            <li class="breadcrumb-item active">Tạo mới</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Message Alert -->
                        <jsp:include page="Common/Message.jsp"/>

                        <!-- Error Alert -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="mdi mdi-alert-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form id="importOrderForm" method="post" action="AddImportOrder">
                            <div class="row">
                                <!-- Thông tin cơ bản -->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">
                                                <i class="mdi mdi-information me-2"></i>Thông tin đơn nhập
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <!-- Supplier Selection -->
                                            <div class="mb-3">
                                                <label class="form-label">Nhà cung cấp <span class="text-danger">*</span></label>
                                                <select class="form-select" name="supplierId" required>
                                                    <option value="">-- Chọn nhà cung cấp --</option>
                                                    <c:forEach var="supplier" items="${suppliers}">
                                                        <option value="${supplier.supplierID}" 
                                                                ${selectedSupplierId == supplier.supplierID ? 'selected' : ''}>
                                                            ${supplier.supplierName}
                                                            <c:if test="${not empty supplier.contactName}">
                                                                - ${supplier.contactName}
                                                            </c:if>
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <!-- Import Date -->
                                            <div class="mb-3">
                                                <label class="form-label">Ngày nhập</label>
                                                <input type="date" class="form-control" name="importDate" required>
                                            </div>

                                            <!-- Note -->
                                            <div class="mb-3">
                                                <label class="form-label">Ghi chú</label>
                                                <textarea class="form-control" name="note" rows="3" 
                                                          placeholder="Ghi chú về đơn nhập hàng..."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sản phẩm -->
                                <div class="col-lg-8">
                                    <div class="card">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h5 class="card-title mb-0">
                                                <i class="mdi mdi-package-variant me-2"></i>Danh sách sản phẩm
                                            </h5>
                                            <div style="vertical-align: center" class="btn-group">
                                                <button type="button" class="btn btn-success btn-sm" id="importExcelBtn">
                                                    <i class="mdi mdi-file-excel me-1"></i>Import Excel
                                                </button>
                                                <a href="#" class="btn btn-outline-success btn-sm" id="downloadTemplateBtn">
                                                    <i class="mdi mdi-download me-1"></i>Tải mẫu
                                                </a>
                                                <button type="button" class="btn btn-add-product" id="addProductBtn">
                                                    <i class="mdi mdi-plus me-2"></i>Thêm sản phẩm
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <!-- Product Search -->
                                            <div class="row mb-3" id="productSearchRow" style="display: none;">
                                                <div class="col-12">
                                                    <div class="product-search-container">
                                                        <input type="text" class="form-control" id="productSearchInput" 
                                                               placeholder="Nhập tên sản phẩm (tối thiểu 2 ký tự)...">
                                                        <div class="product-suggestions" id="productSuggestions"></div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Selected Products -->
                                            <div id="selectedProducts">
                                                <div class="text-center py-4 text-muted" id="noProductsMessage">
                                                    <i class="mdi mdi-package-variant-closed-remove" style="font-size: 48px;"></i>
                                                    <p class="mt-2 mb-0">Chưa có sản phẩm nào được chọn</p>
                                                    <p class="small">Nhấn "Thêm sản phẩm" hoặc "Import Excel" để bắt đầu</p>
                                                </div>
                                            </div>
                                            
                                            <!-- Hidden file input for Excel import -->
                                            <input type="file" id="excelFileInput" accept=".xlsx,.xls" style="display: none;">
                                        </div>
                                    </div>

                                    <!-- Total Section -->
                                    <div class="total-section" style="display: none;" id="totalSection">
                                        <div class="row align-items-center">
                                            <div class="col-sm-6">
                                                <h5 class="mb-0">Tổng cộng:</h5>
                                            </div>
                                            <div class="col-sm-6 text-sm-end">
                                                <div class="total-amount" id="totalAmount">0 ₫</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="d-flex justify-content-end gap-3 mt-3">
                                        <a href="ImportOrderList" class="btn btn-secondary">
                                            <i class="mdi mdi-arrow-left me-2"></i>Quay lại
                                        </a>
                                        <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                                            <i class="mdi mdi-content-save me-2"></i>Lưu đơn nhập hàng
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
        </div>

        <jsp:include page="Common/Js.jsp"/>
        
        <!-- SheetJS for Excel processing -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

        <script>
            let productCounter = 0;
            let selectedProductIds = [];
            let searchTimeout;

            $(document).ready(function () {
                // Set current date
                const today = new Date().toISOString().split('T')[0];
                $('input[name="importDate"]').val(today);

                // Add product button
                $('#addProductBtn').click(function () {
                    $('#productSearchRow').show();
                    $('#productSearchInput').focus();
                });
                
                // Import Excel button
                $('#importExcelBtn').click(function() {
                    $('#excelFileInput').click();
                });
                
                // Download template button
                $('#downloadTemplateBtn').click(function(e) {
                    e.preventDefault();
                    downloadExcelTemplate();
                });
                
                // Handle file selection
                $('#excelFileInput').change(function() {
                    const file = this.files[0];
                    if (file) {
                        readExcelFile(file);
                    }
                });

                // Product search với debounce
                $('#productSearchInput').on('input', function () {
                    clearTimeout(searchTimeout);
                    const query = $(this).val().trim();

                    if (query.length >= 2) { // Tối thiểu 2 ký tự
                        // Hiển thị loading
                        $('#productSuggestions').html('<div class="p-3 text-center"><i class="mdi mdi-loading mdi-spin"></i> Đang tìm kiếm...</div>').show();

                        searchTimeout = setTimeout(() => {
                            searchProducts(query);
                        }, 500); // Tăng delay lên 500ms
                    } else {
                        $('#productSuggestions').hide();
                    }
                });

                // Click outside to hide suggestions
                $(document).click(function (e) {
                    if (!$(e.target).closest('.product-search-container').length) {
                        $('#productSuggestions').hide();
                    }
                });

                // Form validation
                $('#importOrderForm').on('submit', function (e) {
                    if (selectedProductIds.length === 0) {
                        e.preventDefault();
                        alert('Vui lòng chọn ít nhất một sản phẩm!');
                        return false;
                    }

                    // Validate quantities and prices
                    let isValid = true;
                    $('.import-item-row').each(function () {
                        const quantity = parseInt($(this).find('.quantity-input').val());
                        const price = parseFloat($(this).find('.price-input').val());

                        if (quantity <= 0 || isNaN(quantity)) {
                            isValid = false;
                            $(this).find('.quantity-input').addClass('is-invalid');
                        }

                        if (price <= 0 || isNaN(price)) {
                            isValid = false;
                            $(this).find('.price-input').addClass('is-invalid');
                        }
                    });

                    if (!isValid) {
                        e.preventDefault();
                        alert('Vui lòng nhập số lượng và giá nhập hợp lệ!');
                        return false;
                    }
                });
            });

            // Search products via API với cache và throttling
            let searchCache = {};
            let currentSearchRequest = null;

            function searchProducts(query) {
                // Kiểm tra cache
                if (searchCache[query]) {
                    showProductSuggestions(searchCache[query]);
                    return;
                }

                // Hủy request trước nếu có
                if (currentSearchRequest) {
                    currentSearchRequest.abort();
                }

                currentSearchRequest = $.ajax({
                    url: 'api/product-search',
                    method: 'GET',
                    data: {q: query, limit: 10},
                    dataType: 'json',
                    timeout: 10000, // 10 giây timeout
                    success: function (response) {
                        currentSearchRequest = null;
                        if (response.status === 'success' && response.data.length > 0) {
                            // Lưu vào cache
                            searchCache[query] = response.data;
                            showProductSuggestions(response.data);
                        } else {
                            $('#productSuggestions').hide();
                        }
                    },
                    error: function (xhr, status, error) {
                        currentSearchRequest = null;
                        if (status !== 'abort') {
                            console.log('Lỗi khi tìm kiếm sản phẩm:', error);
                            $('#productSuggestions').html('<div class="p-3 text-center text-muted">Có lỗi khi tìm kiếm</div>').show();
                        }
                    }
                });
            }

            // Show product suggestions - hiển thị các variant
            function showProductSuggestions(variants) {
                let html = '';

                variants.forEach(function (variant) {
                    if (selectedProductIds.includes(variant.variantId)) {
                        return; // Skip already selected variants
                    }
                    
                    const brandName = variant.brandName || '';
                    const colorName = variant.colorName || '';
                    const sizeName = variant.sizeName || '';
                    const variantId = variant.variantId || 0;
                    const price = variant.price || 0;
                    const productName = variant.name || '';
                    const productImage = variant.image || 'default.png';
                    const quantity = variant.quantity || 0;

                    // Tạo tên hiển thị với màu sắc và size
                    let displayName = productName;
                    if (colorName) displayName += ' - ' + colorName;
                    if (sizeName) displayName += ' - ' + sizeName;

                    html += '<div class="product-suggestion-item" onclick="selectProduct(' + variant.id + ', \'' + 
                            productName + '\', \'' + productImage + '\', ' + price + ', \'' + brandName + '\', \'' + 
                            colorName + '\', \'' + sizeName + '\', ' + variantId + ')">' +
                            '<div class="d-flex align-items-center">' +
                            '<div class="product-info flex-grow-1">' +
                            '<h6>' + displayName + '</h6>' +
                            '<small class="text-muted">' + brandName + ' - Tồn kho: ' + quantity + '</small>' +
                            '</div>' +
                            '<div class="text-end">' +
                            '<span class="product-price">' + formatCurrency(price) + '</span>' +
                            '</div></div></div>';
                });

                $('#productSuggestions').html(html).show();
            }

            // Select product variant
            function selectProduct(productId, name, image, price, brand, color, size, variantId) {
                selectedProductIds.push(variantId); // Lưu variantId thay vì productId

                const displayName = name + (color ? ' - ' + color : '') + (size ? ' - ' + size : '');

                const productHtml = '<div class="import-item-row" data-variant-id="' + variantId + '">' +
                    '<div class="row align-items-center">' +
                    '<div class="col-md-6">' +
                    '<div class="product-info">' +
                    '<h6 class="mb-1">' + displayName + '</h6>' +
                    '<small class="text-muted">' + brand + '</small>' +
                    '<input type="hidden" name="productId" value="' + productId + '">' +
                    '<input type="hidden" name="variantId" value="' + variantId + '">' +
                    '</div></div>' +
                    '<div class="col-md-2">' +
                    '<div class="form-floating">' +
                    '<input type="number" class="form-control quantity-input" name="quantity" min="1" value="1" required onchange="calculateSubtotal(this)">' +
                    '<label>Số lượng</label>' +
                    '</div></div>' +
                    '<div class="col-md-2">' +
                    '<div class="form-floating">' +
                    '<input type="number" class="form-control price-input" name="importPrice" min="0" step="1000" value="' + price + '" required onchange="calculateSubtotal(this)">' +
                    '<label>Giá nhập (₫)</label>' +
                    '</div></div>' +
                    '<div class="col-md-1">' +
                    '<div class="subtotal-display text-end fw-bold text-success">' + formatCurrency(price) + '</div>' +
                    '</div>' +
                    '<div class="col-md-1 text-end">' +
                    '<button type="button" class="remove-item-btn" onclick="removeProduct(' + variantId + ', this)">' +
                    '<i class="mdi mdi-close"></i>' +
                    '</button>' +
                    '</div></div></div>';

                if ($('#noProductsMessage').is(':visible')) {
                    $('#noProductsMessage').hide();
                    $('#totalSection').show();
                }

                $('#selectedProducts').append(productHtml);
                $('#productSuggestions').hide();
                $('#productSearchInput').val('');
                $('#productSearchRow').hide();
                $('#submitBtn').prop('disabled', false);

                calculateTotal();
            }

            // Remove product variant
            function removeProduct(variantId, button) {
                selectedProductIds = selectedProductIds.filter(id => id !== variantId);
                $(button).closest('.import-item-row').remove();

                if (selectedProductIds.length === 0) {
                    $('#noProductsMessage').show();
                    $('#totalSection').hide();
                    $('#submitBtn').prop('disabled', true);
                }

                calculateTotal();
            }

            // Calculate subtotal for each item
            function calculateSubtotal(input) {
                const row = $(input).closest('.import-item-row');
                const quantity = parseInt(row.find('.quantity-input').val()) || 0;
                const price = parseFloat(row.find('.price-input').val()) || 0;
                const subtotal = quantity * price;

                row.find('.subtotal-display').text(formatCurrency(subtotal));
                calculateTotal();
            }

            // Calculate total amount
            function calculateTotal() {
                let total = 0;
                $('.import-item-row').each(function () {
                    const quantity = parseInt($(this).find('.quantity-input').val()) || 0;
                    const price = parseFloat($(this).find('.price-input').val()) || 0;
                    total += quantity * price;
                });

                $('#totalAmount').text(formatCurrency(total));
            }

            // Format currency
            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(amount);
            }
            
            // Download Excel template
            function downloadExcelTemplate() {
                const wb = XLSX.utils.book_new();
                const wsData = [
                    ['Mã sản phẩm', 'Tên sản phẩm', 'Số lượng', 'Giá nhập (₫)', 'Ghi chú'],
                    ['1', 'Áo thun chạy bộ Advanced Vent Tech Graphic Camo', 10, 150000, 'Size M, màu đen'],
                    ['2', 'Biker Shorts nữ chạy bộ 8inch', 5, 300000, 'Size L, màu xanh'],
                ];
                
                const ws = XLSX.utils.aoa_to_sheet(wsData);
                
                // Set column widths
                ws['!cols'] = [
                    {width: 15}, // Mã sản phẩm
                    {width: 25}, // Tên sản phẩm
                    {width: 12}, // Số lượng
                    {width: 15}, // Giá nhập
                    {width: 30}  // Ghi chú
                ];
                
                XLSX.utils.book_append_sheet(wb, ws, 'Danh sách nhập hàng');
                XLSX.writeFile(wb, 'Mau_Nhap_Hang.xlsx');
            }
            
            // Read Excel file
            function readExcelFile(file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    try {
                        const data = new Uint8Array(e.target.result);
                        const workbook = XLSX.read(data, {type: 'array'});
                        const firstSheetName = workbook.SheetNames[0];
                        const worksheet = workbook.Sheets[firstSheetName];
                        const jsonData = XLSX.utils.sheet_to_json(worksheet, {header: 1});
                        
                        processExcelData(jsonData);
                    } catch (error) {
                        alert('Lỗi khi đọc file Excel: ' + error.message);
                    }
                };
                reader.readAsArrayBuffer(file);
            }
            
            // Process Excel data
            function processExcelData(data) {
                if (data.length < 2) {
                    alert('File Excel không có dữ liệu!');
                    return;
                }
                
                // Skip header row
                let successCount = 0;
                let errorCount = 0;
                const errors = [];
                
                for (let i = 1; i < data.length; i++) {
                    const row = data[i];
                    const productId = row[0]; // Mã sản phẩm
                    const productName = row[1]; // Tên sản phẩm
                    const quantity = parseInt(row[2]) || 1; // Số lượng
                    const price = parseFloat(row[3]) || 0; // Giá nhập
                    const note = row[4] || ''; // Ghi chú
                    
                    if (!productId || !productName) {
                        errors.push(`Dòng ${i + 1}: Thiếu mã hoặc tên sản phẩm`);
                        errorCount++;
                        continue;
                    }
                    
                    if (selectedProductIds.includes(productId)) {
                        errors.push(`Dòng ${i + 1}: Sản phẩm ${productId} đã tồn tại`);
                        errorCount++;
                        continue;
                    }
                    
                    // Add product to list
                    addProductFromExcel(productId, productName, quantity, price, note);
                    successCount++;
                }
                
                // Show results
                let message = `Nhập thành công ${successCount} sản phẩm.`;
                if (errorCount > 0) {
                    message += `\n${errorCount} dòng có lỗi:\n` + errors.slice(0, 5).join('\n');
                    if (errors.length > 5) {
                        message += `\n... và ${errors.length - 5} lỗi khác`;
                    }
                }
                
                alert(message);
                
                // Reset file input
                $('#excelFileInput').val('');
            }
            
            // Add product from Excel data (sẽ cần sửa lại để tìm variantId)
            function addProductFromExcel(productId, productName, quantity, price, note) {
                // Tạm thời sử dụng productId làm variantId, sau này cần sửa lại
                const variantId = productId; 
                selectedProductIds.push(variantId);
                
                const subtotal = quantity * price;
                const productHtml = '<div class="import-item-row" data-variant-id="' + variantId + '">' +
                    '<div class="row align-items-center">' +
                    '<div class="col-md-6">' +
                    '<div class="product-info">' +
                    '<h6 class="mb-1">' + productName + '</h6>' +
                    '<small class="text-muted">' + note + '</small>' +
                    '<input type="hidden" name="productId" value="' + productId + '">' +
                    '<input type="hidden" name="variantId" value="' + variantId + '">' +
                    '</div></div>' +
                    '<div class="col-md-2">' +
                    '<div class="form-floating">' +
                    '<input type="number" class="form-control quantity-input" name="quantity" min="1" value="' + quantity + '" required onchange="calculateSubtotal(this)">' +
                    '<label>Số lượng</label>' +
                    '</div></div>' +
                    '<div class="col-md-2">' +
                    '<div class="form-floating">' +
                    '<input type="number" class="form-control price-input" name="importPrice" min="0" step="1000" value="' + price + '" required onchange="calculateSubtotal(this)">' +
                    '<label>Giá nhập (₫)</label>' +
                    '</div></div>' +
                    '<div class="col-md-1">' +
                    '<div class="subtotal-display text-end fw-bold text-success">' + formatCurrency(subtotal) + '</div>' +
                    '</div>' +
                    '<div class="col-md-1 text-end">' +
                    '<button type="button" class="remove-item-btn" onclick="removeProduct(\'' + variantId + '\', this)">' +
                    '<i class="mdi mdi-close"></i>' +
                    '</button>' +
                    '</div></div></div>';
                
                if ($('#noProductsMessage').is(':visible')) {
                    $('#noProductsMessage').hide();
                    $('#totalSection').show();
                }
                
                $('#selectedProducts').append(productHtml);
                $('#submitBtn').prop('disabled', false);
                
                calculateTotal();
            }
        </script>
    </body>
</html>
