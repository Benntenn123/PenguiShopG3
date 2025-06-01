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
                                                        <h5 class="table-heading">PRODUCT</h5>
                                                    </td>
                                                    <td class="table-wrapper wrapper-price">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="table-heading">PRICE</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-size">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="table-heading">SIZE</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-quantity">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="table-heading">QUANTITY</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-total">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="table-heading">TOTAL</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-action">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="table-heading">ACTION</h5>
                                                        </div>
                                                    </td>
                                                </tr>
                                                
                                                <!-- Product 1 -->
                                                <tr class="table-row ticket-row product-row" data-product-id="1" data-price="20.00">
                                                    <td class="table-wrapper wrapper-checkbox">
                                                        <div class="table-wrapper-center">
                                                            <input type="checkbox" name="selectedProducts" value="1" class="product-checkbox product-select">
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-product">
                                                        <div class="wrapper">
                                                            <div class="wrapper-img">
                                                                <img src="./assets/images/homepage-one/product-img/product-img-1.webp" alt="img">
                                                            </div>
                                                            <div class="wrapper-content">
                                                                <h5 class="heading">Classic Design Skirt</h5>
                                                                <p style="color: #888; font-size: 12px; margin: 5px 0;">Premium Cotton Blend</p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-price">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="heading unit-price">$20.00</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-size">
                                                        <div class="table-wrapper-center">
                                                            <select name="size_1" class="size-select">
                                                                <option value="XS">XS</option>
                                                                <option value="S" selected>S</option>
                                                                <option value="M">M</option>
                                                                <option value="L">L</option>
                                                                <option value="XL">XL</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-quantity">
                                                        <div class="table-wrapper-center">
                                                            <div class="quantity-controls">
                                                                <button type="button" class="quantity-btn minus-btn">-</button>
                                                                <input type="number" name="quantity_1" value="1" min="1" max="99" class="quantity-input">
                                                                <button type="button" class="quantity-btn plus-btn">+</button>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-total">
                                                        <div class="table-wrapper-center">
                                                            <h5 class="heading total-price">$20.00</h5>
                                                        </div>
                                                    </td>
                                                    <td class="table-wrapper wrapper-action">
                                                        <div class="table-wrapper-center">
                                                            <span class="remove-btn" style="cursor: pointer;">
                                                                <svg width="10" height="10" viewBox="0 0 10 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M9.7 0.3C9.3 -0.1 8.7 -0.1 8.3 0.3L5 3.6L1.7 0.3C1.3 -0.1 0.7 -0.1 0.3 0.3C-0.1 0.7 -0.1 1.3 0.3 1.7L3.6 5L0.3 8.3C-0.1 8.7 -0.1 9.3 0.3 9.7C0.7 10.1 1.3 10.1 1.7 9.7L5 6.4L8.3 9.7C8.7 10.1 9.3 10.1 9.7 9.7C10.1 9.3 10.1 8.7 9.7 8.3L6.4 5L9.7 1.7C10.1 1.3 10.1 0.7 9.7 0.3Z" fill="#AAAAAA"></path>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </td>
                                                </tr> 
                                              
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
            $(document).ready(function() {
                // Update individual product total when quantity changes
                function updateProductTotal(row) {
                    const price = parseFloat(row.data('price'));
                    const quantity = parseInt(row.find('.quantity-input').val());
                    const total = price * quantity;
                    row.find('.total-price').text('$' + total.toFixed(2));
                    updateCartSummary();
                }
                
                // Update cart summary
                function updateCartSummary() {
                    let selectedCount = 0;
                    let totalQuantity = 0;
                    let grandTotal = 0;
                    
                    $('.product-select:checked').each(function() {
                        const row = $(this).closest('.product-row');
                        const quantity = parseInt(row.find('.quantity-input').val());
                        const price = parseFloat(row.data('price'));
                        
                        selectedCount++;
                        totalQuantity += quantity;
                        grandTotal += (price * quantity);
                    });
                    
                    $('#selected-count').text(selectedCount);
                    $('#summary-count').text(selectedCount);
                    $('#summary-quantity').text(totalQuantity);
                    $('#grand-total').text('$' + grandTotal.toFixed(2));
                    
                    // Enable/disable checkout button
                    $('#checkout-btn').prop('disabled', selectedCount === 0);
                }
                
                // Quantity button handlers
                $('.plus-btn').click(function() {
                    const input = $(this).siblings('.quantity-input');
                    const currentVal = parseInt(input.val());
                    const maxVal = parseInt(input.attr('max'));
                    
                    if (currentVal < maxVal) {
                        input.val(currentVal + 1);
                        updateProductTotal($(this).closest('.product-row'));
                    }
                });
                
                $('.minus-btn').click(function() {
                    const input = $(this).siblings('.quantity-input');
                    const currentVal = parseInt(input.val());
                    const minVal = parseInt(input.attr('min'));
                    
                    if (currentVal > minVal) {
                        input.val(currentVal - 1);
                        updateProductTotal($(this).closest('.product-row'));
                    }
                });
                
                // Quantity input change handler
                $('.quantity-input').on('input change', function() {
                    const minVal = parseInt($(this).attr('min'));
                    const maxVal = parseInt($(this).attr('max'));
                    let currentVal = parseInt($(this).val());
                    
                    if (isNaN(currentVal) || currentVal < minVal) {
                        $(this).val(minVal);
                    } else if (currentVal > maxVal) {
                        $(this).val(maxVal);
                    }
                    
                    updateProductTotal($(this).closest('.product-row'));
                });
                
                // Product selection handler
                $('.product-select').change(function() {
                    updateCartSummary();
                });
                
                // Select all handler
                $('#select-all').change(function() {
                    const isChecked = $(this).is(':checked');
                    $('.product-select').prop('checked', isChecked);
                    updateCartSummary();
                });
                
                // Remove product handler
                $('.remove-btn').click(function() {
                    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                        $(this).closest('.product-row').remove();
                        updateCartSummary();
                    }
                });
                
                // Form submission handler
                $('#cart-form').submit(function(e) {
                    const selectedProducts = $('.product-select:checked');
                    if (selectedProducts.length === 0) {
                        e.preventDefault();
                        alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
                    }
                });
                
                // Initialize totals
                $('.product-row').each(function() {
                    updateProductTotal($(this));
                });
                updateCartSummary();
            });
        </script>

    </body>
</html>