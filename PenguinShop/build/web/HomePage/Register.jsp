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
        <style>
            .social-icon {
                display: inline-flex;
                gap: 20px;
                padding: 0;
                list-style: none;
            }
            .social-icon li a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                text-decoration: none;
                font-size: 24px;
                transition: all 0.3s ease;
            }
            .social-icon li.google a {
                background-color: #db4437;
                color: #fff;
            }
            .social-icon li.google a:hover {
                background-color: #c1351d;
            }
            .social-icon li.comeback a {
                background-color: #28a745;
                color: #fff;
            }
            .social-icon li.comeback a:hover {
                background-color: #218838;
            }

            /* Password Requirements Styles */
            .password-requirements {
                margin-top: 10px;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid #e1e5e9;
            }

            .requirement {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
                font-size: 13px;
                transition: all 0.3s ease;
            }

            .requirement:last-child {
                margin-bottom: 0;
            }

            .requirement i {
                margin-right: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            .requirement.valid {
                color: #28a745;
            }

            .requirement.valid i {
                color: #28a745;
            }

            .requirement.invalid {
                color: #6c757d;
            }

            .requirement.invalid i {
                color: #6c757d;
            }

            /* Validation Message Styles */
            .validation-message {
                display: block;
                margin-top: 5px;
                font-size: 12px;
                min-height: 18px;
                transition: all 0.3s ease;
            }

            .validation-message.success {
                color: #28a745;
            }

            .validation-message.error {
                color: #dc3545;
            }

            .validation-message.checking {
                color: #007bff;
            }

            .form-control.error {
                border-color: #dc3545;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            }

            .form-control.success {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }

            .spinner {
                display: inline-block;
                width: 12px;
                height: 12px;
                border: 2px solid #f3f3f3;
                border-top: 2px solid #007bff;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
    </head>
    <body>

        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp"/>
        <!--------------- header-section-end --------------->

        <!--------------- login-section--------------->
        <section class="login account footer-padding">
            <div class="container">
                <div class="login-section account-section">
                    <div style="height: 98.1rem !important" class="review-form">
                        <h5 class="comment-title">Đăng Kí</h5>
                        <form method="post" action="register">
                            <input type="hidden" name="action" value="register"/>
                            <div class="account-inner-form">
                                <div class="review-form-name">
                                    <label for="fname" class="form-label">Tên</label>
                                    <input type="text" name="fname" id="fname" class="form-control" placeholder="Nhập tên của bạn">
                                    <span class="validation-message" id="fname-message"></span>
                                </div>
                                <div class="review-form-name">
                                    <label for="lname" class="form-label">Họ</label>
                                    <input type="text" name="lname" id="lname" class="form-control" placeholder="Nhập họ của bạn">
                                    <span class="validation-message" id="lname-message"></span>
                                </div>
                            </div>
                            <div class="account-inner-form">
                                <div class="review-form-name">
                                    <label for="email" class="form-label">Địa chỉ Email*</label>
                                    <input name="email" type="email" id="email" class="form-control" placeholder="user@gmail.com">
                                    <span class="validation-message" id="email-message"></span>
                                </div>
                                <div class="review-form-name">
                                    <label for="phone" class="form-label">Số điện thoại*</label>
                                    <input name="phone" type="tel" id="phone" class="form-control" placeholder="+84388**0899">
                                    <span class="validation-message" id="phone-message"></span>
                                </div>
                            </div>
                            <div class="account-inner-form">
                                <div class="review-form-name">
                                    <label for="password" name="password" class="form-label">Mật Khẩu</label>
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Nhập mật khẩu của bạn">
                                    <span class="validation-message" id="password-message"></span>
                                </div>
                                <div class="review-form-name">
                                    <label for="re-password" class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" name="re-password" id="re-password" class="form-control" placeholder="Xác nhận mật khẩu">
                                    <span class="validation-message" id="re-password-message"></span>
                                </div>
                            </div>
                            <div class="password-requirements">
                                <div class="requirement invalid" id="length-req">
                                    <i class='bx bx-x-circle'></i>
                                    <span>Tối thiểu 8 ký tự</span>
                                </div>
                                <div class="requirement invalid" id="uppercase-req">
                                    <i class='bx bx-x-circle'></i>
                                    <span>Ít nhất 1 chữ cái viết hoa</span>
                                </div>
                                <div class="requirement invalid" id="special-req">
                                    <i class='bx bx-x-circle'></i>
                                    <span>Ít nhất 1 ký tự đặc biệt (!@#$%^&*)</span>
                                </div>
                            </div>
                            <div>
                                <div style="margin: 20px 0px" class="g-recaptcha" data-sitekey="6LexoiArAAAAAAknmJMBGgZ0a1zuLa03LmsjDfov"></div>
                                <span class="validation-message" id="recaptcha-message"></span>
                            </div>

                            <div class="review-form-name checkbox">
                                <div class="checkbox-item">
                                    <input type="checkbox" id="terms">
                                    <p class="remember">
                                        Tôi đồng ý với các điều khoản của <span class="inner-text">PenguinShop.</span></p>
                                </div>
                                <span class="validation-message" id="terms-message"></span>
                            </div>
                            <div class="login-btn text-center">
                                <button type="submit" class="shop-btn" id="create-account-btn">Tạo tài khoản</button>
                            </div>
                        </form>
                        <span class="shop-account">Đã có tài khoản? <a href="login">Đăng nhập ngay</a></span>
                        <div class="login-social text-center">
                            <h5 style="font-size: 16px; margin-top: 1rem !important" class="comment-title">Tiếp tục với</h5>
                            <ul class="social-icon">
                                <li class="google">
                                    <a href="redirect_google">
                                        <i class='bx bxl-google'></i>
                                    </a>
                                </li>
                                <li class="comeback">
                                    <a href="trangchu">
                                        <i class='bx bx-home'></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- login-section-end --------------->

        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp" />
        <!--------------- footer-section-end --------------->

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.querySelector('form[action="register"]');
                const passwordInput = document.getElementById('password');
                const emailInput = document.getElementById('email');
                const phoneInput = document.getElementById('phone');
                const fnameInput = document.getElementById('fname');
                const lnameInput = document.getElementById('lname');
                const confirmPasswordInput = document.getElementById('re-password');
                const termsCheckbox = document.getElementById('terms');
                const lengthReq = document.getElementById('length-req');
                const uppercaseReq = document.getElementById('uppercase-req');
                const specialReq = document.getElementById('special-req');
                const emailMessage = document.getElementById('email-message');
                const phoneMessage = document.getElementById('phone-message');
                const fnameMessage = document.getElementById('fname-message');
                const lnameMessage = document.getElementById('lname-message');
                const passwordMessage = document.getElementById('password-message');
                const rePasswordMessage = document.getElementById('re-password-message');
                const termsMessage = document.getElementById('terms-message');
                const recaptchaMessage = document.getElementById('recaptcha-message');

                // Validation cho password
                passwordInput.addEventListener('input', function () {
                    const password = this.value;

                    // Kiểm tra độ dài tối thiểu 8 ký tự
                    if (password.length >= 8) {
                        updateRequirement(lengthReq, true);
                    } else {
                        updateRequirement(lengthReq, false);
                    }

                    // Kiểm tra có ít nhất 1 chữ cái viết hoa
                    if (/[A-Z]/.test(password)) {
                        updateRequirement(uppercaseReq, true);
                    } else {
                        updateRequirement(uppercaseReq, false);
                    }

                    // Kiểm tra có ít nhất 1 ký tự đặc biệt
                    if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) {
                        updateRequirement(specialReq, true);
                    } else {
                        updateRequirement(specialReq, false);
                    }

                    // Kiểm tra password rỗng
                    if (password.length === 0) {
                        resetValidation(passwordInput, passwordMessage);
                    } else {
                        showValidationMessage(passwordInput, passwordMessage, '', '');
                    }
                });

                // Validation cho email - sử dụng blur event
                emailInput.addEventListener('blur', function () {
                    const email = this.value.trim();
                    
                    if (email.length === 0) {
                        resetValidation(emailInput, emailMessage);
                        return;
                    }

                    // Kiểm tra định dạng email cơ bản
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email)) {
                        showValidationMessage(emailInput, emailMessage, 'Định dạng email không hợp lệ', 'error');
                        return;
                    }

                    // Gọi AJAX kiểm tra email
                    checkEmailExists(email);
                });

                // Validation cho phone - chỉ kiểm tra tồn tại với blur event
                phoneInput.addEventListener('blur', function () {
                    const phone = this.value.trim();
                    
                    if (phone.length === 0) {
                        resetValidation(phoneInput, phoneMessage);
                        return;
                    }

                    // Chỉ kiểm tra tồn tại, không cần kiểm tra định dạng
                    checkPhoneExists(phone);
                });

                // Validation cho fname
                fnameInput.addEventListener('blur', function () {
                    const fname = this.value.trim();
                    if (fname.length === 0) {
                        showValidationMessage(fnameInput, fnameMessage, 'Vui lòng nhập tên', 'error');
                    } else {
                        resetValidation(fnameInput, fnameMessage);
                    }
                });

                // Validation cho lname
                lnameInput.addEventListener('blur', function () {
                    const lname = this.value.trim();
                    if (lname.length === 0) {
                        showValidationMessage(lnameInput, lnameMessage, 'Vui lòng nhập họ', 'error');
                    } else {
                        resetValidation(lnameInput, lnameMessage);
                    }
                });

                // Validation cho confirm password
                confirmPasswordInput.addEventListener('blur', function () {
                    const confirmPassword = this.value;
                    const password = passwordInput.value;
                    if (confirmPassword.length === 0) {
                        showValidationMessage(confirmPasswordInput, rePasswordMessage, 'Vui lòng xác nhận mật khẩu', 'error');
                    } else if (confirmPassword !== password) {
                        showValidationMessage(confirmPasswordInput, rePasswordMessage, 'Mật khẩu xác nhận không khớp', 'error');
                    } else {
                        showValidationMessage(confirmPasswordInput, rePasswordMessage, 'Mật khẩu xác nhận hợp lệ', 'success');
                    }
                });

                function updateRequirement(element, isValid) {
                    const icon = element.querySelector('i');

                    if (isValid) {
                        element.classList.remove('invalid');
                        element.classList.add('valid');
                        icon.className = 'bx bx-check-circle';
                    } else {
                        element.classList.remove('valid');
                        element.classList.add('invalid');
                        icon.className = 'bx bx-x-circle';
                    }
                }

                function showValidationMessage(input, messageElement, message, type) {
                    messageElement.textContent = message;
                    messageElement.className = `validation-message ${type}`;
                    
                    input.classList.remove('error', 'success');
                    if (type) {
                        input.classList.add(type);
                    }
                }

                function showLoadingMessage(input, messageElement, message) {
                    messageElement.innerHTML = `<span class="spinner"></span> ${message}`;
                    messageElement.className = 'validation-message checking';
                    
                    input.classList.remove('error', 'success');
                }

                function resetValidation(input, messageElement) {
                    messageElement.textContent = '';
                    messageElement.className = 'validation-message';
                    input.classList.remove('error', 'success');
                }

                function checkEmailExists(email) {
                    showLoadingMessage(emailInput, emailMessage, 'Đang kiểm tra email...');
                    return $.ajax({
                        url: "register",
                        type: "POST",
                        data: {
                            action: "checkEmail",
                            email: email
                        },
                        success: function (response) {
                            if (response.status === "exist") {
                                showValidationMessage(emailInput, emailMessage, 'Địa chỉ email này đã được sử dụng', 'error');
                            } else if (response.status === "oke") {
                                showValidationMessage(emailInput, emailMessage, 'Địa chỉ email hợp lệ', 'success');
                            } else {
                                toastr.error("Lỗi kiểm tra email.");
                            }
                        },
                        error: function (xhr, status, error) {
                            toastr.error("Lỗi kết nối server khi kiểm tra email.");
                        }
                    });
                }

                function checkPhoneExists(phone) {
                    showLoadingMessage(phoneInput, phoneMessage, 'Đang kiểm tra số điện thoại...');
                    return $.ajax({
                        url: "register",
                        type: "POST",
                        data: {
                            action: "checkPhone",
                            phone_number: phone
                        },
                        success: function (response) {
                            if (response.status === "exist") {
                                showValidationMessage(phoneInput, phoneMessage, 'Số điện thoại này đã được sử dụng', 'error');
                            } else if (response.status === "oke") {
                                showValidationMessage(phoneInput, phoneMessage, 'Số điện thoại hợp lệ', 'success');
                            } else {
                                toastr.error("Lỗi kiểm tra số điện thoại.");
                            }
                        },
                        error: function (xhr, status, error) {
                            toastr.error("Lỗi kết nối server khi kiểm tra số điện thoại.");
                        }
                    });
                }

                // Xử lý submit form
                form.addEventListener('submit', async function (e) {
                    e.preventDefault(); // Ngăn submit mặc định

                    // Lấy giá trị các trường
                    const fname = fnameInput.value.trim();
                    const lname = lnameInput.value.trim();
                    const email = emailInput.value.trim();
                    const phone = phoneInput.value.trim();
                    const password = passwordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    const termsChecked = termsCheckbox.checked;

                    // Kiểm tra trường rỗng
                    if (!fname) {
                        showValidationMessage(fnameInput, fnameMessage, 'Vui lòng nhập tên', 'error');
                        fnameInput.focus();
                        return;
                    }
                    if (!lname) {
                        showValidationMessage(lnameInput, lnameMessage, 'Vui lòng nhập họ', 'error');
                        lnameInput.focus();
                        return;
                    }
                    if (!email) {
                        showValidationMessage(emailInput, emailMessage, 'Vui lòng nhập email', 'error');
                        emailInput.focus();
                        return;
                    }
                    if (!phone) {
                        showValidationMessage(phoneInput, phoneMessage, 'Vui lòng nhập số điện thoại', 'error');
                        phoneInput.focus();
                        return;
                    }
                    if (!password) {
                        showValidationMessage(passwordInput, passwordMessage, 'Vui lòng nhập mật khẩu', 'error');
                        passwordInput.focus();
                        return;
                    }
                    if (!confirmPassword) {
                        showValidationMessage(confirmPasswordInput, rePasswordMessage, 'Vui lòng xác nhận mật khẩu', 'error');
                        confirmPasswordInput.focus();
                        return;
                    }

                    // Kiểm tra mật khẩu
                    const isLengthValid = password.length >= 8;
                    const isUppercaseValid = /[A-Z]/.test(password);
                    const isSpecialValid = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);

                    if (!isLengthValid || !isUppercaseValid || !isSpecialValid) {
                        showValidationMessage(passwordInput, passwordMessage, 'Vui lòng đảm bảo mật khẩu đáp ứng tất cả các yêu cầu', 'error');
                        passwordInput.focus();
                        return;
                    }

                    if (password !== confirmPassword) {
                        showValidationMessage(confirmPasswordInput, rePasswordMessage, 'Mật khẩu xác nhận không khớp', 'error');
                        confirmPasswordInput.focus();
                        return;
                    }

                    // Kiểm tra email và phone bằng AJAX
                    const emailHasError = emailInput.classList.contains('error');
                    const phoneHasError = phoneInput.classList.contains('error');

                    if (!emailHasError && !emailInput.classList.contains('success')) {
                        await checkEmailExists(email); // Chờ AJAX hoàn tất
                    }
                    if (!phoneHasError && !phoneInput.classList.contains('success')) {
                        await checkPhoneExists(phone); // Chờ AJAX hoàn tất
                    }

                    // Kiểm tra lại sau AJAX
                    if (emailInput.classList.contains('error') || phoneInput.classList.contains('error')) {
                        showValidationMessage(emailInput, emailMessage, 'Vui lòng kiểm tra lại email và số điện thoại', 'error');
                        return;
                    }

                    // Kiểm tra checkbox điều khoản
                    if (!termsChecked) {
                        showValidationMessage(termsCheckbox, termsMessage, 'Vui lòng đồng ý với các điều khoản', 'error');
                        termsCheckbox.focus();
                        return;
                    }

                    // Kiểm tra reCAPTCHA
                    const recaptchaResponse = grecaptcha.getResponse();
                    if (!recaptchaResponse) {
                        showValidationMessage(null, recaptchaMessage, 'Vui lòng xác minh reCAPTCHA', 'error');
                        return;
                    }

                    // Nếu tất cả hợp lệ, submit form
                    form.submit();
                });
            });
        </script>

        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>