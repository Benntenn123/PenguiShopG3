<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .quantity-controls {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .quantity-btn {
                background: #f8f9fa;
                border: 1px solid #AE1C9A;
                width: 30px;
                height: 30px;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                color: #AE1C9A;
                transition: all 0.3s ease;
            }

            .quantity-btn:hover {
                background: #AE1C9A;
                color: white;
                transform: scale(1.05);
            }

            .quantity-input {
                width: 50px;
                text-align: center;
                border: 2px solid #AE1C9A;
                border-radius: 6px;
                padding: 8px 5px;
                font-size: 14px;
                font-weight: bold;
                color: #AE1C9A;
                transition: all 0.3s ease;
            }

            .quantity-input:focus {
                outline: none;
                border-color: #8e1578;
                box-shadow: 0 0 10px rgba(174, 28, 154, 0.3);
            }

            .product-checkbox {
                width: 20px;
                height: 20px;
                cursor: pointer;
                accent-color: #AE1C9A;
                transform: scale(1.2);
            }

            .product-checkbox:checked {
                filter: drop-shadow(0 0 5px rgba(174, 28, 154, 0.5));
            }

            .total-price {
                font-weight: bold;
                color: #AE1C9A;
                font-size: 16px;
                text-shadow: 0 1px 2px rgba(174, 28, 154, 0.1);
            }

            .size-select {
                padding: 8px 12px;
                border: 2px solid #AE1C9A;
                border-radius: 6px;
                background: white;
                color: #AE1C9A;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 80px;
            }

            .size-select:focus {
                outline: none;
                background: #AE1C9A;
                color: white;
                box-shadow: 0 0 10px rgba(174, 28, 154, 0.3);
            }

            .size-select option {
                background: white;
                color: #AE1C9A;
                padding: 5px;
            }

            .table-wrapper.wrapper-checkbox {
                width: 5%;
                text-align: center;
            }

            .table-wrapper.wrapper-product {
                width: 30%;
            }

            .table-wrapper.wrapper-price {
                width: 12%;
                text-align: center;
            }

            .table-wrapper.wrapper-size {
                width: 10%;
                text-align: center;
            }

            .table-wrapper.wrapper-quantity {
                width: 15%;
                text-align: center;
            }

            .table-wrapper.wrapper-total {
                width: 12%;
                text-align: center;
            }

            .table-wrapper.wrapper-action {
                width: 8%;
                text-align: center;
            }

            .cart-summary {
                margin-top: 20px;
                padding: 25px;
                background: linear-gradient(135deg, #faf8ff 0%, #f5f0ff 100%);
                border-radius: 12px;
                border: 2px solid #AE1C9A;
                box-shadow: 0 4px 15px rgba(174, 28, 154, 0.15);
            }

            .cart-summary h4 {
                color: #AE1C9A;
                margin-bottom: 20px;
                font-size: 20px;
                font-weight: bold;
                border-bottom: 2px solid #AE1C9A;
                padding-bottom: 10px;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 12px;
                padding: 8px 0;
                font-size: 15px;
            }

            .summary-row span:first-child {
                color: #666;
                font-weight: 500;
            }

            .summary-row span:last-child {
                color: #AE1C9A;
                font-weight: bold;
            }

            .grand-total {
                font-size: 20px;
                font-weight: bold;
                color: #AE1C9A;
                border-top: 3px solid #AE1C9A;
                padding-top: 15px;
                margin-top: 15px;
                background: rgba(174, 28, 154, 0.05);
                padding: 15px;
                border-radius: 8px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .checkout-btn {
                background: linear-gradient(135deg, #AE1C9A 0%, #d63ab5 100%);
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 8px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                margin-top: 20px;
                width: 100%;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(174, 28, 154, 0.3);
            }

            .checkout-btn:hover {
                background: linear-gradient(135deg, #8e1578 0%, #b5309a 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(174, 28, 154, 0.4);
            }

            .checkout-btn:disabled {
                background: #cccccc;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .remove-btn {
                transition: all 0.3s ease;
                padding: 8px;
                border-radius: 50%;
            }

            .remove-btn:hover {
                background: rgba(174, 28, 154, 0.1);
                transform: scale(1.2);
            }

            .remove-btn svg path {
                transition: fill 0.3s ease;
            }

            .remove-btn:hover svg path {
                fill: #AE1C9A;
            }

            .inner-text {
                color: #AE1C9A;
                font-weight: bold;
                font-size: 16px;
            }

            .cart-heading {
                color: #AE1C9A;
                text-shadow: 0 1px 3px rgba(174, 28, 154, 0.2);
            }

            .table-heading {
                color: #AE1C9A;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .unit-price {
                color: #666;
                font-weight: 600;
            }

            .product-row:hover {
                background: rgba(174, 28, 154, 0.02);
                transition: all 0.3s ease;
            }

            .clean-btn, .shop-btn {
                transition: all 0.3s ease;
                border: 2px solid #AE1C9A;
                color: #AE1C9A;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                display: inline-block;
                margin: 0 10px;
            }

            .clean-btn:hover, .shop-btn:hover {
                background: #AE1C9A;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(174, 28, 154, 0.3);
            }
            .in-stock {
                color: #28a745;
            } /* Green for in stock */
            .out-of-stock {
                color: #dc3545;
            } /* Red for out of stock */
        </style>
    </head>
    <body>

        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <!--------------- blog-tittle-section---------------->

        <!--------------- blog-tittle-section-end---------------->

        <!---------------user-profile-section---------------->
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">

                    <div class="user-dashboard">

                        <jsp:include page="Common/CommonUser.jsp"/>

                        <!-- nav-content -->
                        <div class="tab-content nav-content" id="v-pills-tabContent" style="flex: 1 0%;">
                            <div class="" id="v-pills-wishlist" role="tabpanel"
                                 aria-labelledby="v-pills-wishlist-tab" tabindex="0">

                                <div class="wishlist">
                                    <div class="cart-content">
                                        <h5 class="cart-heading">Xin chào ${user.fullName}</h5>
                                        <p>Giỏ hàng của bạn có <span class="inner-text" id="selected-count">0</span> sản phẩm được chọn</p>
                                    </div>

                                    <form id="cart-form" action="processCart" method="post">
                                        <div class="cart-section wishlist-section">
                                            <table>
                                                <tbody>
                                                    <tr class="table-row table-top-row">
                                                        <td class="table-wrapper wrapper-checkbox">
                                                            <div class="table-wrapper-center">
                                                                <input type="checkbox" id="select-all" class="product-checkbox">
                                                            </div>
                                                        </td>
                                                        <td class="table-wrapper wrapper-product">
                                                            <h5 class="table-heading">Sản Phẩm</h5>
                                                        </td>
                                                        <td class="table-wrapper wrapper-price">
                                                            <div class="table-wrapper-center">
                                                                <h5 class="table-heading">Giá</h5>
                                                            </div>
                                                        </td>
                                                        <td class="table-wrapper wrapper-size">
                                                            <div class="table-wrapper-center">
                                                                <h5 class="table-heading">Loại</h5>
                                                            </div>
                                                        </td>
                                                        <td class="table-wrapper wrapper-quantity">
                                                            <div class="table-wrapper-center">
                                                                <h5 class="table-heading">Số Lượng</h5>
                                                            </div>
                                                        </td>
                                                        <td class="table-wrapper wrapper-total">
                                                            <div class="table-wrapper-center">
                                                                <h5 class="table-heading">Tổng</h5>
                                                            </div>
                                                        </td>
                                                        <td class="table-wrapper wrapper-action">
                                                            <div class="table-wrapper-center">
                                                                <h5 class="table-heading">Hành Động</h5>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <c:forEach var="cart" items="${cart}">
                                                        <!-- Product 1 -->
                                                        <tr class="table-row ticket-row product-row" data-product-id="1" data-price="20.00">
                                                            <td class="table-wrapper wrapper-checkbox">
                                                                <div class="table-wrapper-center">
                                                                    <input type="checkbox" name="selectedProducts" value="${cart.cartID}" class="product-checkbox product-select">
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-product">
                                                                <div class="wrapper">
                                                                    <div class="wrapper-img">
                                                                        <img src="api/img/${cart.product.imageMainProduct}" alt="img">
                                                                    </div>
                                                                    <div class="wrapper-content">
                                                                        <h5 style="width: 200px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" class="heading">${cart.product.productName}</h5>
                                                                        <p style="font-size: 12px; margin: 5px 0; font-weight: bold" 
                                                                           class="${cart.variant.quantity > 0 ? 'in-stock' : 'out-of-stock'}">
                                                                            <c:choose>
                                                                                <c:when test="${cart.variant.quantity > 0}">
                                                                                    Còn hàng
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    Hết hàng
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-price">
                                                                <div class="table-wrapper-center">
                                                                    <h5 class="heading unit-price" data-price="${cart.variant.price}">${cart.variant.price} VND</h5>
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-size">
                                                                <div class="table-wrapper-center">
                                                                    <button type="button" onclick="changeVariant()" style="padding: 10px; width: 80px;
                                                                            font-size: 14px; border-radius: 6px; border: 1px solid #AE1C9A">${cart.variant.size.sizeName} - ${cart.variant.color.colorName}</button>
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-quantity">
                                                                <div class="table-wrapper-center">
                                                                    <div class="quantity-controls">
                                                                        <button type="button" class="quantity-btn minus-btn">-</button>
                                                                        <input type="number" name="quantity_${cart.cartID}" value="${cart.quantity}" min="1" max="${cart.variant.quantity}" class="quantity-input">
                                                                        <button type="button" class="quantity-btn plus-btn">+</button>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-total">
                                                                <div class="table-wrapper-center">
                                                                    <h5 class="heading total-price">${cart.variant.price * cart.quantity} VND</h5>
                                                                </div>
                                                            </td>
                                                            <td class="table-wrapper wrapper-action">
                                                                <div class="table-wrapper-center">
                                                                    <span class="remove-btn" style="cursor: pointer;" data-cart-id="${cart.cartID}">
                                                                        <svg width="10" height="10" viewBox="0 0 10 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path d="M9.7 0.3C9.3 -0.1 8.7 -0.1 8.3 0.3L5 3.6L1.7 0.3C1.3 -0.1 0.7 -0.1 0.3 0.3C-0.1 0.7 -0.1 1.3 0.3 1.7L3.6 5L0.3 8.3C-0.1 8.7 -0.1 9.3 0.3 9.7C0.7 10.1 1.3 10.1 1.7 9.7L5 6.4L8.3 9.7C8.7 10.1 9.3 10.1 9.7 9.7C10.1 9.3 10.1 8.7 9.7 8.3L6.4 5L9.7 1.7C10.1 1.3 10.1 0.7 9.7 0.3Z" fill="#AAAAAA"></path>
                                                                        </svg>
                                                                    </span>
                                                                </div>
                                                            </td>
                                                        </tr> 
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Cart Summary -->
                                        <div class="cart-summary">
                                            <h4>Tóm tắt đơn hàng</h4>
                                            <div class="summary-row">
                                                <span>Số sản phẩm đã chọn:</span>
                                                <span id="summary-count">0</span>
                                            </div>
                                            <div class="summary-row">
                                                <span>Tổng số lượng:</span>
                                                <span id="summary-quantity">0</span>
                                            </div>
                                            <div class="summary-row grand-total">
                                                <span>Tổng cộng:</span>
                                                <span id="grand-total">$0.00</span>
                                            </div>
                                            <button type="submit" class="checkout-btn" id="checkout-btn" disabled>
                                                Thanh toán đơn hàng
                                            </button>
                                        </div>
                                    </form>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- user-profile-section-end --------------->

        <!--------------- footer-section--------------->
        <!--------------- footer-section-end--------------->

        <jsp:include page="Common/Footer.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <script>
            $(document).ready(function () {
                // Function to parse price from text (remove "VND" and convert to number)
                function parsePriceFromText(priceText) {
                    return parseFloat(priceText.replace(/[^\d.]/g, '')) || 0;
                }

                // Function to format price with VND
                function formatPrice(price) {
                    return Math.round(price).toLocaleString('vi-VN') + ' VND';
                }

                // Update individual product total when quantity changes
                function updateProductTotal(row) {
                    const priceElement = row.find('.unit-price');
                    const price = parseFloat(priceElement.data('price')) || parsePriceFromText(priceElement.text());
                    const quantity = parseInt(row.find('.quantity-input').val()) || 1;
                    const total = price * quantity;
                    row.find('.total-price').text(formatPrice(total));
                    updateCartSummary();
                }

                // Update cart summary
                function updateCartSummary() {
                    let selectedCount = 0;
                    let totalQuantity = 0;
                    let grandTotal = 0;

                    $('.product-select:checked').each(function () {
                        const row = $(this).closest('.product-row');
                        const quantity = parseInt(row.find('.quantity-input').val()) || 1;
                        const priceElement = row.find('.unit-price');
                        const price = parseFloat(priceElement.data('price')) || parsePriceFromText(priceElement.text());

                        selectedCount++;
                        totalQuantity += quantity;
                        grandTotal += (price * quantity);
                    });

                    $('#selected-count').text(selectedCount);
                    $('#summary-count').text(selectedCount);
                    $('#summary-quantity').text(totalQuantity);
                    $('#grand-total').text(formatPrice(grandTotal));

                    // Enable/disable checkout button
                    $('#checkout-btn').prop('disabled', selectedCount === 0);
                }

                // Function to send wishlist update to backend
                function updateWishlist(cartId, isSelected) {
                    $.ajax({
                        url: 'addWhist',
                        type: 'POST',
                        data: {
                            cartId: cartId,
                            selected: isSelected
                        },
                        beforeSend: function () {
                            // Add loading state
                            $('body').addClass('loading');
                        },
                        success: function (response) {
                            console.log('Wishlist updated successfully');
                            // Handle success response if needed
                        },
                        error: function (xhr, status, error) {
                            console.error('Error updating wishlist:', error);
                            // Optionally show error message to user
                            alert('Có lỗi xảy ra khi cập nhật danh sách yêu thích. Vui lòng thử lại.');

                            // Revert checkbox state on error
                            const checkbox = $(`input[value="${cartId}"]`);
                            checkbox.prop('checked', !isSelected);
                            updateCartSummary();
                        },
                        complete: function () {
                            // Remove loading state
                            $('body').removeClass('loading');
                        }
                    });
                }

                // Quantity button handlers
                $('.plus-btn').click(function () {
                    const input = $(this).siblings('.quantity-input');
                    const currentVal = parseInt(input.val()) || 1;
                    const maxVal = parseInt(input.attr('max')) || 99;

                    if (currentVal < maxVal) {
                        input.val(currentVal + 1);
                        updateProductTotal($(this).closest('.product-row'));
                    }
                });

                $('.minus-btn').click(function () {
                    const input = $(this).siblings('.quantity-input');
                    const currentVal = parseInt(input.val()) || 1;
                    const minVal = parseInt(input.attr('min')) || 1;

                    if (currentVal > minVal) {
                        input.val(currentVal - 1);
                        updateProductTotal($(this).closest('.product-row'));
                    }
                });

                // Quantity input change handler
                $('.quantity-input').on('input change', function () {
                    const minVal = parseInt($(this).attr('min')) || 1;
                    const maxVal = parseInt($(this).attr('max')) || 99;
                    let currentVal = parseInt($(this).val()) || minVal;

                    if (isNaN(currentVal) || currentVal < minVal) {
                        $(this).val(minVal);
                    } else if (currentVal > maxVal) {
                        $(this).val(maxVal);
                    }

                    updateProductTotal($(this).closest('.product-row'));
                });

                // Product selection handler - with backend integration
                $('.product-select').change(function () {
                    const cartId = $(this).val();
                    const isSelected = $(this).is(':checked');

                    // Update UI immediately
                    updateCartSummary();

                    // Send request to backend
                    updateWishlist(cartId, isSelected);
                });

                // Select all handler
                $('#select-all').change(function () {
                    const isChecked = $(this).is(':checked');

                    $('.product-select').each(function () {
                        const wasChecked = $(this).is(':checked');
                        $(this).prop('checked', isChecked);

                        // Only send request if state actually changed
                        if (wasChecked !== isChecked) {
                            const cartId = $(this).val();
                            updateWishlist(cartId, isChecked);
                        }
                    });

                    updateCartSummary();
                });

                // Remove product handler
                $('.remove-btn').click(function () {
                    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                        const cartId = $(this).data('cart-id');
                        const row = $(this).closest('.product-row');

                        // Send request to remove from backend
                        $.ajax({
                            url: 'removeFromCart',
                            type: 'POST',
                            data: {
                                cartId: cartId
                            },
                            beforeSend: function () {
                                row.addClass('loading');
                            },
                            success: function (response) {
                                try {
                                    const data = typeof response === 'string' ? JSON.parse(response) : response;

                                    if (data.status === 'success') {
                                        row.remove(); // Xóa hàng chỉ khi thành công
                                        updateCartSummary(); // Cập nhật giỏ hàng
                                        toastr.success(data.message || 'Xóa sản phẩm thành công!', 'Thành công');
                                    } else {
                                        // Xử lý các trạng thái lỗi từ backend
                                        toastr.error(data.message || 'Không thể xóa sản phẩm. Vui lòng thử lại.', 'Lỗi');
                                    }
                                } catch (e) {
                                    console.error('Error parsing response:', e);
                                    toastr.error('Đã có lỗi xảy ra khi xử lý phản hồi từ server.', 'Lỗi');
                                }
                                row.removeClass('loading');
                            },
                            error: function (xhr, status, error) {
                                console.error('Error removing item:', error);
                                let errorMessage = 'Có lỗi xảy ra khi xóa sản phẩm. Vui lòng thử lại.';
                                try {
                                    const data = JSON.parse(xhr.responseText);
                                    errorMessage = data.message || errorMessage;
                                } catch (e) {
                                    console.error('Error parsing error response:', e);
                                }
                                toastr.error(errorMessage, 'Lỗi');
                                row.removeClass('loading');
                            }
                        });
                    }
                });

                // Form submission handler
                $('#cart-form').submit(function (e) {
                    const selectedProducts = $('.product-select:checked');
                    if (selectedProducts.length === 0) {
                        e.preventDefault();
                        alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
                        return false;
                    }

                    // Optionally add loading state during form submission
                    $(this).find('button[type="submit"]').prop('disabled', true).text('Đang xử lý...');
                });

                // Initialize totals on page load
                $('.product-row').each(function () {
                    updateProductTotal($(this));
                });
                updateCartSummary();
            });

            // Function for variant change (placeholder)
            function changeVariant() {
                // This function should handle variant changes
                console.log('Change variant functionality to be implemented');
            }
        </script>

    </body>
</html>