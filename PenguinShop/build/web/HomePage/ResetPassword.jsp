<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quên Mật Khẩu - Đặt Mật Khẩu Mới</title>
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
        .success-icon {
            text-align: center;
            margin-bottom: 20px;
        }
        .success-icon svg {
            width: 60px;
            height: 60px;
            color: #28a745;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        .password-input-container {
            position: relative;
        }
        .form-input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-input:focus {
            outline: none;
            border-color: #AE1C9A;
        }
        .form-input.valid {
            border-color: #28a745;
        }
        .form-input.invalid {
            border-color: #dc3545;
        }
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #666;
        }
        .password-toggle:hover {
            color: #333;
        }
        .password-requirements {
            margin-top: 10px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #AE1C9A;
        }
        .password-requirements h4 {
            margin: 0 0 10px 0;
            font-size: 14px;
            color: #333;
        }
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
            font-size: 13px;
            color: #666;
        }
        .requirement.valid {
            color: #28a745;
        }
        .requirement.invalid {
            color: #dc3545;
        }
        .requirement-icon {
            width: 16px;
            height: 16px;
            margin-right: 8px;
        }
        .password-strength {
            margin-top: 10px;
        }
        .strength-label {
            font-size: 13px;
            margin-bottom: 5px;
            color: #666;
        }
        .strength-bar {
            height: 4px;
            background-color: #e1e5e9;
            border-radius: 2px;
            overflow: hidden;
        }
        .strength-fill {
            height: 100%;
            transition: all 0.3s;
            border-radius: 2px;
        }
        .strength-weak .strength-fill {
            width: 25%;
            background-color: #dc3545;
        }
        .strength-fair .strength-fill {
            width: 50%;
            background-color: #ffc107;
        }
        .strength-good .strength-fill {
            width: 75%;
            background-color: #28a745;
        }
        .strength-strong .strength-fill {
            width: 100%;
            background-color: #AE1C9A;
        }
        .match-indicator {
            margin-top: 8px;
            font-size: 13px;
        }
        .match-indicator.valid {
            color: #28a745;
        }
        .match-indicator.invalid {
            color: #dc3545;
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
            margin-top: 10px;
        }
        .btn-primary:hover {
            background-color: #8a1579;
        }
        .btn-primary:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #AE1C9A;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="Common/Header.jsp"/>
    
    <div class="forgot-password-container">
        <div class="success-icon">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
        </div>
        
        <h2 class="form-title">Đặt Mật Khẩu Mới</h2>
        <p class="form-description">
            Xác thực thành công! Vui lòng tạo mật khẩu mới cho tài khoản của bạn.
        </p>
        
        <form action="ForgotPasswordServlet" method="POST" id="resetPasswordForm">
            <input type="hidden" name="step" value="4">
            <input type="hidden" name="email" value="${sessionScope.email}">
            <input type="hidden" name="resetToken" value="${sessionScope.resetToken}">
            
            <div class="form-group">
                <label class="form-label" for="newPassword">Mật khẩu mới *</label>
                <div class="password-input-container">
                    <input type="password" 
                           id="newPassword" 
                           name="newPassword" 
                           class="form-input" 
                           placeholder="Nhập mật khẩu mới"
                           required>
                    <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                        <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20" id="eyeIcon1">
                            <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                            <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                        </svg>
                    </button>
                </div>
                
                <div class="password-requirements">
                    <h4>Yêu cầu mật khẩu:</h4>
                    <div class="requirement" id="req-length">
                        <svg class="requirement-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                        </svg>
                        Ít nhất 8 ký tự
                    </div>
                    <div class="requirement" id="req-uppercase">
                        <svg class="requirement-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                        </svg>
                        Ít nhất 1 chữ hoa
                    </div>
                    <div class="requirement" id="req-lowercase">
                        <svg class="requirement-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                        </svg>
                        Ít nhất 1 chữ thường
                    </div>
                    <div class="requirement" id="req-number">
                        <svg class="requirement-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                        </svg>
                        Ít nhất 1 chữ số
                    </div>
                    <div class="requirement" id="req-special">
                        <svg class="requirement-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                        </svg>
                        Ít nhất 1 ký tự đặc biệt (!@#$%^&*)
                    </div>
                </div>
                
                <div class="password-strength" id="passwordStrength" style="display: none;">
                    <div class="strength-label">Độ mạnh mật khẩu: <span id="strengthText">Yếu</span></div>
                    <div class="strength-bar">
                        <div class="strength-fill"></div>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="confirmPassword">Xác nhận mật khẩu *</label>
                <div class="password-input-container">
                    <input type="password" 
                           id="confirmPassword" 
                           name="confirmPassword" 
                           class="form-input" 
                           placeholder="Nhập lại mật khẩu mới"
                           required>
                    <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                        <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20" id="eyeIcon2">
                            <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                            <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                        </svg>
                    </button>
                </div>
                <div class="match-indicator" id="matchIndicator" style="display: none;"></div>
            </div>
            
            <button type="submit" class="btn-primary" id="submitBtn" disabled>
                Đặt Mật Khẩu Mới
            </button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">← Quay về đăng nhập</a>
        </div>
    </div>
    
    <script>
        // Password visibility toggle
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const eyeIcon = inputId === 'newPassword' ? 'eyeIcon1' : 'eyeIcon2';
            const icon = document.getElementById(eyeIcon);
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.innerHTML = `
                    <path d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z"/>
                    <path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z"/>
                `;
            } else {
                input.type = 'password';
                icon.innerHTML = `
                    <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                    <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                `;
            }
        }
        
        // Password validation
        const passwordInput = document.getElementById('newPassword');
        const confirmInput = document.getElementById('confirmPassword');
        const submitBtn = document.getElementById('submitBtn');
        const strengthContainer = document.getElementById('passwordStrength');
        const strengthText = document.getElementById('strengthText');
        const matchIndicator = document.getElementById('matchIndicator');
        
        const requirements = {
            length: /^.{8,}$/,
            uppercase: /[A-Z]/,
            lowercase: /[a-z]/,
            number: /[0-9]/,
            special: /[!@#$%^&*]/
        };
        
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            validatePassword(password);
            checkPasswordMatch();
        });
        
        confirmInput.addEventListener('input', function() {
            checkPasswordMatch();
        });
        
        function validatePassword(password) {
            let validCount = 0;
            
            // Check each requirement
            Object.keys(requirements).forEach(req => {
                const element = document.getElementById(`req-${req}`);
                if (requirements[req].test(password)) {
                    element.classList.add('valid');
                    element.classList.remove('invalid');
                    validCount++;
                } else {
                    element.classList.add('invalid');
                    element.classList.remove('valid');
                }
            });
            
            // Update password strength
            updatePasswordStrength(password, validCount);
            
            // Update input styling
            if (validCount === 5) {
                passwordInput.classList.add('valid');
                passwordInput.classList.remove('invalid');
            } else if (password.length > 0) {
                passwordInput.classList.add('invalid');
                passwordInput.classList.remove('valid');
            } else {
                passwordInput.classList.remove('valid', 'invalid');
            }
            
            updateSubmitButton();
        }
        
        function updatePasswordStrength(password, validCount) {
            if (password.length === 0) {
                strengthContainer.style.display = 'none';
                return;
            }
            
            strengthContainer.style.display = 'block';
            const strengthBar = strengthContainer.querySelector('.strength-bar');
            
            // Remove all strength classes
            strengthBar.classList.remove('strength-weak', 'strength-fair', 'strength-good', 'strength-strong');
            
            if (validCount <= 2) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Yếu';
            } else if (validCount === 3) {
                strengthBar.classList.add('strength-fair');
                strengthText.textContent = 'Trung bình';
            } else if (validCount === 4) {
                strengthBar.classList.add('strength-good');
                strengthText.textContent = 'Tốt';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = 'Mạnh';
            }
        }
        
        function checkPasswordMatch() {
            const password = passwordInput.value;
            const confirmPassword = confirmInput.value;
            
            if (confirmPassword.length === 0) {
                matchIndicator.style.display = 'none';
                confirmInput.classList.remove('valid', 'invalid');
                return;
            }
            
            matchIndicator.style.display = 'block';
            
            if (password === confirmPassword) {
                matchIndicator.textContent = '✓ Mật khẩu khớp';
                matchIndicator.classList.add('valid');
                matchIndicator.classList.remove('invalid');
                confirmInput.classList.add('valid');
                confirmInput.classList.remove('invalid');
            } else {
                matchIndicator.textContent = '✗ Mật khẩu không khớp';
                matchIndicator.classList.add('invalid');
                matchIndicator.classList.remove('valid');
                confirmInput.classList.add('invalid');
                confirmInput.classList.remove('valid');
            }
            
            updateSubmitButton();
        }
        
        function updateSubmitButton() {
            const password = passwordInput.value;
            const confirmPassword = confirmInput.value;
            
            // Check if password meets all requirements
            const allRequirementsMet = Object.keys(requirements).every(req => 
                requirements[req].test(password)
            );
            
            // Check if passwords match
            const passwordsMatch = password === confirmPassword && password.length > 0;
            
            if (allRequirementsMet && passwordsMatch) {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        }
        
        // Form submission
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const password = passwordInput.value;
            const confirmPassword = confirmInput.value;
            
            // Final validation
            const allRequirementsMet = Object.keys(requirements).every(req => 
                requirements[req].test(password)
            );
            
            if (!allRequirementsMet) {
                alert('Mật khẩu không đáp ứng các yêu cầu bắt buộc.');
                return;
            }
            
            if (password !== confirmPassword) {
                alert('Mật khẩu xác nhận không khớp.');
                return;
            }
            
            // Submit form
            this.submit();
        });
    </script>
    
    <jsp:include page="Common/Footer.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
</body>
</html>