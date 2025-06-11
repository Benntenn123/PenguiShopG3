<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>


            .header h1 {
                font-size: 20px;
                font-weight: bold;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 16px;
            }

            .section {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 16px;
                padding: 16px;
            }

            .section-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 16px;
            }

            .section-title {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .section-title .icon {
                color: #AE1C9A;
                width: 20px;
                height: 20px;
            }

            .section-title h2 {
                font-size: 16px;
                font-weight: 600;
            }

            .btn-add {
                color: #AE1C9A;
                background: none;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 4px;
                font-size: 14px;
            }

            .btn-add:hover {
                opacity: 0.8;
            }

            .address-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 16px;
                background: rgba(174, 28, 154, 0.05);
            }

            .address-info {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

            .address-name {
                font-weight: 600;
                margin-bottom: 4px;
            }

            .address-text {
                color: #666;
                margin-bottom: 8px;
            }

            .default-badge {
                background: #AE1C9A;
                color: white;
                font-size: 12px;
                padding: 4px 8px;
                border-radius: 4px;
            }

            .btn-change {
                color: #AE1C9A;
                background: none;
                border: none;
                cursor: pointer;
            }

            .product-item {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 12px;
            }

            .product-image {
                width: 64px;
                height: 64px;
                object-fit: cover;
                border-radius: 4px;
            }

            .product-info {
                flex: 1;
            }

            .product-name {
                font-weight: 500;
                margin-bottom: 4px;
            }

            .product-variant {
                color: #666;
                font-size: 14px;
                margin-bottom: 8px;
            }

            .product-price-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .product-price {
                color: #AE1C9A;
                font-weight: 600;
            }

            .product-quantity {
                color: #666;
            }

            .shipping-option {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background: #f0f8ff;
            }

            .shipping-price {
                color: #AE1C9A;
                font-weight: 600;
            }

            .payment-option {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.2s;
                margin-bottom: 8px;
            }

            .payment-option:hover {
                border-color: #AE1C9A;
            }

            .payment-option.selected {
                border-color: #AE1C9A;
                background: rgba(174, 28, 154, 0.05);
            }

            .radio {
                width: 20px;
                height: 20px;
                border: 2px solid #ddd;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .payment-option.selected .radio {
                border-color: #AE1C9A;
            }

            .radio-dot {
                width: 10px;
                height: 10px;
                background: #AE1C9A;
                border-radius: 50%;
                display: none;
            }

            .payment-option.selected .radio-dot {
                display: block;
            }

            .payment-icon {
                font-size: 24px;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 8px;
            }

            .summary-total {
                display: flex;
                justify-content: space-between;
                font-size: 18px;
                font-weight: 600;
                color: #AE1C9A;
                padding-top: 8px;
                border-top: 1px solid #ddd;
            }

            .btn-order {
                width: 100%;
                background: linear-gradient(135deg, #AE1C9A, #E91E63);
                color: white;
                border: none;
                padding: 16px;
                border-radius: 8px;
                font-size: 18px;
                font-weight: 600;
                cursor: pointer;
                transition: opacity 0.2s;
            }

            .btn-order:hover {
                opacity: 0.9;
            }

            .terms {
                text-align: center;
                color: #666;
                font-size: 12px;
                margin-top: 8px;
            }

            .modal {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                display: none;
                align-items: center;
                justify-content: center;
                padding: 16px;
                z-index: 1000;
            }

            .modal.show {
                display: flex;
            }

            .modal-content {
                background: white;
                border-radius: 8px;
                width: 100%;
                max-width: 400px;
                max-height: 90vh;
                overflow-y: auto;
            }

            .modal-header {
                padding: 16px;
                border-bottom: 1px solid #ddd;
            }

            .modal-header h3 {
                font-size: 18px;
                font-weight: 600;
            }

            .modal-body {
                padding: 16px;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-label {
                display: block;
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 4px;
            }

            .form-input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
            }

            .form-input:focus {
                outline: none;
                border-color: #AE1C9A;
                box-shadow: 0 0 0 2px rgba(174, 28, 154, 0.2);
            }

            .form-textarea {
                resize: vertical;
                min-height: 80px;
            }

            .modal-actions {
                display: flex;
                gap: 12px;
                padding-top: 16px;
            }

            .btn-cancel {
                flex: 1;
                padding: 12px;
                border: 1px solid #ddd;
                background: white;
                border-radius: 8px;
                cursor: pointer;
            }

            .btn-submit {
                flex: 1;
                padding: 12px;
                background: #AE1C9A;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }

            .btn-submit:hover {
                opacity: 0.9;
            }

            .floating-btn {
                position: fixed;
                bottom: 80px;
                right: 16px;
                background: #AE1C9A;
                color: white;
                border: none;
                border-radius: 50%;
                width: 56px;
                height: 56px;
                cursor: pointer;
                box-shadow: 0 4px 12px rgba(174, 28, 154, 0.3);
                display: none;
            }

            .floating-btn:hover {
                opacity: 0.9;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 8px;
                }

                .product-item {
                    flex-direction: column;
                    text-align: center;
                }

                .address-info {
                    flex-direction: column;
                    gap: 8px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="Common/Header.jsp" />
        <!-- Header -->
        <div style="padding: 16px; text-align: center; margin-top: 30px" class="header">
            <h1 style="color: #AE1C9A; font-size: 40px">Xác nhận đơn hàng</h1>
        </div>

        <div class="container">
            <!-- Địa chỉ nhận hàng -->
            <div class="section">
                <div style="font-size: 18px" class="section-header">
                    <div style="margin-bottom: 0px !important" class="section-title">
                        <svg class="icon" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                        </svg>
                        <h2 style="margin-bottom: 0px !important">Địa chỉ nhận hàng</h2>
                    </div>
                    <a class="btn-add" href="deliveryinfo"> 
                        <span>Quản lí địa chỉ người nhận</span>
                    </a>
                </div>

                <div class="address-card" id="default-address">
                    <!-- Address will be populated by JavaScript -->
                </div>
            </div>

            <!-- Sản phẩm -->
            <div class="section">
                <h2 style="margin-bottom: 16px; font-size: 18px">Sản phẩm đã chọn</h2>
                <div id="products-list">
                    <c:forEach var="cartsession" items="${selectedCartItems}">
                        <div class="product-item">
                            <img src="api/img/${cartsession.value.cart.variant.product.imageMainProduct}" style="height: 100px; width: 100px" alt="" class="product-image">
                            <div class="product-info">
                                <div style="font-size: 16px" class="product-name">${cartsession.value.cart.variant.product.productName}</div>
                                <div class="product-variant">
                                    Màu ${cartsession.value.cart.variant.color.colorName}, 
                                    Size ${cartsession.value.cart.variant.size.sizeName}
                                </div>
                                <div class="product-price-row">
                                    <span style="font-size: 16px" class="product-price">
                                        ${cartsession.value.totalAmount} VND
                                    </span>
                                    <span style="font-size: 16px" class="product-quantity">x${cartsession.value.quantity}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Phương thức vận chuyển -->
            <div class="section">
                <div class="section-title" style="margin-bottom: 16px;">
                    <svg class="icon" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.66 1.34 3 3 3s3-1.34 3-3h6c0 1.66 1.34 3 3 3s3-1.34 3-3h2v-5l-3-4zM6 18.5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm13.5-9l1.96 2.5H17V9.5h2.5zm-1.5 9c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/>
                    </svg>
                    <h2>Phương thức vận chuyển</h2>
                </div>
                <div class="shipping-option">
                    <div>
                        <div style="font-weight: 500;">Giao hàng tiêu chuẩn</div>
                        <div style="font-size: 14px; color: #666;">Nhận hàng vào 12 - 15 Th6</div>
                    </div>
                    <div class="shipping-price">₫30,000</div>
                </div>
            </div>

            <!-- Phương thức thanh toán -->
            <div class="section">
                <div class="section-title" style="margin-bottom: 16px;">
                    <svg class="icon" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/>
                    </svg>
                    <h2>Phương thức thanh toán</h2>
                </div>
                <div id="payment-methods">
                    <div class="payment-option selected" onclick="selectPayment(this, 'cod')">
                        <div class="radio">
                            <div class="radio-dot"></div>
                        </div>
                        <span class="payment-icon">💵</span>
                        <span>Thanh toán khi nhận hàng (COD)</span>
                    </div>
                    <div class="payment-option" onclick="selectPayment(this, 'momo')">
                        <div class="radio">
                            <div class="radio-dot"></div>
                        </div>
                        <span class="payment-icon">🅿️</span>
                        <span>Ví MoMo</span>
                    </div>
                    <div class="payment-option" onclick="selectPayment(this, 'bank')">
                        <div class="radio">
                            <div class="radio-dot"></div>
                        </div>
                        <span class="payment-icon">💳</span>
                        <span>Thẻ ATM/Visa/Master</span>
                    </div>
                    <div class="payment-option" onclick="selectPayment(this, 'shopee_pay')">
                        <div class="radio">
                            <div class="radio-dot"></div>
                        </div>
                        <span class="payment-icon">🛒</span>
                        <span>ShopeePay</span>
                    </div>
                </div>
            </div>

            <!-- Tổng cộng -->
            <div class="section">
                <h2 style="margin-bottom: 16px;">Chi tiết thanh toán</h2>
                <div class="summary-row">
                    <span>Tổng tiền hàng</span>
                    <span id="subtotal">₫1,197,000</span>
                </div>
                <div class="summary-row">
                    <span>Phí vận chuyển</span>
                    <span>₫30,000</span>
                </div>
                <div class="summary-total">
                    <span>Tổng thanh toán</span>
                    <span id="total">₫1,227,000</span>
                </div>
            </div>

            <!-- Nút đặt hàng -->
            <div class="section">
                <button class="btn-order" onclick="placeOrder()">Đặt hàng</button>
                <p class="terms">Nhấn "Đặt hàng" đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản Shopee</p>
            </div>
        </div>

        <!-- Modal thêm địa chỉ -->
        <div class="modal" id="addressModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Chọn địa chỉ</h3>
                </div>
                <div class="modal-body">
                    <c:forEach var="address" items="${deliList}">
                        <div class="address-card" onclick="selectAddress('${address.deliveryInfoID}')" style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 12px; cursor: pointer; background: #f9f9f9;">
                            <div>
                                <div style="font-size: 16px; font-weight: 600;" class="address-name">${address.fullName} | ${address.phone}</div>
                                <div style="font-size: 16px; color: #666;" class="address-text">${address.addessDetail}, ${address.city}</div>
                                <span style="font-size: 16px; color: white; display: ${address.isDefault eq 1 ? 'inline' : 'none'};" class="default-badge">Mặc định</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="modal-actions">
                    <button class="btn-cancel" onclick="hideAddressModal()" style="font-size: 16px;margin: 10px 20px !important;padding: 12px 10px; border-radius: 8px; background: #AE1C9A; color: white; border: none; cursor: pointer;">Hủy</button>
                </div>
            </div>
        </div>

        <!-- Floating button -->
        <button class="floating-btn" onclick="showAddressModal()">
            <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
            <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
            </svg>
        </button>


        <script>
            // Parse the deli JSON string with proper unescaping
            let deliRaw = '${deli}';
            console.log('Raw deli data:', deliRaw);

            let addresses = [];
            try {
                // Unescape the JSON string - thay thế \" thành "
                let unescapedJson = deliRaw.replace(/\\"/g, '"');
                console.log('Unescaped JSON:', unescapedJson);

                addresses = unescapedJson ? JSON.parse(unescapedJson) : [];
                console.log('Parsed addresses:', addresses);
            } catch (error) {
                console.error('Error parsing addresses JSON:', error);
                console.log('Raw data was:', deliRaw);

                // Fallback: thử parse trực tiếp nếu cách trên không work
                try {
                    addresses = JSON.parse(deliRaw);
                } catch (error2) {
                    console.error('Fallback parse also failed:', error2);
                    addresses = [];
                }
            }
            function selectAddress(addressId) {
    // Cập nhật địa chỉ mặc định trong giao diện
    updateDefaultAddress(addressId);
}

function updateDefaultAddress(addressId) {
    // Tìm địa chỉ đã chọn
    const selectedAddress = addresses.find(addr => addr.deliveryInfoID == addressId);
    if (!selectedAddress) {
        console.error('Address not found for ID:', addressId);
        return;
    }

    // Cập nhật địa chỉ mặc định trong giao diện
    const addressCard = document.getElementById('default-address');
    if (addressCard) {
        const fullName = selectedAddress.fullName || '';
        const phone = selectedAddress.phone || '';
        const addressDetail = selectedAddress.addessDetail || '';
        const city = selectedAddress.city || '';

        // Tạo nội dung HTML mới
        const htmlContent = '<div class="address-info">' +
            '<div>' +
                '<div style="font-size: 16px" class="address-name">' + fullName + ' | ' + phone + '</div>' +
                '<div style="font-size: 16px" class="address-text">' + addressDetail + ', ' + city + '</div>' +
                '<span style="font-size: 16px" class="default-badge">Mặc định</span>' +
            '</div>' +
            '<button style="font-size: 16px" onclick="showAddressModal()" class="btn-change">Thay đổi</button>' +
        '</div>';

        // Cập nhật nội dung mới vào card
        addressCard.innerHTML = htmlContent;

        // Gọi AJAX để tính tiền ship
        calculateShipping(addressId);
    }
}

function calculateShipping(addressId) {
    // Gửi AJAX để tính tiền ship
    $.ajax({
        url: 'calculateShippingFee',
        method: 'POST',
        data: { addressId: addressId },
        success: function(response) {
            // Xử lý phản hồi từ server
            console.log('Shipping cost:', response.shippingCost);
            hideAddressModal();
            // Có thể cập nhật giao diện để hiển thị giá tiền ship
        },
        error: function(error) {
            console.error('Error calculating shipping:', error);
        }
    });
    
}

            // Function to display the default address
            function displayDefaultAddress() {
                const addressCard = document.getElementById('default-address');
                if (!addressCard) {
                    console.error('Address card element not found');
                    return;
                }

                console.log('Displaying default address...');
                console.log('Total addresses:', addresses.length);

                let defaultAddress = addresses.find(addr => addr.isDefault === 1);
                console.log('Found default address:', defaultAddress);

                // Nếu không tìm thấy địa chỉ mặc định, sử dụng địa chỉ đầu tiên
                if (!defaultAddress && addresses.length > 0) {
                    defaultAddress = addresses[0];
                    console.log('Using first address as default:', defaultAddress);
                }

                if (defaultAddress) {
                    // Lấy các giá trị với giá trị mặc định
                    const fullName = defaultAddress.fullName || '';
                    const phone = defaultAddress.phone || '';
                    const addressDetail = defaultAddress.addessDetail || '';
                    const city = defaultAddress.city || '';

                    // Tạo nội dung HTML bằng cách nối chuỗi
                    const htmlContent = '<div class="address-info">' +
                            '<div>' +
                            '<div style="font-size: 16px" class="address-name">' + fullName + ' | ' + phone + '</div>' +
                            '<div style="font-size: 16px" class="address-text">' + addressDetail + ', ' + city + '</div>' +
                            (defaultAddress.isDefault ? '<span style="font-size: 16px" class="default-badge">Mặc định</span>' : '') +
                            '</div>' +
                            '<button style="font-size: 16px" onclick="showAddressModal()" class="btn-change">Thay đổi</button>' +
                            '</div>';

                    console.log('HTML Content generated successfully');
                    addressCard.innerHTML = htmlContent;
                } else {
                    console.log('No address found, showing default message');
                    addressCard.innerHTML = '<div class="address-info">' +
                            '<div style="font-size: 16px; color: #666;">Chưa có địa chỉ nào được chọn. Vui lòng thêm địa chỉ.</div>' +
                            '<button style="font-size: 16px" onclick="showAddressModal()" class="btn-change">Thêm địa chỉ</button>' +
                            '</div>';
                }
            }

            // Gọi hàm để hiển thị địa chỉ
            displayDefaultAddress();

            // Call the function to display the default address on page load
            displayDefaultAddress();

            let selectedPayment = 'cod';

            function selectPayment(element, paymentId) {
                document.querySelectorAll('.payment-option').forEach(option => {
                    option.classList.remove('selected');
                });
                element.classList.add('selected');
                selectedPayment = paymentId;
            }

            function showAddressModal() {
                const modal = document.getElementById('addressModal');
                if (modal) {
                    modal.classList.add('show');
                }
            }

            function hideAddressModal() {
                const modal = document.getElementById('addressModal');
                if (modal) {
                    modal.classList.remove('show');
                }

                // Clear form fields safely
                const fields = ['newName', 'newPhone', 'newAddress'];
                fields.forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    if (field)
                        field.value = '';
                });
            }

            function addAddress() {
                const name = document.getElementById('newName')?.value?.trim() || '';
                const phone = document.getElementById('newPhone')?.value?.trim() || '';
                const address = document.getElementById('newAddress')?.value?.trim() || '';

                if (!name || !phone || !address) {
                    alert('Vui lòng điền đầy đủ thông tin');
                    return;
                }

                const newAddress = {
                    deliveryInfoID: addresses.length + 1,
                    fullName: name,
                    phone: phone,
                    addessDetail: address,
                    city: '',
                    isDefault: addresses.length === 0 ? 1 : 0
                };

                addresses.push(newAddress);
                hideAddressModal();
                displayDefaultAddress();
                alert('Thêm địa chỉ thành công!');

                // Update floating button visibility
                updateFloatingButton();
            }

            function placeOrder() {
                const defaultAddress = addresses.find(addr => addr.isDefault === 1) || addresses[0];

                if (!defaultAddress) {
                    alert('Vui lòng chọn địa chỉ giao hàng!');
                    return;
                }

                const orderData = {
                    payment: selectedPayment,
                    address: defaultAddress,
                    total: '₫1,227,000'
                };

                const paymentText = {
                    'cod': 'COD',
                    'momo': 'MoMo',
                    'bank': 'Thẻ ngân hàng',
                    'shopee_pay': 'ShopeePay'
                }[selectedPayment] || 'Không xác định';

                const addressText = `${defaultAddress.fullName || ''}, ${defaultAddress.addessDetail || ''}, ${defaultAddress.city || ''}`;

                        alert(`Đặt hàng thành công!\nPhương thức thanh toán: ${paymentText}\nĐịa chỉ: ${addressText}\nTổng tiền: ${orderData.total}`);
                    }

                    function updateFloatingButton() {
                        const floatingBtn = document.querySelector('.floating-btn');
                        if (floatingBtn) {
                            floatingBtn.style.display = addresses.length > 1 ? 'block' : 'none';
                        }
                    }

                    // Initialize floating button and modal event listener
                    document.addEventListener('DOMContentLoaded', function () {
                        updateFloatingButton();

                        // Close modal when clicking outside
                        const addressModal = document.getElementById('addressModal');
                        if (addressModal) {
                            addressModal.addEventListener('click', function (e) {
                                if (e.target === this) {
                                    hideAddressModal();
                                }
                            });
                        }
                    });
        </script>
    </body>
</html>