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
                        <form>
                            <div class=" account-inner-form">
                                <div class="review-form-name">
                                    <label for="fname" class="form-label">Tên</label>
                                    <input type="text" id="fname" class="form-control" placeholder="Nhập tên của bạn">
                                </div>
                                <div class="review-form-name">
                                    <label for="lname" class="form-label">Họ</label>
                                    <input type="text" id="lname" class="form-control" placeholder="Nhập họ của bạn">
                                </div>
                            </div>
                            <div class=" account-inner-form">
                                <div class="review-form-name">
                                    <label for="email" class="form-label">Địa chỉ Email*</label>
                                    <input type="email" id="email" class="form-control" placeholder="user@gmail.com">
                                    <span class="validation-message" id="email-message"></span>
                                </div>
                                <div class="review-form-name">
                                    <label for="phone" class="form-label">Số điện thoại*</label>
                                    <input type="tel" id="phone" class="form-control" placeholder="+84388**0899">
                                    <span class="validation-message" id="phone-message"></span>
                                </div>
                            </div>
                            <div class=" account-inner-form">
                                <div class="review-form-name">
                                    <label for="password" class="form-label">Mật Khẩu</label>
                                    <input type="password" id="password" class="form-control" placeholder="Nhập mật khẩu của bạn">
                                </div>
                                <div class="review-form-name">
                                    <label for="re-password" class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" id="re-password" class="form-control" placeholder="Xác nhận mật khẩu">
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
                            </div>

                            <div class="review-form-name checkbox">
                                <div class="checkbox-item">
                                    <input type="checkbox" id="terms">
                                    <p class="remember">
                                        Tôi đồng ý với các điều khoản của <span class="inner-text">PenguinShop.</span></p>
                                </div>
                            </div>
                            <div class="login-btn text-center">
                                <a href="#" class="shop-btn" id="create-account-btn">Tạo tài khoản</a>
                                <span class="shop-account">Đã có tài khoản ?<a href="login">Đăng nhập ngay</a></span>
                            </div>
                        </form>
                        <div class="login-social text-center">
                            <h5 style="font-size: 16px; margin-top: 1rem !important" class="comment-title">Tiếp tục với</h5>
                            <ul class="social-icon">
                                <li class="google">
                                    <a href="#">
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

        <!--------------- footer-section-end --------------->

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const passwordInput = document.getElementById('password');
                const emailInput = document.getElementById('email');
                const phoneInput = document.getElementById('phone');
                const lengthReq = document.getElementById('length-req');
                const uppercaseReq = document.getElementById('uppercase-req');
                const specialReq = document.getElementById('special-req');
                const emailMessage = document.getElementById('email-message');
                const phoneMessage = document.getElementById('phone-message');

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
                    input.classList.add(type);
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
                    $.ajax({
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
                                toastr.error("Error.");
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error");
                        }
                    });
                }

                function checkPhoneExists(phone) {
                    showLoadingMessage(phoneInput, phoneMessage, 'Đang kiểm tra số điện thoại...');
                    
                    $.ajax({
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
                                toastr.error("Error.");
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Error");
                        }
                    });
                }

                // Xử lý submit form
                document.getElementById('create-account-btn').addEventListener('click', function (e) {
                    e.preventDefault();

                    const password = document.getElementById('password').value;
                    const confirmPassword = document.getElementById('re-password').value;
                    const termsChecked = document.getElementById('terms').checked;

                    // Kiểm tra tất cả các yêu cầu mật khẩu
                    const isLengthValid = password.length >= 8;
                    const isUppercaseValid = /[A-Z]/.test(password);
                    const isSpecialValid = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);

                    if (!isLengthValid || !isUppercaseValid || !isSpecialValid) {
                        alert('Vui lòng đảm bảo mật khẩu đáp ứng tất cả các yêu cầu!');
                        return;
                    }

                    if (password !== confirmPassword) {
                        alert('Mật khẩu xác nhận không khớp!');
                        return;
                    }

                    // Kiểm tra email và phone validation
                    const emailHasError = emailInput.classList.contains('error');
                    const phoneHasError = phoneInput.classList.contains('error');
                    
                    if (emailHasError || phoneHasError) {
                        alert('Vui lòng kiểm tra lại email và số điện thoại!');
                        return;
                    }

                    if (!termsChecked) {
                        alert('Vui lòng đồng ý với các điều khoản!');
                        return;
                    }

                    // Nếu tất cả đều hợp lệ, có thể submit form
                    alert('Đăng ký thành công!');
                    // Thêm logic submit form ở đây
                });
            });
        </script>

        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp" />
        <!--------------- footer-section-end --------------->

        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />

    </body>
</html>