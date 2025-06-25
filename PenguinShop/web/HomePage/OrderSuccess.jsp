<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .success-container {
                min-height: 60vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 50px 0;
                background: linear-gradient(135deg, #faf8ff 0%, #f5f0ff 100%);
            }

            .success-card {
                background: white;
                border-radius: 20px;
                padding: 50px 40px;
                text-align: center;
                box-shadow: 0 20px 40px rgba(174, 28, 154, 0.15);
                border: 2px solid #AE1C9A;
                max-width: 600px;
                width: 100%;
                position: relative;
                overflow: hidden;
            }

            .success-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(90deg, #AE1C9A, #d63ab5, #AE1C9A);
                animation: shimmer 2s infinite;
            }

            @keyframes shimmer {
                0% { background-position: -200px 0; }
                100% { background-position: 200px 0; }
            }

            .success-icon {
                width: 100px;
                height: 100px;
                background: linear-gradient(135deg, #AE1C9A 0%, #d63ab5 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 30px;
                animation: bounce 0.8s ease-out;
                box-shadow: 0 10px 30px rgba(174, 28, 154, 0.3);
            }

            @keyframes bounce {
                0% { transform: scale(0); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }

            .success-icon svg {
                width: 50px;
                height: 50px;
                color: white;
            }

            .success-title {
                color: #AE1C9A;
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 20px;
                text-shadow: 0 2px 4px rgba(174, 28, 154, 0.1);
            }

            .success-message {
                color: #666;
                font-size: 1.2rem;
                margin-bottom: 30px;
                line-height: 1.6;
            }

            .order-details {
                background: rgba(174, 28, 154, 0.05);
                border-radius: 12px;
                padding: 25px;
                margin: 30px 0;
                border: 1px solid rgba(174, 28, 154, 0.2);
            }

            .order-details h4 {
                color: #AE1C9A;
                margin-bottom: 20px;
                font-size: 1.4rem;
                font-weight: bold;
            }

            .detail-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 12px;
                padding: 8px 0;
                border-bottom: 1px solid rgba(174, 28, 154, 0.1);
            }

            .detail-row:last-child {
                border-bottom: none;
                font-weight: bold;
                font-size: 1.1rem;
                color: #AE1C9A;
                border-top: 2px solid #AE1C9A;
                padding-top: 15px;
                margin-top: 15px;
            }

            .detail-row span:first-child {
                color: #666;
                font-weight: 500;
            }

            .detail-row span:last-child {
                color: #AE1C9A;
                font-weight: bold;
            }

            .action-buttons {
                display: flex;
                gap: 20px;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 40px;
            }

            .btn-primary, .btn-secondary {
                padding: 15px 30px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 10px;
                transition: all 0.3s ease;
                border: 2px solid #AE1C9A;
                min-width: 180px;
                justify-content: center;
            }

            .btn-primary {
                background: linear-gradient(135deg, #AE1C9A 0%, #d63ab5 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(174, 28, 154, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #8e1578 0%, #b5309a 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(174, 28, 154, 0.4);
                text-decoration: none;
                color: white;
            }

            .btn-secondary {
                background: white;
                color: #AE1C9A;
            }

            .btn-secondary:hover {
                background: #AE1C9A;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(174, 28, 154, 0.3);
                text-decoration: none;
            }

            .timeline {
                margin: 30px 0;
                position: relative;
            }

            .timeline-item {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                position: relative;
            }

            .timeline-icon {
                width: 40px;
                height: 40px;
                background: #AE1C9A;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 20px;
                z-index: 2;
            }

            .timeline-icon.pending {
                background: #ddd;
            }

            .timeline-icon svg {
                width: 20px;
                height: 20px;
                color: white;
            }

            .timeline-content {
                flex: 1;
            }

            .timeline-title {
                font-weight: bold;
                color: #AE1C9A;
                margin-bottom: 5px;
            }

            .timeline-desc {
                color: #666;
                font-size: 14px;
            }

            .timeline-line {
                position: absolute;
                left: 19px;
                top: 50px;
                bottom: -10px;
                width: 2px;
                background: #ddd;
                z-index: 1;
            }

            .timeline-item:last-child .timeline-line {
                display: none;
            }

            .confetti {
                position: absolute;
                width: 10px;
                height: 10px;
                background: #AE1C9A;
                animation: confetti-fall 3s linear infinite;
            }

            @keyframes confetti-fall {
                0% {
                    transform: translateY(-100vh) rotateZ(0deg);
                    opacity: 1;
                }
                100% {
                    transform: translateY(100vh) rotateZ(720deg);
                    opacity: 0;
                }
            }

            .order-number {
                background: linear-gradient(135deg, #AE1C9A 0%, #d63ab5 100%);
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: bold;
                display: inline-block;
                margin: 20px 0;
                font-size: 1.1rem;
                letter-spacing: 1px;
            }

            @media (max-width: 768px) {
                .success-card {
                    margin: 20px;
                    padding: 30px 20px;
                }

                .success-title {
                    font-size: 2rem;
                }

                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }

                .btn-primary, .btn-secondary {
                    width: 100%;
                    max-width: 300px;
                }
            }
        </style>
    </head>
    <body>
        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <section style="margin-bottom: 50px" class="success-container">
            <div style="display: flex; justify-content: center" class="container">
                <div class="success-card">
                    <!-- Confetti Animation -->
                    <div class="confetti" style="left: 10%; animation-delay: 0s;"></div>
                    <div class="confetti" style="left: 20%; animation-delay: 0.2s; background: #d63ab5;"></div>
                    <div class="confetti" style="left: 30%; animation-delay: 0.4s;"></div>
                    <div class="confetti" style="left: 40%; animation-delay: 0.6s; background: #ff6b9d;"></div>
                    <div class="confetti" style="left: 50%; animation-delay: 0.8s;"></div>
                    <div class="confetti" style="left: 60%; animation-delay: 1s; background: #d63ab5;"></div>
                    <div class="confetti" style="left: 70%; animation-delay: 1.2s;"></div>
                    <div class="confetti" style="left: 80%; animation-delay: 1.4s; background: #ff6b9d;"></div>
                    <div class="confetti" style="left: 90%; animation-delay: 1.6s;"></div>

                    <!-- Success Icon -->
                    <div class="success-icon">
                        <svg fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                        </svg>
                    </div>

                    <!-- Success Message -->
                    <h1 class="success-title">Đặt hàng thành công!</h1>
                    <p style="font-size: 16px" class="success-message">
                        Cảm ơn bạn đã tin tưởng và mua sắm tại cửa hàng của chúng tôi. 
                        Đơn hàng của bạn đã được xác nhận và đang được xử lý.
                    </p>

                    <!-- Order Details -->
                    <div class="order-details">
                        <h4 style="font-size: 16px;">Chi tiết đơn hàng</h4>
                        <div style="font-size: 16px;" class="detail-row">
                            <span >Số lượng sản phẩm:</span>
                            <span>${totalItems != null ? totalItems : '1'} sản phẩm</span>
                        </div>
                        <div style="font-size: 16px;" class="detail-row">
                            <span>Phương thức thanh toán:</span>
                            <span>${paymentMethod != null ? paymentMethod : 'Thanh toán khi nhận hàng'}</span>
                        </div>
                        <div style="font-size: 16px;" class="detail-row">
                            <span>Địa chỉ giao hàng:</span>
                            <span>${shippingAddress != null ? shippingAddress : user.address}</span>
                        </div>
                        <div style="font-size: 16px;" class="detail-row">
                            <span>Tổng tiền:</span>
                            <span>${totalAmount != null ? totalAmount : '0'} VND</span>
                        </div>
                    </div>

                   

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="orderhistory" class="btn-primary">
                            <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path>
                            </svg>
                            Xem đơn hàng
                        </a>
                        <a href="search" class="btn-secondary">
                            <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 2L3 7v11a1 1 0 001 1h3a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1h3a1 1 0 001-1V7l-7-5z" clip-rule="evenodd"></path>
                            </svg>
                            Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp"/>
        <jsp:include page="Common/Js.jsp"/>

        <script>
            $(document).ready(function() {
                // Auto redirect after 30 seconds (optional)
                // setTimeout(function() {
                //     window.location.href = 'shop';
                // }, 30000);

                // Add more confetti dynamically
                function createConfetti() {
                    const colors = ['#AE1C9A', '#d63ab5', '#ff6b9d', '#ffa8cc'];
                    for(let i = 0; i < 10; i++) {
                        setTimeout(() => {
                            const confetti = $('<div class="confetti"></div>');
                            confetti.css({
                                left: Math.random() * 100 + '%',
                                backgroundColor: colors[Math.floor(Math.random() * colors.length)],
                                animationDelay: Math.random() * 3 + 's'
                            });
                            $('.success-card').append(confetti);
                            
                            // Remove confetti after animation
                            setTimeout(() => {
                                confetti.remove();
                            }, 3000);
                        }, i * 200);
                    }
                }

                // Create confetti on page load
                createConfetti();

                // Create more confetti every 5 seconds
                setInterval(createConfetti, 5000);
            });
        </script>
    </body>
</html>