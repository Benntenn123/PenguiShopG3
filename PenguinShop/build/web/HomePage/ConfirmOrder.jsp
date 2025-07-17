<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xác nhận đơn hàng</title>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .forgot-password-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            background-color: white;
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            font-weight: 600;
        }
        .form-description {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .verification-info {
            background-color: #f8e7f5;
            border: 1px solid #e6b3d9;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
            text-align: center;
        }
        .verification-info .method {
            font-weight: 600;
            color: #8a1579;
        }
        .otp-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 25px;
        }
        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            outline: none;
            transition: border-color 0.3s;
        }
        .otp-input:focus {
            border-color: #AE1C9A;
        }
        .otp-input.filled {
            border-color: #28a745;
            background-color: #f8fff9;
        }
        .btn-primary {
            width: 100%;
            padding: 12px;
            background-color: #AE1C9A;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-bottom: 15px;
        }
        .btn-primary:hover {
            background-color: #8a1579;
        }
        .btn-primary:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .resend-section {
            text-align: center;
            margin-bottom: 20px;
        }
        .resend-text {
            color: #666;
            margin-bottom: 10px;
        }
        .resend-button {
            background: none;
            border: none;
            color: #AE1C9A;
            cursor: pointer;
            text-decoration: underline;
            font-size: 14px;
        }
        .resend-button:hover {
            color: #8a1579;
        }
        .resend-button:disabled {
            color: #ccc;
            cursor: not-allowed;
            text-decoration: none;
        }
        .countdown {
            color: #666;
            font-weight: 500;
        }
        .back-link {
            text-align: center;
        }
        .back-link a {
            color: #AE1C9A;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #dc3545;
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="Common/Header.jsp"/>
    
    <div class="forgot-password-container">
        <h2 class="form-title">Nhập Mã Xác Thực</h2>
        <p class="form-description">
            Chúng tôi đã gửi mã xác thực gồm 6 chữ số đến bạn.
        </p>
        
        <div class="verification-info">
            <div>Mã được gửi qua: <span class="method">${verificationMethod}</span></div>
            <div><strong>${sessionScope.deliveryInfo.email}</strong></div>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <form action="confirm-order" method="POST" id="otpForm">
            <input type="hidden" name="step" value="3">
            <input type="hidden" name="email" value="${sessionScope.deliveryInfo.email}">
            
            <div class="otp-container">
                <input type="text" class="otp-input" id="otp1" name="otp1" maxlength="1" pattern="[0-9]">
                <input type="text" class="otp-input" id="otp2" name="otp2" maxlength="1" pattern="[0-9]">
                <input type="text" class="otp-input" id="otp3" name="otp3" maxlength="1" pattern="[0-9]">
                <input type="text" class="otp-input" id="otp4" name="otp4" maxlength="1" pattern="[0-9]">
                <input type="text" class="otp-input" id="otp5" name="otp5" maxlength="1" pattern="[0-9]">
                <input type="text" class="otp-input" id="otp6" name="otp6" maxlength="1" pattern="[0-9]">
            </div>
            
            <input type="hidden" name="otp" id="fullOtp">
            
            <button type="submit" class="btn-primary" id="verifyBtn">
                Xác Thực
            </button>
        </form>
        
        <div class="resend-section">
            <div class="resend-text">Không nhận được mã?</div>
            <button class="resend-button" id="resendBtn" onclick="resendOTP()">
                Gửi lại mã
            </button>
            <div class="countdown" id="countdown" style="display: none;"></div>
        </div>
        
        <div class="back-link">
            <a href="forgot-password-step2.jsp">← Quay lại</a>
        </div>
    </div>
    
    <script>
        // OTP Input handling
        const otpInputs = document.querySelectorAll('.otp-input');
        const fullOtpInput = document.getElementById('fullOtp');
        
        otpInputs.forEach((input, index) => {
            input.addEventListener('input', function(e) {
                // Only allow numbers
                this.value = this.value.replace(/[^0-9]/g, '');
                
                // Update visual state
                if (this.value) {
                    this.classList.add('filled');
                } else {
                    this.classList.remove('filled');
                }
                
                // Move to next input
                if (this.value && index < otpInputs.length - 1) {
                    otpInputs[index + 1].focus();
                }
                
                // Update full OTP value
                updateFullOTP();
            });
            
            input.addEventListener('keydown', function(e) {
                // Handle backspace
                if (e.key === 'Backspace' && !this.value && index > 0) {
                    otpInputs[index - 1].focus();
                }
            });
            
            // Handle paste
            input.addEventListener('paste', function(e) {
                e.preventDefault();
                const pastedData = e.clipboardData.getData('text').replace(/[^0-9]/g, '');
                
                for (let i = 0; i < Math.min(pastedData.length, otpInputs.length - index); i++) {
                    otpInputs[index + i].value = pastedData[i];
                    otpInputs[index + i].classList.add('filled');
                }
                
                updateFullOTP();
                
                // Focus next empty input or last input
                const nextEmptyIndex = Array.from(otpInputs).findIndex((input, i) => i > index && !input.value);
                if (nextEmptyIndex !== -1) {
                    otpInputs[nextEmptyIndex].focus();
                } else {
                    otpInputs[otpInputs.length - 1].focus();
                }
            });
        });
        
        function updateFullOTP() {
            const otp = Array.from(otpInputs).map(input => input.value).join('');
            fullOtpInput.value = otp;
        }
        
        // Resend OTP functionality
        let countdownTimer;
        let countdownSeconds = 60;
        
        function resendOTP() {
            // Call resend API here
            fetch('ForgotPasswordServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'step=resend&email=${sessionScope.email}&verification_method=${sessionScope.verificationMethod}'
            });
            
            // Start countdown
            startCountdown();
        }
        
        function startCountdown() {
            const resendBtn = document.getElementById('resendBtn');
            const countdown = document.getElementById('countdown');
            
            resendBtn.style.display = 'none';
            countdown.style.display = 'block';
            countdownSeconds = 60;
            
            countdownTimer = setInterval(() => {
                countdown.textContent = `Gửi lại sau ${countdownSeconds}s`;
                countdownSeconds--;
                
                if (countdownSeconds < 0) {
                    clearInterval(countdownTimer);
                    resendBtn.style.display = 'inline';
                    countdown.style.display = 'none';
                }
            }, 1000);
        }
        
        // Auto-submit when all digits are entered
        document.getElementById('otpForm').addEventListener('input', function() {
            const otp = fullOtpInput.value;
            if (otp.length === 6) {
                // Optional: Auto-submit after a short delay
                // setTimeout(() => this.submit(), 500);
            }
        });
        
        // Focus first input on load
        document.addEventListener('DOMContentLoaded', function() {
            otpInputs[0].focus();
        });
    </script>
    
    <jsp:include page="Common/Footer.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
</body>
</html>