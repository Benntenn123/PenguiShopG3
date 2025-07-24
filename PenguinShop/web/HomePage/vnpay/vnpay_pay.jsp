<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="../Common/Css.jsp"/>
      
        <title>Tạo mới đơn hàng</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .payment-container {
                max-width: 700px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(174, 28, 154, 0.3);
                overflow: hidden;
                position: relative;
            }
            
            .payment-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(90deg, #AE1C9A, #e91e63, #AE1C9A);
            }
            
            .vnpay-header {
                background: linear-gradient(135deg, #AE1C9A, #d63384);
                color: white;
                padding: 30px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            
            .vnpay-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: shimmer 3s infinite;
            }
            
            @keyframes shimmer {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
            
            .vnpay-header h3 {
                margin: 0;
                font-size: 2.2em;
                font-weight: 700;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
                position: relative;
                z-index: 1;
            }
            
            .vnpay-header .subtitle {
                margin-top: 10px;
                font-size: 1.1em;
                opacity: 0.9;
                position: relative;
                z-index: 1;
            }
            
            .form-container {
                padding: 40px;
            }
            
            .section-title {
                color: #AE1C9A;
                font-size: 1.8em;
                font-weight: 600;
                margin-bottom: 30px;
                text-align: center;
                position: relative;
            }
            
            .section-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background: linear-gradient(90deg, #AE1C9A, #e91e63);
                border-radius: 2px;
            }
            
            .form-group {
                margin-bottom: 25px;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #2c3e50;
                font-weight: 600;
                font-size: 1.1em;
            }
            
            .form-control {
                width: 100%;
                padding: 15px;
                border: 2px solid #e0e0e0;
                border-radius: 12px;
                background-color: white;
                font-size: 1.1em;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            
            .form-control:focus {
                border-color: #AE1C9A;
                box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
                outline: none;
            }
            
            .payment-methods {
                background: linear-gradient(135deg, #f8f9fa, #ffffff);
                padding: 25px;
                border-radius: 15px;
                margin-bottom: 25px;
                border: 2px solid #AE1C9A;
                box-shadow: 0 5px 15px rgba(174, 28, 154, 0.1);
            }
            
            .payment-methods h4 {
                color: #AE1C9A;
                margin-bottom: 20px;
                font-weight: 700;
                font-size: 1.3em;
            }
            
            .payment-methods h5 {
                color: #6c757d;
                margin: 20px 0 15px 0;
                font-weight: 600;
                font-size: 1.1em;
            }
            
            .payment-option {
                margin-bottom: 15px;
                padding: 12px 15px;
                background: white;
                border-radius: 10px;
                border: 2px solid transparent;
                transition: all 0.3s ease;
                cursor: pointer;
                display: flex;
                align-items: center;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            
            .payment-option:hover {
                border-color: #AE1C9A;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(174, 28, 154, 0.2);
            }
            
            .payment-option input[type="radio"] {
                margin-right: 12px;
                transform: scale(1.2);
                accent-color: #AE1C9A;
            }
            
            .payment-option label {
                color: #2c3e50;
                font-weight: 500;
                cursor: pointer;
                margin: 0;
                flex: 1;
            }
            
            .payment-option .payment-icon {
                margin-left: 10px;
                color: #AE1C9A;
                font-size: 1.2em;
            }
            
            .language-section {
                background: linear-gradient(135deg, #f1f3f4, #ffffff);
                padding: 20px;
                border-radius: 15px;
                margin-bottom: 25px;
                border: 2px solid #e0e0e0;
            }
            
            .language-section h5 {
                color: #AE1C9A;
                margin-bottom: 15px;
                font-weight: 600;
                font-size: 1.2em;
            }
            
            .language-option {
                margin-bottom: 10px;
                padding: 10px 15px;
                background: white;
                border-radius: 8px;
                border: 2px solid transparent;
                transition: all 0.3s ease;
                cursor: pointer;
                display: flex;
                align-items: center;
            }
            
            .language-option:hover {
                border-color: #AE1C9A;
                background: #f8f9fa;
            }
            
            .language-option input[type="radio"] {
                margin-right: 10px;
                transform: scale(1.1);
                accent-color: #AE1C9A;
            }
            
            .language-option label {
                color: #2c3e50;
                font-weight: 500;
                cursor: pointer;
                margin: 0;
            }
            
            .submit-btn {
                width: 100%;
                padding: 18px;
                background: linear-gradient(135deg, #AE1C9A, #d63384);
                color: white;
                border: none;
                border-radius: 15px;
                font-weight: 700;
                font-size: 1.2em;
                transition: all 0.3s ease;
                box-shadow: 0 8px 20px rgba(174, 28, 154, 0.3);
                position: relative;
                overflow: hidden;
            }
            
            .submit-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                transition: left 0.5s;
            }
            
            .submit-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 25px rgba(174, 28, 154, 0.4);
            }
            
            .submit-btn:hover::before {
                left: 100%;
            }
            
            .submit-btn:active {
                transform: translateY(-1px);
            }
            
            .vnpay-footer {
                text-align: center;
                padding: 20px;
                color: #6c757d;
                background: #f8f9fa;
                margin-top: 20px;
            }
            
            .security-badge {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-top: 15px;
                color: #28a745;
                font-size: 0.9em;
            }
            
            .security-badge i {
                margin-right: 5px;
            }
            
            @media (max-width: 768px) {
                .payment-container {
                    margin: 10px;
                    border-radius: 15px;
                }
                
                .form-container {
                    padding: 25px;
                }
                
                .vnpay-header {
                    padding: 20px;
                }
                
                .vnpay-header h3 {
                    font-size: 1.8em;
                }
            }
        </style>
    </head>

    <body>
        <!--------------- header-section --------------->
        <jsp:include page="../Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <section class="payment-section" style="margin: 50px 0px 50px 0px">
            <div class="payment-container">
            <div class="vnpay-header">
                <h3><i class="fas fa-credit-card"></i> VNPAY</h3>
                <div class="subtitle">Cổng thanh toán trực tuyến an toàn</div>
            </div>
            
            <div class="form-container">
                <h3 class="section-title">Tạo mới đơn hàng</h3>
                
                <form action="vnpayajax" id="frmCreateOrder" method="post">   
                    <div class="form-group">
                        <label for="amount"><i class="fas fa-money-bill-wave"></i> Số tiền thanh toán</label>
                        <input class="form-control" 
                               data-val="true" 
                               data-val-number="The field Amount must be a number." 
                               data-val-required="The Amount field is required." 
                               id="amount" 
                               max="100000000" 
                               min="1" 
                               name="amount" 
                               type="number" 
                               value="${amount}"
                               placeholder="Nhập số tiền..." />
                    </div>
                    
                    <div class="payment-methods">
                        <h4><i class="fas fa-wallet"></i> Chọn phương thức thanh toán</h4>
                        
                        <h5>Cách 1: Chuyển hướng sang Cổng VNPAY</h5>
                        <div class="payment-option">
                            <input type="radio" Checked="True" id="bankCode1" name="bankCode" value="">
                            <label for="bankCode1">Cổng thanh toán VNPAYQR</label>
                            <i class="fas fa-qrcode payment-icon"></i>
                        </div>

                        <h5>Cách 2: Tách phương thức tại site</h5>
                        <div class="payment-option">
                            <input type="radio" id="bankCode2" name="bankCode" value="VNPAYQR">
                            <label for="bankCode2">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label>
                            <i class="fas fa-mobile-alt payment-icon"></i>
                        </div>
                        <div class="payment-option">
                            <input type="radio" id="bankCode3" name="bankCode" value="VNBANK">
                            <label for="bankCode3">Thanh toán qua thẻ ATM/Tài khoản nội địa</label>
                            <i class="fas fa-university payment-icon"></i>
                        </div>
                        <div class="payment-option">
                            <input type="radio" id="bankCode4" name="bankCode" value="INTCARD">
                            <label for="bankCode4">Thanh toán qua thẻ quốc tế</label>
                            <i class="fas fa-credit-card payment-icon"></i>
                        </div>
                    </div>
                    
                    <div class="language-section">
                        <h5><i class="fas fa-language"></i> Chọn ngôn ngữ giao diện thanh toán</h5>
                        <div class="language-option">
                            <input type="radio" id="language1" Checked="True" name="language" value="vn">
                            <label for="language1">🇻🇳 Tiếng Việt</label>
                        </div>
                        <div class="language-option">
                            <input type="radio" id="language2" name="language" value="en">
                            <label for="language2">🇺🇸 English</label>
                        </div>
                    </div>
                    
                    <input name="orderID" value="${orderID}" type="hidden"/>
                    <input name="type" value="${type}" type="hidden"/>
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-lock"></i> Thanh toán an toàn
                    </button>
                    
                    <div class="security-badge">
                        <i class="fas fa-shield-alt"></i>
                        Được bảo mật bởi SSL 256-bit
                    </div>
                </form>
            </div>
            
            <div class="vnpay-footer">
                <p><i class="fas fa-copyright"></i> VNPAY 2020 - Thanh toán trực tuyến an toàn</p>
            </div>
        </div>
                    <div style="margin-top:100px"></div>
        <!--------------- footer-section--------------->
        <jsp:include page="../Common/Footer.jsp"/>
        <jsp:include page="../Common/Js.jsp"/>

        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>       
    </body>
</html>