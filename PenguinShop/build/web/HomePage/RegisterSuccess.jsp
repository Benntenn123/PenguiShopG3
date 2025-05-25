<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .thank-you-main {
                background: #F8F8F8;
                min-height: 70vh;
                font-family: 'Arial', sans-serif;
                position: relative;
                overflow: hidden;
                margin-top: 70px;
                margin-bottom: 50px;
            }

            .thank-you-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 70vh;
                padding: 20px;
                animation: fadeInUp 1s ease-out;
                position: relative;
                z-index: 2;
            }

            .success-icon {
                font-size: 100px;
                color: #28a745;
                margin-bottom: 30px;
                animation: bounceIn 1.2s ease-out;
                text-shadow: 0 0 20px rgba(40, 167, 69, 0.3);
            }

            .thank-you-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 50px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
                text-align: center;
                max-width: 600px;
                width: 100%;
                animation: slideInUp 0.8s ease-out 0.3s both;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .thank-you-title {
                font-size: 2.5rem;
                color: #333;
                margin-bottom: 20px;
                font-weight: bold;
                background: linear-gradient(45deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                animation: textGlow 2s ease-in-out infinite alternate;
            }

            .thank-you-message {
                font-size: 1.2rem;
                color: #666;
                margin-bottom: 30px;
                line-height: 1.6;
                animation: fadeIn 1s ease-out 0.6s both;
            }

            .email-verification {
                background: linear-gradient(135deg, #ff6b6b, #feca57);
                color: white;
                padding: 15px 25px;
                border-radius: 50px;
                margin: 20px 0;
                font-weight: bold;
                animation: pulse 2s infinite;
                box-shadow: 0 10px 30px rgba(255, 107, 107, 0.3);
            }

            .social-icon {
                display: inline-flex;
                gap: 20px;
                padding: 0;
                list-style: none;
                margin-top: 30px;
                animation: fadeInUp 1s ease-out 0.9s both;
            }

            .social-icon li a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                text-decoration: none;
                font-size: 24px;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                position: relative;
                overflow: hidden;
            }

            .social-icon li a::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .social-icon li a:hover::before {
                left: 100%;
            }

            .social-icon li.google a {
                background: linear-gradient(135deg, #ea4335, #db4437);
                color: #fff;
                box-shadow: 0 8px 25px rgba(219, 68, 55, 0.3);
            }

            .social-icon li.google a:hover {
                transform: translateY(-5px) scale(1.1);
                box-shadow: 0 15px 35px rgba(219, 68, 55, 0.4);
            }

            .social-icon li.comeback a {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: #fff;
                box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
            }

            .social-icon li.comeback a:hover {
                transform: translateY(-5px) scale(1.1);
                box-shadow: 0 15px 35px rgba(40, 167, 69, 0.4);
            }

            .thank-you-main .floating-particles {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
            }

            .thank-you-main .particle {
                position: absolute;
                background: rgba(102, 126, 234, 0.1);
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
            }

            .thank-you-main .particle:nth-child(1) {
                width: 10px;
                height: 10px;
                left: 10%;
                animation-delay: -0.5s;
            }

            .thank-you-main .particle:nth-child(2) {
                width: 20px;
                height: 20px;
                left: 20%;
                animation-delay: -1s;
            }

            .thank-you-main .particle:nth-child(3) {
                width: 15px;
                height: 15px;
                left: 30%;
                animation-delay: -1.5s;
            }

            .thank-you-main .particle:nth-child(4) {
                width: 12px;
                height: 12px;
                left: 40%;
                animation-delay: -2s;
            }

            .thank-you-main .particle:nth-child(5) {
                width: 18px;
                height: 18px;
                left: 50%;
                animation-delay: -2.5s;
            }

            .thank-you-main .particle:nth-child(6) {
                width: 8px;
                height: 8px;
                left: 60%;
                animation-delay: -3s;
            }

            .thank-you-main .particle:nth-child(7) {
                width: 22px;
                height: 22px;
                left: 70%;
                animation-delay: -3.5s;
            }

            .thank-you-main .particle:nth-child(8) {
                width: 14px;
                height: 14px;
                left: 80%;
                animation-delay: -4s;
            }

            .thank-you-main .particle:nth-child(9) {
                width: 16px;
                height: 16px;
                left: 90%;
                animation-delay: -4.5s;
            }

            .confetti {
                position: fixed;
                top: -10px;
                left: 50%;
                width: 10px;
                height: 10px;
                background: #ff6b6b;
                animation: confetti-fall 3s linear infinite;
                z-index: 1000;
            }

            .confetti:nth-child(odd) {
                background: #4ecdc4;
                animation-delay: -0.5s;
            }

            .confetti:nth-child(even) {
                background: #45b7d1;
                animation-delay: -1s;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes slideInUp {
                from {
                    opacity: 0;
                    transform: translateY(100px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes bounceIn {
                0% {
                    opacity: 0;
                    transform: scale(0.3);
                }
                50% {
                    opacity: 1;
                    transform: scale(1.05);
                }
                70% {
                    transform: scale(0.9);
                }
                100% {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            @keyframes textGlow {
                from {
                    text-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
                }
                to {
                    text-shadow: 0 0 20px rgba(102, 126, 234, 0.6);
                }
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            @keyframes confetti-fall {
                0% {
                    transform: translateY(-100vh) rotate(0deg);
                }
                100% {
                    transform: translateY(100vh) rotate(360deg);
                }
            }

            @media (max-width: 768px) {
                .thank-you-card {
                    padding: 30px 20px;
                    margin: 20px;
                }
                
                .thank-you-title {
                    font-size: 2rem;
                }
                
                .success-icon {
                    font-size: 80px;
                }
                
                .social-icon li a {
                    width: 50px;
                    height: 50px;
                    font-size: 20px;
                }
            }
        </style>
    </head>
    <body>
                
        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp" />
        <!--------------- header-section-end --------------->
        
        <!--------------- thank-you-section --------------->
        <div class="thank-you-main">
            <!-- Floating Particles Background -->
            <div class="floating-particles">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>

            <div class="thank-you-container">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            
            <div class="thank-you-card">
                <h1 class="thank-you-title">Chúc Mừng!</h1>
                <p class="thank-you-message">
                    Tài khoản của bạn đã được tạo thành công. 
                    Cảm ơn bạn đã tham gia cộng đồng của chúng tôi!
                </p>
                
                <div class="email-verification">
                    <i class="fas fa-envelope"></i>
                    Vui lòng kiểm tra email để xác thực tài khoản
                </div>
                
                <p class="thank-you-message">
                    Chúng tôi đã gửi một email xác thực đến địa chỉ email của bạn. 
                    Hãy click vào link trong email để hoàn tất quá trình đăng ký.
                </p>
                
                <ul class="social-icon">
                    <li class="google">
                        <a href="mailto:peguing6@gmail.com" title="Liên hệ hỗ trợ">
                            <i class="fas fa-envelope"></i>
                        </a>
                    </li>
                    <li class="comeback">
                        <a href="trangchu" title="Về trang chủ">
                            <i class="fas fa-home"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        </div>
        <!--------------- thank-you-section-end --------------->
        
        <!-- Confetti Animation -->
        <div class="confetti" style="left: 10%;"></div>
        <div class="confetti" style="left: 20%;"></div>
        <div class="confetti" style="left: 30%;"></div>
        <div class="confetti" style="left: 40%;"></div>
        <div class="confetti" style="left: 60%;"></div>
        <div class="confetti" style="left: 70%;"></div>
        <div class="confetti" style="left: 80%;"></div>
        <div class="confetti" style="left: 90%;"></div>
        
        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp" />
        <!--------------- footer-section-end--------------->
        
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
        
        <script>
            // Auto redirect after 10 seconds
            setTimeout(function() {
                if (confirm('Bạn có muốn về trang chủ không?')) {
                    window.location.href = 'trangchu';
                }
            }, 10000);

            // Create more confetti on click
            document.addEventListener('click', function(e) {
                createConfetti(e.clientX, e.clientY);
            });

            function createConfetti(x, y) {
                const colors = ['#ff6b6b', '#4ecdc4', '#45b7d1', '#96ceb4', '#feca57'];
                
                for (let i = 0; i < 6; i++) {
                    const confetti = document.createElement('div');
                    confetti.style.position = 'fixed';
                    confetti.style.left = x + 'px';
                    confetti.style.top = y + 'px';
                    confetti.style.width = '8px';
                    confetti.style.height = '8px';
                    confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.pointerEvents = 'none';
                    confetti.style.zIndex = '1000';
                    confetti.style.borderRadius = '50%';
                    
                    const angle = (Math.PI * 2 * i) / 6;
                    const velocity = 50 + Math.random() * 100;
                    
                    document.body.appendChild(confetti);
                    
                    confetti.animate([
                        {
                            transform: `translate(0, 0) scale(1)`,
                            opacity: 1
                        },
                        {
                            transform: `translate(${Math.cos(angle) * velocity}px, ${Math.sin(angle) * velocity}px) scale(0)`,
                            opacity: 0
                        }
                    ], {
                        duration: 1000,
                        easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
                    }).onfinish = () => confetti.remove();
                }
            }
        </script>
    </body>
</html>