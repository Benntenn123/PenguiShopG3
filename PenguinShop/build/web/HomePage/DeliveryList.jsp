<%-- 
    Document   : DeliveryList
    Created on : May 28, 2025, 4:16:14 PM
    Author     : fptshop
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
    </head>
    <body>
        <jsp:include page="Common/Header.jsp" />
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">
                    <div class="user-dashboard">

                        <jsp:include page="Common/CommonUser.jsp" />
                        <div class="nav-content" id="v-pills-tabContent" style="flex: 1 0%;">
                        <div class="tab-pane" id="v-pills-address" role="tabpanel"
                            aria-labelledby="v-pills-address-tab" tabindex="0">
                            <div class="profile-section address-section addresses ">
                                <div class="row gy-md-0 g-5">
                                    <div class="col-md-6">
                                        <div class="seller-info">
                                            <h5 class="heading">Address-01</h5>
                                            <div class="info-list">
                                                <div class="info-title">
                                                    <p>Name:</p>
                                                    <p>Email:</p>
                                                    <p>Phone:</p>
                                                    <p>City:</p>
                                                    <p>Zip:</p>
                                                </div>
                                                <div class="info-details">
                                                    <p>Sajjad</p>
                                                    <p>demoemail@gmail.com</p>
                                                    <p>023 434 54354</p>
                                                    <p>Haydarabad, Rord 34</p>
                                                    <p>3454</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="seller-info">
                                            <h5 class="heading">Address-02</h5>
                                            <div class="info-list">
                                                <div class="info-title">
                                                    <p>Name:</p>
                                                    <p>Email:</p>
                                                    <p>Phone:</p>
                                                    <p>City:</p>
                                                    <p>Zip:</p>
                                                </div>
                                                <div class="info-details">
                                                    <p>Sajjad</p>
                                                    <p>demoemail@gmail.com</p>
                                                    <p>023 434 54354</p>
                                                    <p>Haydarabad, Rord 34</p>
                                                    <p>3454</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <a href="#" class="shop-btn" onclick="modalAction('.submit')">Thêm địa chỉ nhận mới</a>
                                        <!-- modal -->
                                        <div class="modal-wrapper submit">
                                            <div onclick="modalAction('.submit')" class="anywhere-away"></div>

                                            <!-- change this -->
                                            <div class="login-section account-section modal-main">
                                                <div class="review-form">
                                                    <div class="review-content">
                                                        <h5 style="margin-bottom: 30px" class="comment-title">Thêm thông tin người nhận mới</h5>
                                                        <div class="close-btn">
                                                            <img style="margin-bottom: 30px;width: 30px; height: auto" src="./HomePage/assets/images/homepage-one/close-btn.png"
                                                                onclick="modalAction('.submit')" alt="close-btn">
                                                        </div>
                                                    </div>
                                                    <div class=" account-inner-form">
                                                        <div class="review-form-name">
                                                            <label for="fullname" class="form-label">Tên người nhận</label>
                                                            <input type="text" id="fullname" name="fullname" class="form-control"
                                                                placeholder="Nhập họ tên của bạn">
                                                        </div>
                                                        <div class="review-form-name">
                                                            <label for="useremail" class="form-label">Địa chỉ Email*</label>
                                                            <input type="email" id="useremail" name="email" class="form-control"
                                                                placeholder="user@gmail.com">
                                                        </div>
                                                    </div>
                                                    <div class=" account-inner-form">
                                                        <div class="review-form-name">
                                                            <label for="userphone" class="form-label">Số điện thoại*</label>
                                                            <input type="tel" id="userphone" name="phone" class="form-control"
                                                                placeholder="0388**0899">
                                                        </div>
                                                        <div class="review-form-name">
                                                            <label for="usercity" class="form-label">Tỉnh*</label>
                                                            <select id="usercity" name="provinces" class="form-select">
                                                                <option>Lựa chọn...</option>
                                                                <c:forEach var="provinces" items="${provinces}">
                                                                <option>${provinces}</option>
                                                                
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class=" account-inner-form city-inner-form">
                                                        
                                                        <div class="review-form-name">
                                                            <label for="usercity" class="form-label">Phường/Huyện*</label>
                                                            <select id="usercity" name="phuong" class="form-select">
                                                                <option>Lựa chọn...</option>
                                                                
                                                                <option></option>
                                                                
                                                                
                                                            </select>
                                                        </div>
                                                         <div class="review-form-name">
                                                            <label for="usercity" class="form-label">Xã*</label>
                                                            <select id="usercity" name="xa" class="form-select">
                                                                <option>Lựa chọn...</option>
                                                                
                                                                <option></option>
                                                                
                                                                
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="review-form-name address-form">
                                                        <label for="useraddress" class="form-label">Địa chỉ bổ sung*</label>
                                                        <input type="text" id="useraddress" class="form-control"
                                                            placeholder="Bổ sung">
                                                    </div>
                                                    <div class="login-btn text-center">
                                                        <a href="#" onclick="modalAction('.submit')"
                                                            class="shop-btn">Add Address</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- change this -->

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>
