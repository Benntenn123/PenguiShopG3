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
        </style>
    </head>
    <body>
        
        <%
            String email = "";
            String password = "";
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    
                    if ("userEmail".equals(cookie.getName())) {
                        email = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    } else if ("userPassword".equals(cookie.getName())) {
                        password = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    }
                }
            }
            
        %>

        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp" />
        <!--------------- header-section-end --------------->

        <!--------------- login-section --------------->
        <section class="login footer-padding">
            <div class="container">
                <div class="login-section">
                    <div class="review-form">
                        <h5 class="comment-title">Đăng nhập</h5>
                        <form method="post" action="login">
                            <div class="review-form-name">
                                <label for="email" class="form-label">Địa chỉ email</label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    class="form-control"
                                    placeholder="Email"
                                    value="<%= email %>"
                                    required
                                    />
                            </div>
                            <div class="review-form-name">
                                <label for="password" class="form-label">Mật Khẩu</label>
                                <input
                                    type="password"
                                    id="password"
                                    name="password"
                                    class="form-control"
                                    placeholder="Password"
                                    value="<%= password %>"
                                    required
                                    />
                            </div>
                            <div class="review-form-name checkbox">
                                <div class="checkbox-item">
                                    <input type="checkbox" id="rememberMe" name="rememberMe" />
                                    <label for="rememberMe" class="address"> Nhớ tôi</label>
                                </div>
                                <div class="forget-pass">
                                    <a style="font-size: 16px" href="forgot-password.html">Bạn quên mật khẩu?</a>
                                </div>
                            </div>

                            <div class="login-btn text-center">
                                <button type="submit" class="shop-btn">Đăng Nhập</button>
                                <span class="shop-account">
                                    Bạn không có tài khoản ?
                                    <a href="create-account.html">Đăng kí ngay</a>
                                </span>
                            </div>
                        </form>
                        <div class="login-social text-center">
                            <h5 style="font-size: 16px" class="comment-title">Đăng nhập với</h5>
                            <ul class="social-icon">
                                <li class="google">
                                    <a href="#">
                                        <i class='bx bxl-google'></i>
                                    </a>
                                </li>
                                <li class="comeback">
                                    <a href="index.html">
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
        <!--------------- footer-section-end--------------->

        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>