<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<header id="header" class="header">
    <div class="header-top-section">
        <div class="container">
            <div class="header-top">
                <div class="header-profile">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <!-- User đã login - hiển thị QR scanner -->
                            <a href="#" onclick="openQRScanner()" style="cursor: pointer;">
                                <span style="font-weight: bold;">
                                    <i class="fas fa-qrcode" style="margin-right: 8px; color: #007bff;"></i>
                                    Quét mã QR để thêm sản phẩm vào giỏ hàng
                                </span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <!-- User chưa login - hiển thị promo -->
                            <a><span style="font-weight: bold;">Cần đồ thể thao - Đã có Penguin lo. Nhập mã <span style="color: red; font-weight: bold;">Sơn</span>  để đặt hàng</span></a>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>
    </div>
    <div class="header-center-section d-none d-lg-block">
        <div class="container">
            <div class="header-center">
                <div class="logo">
                    <a href="trangchu">
                        <img height="80px" src="./HomePage/assets/images/logos/logo.png" alt="logo">
                    </a>
                </div>
                <div class="header-cart-items">
                    <div class="header-search">
                        <button class="header-search-btn" onclick="modalAction('.search')">
                            <span>
                                <svg width="22" height="22" viewBox="0 0 22 22" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M13.9708 16.4151C12.5227 17.4021 10.9758 17.9723 9.27353 18.0062C5.58462 18.0802 2.75802 16.483 1.05056 13.1945C-1.76315 7.77253 1.33485 1.37571 7.25086 0.167548C12.2281 -0.848249 17.2053 2.87895 17.7198 7.98579C17.9182 9.95558 17.5566 11.7939 16.5852 13.5061C16.4512 13.742 16.483 13.8725 16.6651 14.0553C18.2412 15.6386 19.8112 17.2272 21.3735 18.8244C22.1826 19.6513 22.2058 20.7559 21.456 21.4932C20.7697 22.1678 19.7047 22.1747 18.9764 21.4793C18.3623 20.8917 17.7774 20.2737 17.1796 19.6688C16.118 18.5929 15.0564 17.5153 13.9708 16.4151ZM2.89545 9.0364C2.91692 12.4172 5.59664 15.1164 8.91967 15.1042C12.2384 15.092 14.9138 12.3493 14.8889 8.98505C14.864 5.63213 12.1826 2.92508 8.89047 2.92857C5.58204 2.93118 2.87397 5.68958 2.89545 9.0364Z"
                                        fill="black" />
                                </svg>
                            </span>
                        </button>
                        <div class="modal-wrapper search">
                            <div onclick="modalAction('.search')" class="anywhere-away"></div>

                            <!-- change this -->
                            <div class="modal-main">
                                <div class="wrapper-close-btn" onclick="modalAction('.search')">
                                    <span>
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                             stroke-width="1.5" stroke="red" class="w-6 h-6">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                  d="M6 18L18 6M6 6l12 12"></path>
                                        </svg>
                                    </span>
                                </div>

                                <div class="wrapper-main">
                                    <div class="search-section">
                                        <input id="searchInput" type="text" placeholder="Tìm kiếm sản phẩm.........">
                                            <div class="divider"></div>
                                            <button type="button">Tất cả danh mục</button>
                                            <a type="button" class="shop-btn" onclick="handleSearch()">Tìm kiếm</a>
                                    </div>
                                </div>


                            </div>

                            <!-- change this -->

                        </div>
                    </div>


                    <div class="header-cart">
                        <a href="listCart" class="cart-item">
                            <span>
                                <svg width="35" height="28" viewBox="0 0 35 28" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M16.4444 21.897C14.8444 21.897 13.2441 21.8999 11.6441 21.8963C9.79233 21.892 8.65086 21.0273 8.12595 19.2489C7.04294 15.5794 5.95756 11.9107 4.87166 8.24203C4.6362 7.4468 4.37783 7.25412 3.55241 7.25175C2.7786 7.24964 2.00507 7.25754 1.23127 7.24911C0.512247 7.24148 0.0157813 6.79109 0.000242059 6.15064C-0.0160873 5.48281 0.475637 5.01689 1.23232 5.00873C2.11121 4.99952 2.99089 4.99214 3.86951 5.01268C5.36154 5.04769 6.52014 5.93215 6.96393 7.35415C7.14171 7.92378 7.34055 8.49026 7.46382 9.07201C7.54968 9.47713 7.77881 9.49661 8.10566 9.49582C11.8335 9.48897 15.5611 9.49134 19.2889 9.49134C21.0825 9.49134 22.8761 9.48108 24.6694 9.49503C26.0848 9.50608 27.0907 10.4906 27.0156 11.7778C27.0006 12.0363 26.925 12.2958 26.8473 12.5457C26.1317 14.8411 25.4124 17.1351 24.6879 19.4279C24.1851 21.0186 23.0223 21.8826 21.3504 21.8944C19.7151 21.906 18.0797 21.897 16.4444 21.897Z"
                                        fill="#6E6D79" />
                                    <path
                                        d="M12.4012 27.5161C11.167 27.5227 10.1488 26.524 10.1345 25.2928C10.1201 24.0419 11.1528 22.9982 12.3967 23.0066C13.6209 23.0151 14.6422 24.0404 14.6436 25.2623C14.6451 26.4855 13.6261 27.5095 12.4012 27.5161Z"
                                        fill="#6E6D79" />
                                    <path
                                        d="M22.509 25.2393C22.5193 26.4842 21.5393 27.4971 20.3064 27.5155C19.048 27.5342 18.0272 26.525 18.0277 25.2622C18.0279 24.0208 19.0214 23.0161 20.2572 23.0074C21.4877 22.9984 22.4988 24.0006 22.509 25.2393Z"
                                        fill="#6E6D79" />
                                    <circle cx="26.9523" cy="8" r="8" fill="#AE1C9A" />
                                    
                                </svg>
                                
                            </span>
                            <p style="position: relative; top: -8px; left: -17px;color: white; font-weight: 400">${totalCart}</p>
                            <span class="cart-text">
                                Giỏ Hàng
                            </span>
                        </a>

                    </div>
                    <div class="header-user">
                        <c:if test="${not empty sessionScope.user}">
                            <a href="userprofile">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"
                                         class="fill-current">
                                        <path fill="none" d="M0 0h24v24H0z"></path>
                                        <path
                                            d="M20 22H4v-2a5 5 0 0 1 5-5h6a5 5 0 0 1 5 5v2zm-8-9a6 6 0 1 1 0-12 6 6 0 0 1 0 12z">
                                        </path>
                                    </svg>
                                </span>
                            </a>
                            <a href="userprofile" style="vertical-align: middle">${sessionScope.user.fullName}</a>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <a style="font-size: 16px; font-weight: normal" href="login">
                                Đăng nhập
                            </a>
                            <span><a style="font-weight: normal;font-size: 16px" href="register">/ Đăng kí</a></span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <nav class="mobile-menu d-block d-lg-none">
        <div class="mobile-menu-header d-flex justify-content-between align-items-center">
            <button class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions"
                    aria-controls="offcanvasWithBothOptions">
                <span>
                    <svg width="14" height="9" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect width="14" height="1" fill="#1D1D1D" />
                        <rect y="8" width="14" height="1" fill="#1D1D1D" />
                        <rect y="4" width="10" height="1" fill="#1D1D1D" />
                    </svg>
                </span>
            </button>
            <a href="trangchu" class="mobile-header-logo">
                <img src="./assets/images/logos/logo.png" alt="logo">
            </a>
            <a href="cart.html" class="header-cart cart-item">
                <span>
                    <svg width="35" height="28" viewBox="0 0 35 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M16.4444 21.897C14.8444 21.897 13.2441 21.8999 11.6441 21.8963C9.79233 21.892 8.65086 21.0273 8.12595 19.2489C7.04294 15.5794 5.95756 11.9107 4.87166 8.24203C4.6362 7.4468 4.37783 7.25412 3.55241 7.25175C2.7786 7.24964 2.00507 7.25754 1.23127 7.24911C0.512247 7.24148 0.0157813 6.79109 0.000242059 6.15064C-0.0160873 5.48281 0.475637 5.01689 1.23232 5.00873C2.11121 4.99952 2.99089 4.99214 3.86951 5.01268C5.36154 5.04769 6.52014 5.93215 6.96393 7.35415C7.14171 7.92378 7.34055 8.49026 7.46382 9.07201C7.54968 9.47713 7.77881 9.49661 8.10566 9.49582C11.8335 9.48897 15.5611 9.49134 19.2889 9.49134C21.0825 9.49134 22.8761 9.48108 24.6694 9.49503C26.0848 9.50608 27.0907 10.4906 27.0156 11.7778C27.0006 12.0363 26.925 12.2958 26.8473 12.5457C26.1317 14.8411 25.4124 17.1351 24.6879 19.4279C24.1851 21.0186 23.0223 21.8826 21.3504 21.8944C19.7151 21.906 18.0797 21.897 16.4444 21.897Z"
                            fill="#6E6D79" />
                        <path
                            d="M12.4012 27.5161C11.167 27.5227 10.1488 26.524 10.1345 25.2928C10.1201 24.0419 11.1528 22.9982 12.3967 23.0066C13.6209 23.0151 14.6422 24.0404 14.6436 25.2623C14.6451 26.4855 13.6261 27.5095 12.4012 27.5161Z"
                            fill="#6E6D79" />
                        <path
                            d="M22.509 25.2393C22.5193 26.4842 21.5393 27.4971 20.3064 27.5155C19.048 27.5342 18.0272 26.525 18.0277 25.2622C18.0279 24.0208 19.0214 23.0161 20.2572 23.0074C21.4877 22.9984 22.4988 24.0006 22.509 25.2393Z"
                            fill="#6E6D79" />
                        <circle cx="26.9523" cy="8" r="8" fill="#AE1C9A" />
                        <path
                            d="M23.7061 13V11.8864L27.1514 8.31676C27.5193 7.92898 27.8226 7.58925 28.0612 7.29759C28.3032 7.0026 28.4838 6.72254 28.6031 6.45739C28.7225 6.19223 28.7821 5.91051 28.7821 5.61222C28.7821 5.27415 28.7026 4.98248 28.5435 4.73722C28.3844 4.48864 28.1673 4.29806 27.8922 4.16548C27.6171 4.02959 27.3072 3.96165 26.9625 3.96165C26.5979 3.96165 26.2797 4.03622 26.008 4.18537C25.7362 4.33452 25.5274 4.54498 25.3815 4.81676C25.2357 5.08854 25.1628 5.40672 25.1628 5.77131H23.6962C23.6962 5.15151 23.8387 4.60961 24.1237 4.1456C24.4088 3.68158 24.7999 3.32197 25.297 3.06676C25.7942 2.80824 26.3593 2.67898 26.9923 2.67898C27.632 2.67898 28.1955 2.80658 28.6827 3.06179C29.1732 3.31368 29.556 3.65838 29.8311 4.09588C30.1062 4.53007 30.2438 5.0206 30.2438 5.56747C30.2438 5.94531 30.1725 6.31487 30.03 6.67614C29.8908 7.0374 29.6472 7.4401 29.2992 7.88423C28.9511 8.32505 28.4672 8.86032 27.8475 9.49006L25.824 11.608V11.6825H30.4078V13H23.7061Z"
                            fill="#F9FFFB" />
                    </svg>

                </span>
            </a>
        </div>

        <div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions">

            <div class="offcanvas-body">
                <div class="header-top">
                    <div class="header-cart ">
                        <div class="header-compaire">
                            <a href="compaire.html" class="cart-item">
                                <span>
                                    <svg width="34" height="27" viewBox="0 0 34 27" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M22 16.0094C21.997 22.0881 17.0653 27.007 10.9802 27C4.90444 26.9931 -0.00941233 22.0569 1.3538e-05 15.9688C0.00943941 9.89602 4.95157 4.98663 11.0422 5.00003C17.0961 5.01342 22.003 9.94315 22 16.0094ZM6.16553 15.7812C6.40365 12.6236 8.72192 11.2861 10.5868 11.1993C12.3305 11.1179 14.4529 12.3353 14.7465 13.6143C14.2425 13.6143 13.7459 13.6143 13.2429 13.6143C13.2429 14.0241 13.2429 14.3986 13.2429 14.7975C14.308 14.7975 15.3374 14.8064 16.3668 14.793C16.7805 14.7876 17.0102 14.5291 17.0147 14.1005C17.0221 13.3414 17.0172 12.5824 17.0172 11.8234C17.0172 11.558 17.0172 11.2925 17.0172 11.0311C16.5836 11.0311 16.2165 11.0311 15.7908 11.0311C15.7908 11.6046 15.7908 12.1572 15.7908 12.7937C13.9379 10.0444 10.8447 9.4545 8.48578 10.4824C6.21811 11.4706 4.90792 13.847 5.04682 15.7817C5.40997 15.7812 5.77609 15.7812 6.16553 15.7812ZM15.8191 16.2178C15.7581 17.4576 15.3498 18.547 14.4742 19.4286C13.5976 20.3111 12.5265 20.772 11.2858 20.8008C9.57472 20.8405 7.568 19.6424 7.2495 18.3892C7.75403 18.3892 8.25013 18.3892 8.76012 18.3892C8.76012 17.9809 8.76012 17.6064 8.76012 17.2041C7.68458 17.2041 6.64178 17.1921 5.59997 17.21C5.19962 17.2169 5.00069 17.4839 4.99771 17.9442C4.99176 18.803 4.99573 19.6612 4.99573 20.52C4.99573 20.6698 4.99573 20.8196 4.99573 20.964C5.4318 20.964 5.79692 20.964 6.20224 20.964C6.20224 20.3895 6.20224 19.8418 6.20224 19.1686C7.07984 20.4912 8.16976 21.3465 9.58216 21.7617C11.0184 22.1839 12.4114 22.0494 13.7548 21.4035C15.8191 20.4113 17.0946 18.1466 16.9507 16.2178C16.5861 16.2178 16.2209 16.2178 15.8191 16.2178Z"
                                            fill="#6E6D79" />
                                        <path
                                            d="M6.16568 15.7814C5.77624 15.7814 5.41062 15.7814 5.04648 15.7814C4.90757 13.8471 6.21777 11.4703 8.48543 10.482C10.8444 9.45411 13.9376 10.044 15.7905 12.7934C15.7905 12.1569 15.7905 11.6042 15.7905 11.0307C16.2161 11.0307 16.5833 11.0307 17.0168 11.0307C17.0168 11.2917 17.0168 11.5571 17.0168 11.823C17.0168 12.582 17.0218 13.341 17.0144 14.1001C17.0104 14.5287 16.7802 14.7877 16.3665 14.7926C15.3371 14.8055 14.3076 14.7971 13.2425 14.7971C13.2425 14.3982 13.2425 14.0237 13.2425 13.6139C13.7451 13.6139 14.2417 13.6139 14.7462 13.6139C14.4525 12.3355 12.3302 11.118 10.5864 11.1989C8.72207 11.2862 6.4038 12.6237 6.16568 15.7814Z"
                                            fill="white" />
                                        <path
                                            d="M15.8191 16.2178C16.2209 16.2178 16.5865 16.2178 16.9502 16.2178C17.094 18.1466 15.8186 20.4108 13.7543 21.4035C12.4109 22.0494 11.0178 22.1834 9.58161 21.7617C8.16971 21.3469 7.07978 20.4912 6.20169 19.1686C6.20169 19.8418 6.20169 20.3895 6.20169 20.9639C5.79687 20.9639 5.43125 20.9639 4.99518 20.9639C4.99518 20.8201 4.99518 20.6703 4.99518 20.5199C4.99518 19.6612 4.99121 18.8029 4.99716 17.9442C5.00014 17.4838 5.19907 17.2169 5.59943 17.21C6.64173 17.1916 7.68403 17.204 8.75957 17.204C8.75957 17.6064 8.75957 17.9809 8.75957 18.3892C8.25008 18.3892 7.75348 18.3892 7.24895 18.3892C7.56794 19.6428 9.57466 20.8404 11.2852 20.8007C12.526 20.772 13.597 20.3111 14.4736 19.4285C15.3492 18.547 15.758 17.457 15.8191 16.2178Z"
                                            fill="white" />
                                        <circle cx="25.9322" cy="8" r="8" fill="#AE1C9A" />
                                        <path
                                            d="M26.012 13.1392C25.3292 13.1392 24.7194 13.0215 24.1825 12.7862C23.6488 12.5509 23.2263 12.2244 22.9147 11.8068C22.6065 11.3859 22.4407 10.8987 22.4175 10.3452H23.9786C23.9985 10.6468 24.0996 10.9086 24.2819 11.1307C24.4675 11.3494 24.7094 11.5185 25.0077 11.6378C25.306 11.7571 25.6375 11.8168 26.0021 11.8168C26.4031 11.8168 26.7577 11.7472 27.066 11.608C27.3775 11.4687 27.6211 11.2749 27.7968 11.0263C27.9725 10.7744 28.0603 10.4844 28.0603 10.1562C28.0603 9.81487 27.9725 9.51491 27.7968 9.25639C27.6245 8.99455 27.3709 8.78906 27.0361 8.63991C26.7047 8.49077 26.3037 8.41619 25.833 8.41619H24.9729V7.16335H25.833C26.2109 7.16335 26.5423 7.09541 26.8273 6.95952C27.1157 6.82363 27.3411 6.63471 27.5035 6.39276C27.6659 6.14749 27.7471 5.8608 27.7471 5.53267C27.7471 5.2178 27.6758 4.94437 27.5333 4.71236C27.3941 4.47704 27.1952 4.29309 26.9367 4.16051C26.6815 4.02794 26.3799 3.96165 26.0319 3.96165C25.7004 3.96165 25.3906 4.02296 25.1022 4.1456C24.8172 4.26491 24.5852 4.43726 24.4062 4.66264C24.2272 4.88471 24.1311 5.15151 24.1178 5.46307H22.6313C22.6479 4.91288 22.8103 4.42898 23.1185 4.01136C23.4301 3.59375 23.8411 3.26728 24.3515 3.03196C24.8619 2.79664 25.4287 2.67898 26.0518 2.67898C26.7047 2.67898 27.2682 2.80658 27.7421 3.06179C28.2194 3.31368 28.5873 3.65009 28.8458 4.07102C29.1076 4.49195 29.2369 4.95265 29.2336 5.45312C29.2369 6.0232 29.0778 6.5071 28.7563 6.90483C28.4381 7.30256 28.0139 7.56937 27.4836 7.70526V7.7848C28.1597 7.88755 28.6834 8.15601 29.0546 8.5902C29.4291 9.02438 29.6147 9.56297 29.6114 10.206C29.6147 10.7661 29.459 11.2682 29.1441 11.7124C28.8326 12.1565 28.4067 12.5062 27.8664 12.7614C27.3262 13.0133 26.708 13.1392 26.012 13.1392Z"
                                            fill="#F9FFFB" />
                                    </svg>

                                </span>
                            </a>
                        </div>
                        <div class="header-favourite">
                            <a href="wishlist.html" class="cart-item">
                                <span>
                                    <svg width="35" height="27" viewBox="0 0 35 27" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M11.4047 8.54989C11.6187 8.30247 11.8069 8.07783 12.0027 7.86001C15.0697 4.45162 20.3879 5.51717 22.1581 9.60443C23.4189 12.5161 22.8485 15.213 20.9965 17.6962C19.6524 19.498 17.95 20.9437 16.2722 22.4108C15.0307 23.4964 13.774 24.5642 12.5246 25.6408C11.6986 26.3523 11.1108 26.3607 10.2924 25.6397C8.05177 23.6657 5.79225 21.7125 3.59029 19.6964C2.35865 18.5686 1.33266 17.2553 0.638823 15.7086C-0.626904 12.8872 0.0324709 9.41204 2.22306 7.41034C4.84011 5.01855 8.81757 5.36918 11.1059 8.19281C11.1968 8.30475 11.2907 8.41404 11.4047 8.54989Z"
                                            fill="#6E6D79" />
                                        <circle cx="26.7662" cy="8" r="8" fill="#AE1C9A" />
                                        <path
                                            d="M26.846 13.1392C26.1632 13.1392 25.5534 13.0215 25.0164 12.7862C24.4828 12.5509 24.0602 12.2244 23.7487 11.8068C23.4404 11.3859 23.2747 10.8987 23.2515 10.3452H24.8126C24.8325 10.6468 24.9336 10.9086 25.1159 11.1307C25.3015 11.3494 25.5434 11.5185 25.8417 11.6378C26.14 11.7571 26.4715 11.8168 26.836 11.8168C27.2371 11.8168 27.5917 11.7472 27.9 11.608C28.2115 11.4687 28.4551 11.2749 28.6308 11.0263C28.8065 10.7744 28.8943 10.4844 28.8943 10.1562C28.8943 9.81487 28.8065 9.51491 28.6308 9.25639C28.4584 8.99455 28.2049 8.78906 27.8701 8.63991C27.5387 8.49077 27.1377 8.41619 26.667 8.41619H25.8069V7.16335H26.667C27.0448 7.16335 27.3763 7.09541 27.6613 6.95952C27.9497 6.82363 28.1751 6.63471 28.3375 6.39276C28.4999 6.14749 28.5811 5.8608 28.5811 5.53267C28.5811 5.2178 28.5098 4.94437 28.3673 4.71236C28.2281 4.47704 28.0292 4.29309 27.7707 4.16051C27.5155 4.02794 27.2139 3.96165 26.8659 3.96165C26.5344 3.96165 26.2245 4.02296 25.9362 4.1456C25.6511 4.26491 25.4191 4.43726 25.2402 4.66264C25.0612 4.88471 24.9651 5.15151 24.9518 5.46307H23.4653C23.4819 4.91288 23.6443 4.42898 23.9525 4.01136C24.2641 3.59375 24.6751 3.26728 25.1855 3.03196C25.6959 2.79664 26.2627 2.67898 26.8858 2.67898C27.5387 2.67898 28.1021 2.80658 28.5761 3.06179C29.0534 3.31368 29.4213 3.65009 29.6798 4.07102C29.9416 4.49195 30.0709 4.95265 30.0676 5.45312C30.0709 6.0232 29.9118 6.5071 29.5903 6.90483C29.2721 7.30256 28.8479 7.56937 28.3176 7.70526V7.7848C28.9937 7.88755 29.5174 8.15601 29.8886 8.5902C30.2631 9.02438 30.4487 9.56297 30.4454 10.206C30.4487 10.7661 30.293 11.2682 29.9781 11.7124C29.6665 12.1565 29.2406 12.5062 28.7004 12.7614C28.1601 13.0133 27.542 13.1392 26.846 13.1392Z"
                                            fill="#F9FFFB" />
                                    </svg>
                                </span>
                            </a>
                        </div>
                    </div>
                    <div class="shop-btn">
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close">

                        </button>
                    </div>
                </div>
                <div class="header-input">
                    <input type="text" placeholder="Search....">
                        <span>
                            <svg width="22" height="22" viewBox="0 0 22 22" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M13.9708 16.4151C12.5227 17.4021 10.9758 17.9723 9.27353 18.0062C5.58462 18.0802 2.75802 16.483 1.05056 13.1945C-1.76315 7.77253 1.33485 1.37571 7.25086 0.167548C12.2281 -0.848249 17.2053 2.87895 17.7198 7.98579C17.9182 9.95558 17.5566 11.7939 16.5852 13.5061C16.4512 13.742 16.483 13.8725 16.6651 14.0553C18.2412 15.6386 19.8112 17.2272 21.3735 18.8244C22.1826 19.6513 22.2058 20.7559 21.456 21.4932C20.7697 22.1678 19.7047 22.1747 18.9764 21.4793C18.3623 20.8917 17.7774 20.2737 17.1796 19.6688C16.118 18.5929 15.0564 17.5153 13.9708 16.4151ZM2.89545 9.0364C2.91692 12.4172 5.59664 15.1164 8.91967 15.1042C12.2384 15.092 14.9138 12.3493 14.8889 8.98505C14.864 5.63213 12.1826 2.92508 8.89047 2.92857C5.58204 2.93118 2.87397 5.68958 2.89545 9.0364Z"
                                    fill="black"></path>
                            </svg>
                        </span>
                </div>

                <div class="category-dropdown">
                    <ul class="category-list">
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/dresses.webp"
                                                 alt="dress">
                                        </span>
                                        <span class="dropdown-text">
                                            Dresses
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/bags.webp"
                                                 alt="Bags">
                                        </span>
                                        <span class="dropdown-text">
                                            Bags
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/sweaters.webp"
                                                 alt="sweaters">
                                        </span>
                                        <span class="dropdown-text">
                                            Sweaters
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/shoes.webp"
                                                 alt="sweaters">
                                        </span>
                                        <span class="dropdown-text">
                                            Boots
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/gift.webp"
                                                 alt="gift">
                                        </span>
                                        <span class="dropdown-text">
                                            Gifts
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/sneakers.webp"
                                                 alt="sneakers">
                                        </span>
                                        <span class="dropdown-text">
                                            Sneakers
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/watch.webp"
                                                 alt="watch">
                                        </span>
                                        <span class="dropdown-text">
                                            Watches
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/ring.webp"
                                                 alt="ring">
                                        </span>
                                        <span class="dropdown-text">
                                            Gold Ring
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/cap.webp" alt="cap">
                                        </span>
                                        <span class="dropdown-text">
                                            Cap
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/glass.webp"
                                                 alt="glass">
                                        </span>
                                        <span class="dropdown-text">
                                            Sunglasses
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="category-list-item">
                            <a href="product-sidebar.html">
                                <div class="dropdown-item d-flex justify-content-between align-items-center">
                                    <div class="dropdown-list-item d-flex">
                                        <span class="dropdown-img">
                                            <img src="./HomePage/assets/images/homepage-one/category-img/baby.webp"
                                                 alt="baby">
                                        </span>
                                        <span class="dropdown-text">
                                            Baby Shop
                                        </span>
                                    </div>
                                    <div class="drop-down-list-icon">
                                        <span>
                                            <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                      transform="rotate(45 1.5 0.818359)" />
                                                <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                      transform="rotate(135 5.58984 4.90918)" />
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="header-bottom d-lg-block d-none">
        <div class="container">
            <div class="header-nav">
                <div class="category-menu-section position-relative">
                    <div class="empty position-fixed" onclick="tooglmenu()"></div>
                    <button class="dropdown-btn" onclick="tooglmenu()">
                        <span class="dropdown-icon">
                            <svg width="14" height="9" viewBox="0 0 14 9" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <rect width="14" height="1" />
                                <rect y="8" width="14" height="1" />
                                <rect y="4" width="10" height="1" />
                            </svg>
                        </span>
                        <span class="list-text">
                            Tất cả danh mục
                        </span>
                    </button>
                    <div class="category-dropdown position-absolute" id="subMenu">
                        <ul class="category-list">
                            <c:forEach var="cate" items="${cateMenu}">
                                <li class="category-list-item">
                                    <a href="search?cate=${cate.categoryId}">
                                        <div class="dropdown-item">
                                            <div class="dropdown-list-item">
                                                <span class="dropdown-img">
                                                    <img src="api/img/${cate.imageCategory}"
                                                         alt="dress">
                                                </span>
                                                <span class="dropdown-text">
                                                    ${cate.categoryName}
                                                </span>
                                            </div>
                                            <div class="drop-down-list-icon">
                                                <span>
                                                    <svg width="6" height="9" viewBox="0 0 6 9" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <rect x="1.5" y="0.818359" width="5.78538" height="1.28564"
                                                              transform="rotate(45 1.5 0.818359)" fill="#1D1D1D" />
                                                        <rect x="5.58984" y="4.90918" width="5.78538" height="1.28564"
                                                              transform="rotate(135 5.58984 4.90918)" fill="#1D1D1D" />
                                                    </svg>
                                                </span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="header-nav-menu">
                    <ul class="menu-list">
                        <li>
                            <a href="trangchu">
                                <span class="list-text">Trang Chủ</span>
                            </a>
                        </li>
                        <li>
                            <a href="blog">
                                <span class="list-text">Bài viết</span>
                            </a>
                        </li>
                        <li>
                            <a href="brands">
                                <span class="list-text">Thương hiệu</span>
                            </a>
                        </li>
                        <li class="mega-menu">
                            <a href="search">
                                <span class="list-text">Cửa hàng</span>
                                <span>
                                    <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <g clip-path="url(#clip0_1_183)">
                                            <path
                                                d="M2.37811 5.89491C1.88356 5.89491 1.38862 5.90351 0.894066 5.89218C0.443267 5.88202 0.108098 5.59451 0.0178597 5.17027C-0.0641747 4.7851 0.137786 4.36204 0.508895 4.20305C0.659291 4.13859 0.83586 4.11008 1.00071 4.10851C1.93786 4.09992 2.87539 4.10461 3.81254 4.10422C4.07075 4.10422 4.10357 4.07062 4.10396 3.80889C4.10474 2.85847 4.102 1.90843 4.10513 0.958001C4.10669 0.513061 4.336 0.177111 4.71218 0.0501527C5.30752 -0.151027 5.88567 0.278287 5.89387 0.937687C5.90168 1.56232 5.89582 2.18735 5.89582 2.81237C5.89582 3.14441 5.89504 3.47646 5.89621 3.80811C5.897 4.07023 5.92942 4.10422 6.18685 4.10422C7.13728 4.105 8.08732 4.10265 9.03774 4.10539C9.48503 4.10656 9.81941 4.33235 9.94872 4.70776C10.1534 5.30192 9.72605 5.88437 9.06782 5.89413C8.50803 5.90233 7.94825 5.89608 7.38846 5.89608C6.97829 5.89608 6.56851 5.89491 6.15833 5.89687C5.93918 5.89804 5.897 5.94023 5.8966 6.1625C5.89543 7.11918 5.89778 8.07625 5.89543 9.03293C5.89426 9.48216 5.67238 9.81577 5.29736 9.94741C4.70437 10.1552 4.11841 9.72983 4.10669 9.07316C4.09771 8.57861 4.10474 8.08367 4.10474 7.58912C4.10474 7.12035 4.10552 6.65197 4.10435 6.1832C4.10396 5.93398 4.06841 5.89726 3.82387 5.89687C3.34221 5.89569 2.86055 5.89647 2.37889 5.89647C2.37811 5.8953 2.37811 5.8953 2.37811 5.89491Z"
                                                fill="white" />
                                        </g>
                                        <defs>
                                            <clipPath id="clip0_1_185">
                                                <rect width="10" height="10" fill="white" />
                                            </clipPath>
                                        </defs>
                                    </svg>
                                </span>
                            </a>
                            <div class="shop-menu">
                                <div class="menu-wrapper">
                                    <div class="menu-list">
                                        <h5 class="menu-title">Nhãn hàng</h5>
                                        <ul>
                                            <c:forEach var="brand" items="${brandMenu}">
                                                <li><a href="search?brand=${brand.brandID}">${brand.brandName}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </div>
                                    <div class="menu-list">
                                        <h5 class="menu-title">Danh mục sản phẩm</h5>
                                        <ul class="menu-auto-grid">
                                            <c:forEach var="cate" begin="1" end="6" items="${cate}">
                                                <li> 
                                                    <a href="search?cate=${cate.categoryId}">
                                                        ${cate.categoryName}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
<!--                                    <div class="menu-list">
                                        <h5 class="menu-title">Cosmetics</h5>
                                        <ul>
                                            <li><a href="product-sidebar.html">Liptics</a></li>
                                            <li><a href="product-sidebar.html">Foundation</a></li>
                                            <li><a href="product-sidebar.html"> Eye Liner</a></li>
                                        </ul>
                                    </div>-->
                                </div>
                                <div class="shop-menu-img">
                                    <img src="api/img/c6eb61ea-20200428_appvinid_bannerweb_coolmate_qaddlb.jpg" alt="img">
                                </div>
                            </div>
                        </li>
<!--                        <li>
                            <a href="#">
                                <span class="list-text">Pages</span>
                                <span>
                                    <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <g clip-path="url(#clip0_1_183)">
                                            <path
                                                d="M2.37811 5.89491C1.88356 5.89491 1.38862 5.90351 0.894066 5.89218C0.443267 5.88202 0.108098 5.59451 0.0178597 5.17027C-0.0641747 4.7851 0.137786 4.36204 0.508895 4.20305C0.659291 4.13859 0.83586 4.11008 1.00071 4.10851C1.93786 4.09992 2.87539 4.10461 3.81254 4.10422C4.07075 4.10422 4.10357 4.07062 4.10396 3.80889C4.10474 2.85847 4.102 1.90843 4.10513 0.958001C4.10669 0.513061 4.336 0.177111 4.71218 0.0501527C5.30752 -0.151027 5.88567 0.278287 5.89387 0.937687C5.90168 1.56232 5.89582 2.18735 5.89582 2.81237C5.89582 3.14441 5.89504 3.47646 5.89621 3.80811C5.897 4.07023 5.92942 4.10422 6.18685 4.10422C7.13728 4.105 8.08732 4.10265 9.03774 4.10539C9.48503 4.10656 9.81941 4.33235 9.94872 4.70776C10.1534 5.30192 9.72605 5.88437 9.06782 5.89413C8.50803 5.90233 7.94825 5.89608 7.38846 5.89608C6.97829 5.89608 6.56851 5.89491 6.15833 5.89687C5.93918 5.89804 5.897 5.94023 5.8966 6.1625C5.89543 7.11918 5.89778 8.07625 5.89543 9.03293C5.89426 9.48216 5.67238 9.81577 5.29736 9.94741C4.70437 10.1552 4.11841 9.72983 4.10669 9.07316C4.09771 8.57861 4.10474 8.08367 4.10474 7.58912C4.10474 7.12035 4.10552 6.65197 4.10435 6.1832C4.10396 5.93398 4.06841 5.89726 3.82387 5.89687C3.34221 5.89569 2.86055 5.89647 2.37889 5.89647C2.37811 5.8953 2.37811 5.8953 2.37811 5.89491Z"
                                                fill="white" />
                                        </g>
                                        <defs>
                                            <clipPath id="clip0_1_18">
                                                <rect width="10" height="10" fill="white" />
                                            </clipPath>
                                        </defs>
                                    </svg>
                                </span>
                            </a>
                            <ul class="header-sub-menu">
                                <li><a href="product-info.html">Product-details</a></li>
                                <li><a href="privacy.html">Privacy Policy</a></li>
                                <li><a href="terms.html">Terms & Condition</a></li>
                                <li><a href="faq.html">FAQ</a></li>
                                <li><a href="product-sidebar.html">Shop Category Icon</a></li>
                                <li><a href="product-sidebar.html">Shop List View</a></li>
                            </ul>
                        </li>-->
                        <li>
                            <a href="about.html">
                                <span class="list-text">Về chúng tôi</span>
                            </a>
                        </li>
<!--                        <li>
                            <a href="blogs.html">
                                <span class="list-text">Blog</span>
                            </a>
                            <ul class="header-sub-menu">
                                <li><a href="blogs-details.html">Blog-details</a></li>
                            </ul>
                        </li>-->
                        <li>
                            <a href="userprofile">
                                <span class="list-text">Người dùng</span>
                            </a>
                        </li>
                        <li>
                            <a href="contact-us.html">
                                <span class="list-text">Liên hệ</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="header-vendor-btn">
                    <a href="search" class="shop-btn">
                        <span class="list-text shop-text">Bắt đầu ngay</span>
                        <span class="icon">
                            <svg width="24" height="16" viewBox="0 0 24 16" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M20.257 7.07205C20.038 7.07205 19.8474 7.07205 19.6563 7.07205C17.4825 7.07205 15.3086 7.07205 13.1352 7.07205C10.1545 7.07205 7.17336 7.0725 4.19265 7.0725C3.30392 7.0725 2.41519 7.07024 1.52646 7.07295C1.12124 7.07431 0.809811 7.25265 0.625785 7.62651C0.43866 8.00623 0.488204 8.37556 0.737704 8.70426C0.932347 8.96027 1.20529 9.08173 1.52867 9.08037C2.20948 9.07766 2.8903 9.07902 3.57111 9.07902C5.95285 9.07902 8.33415 9.07902 10.7159 9.07902C13.782 9.07902 16.8485 9.07902 19.9146 9.07902C20.0274 9.07902 20.1398 9.07902 20.2822 9.07902C20.1871 9.18332 20.1141 9.26865 20.0358 9.34857C19.5656 9.82672 19.0922 10.3022 18.6229 10.7812C18.1363 11.2779 17.6541 11.7791 17.1675 12.2757C16.4942 12.9634 15.8116 13.6415 15.1476 14.3391C14.9096 14.5893 14.8455 14.9157 14.9406 15.2575C15.156 16.0305 16.0567 16.2499 16.6119 15.6769C17.4342 14.8286 18.2655 13.9892 19.0927 13.1458C19.6948 12.5317 20.2968 11.9172 20.8985 11.3023C21.5952 10.5902 22.2911 9.87729 22.9878 9.1648C23.1059 9.04425 23.2249 8.9246 23.3435 8.8045C23.6903 8.45367 23.7239 7.84278 23.3943 7.4766C22.998 7.03683 22.5852 6.61241 22.1756 6.18573C21.7965 5.79066 21.4134 5.39965 21.0303 5.00909C20.6733 4.64473 20.3132 4.28306 19.9553 3.91915C19.6147 3.57284 19.2754 3.22563 18.9356 2.87887C18.5154 2.44948 18.0951 2.01964 17.6744 1.5907C17.2511 1.15861 16.8198 0.734188 16.4057 0.29261C16.0363 -0.101559 15.3697 -0.0816927 15.0344 0.257392C14.6238 0.672782 14.5999 1.26381 14.995 1.68552C15.3378 2.0517 15.6957 2.40342 16.0465 2.76192C16.929 3.66449 17.8111 4.56797 18.6937 5.47054C19.1829 5.97081 19.6735 6.47018 20.1632 6.97046C20.1885 6.99574 20.2123 7.02329 20.257 7.07205Z" />
                            </svg>
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- QR Scanner Modal -->
<div class="modal fade" id="qrScannerModal" tabindex="-1" aria-labelledby="qrScannerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="qrScannerModalLabel" style="font-size: 18px;">
                    <i class="fas fa-qrcode text-primary me-2"></i>
                    Quét mã QR sản phẩm
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <div class="qr-scanner-container">
                    <!-- Camera Preview -->
                    <div id="cameraContainer" style="display: none; position: relative; margin: 0 auto;">
                        <div id="qrVideo" style="width: 100%; max-width: 500px; height: 375px; border-radius: 10px; border: 2px solid #007bff; overflow: hidden; position: relative; background: #222; margin: 0 auto;">
                            <!-- Video will be inserted here by Html5Qrcode -->
                            <div id="loadingText" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); color: white; font-size: 14px; text-align: center; z-index: 20;">Đang khởi động camera...</div>
                        </div>
                        <div id="scanningLine" style="position: absolute; top: 50%; left: 0; right: 0; height: 2px; background: #007bff; animation: scanning 2s ease-in-out infinite; z-index: 15;"></div>
                        <!-- QR Box Overlay - Larger and more centered -->
                        <div id="qrBoxOverlay" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 300px; height: 300px; border: 4px solid #00ff00; border-radius: 15px; background: transparent; z-index: 10; box-shadow: 0 0 0 9999px rgba(0,0,0,0.4);"></div>
                        <div style="position: absolute; top: 15px; left: 50%; transform: translateX(-50%); color: white; background: rgba(0,0,0,0.8); padding: 8px 16px; border-radius: 20px; font-size: 14px; z-index: 15; font-weight: 500;">
                            📱 Đưa mã QR vào khung xanh để quét
                        </div>
                        <!-- QR Detection Status -->
                        <div id="qrStatus" style="position: absolute; bottom: 15px; left: 50%; transform: translateX(-50%); color: white; background: rgba(0,0,0,0.8); padding: 6px 12px; border-radius: 15px; font-size: 14px; z-index: 15; display: none;">
                            🔍 Đang tìm kiếm QR code...
                        </div>
                    </div>
                    
                    <!-- Upload Image -->
                    <div id="uploadContainer">
                        <div class="upload-area" style="border: 3px dashed #007bff; border-radius: 15px; padding: 40px; margin: 20px 0; background: #f8f9fa;">
                            <i class="fas fa-upload fa-3x text-primary mb-3"></i>
                            <h5 style="font-size: 18px;">Tải lên ảnh QR Code</h5>
                            <p class="text-muted" style="font-size: 16px;">Chọn ảnh chứa mã QR từ thiết bị của bạn</p>
                            <input type="file" id="qrImageInput" accept="image/*" style="display: none;">
                            <button type="button" class="btn btn-primary" onclick="document.getElementById('qrImageInput').click();" style="font-size: 16px;">
                                <i class="fas fa-image me-2"></i>Chọn ảnh
                            </button>
                        </div>
                    </div>
                    
                    <!-- Scanner Controls -->
                    <div class="scanner-controls mt-3">
                        <button type="button" id="startCameraBtn" class="btn btn-primary me-2" onclick="startAIScanner()" style="font-size: 16px; background: linear-gradient(45deg, #e91e63, #ad1457); border-color: #e91e63;">
                            <i class="fas fa-qrcode me-2"></i>Quét Ngay
                        </button>
                        <button type="button" id="smartScanBtn" class="btn btn-secondary me-2" onclick="startSmartScan()" style="display: none; font-size: 16px;">
                            <i class="fas fa-magic me-2"></i>Quét Thông Minh
                        </button>
                        <button type="button" id="stopCameraBtn" class="btn btn-danger" onclick="stopCamera()" style="display: none; font-size: 16px;">
                            <i class="fas fa-stop me-2"></i>Tắt Camera
                        </button>
                    </div>
                    
                    <!-- Quick Scan Tips -->
                    <div id="scanTips" class="mt-3" style="display: none;">
                        <div class="alert alert-info">
                            <h6 style="font-size: 16px;"><i class="fas fa-lightbulb me-2"></i>Mẹo quét nhanh:</h6>
                            <ul class="mb-0" style="text-align: left; font-size: 14px;">
                                <li>📱 Giữ điện thoại cách QR code 15-30cm</li>
                                <li>☀️ Tránh ánh sáng chói hoặc quá tối</li>
                                <li>🎯 Đưa QR code vào giữa khung xanh</li>
                                <li>⏰ Giữ ổn định 2-3 giây</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Result Display -->
                    <div id="scanResult" style="display: none;" class="mt-4 p-3 bg-light rounded">
                        <h6 style="font-size: 18px;">Kết quả quét:</h6>
                        <pre id="qrResult" class="text-start" style="font-size: 14px;"></pre>
                        <button type="button" class="btn btn-primary" onclick="addQRToCart()" style="font-size: 16px;">
                            <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Product Confirmation Modal -->
<div class="modal fade" id="productConfirmModal" tabindex="-1" aria-labelledby="productConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg shadow-lg">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-gradient-primary text-white p-4 border-0">
                <h5 class="modal-title fw-bold" id="productConfirmModalLabel" style="font-size: 18px;">
                    <i class="fas fa-check-circle me-2"></i>
                    Xác nhận thông tin sản phẩm
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-4">
                    <div class="col-md-5">
                        <div class="product-image-container position-relative">
                            <img id="productConfirmImage" src="" alt="Product" class="img-fluid rounded-3 shadow-sm" style="width: 100%; height: 200px; object-fit: cover;">
                            <div class="position-absolute top-0 end-0 m-2">
                                <span class="badge bg-pink px-3 py-2 rounded-pill text-white">
                                    <i class="fas fa-robot me-1"></i>AI Detected
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="product-details h-100 d-flex flex-column">
                            <h4 id="productConfirmName" class="fw-bold text-dark mb-3" style="font-size: 18px; line-height: 1.3;">Tên sản phẩm</h4>
                            
                            <div class="mb-3">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="fas fa-tags text-pink me-2"></i>
                                    <span class="text-muted" style="font-size: 14px;">Phân loại:</span>
                                </div>
                                <p id="productConfirmVariant" class="fw-semibold text-pink ms-4" style="font-size: 16px;">
                                    <span></span>
                                </p>
                            </div>
                            
                            <div class="mb-3">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="fas fa-dollar-sign text-pink me-2"></i>
                                    <span class="text-muted" style="font-size: 14px;">Giá bán:</span>
                                </div>
                                <p id="productConfirmPrice" class="text-pink fw-bold fs-4 ms-4" style="font-size: 20px;">
                                    <span></span>
                                </p>
                            </div>
                            
                            <div class="alert alert-info d-flex align-items-center border-0" style="background: linear-gradient(45deg, #fce4ec, #f8bbd9); font-size: 14px; padding: 1rem; border-radius: 12px;">
                                <i class="fas fa-info-circle text-pink me-2"></i>
                                <div>
                                    <strong>Số lượng:</strong> 1 sản phẩm<br>
                                    <small class="text-muted">QR Scanner tự động thêm 1 sản phẩm vào giỏ hàng</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer bg-light p-4 border-0">
                <div class="d-flex w-100 gap-3">
                    <button type="button" class="btn btn-outline-secondary flex-fill py-3 rounded-3" data-bs-dismiss="modal" style="font-size: 16px;">
                        <i class="fas fa-times me-2"></i>Hủy bỏ
                    </button>
                    <button type="button" class="btn btn-primary flex-fill py-3 rounded-3 fw-bold" onclick="confirmAddToCart()" style="font-size: 16px; background: linear-gradient(45deg, #e91e63, #ad1457);">
                        <i class="fas fa-cart-plus me-2"></i>Xác nhận thêm vào giỏ
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
@keyframes scanning {
    0% { transform: translateY(-50px); opacity: 0; }
    50% { opacity: 1; }
    100% { transform: translateY(50px); opacity: 0; }
}

@keyframes pulse {
    0% { transform: translate(-50%, -50%) scale(1); }
    50% { transform: translate(-50%, -50%) scale(1.05); }
    100% { transform: translate(-50%, -50%) scale(1); }
}

.upload-area {
    transition: all 0.3s ease;
}

.upload-area:hover {
    background-color: #e3f2fd !important;
    border-color: #1976d2 !important;
}

/* Enhanced QR Box Animation */
#qrBoxOverlay {
    transition: all 0.3s ease-in-out;
}

/* Smart Scan Button Gradient */
#smartScanBtn {
    background: linear-gradient(45deg, #6c757d, #495057);
    border: none;
    transition: all 0.3s ease;
    font-size: 16px;
}

#smartScanBtn:hover {
    background: linear-gradient(45deg, #495057, #6c757d);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108,117,125,0.3);
}

/* Primary Scanner Button */
#startCameraBtn {
    background: linear-gradient(45deg, #e91e63, #ad1457);
    border: none;
    transition: all 0.3s ease;
    font-weight: 500;
}

#startCameraBtn:hover {
    background: linear-gradient(45deg, #ad1457, #880e4f);
    transform: translateY(-1px);
    box-shadow: 0 3px 10px rgba(233,30,99,0.4);
}

/* Stop Button */
#stopCameraBtn {
    background: linear-gradient(45deg, #dc3545, #c82333);
    border: none;
    transition: all 0.3s ease;
}

#stopCameraBtn:hover {
    background: linear-gradient(45deg, #c82333, #bd2130);
    transform: translateY(-1px);
    box-shadow: 0 3px 10px rgba(220,53,69,0.4);
}

/* Product Confirmation Modal Enhancements */
.bg-gradient-primary {
    background: linear-gradient(135deg, #e91e63 0%, #ad1457 100%) !important;
}

.text-pink {
    color: #e91e63 !important;
}

.bg-pink {
    background-color: #e91e63 !important;
}

#productConfirmModal .modal-content {
    border-radius: 20px !important;
    overflow: hidden;
    border: none;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

#productConfirmModal .modal-header {
    padding: 1.5rem 2rem;
    border-bottom: none;
}

#productConfirmModal .modal-body {
    padding: 2rem;
}

#productConfirmModal .modal-footer {
    padding: 1.5rem 2rem 2rem 2rem;
    background: linear-gradient(to bottom, #f8f9fa, #e9ecef);
    border-top: none;
}

.product-image-container img {
    transition: transform 0.3s ease;
    border: 3px solid #f8f9fa;
}

.product-image-container:hover img {
    transform: scale(1.02);
}

.product-details .alert {
    border: none;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

#productConfirmModal .btn {
    transition: all 0.3s ease;
    font-weight: 500;
}

#productConfirmModal .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

#productConfirmModal .btn-primary {
    background: linear-gradient(45deg, #e91e63, #ad1457) !important;
    border: none;
}

#productConfirmModal .btn-primary:hover {
    background: linear-gradient(45deg, #ad1457, #880e4f) !important;
}

/* Enhanced Badge */
#productConfirmModal .badge {
    font-size: 11px;
    letter-spacing: 0.5px;
    box-shadow: 0 2px 8px rgba(233, 30, 99, 0.3);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    #productConfirmModal .modal-body {
        padding: 1.5rem;
    }
    
    #productConfirmModal .modal-footer {
        padding: 1rem 1.5rem 1.5rem 1.5rem;
    }
    
    #productConfirmModal .modal-footer .d-flex {
        flex-direction: column;
    }
    
    #productConfirmModal .modal-footer .btn {
        margin-bottom: 0.5rem;
        width: 100% !important;
    }
}
</style>

<!-- QR Code Scanner JavaScript -->
<script src="https://unpkg.com/html5-qrcode@2.3.8/html5-qrcode.min.js"></script>
<script>
let html5QrCode;
let qrScanResult = null;
let isScanning = false;
let scanAttempts = 0;
let lastGuidanceUpdate = 0;

// AI Scanner variables
let aiScannerActive = false;
let aiScannerInterval;
let aiVideoStream;
let aiCanvas;
let aiContext;
let productConfirmData = null;

// Scanning guidance messages
const scanGuidanceMessages = [
    '🔍 Đang quét QR code...',
    '📱 Đưa QR code gần camera hơn',
    '☀️ Kiểm tra ánh sáng xung quanh',
    '🎯 Căn chỉnh QR code vào giữa khung',
    '📏 Thử xa ra hoặc gần vào',
    '🔄 Giữ điện thoại thẳng và ổn định',
    '✨ Đảm bảo QR code rõ nét, không bị mờ'
];

// AI Scanner Functions
function startAIScanner() {
    if (aiScannerActive) return;
    
    console.log('🤖 Starting AI Scanner...');
    document.getElementById('scanTips').style.display = 'block';
    
    const cameraContainer = document.getElementById('cameraContainer');
    const startBtn = document.getElementById('startCameraBtn');
    const stopBtn = document.getElementById('stopCameraBtn');
    
    // Create canvas for screenshot capture
    if (!aiCanvas) {
        aiCanvas = document.createElement('canvas');
        aiContext = aiCanvas.getContext('2d');
    }
    
    // Get user media
    navigator.mediaDevices.getUserMedia({
        video: {
            facingMode: "environment",
            width: { ideal: 640 },
            height: { ideal: 480 }
        }
    }).then(stream => {
        aiVideoStream = stream;
        
        // Create video element
        const videoElement = document.createElement('video');
        videoElement.srcObject = stream;
        videoElement.autoplay = true;
        videoElement.playsInline = true;
        videoElement.style.width = '100%';
        videoElement.style.height = '100%';
        videoElement.style.objectFit = 'cover';
        
        // Clear existing content and add video
        const qrVideo = document.getElementById('qrVideo');
        qrVideo.innerHTML = '';
        qrVideo.appendChild(videoElement);
        
        // Show camera UI
        aiScannerActive = true;
        startBtn.style.display = 'none';
        stopBtn.style.display = 'inline-block';
        cameraContainer.style.display = 'block';
        
        // Update status
        const qrStatus = document.getElementById('qrStatus');
        if (qrStatus) {
            qrStatus.textContent = '🤖 AI Scanner đang phân tích...';
            qrStatus.style.display = 'block';
            qrStatus.style.background = 'rgba(0,123,255,0.8)';
        }
        
        // Start screenshot capture loop
        videoElement.addEventListener('loadeddata', () => {
            aiCanvas.width = videoElement.videoWidth;
            aiCanvas.height = videoElement.videoHeight;
            
            startScreenshotCapture(videoElement);
        });
        
        console.log('✅ AI Scanner started');
        
    }).catch(err => {
        console.error('❌ AI Scanner camera error:', err);
        alert('Không thể khởi động AI Scanner: ' + err.message);
    });
}

function startScreenshotCapture(videoElement) {
    aiScannerInterval = setInterval(() => {
        if (!aiScannerActive) return;
        
        try {
            // Capture frame from video
            aiContext.drawImage(videoElement, 0, 0, aiCanvas.width, aiCanvas.height);
            
            // Convert to base64
            const imageData = aiCanvas.toDataURL('image/jpeg', 0.8);
            
            // Send to backend for QR processing
            sendFrameToBackend(imageData);
            
        } catch (error) {
            console.error('Screenshot capture error:', error);
        }
        
    }, 1000); // Capture every 1 second - adjust as needed
}

function sendFrameToBackend(imageBase64) {
    // Remove data URL prefix
    const base64Data = imageBase64.replace(/^data:image\/jpeg;base64,/, '');
    
    $.ajax({
        url: 'qrAnalyze', // New servlet endpoint
        type: 'POST',
        data: {
            imageData: base64Data,
            userID: '${sessionScope.user.userID}'
        },
        timeout: 3000, // 3 second timeout
        success: function(response) {
            console.log('🤖 AI Response:', response);
            
            if (response.status === 'success' && response.qrData) {
                // QR detected! Show confirmation
                showProductConfirmation(response.qrData, response.productInfo);
                stopAIScanner();
            } else if (response.status === 'no_qr') {
                // No QR found - continue scanning
                updateAIScannerStatus('🔍 Đang tìm QR code...');
            } else if (response.status === 'error') {
                updateAIScannerStatus('⚠️ Lỗi phân tích: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            if (status !== 'timeout') {
                console.error('AI Scanner AJAX error:', error);
                updateAIScannerStatus('❌ Lỗi kết nối AI server');
            }
        }
    });
}

function updateAIScannerStatus(message) {
    const qrStatus = document.getElementById('qrStatus');
    if (qrStatus && aiScannerActive) {
        qrStatus.textContent = message;
    }
}

function stopAIScanner() {
    if (!aiScannerActive) return;
    
    console.log('🛑 Stopping AI Scanner...');
    aiScannerActive = false;
    
    // Clear interval
    if (aiScannerInterval) {
        clearInterval(aiScannerInterval);
        aiScannerInterval = null;
    }
    
    // Stop video stream
    if (aiVideoStream) {
        aiVideoStream.getTracks().forEach(track => track.stop());
        aiVideoStream = null;
    }
    
    // Reset UI
    cleanupCamera();
}

function showProductConfirmation(qrData, productInfo) {
    console.log('📦 Showing product confirmation:', {qrData, productInfo});
    
    // Store data for confirmation - fixed quantity to 1
    productConfirmData = {
        userID: '${sessionScope.user.userID}',
        productID: qrData.productID,
        variantID: qrData.variantID,
        quantity: 1 // Fixed quantity
    };
    
    // Populate modal with product info
    document.getElementById('productConfirmImage').src = "api/img/"+productInfo.imageUrl || './Images/default-product.jpg';
    document.getElementById('productConfirmName').textContent = productInfo.productName || 'Sản phẩm không xác định';
    document.getElementById('productConfirmVariant').querySelector('span').textContent = productInfo.variantName || 'Mặc định';
    document.getElementById('productConfirmPrice').querySelector('span').textContent = productInfo.price || 'Liên hệ';
    
    // Close QR scanner modal and show confirmation
    const qrModal = bootstrap.Modal.getInstance(document.getElementById('qrScannerModal'));
    if (qrModal) {
        qrModal.hide();
    }
    
    const confirmModal = new bootstrap.Modal(document.getElementById('productConfirmModal'));
    confirmModal.show();
}

function confirmAddToCart() {
    if (!productConfirmData) {
        alert('Không có dữ liệu sản phẩm!');
        return;
    }
    
    console.log('✅ Confirming add to cart:', productConfirmData);
    
    $.ajax({
        url: 'addCart',
        type: 'POST',
        data: {
            userID: productConfirmData.userID,
            productID: productConfirmData.productID,
            variantID: productConfirmData.variantID,
            quantity: productConfirmData.quantity
        },
        success: function(response) {
            console.log('🛒 Add cart response:', response);
            
            if (response.status === 'success') {
                alert('✅ Đã thêm sản phẩm vào giỏ hàng bằng AI!');
                
                // Close confirmation modal
                const confirmModal = bootstrap.Modal.getInstance(document.getElementById('productConfirmModal'));
                if (confirmModal) {
                    confirmModal.hide();
                }
                
                // Optional: Update cart count or reload
                // window.location.reload();
                
            } else if (response.status === 'not_logged_in') {
                alert('⚠️ Vui lòng đăng nhập để thêm sản phẩm!');
                window.location.href = 'login';
            } else {
                alert('❌ ' + (response.message || 'Lỗi khi thêm vào giỏ hàng!'));
            }
        },
        error: function(xhr, status, error) {
            console.error('❌ Confirm add cart error:', error);
            alert('❌ Lỗi kết nối: ' + error);
        }
    });
}

function updateScanningGuidance() {
    const now = Date.now();
    if (now - lastGuidanceUpdate < 3000) return; // Update every 3 seconds
    
    lastGuidanceUpdate = now;
    scanAttempts++;
    
    const qrStatus = document.getElementById('qrStatus');
    if (qrStatus && isScanning) {
        const messageIndex = (scanAttempts % scanGuidanceMessages.length);
        qrStatus.textContent = scanGuidanceMessages[messageIndex];
        qrStatus.style.display = 'block';
        qrStatus.style.background = 'rgba(0,0,0,0.8)';
        
        // Change QR box color based on attempts
        const qrBox = document.getElementById('qrBoxOverlay');
        if (qrBox) {
            if (scanAttempts > 5) {
                qrBox.style.borderColor = '#ff9900'; // Orange after many attempts
            } else {
                qrBox.style.borderColor = '#00ff00'; // Green normally
            }
        }
    }
}

// Wait for library to load
function waitForHtml5QrCode(callback) {
    if (typeof Html5Qrcode !== 'undefined') {
        callback();
    } else {
        setTimeout(() => waitForHtml5QrCode(callback), 100);
    }
}

function openQRScanner() {
    const modal = new bootstrap.Modal(document.getElementById('qrScannerModal'));
    modal.show();
}

function startSmartScan() {
    if (isScanning) return;
    
    // Show smart scan tips
    document.getElementById('scanTips').style.display = 'block';
    
    waitForHtml5QrCode(() => {
        const qrVideo = document.getElementById('qrVideo');
        const startBtn = document.getElementById('startCameraBtn');
        const smartBtn = document.getElementById('smartScanBtn');
        const stopBtn = document.getElementById('stopCameraBtn');
        const cameraContainer = document.getElementById('cameraContainer');
        
        // Reset scan attempts
        scanAttempts = 0;
        lastGuidanceUpdate = 0;
        
        // Properly cleanup existing scanner
        if (html5QrCode) {
            if (isScanning) {
                html5QrCode.stop().then(() => {
                    initializeSmartCamera();
                }).catch((err) => {
                    console.log('Previous scanner cleanup:', err);
                    initializeSmartCamera();
                });
            } else {
                html5QrCode.clear();
                initializeSmartCamera();
            }
        } else {
            initializeSmartCamera();
        }
        
        function initializeSmartCamera() {
            html5QrCode = new Html5Qrcode("qrVideo");
            
            document.getElementById('loadingText').textContent = '🧠 Khởi động quét thông minh...';
            
            Html5Qrcode.getCameras().then(cameras => {
                console.log('🧠 Smart Scan - Available cameras:', cameras);
                if (cameras && cameras.length) {
                    // Prioritize back camera for QR scanning
                    let cameraId = cameras[0].id;
                    
                    const backCamera = cameras.find(camera => 
                        camera.label.toLowerCase().includes('back') || 
                        camera.label.toLowerCase().includes('environment') ||
                        camera.label.toLowerCase().includes('rear')
                    );
                    if (backCamera) {
                        cameraId = backCamera.id;
                        console.log('🔍 Smart Scan using back camera:', backCamera.label);
                    }
                    
                    // Enhanced smart scan configuration
                    const smartConfig = {
                        fps: 30, // Max FPS for real-time scanning
                        qrbox: function(viewfinderWidth, viewfinderHeight) {
                            // Larger detection area for easier scanning
                            let qrboxSize = Math.min(viewfinderWidth, viewfinderHeight) * 0.8;
                            return {
                                width: qrboxSize,
                                height: qrboxSize
                            };
                        },
                        aspectRatio: 1.333,
                        disableFlip: false,
                        rememberLastUsedCamera: true,
                        supportedScanTypes: [Html5QrcodeScanType.SCAN_TYPE_CAMERA],
                        experimentalFeatures: {
                            useBarCodeDetectorIfSupported: true
                        },
                        videoConstraints: {
                            facingMode: "environment",
                            width: { 
                                min: 320, 
                                ideal: 640, // Giảm xuống mức realistic
                                max: 1280 
                            },
                            height: { 
                                min: 240, 
                                ideal: 480, 
                                max: 720 
                            }
                            // Bỏ các experimental constraints
                        }
                    };
                    
                    html5QrCode.start(
                        cameraId,
                        smartConfig,
                        (decodedText, decodedResult) => {
                            console.log(`🧠 Smart Scan SUCCESS: ${decodedText}`);
                            // Success feedback
                            const qrStatus = document.getElementById('qrStatus');
                            if (qrStatus) {
                                qrStatus.textContent = '🎉 Quét thành công bằng AI!';
                                qrStatus.style.display = 'block';
                                qrStatus.style.background = 'rgba(0,200,0,0.9)';
                            }
                            
                            // Enhanced success animation
                            try {
                                if (navigator.vibrate) {
                                    navigator.vibrate([100, 50, 100, 50, 200]);
                                }
                                
                                const qrBox = document.getElementById('qrBoxOverlay');
                                if (qrBox) {
                                    qrBox.style.borderColor = '#00ff00';
                                    qrBox.style.boxShadow = '0 0 50px rgba(0,255,0,1), 0 0 0 9999px rgba(0,0,0,0.4)';
                                    qrBox.style.animation = 'pulse 0.5s ease-in-out 2';
                                }
                            } catch (e) {
                                console.log('Enhanced feedback not supported');
                            }
                            
                            handleQRResult(decodedText);
                            setTimeout(() => stopCamera(), 1500);
                        },
                        (errorMessage) => {
                            updateScanningGuidance();
                        }
                    ).then(() => {
                        isScanning = true;
                        startBtn.style.display = 'none';
                        smartBtn.style.display = 'none';
                        stopBtn.style.display = 'inline-block';
                        cameraContainer.style.display = 'block';
                        
                        const loadingText = document.getElementById('loadingText');
                        if (loadingText) {
                            loadingText.style.display = 'none';
                        }
                        
                        // Start guidance immediately
                        setTimeout(() => updateScanningGuidance(), 1000);
                        
                        // Enhanced video styling for smart scan
                        setTimeout(() => {
                            const videoElement = document.querySelector('#qrVideo video');
                            if (videoElement) {
                                videoElement.style.width = '100%';
                                videoElement.style.height = '100%';
                                videoElement.style.objectFit = 'cover';
                                videoElement.style.transform = 'none';
                                videoElement.style.filter = 'contrast(1.1) brightness(1.05)'; // Enhance image quality
                                console.log('🧠 Smart Scan video enhanced');
                            }
                        }, 1000);
                        
                    }).catch(err => {
                        console.error('❌ Smart Scan error:', err);
                        
                        // Safe error handling
                        const loadingText = document.getElementById('loadingText');
                        if (loadingText) {
                            loadingText.textContent = 'Smart Scan lỗi: ' + (err.message || 'Không khả dụng');
                        }
                        
                        let errorMsg = 'Smart Scan không khả dụng!\n\n';
                        if (err.name === 'OverconstrainedError') {
                            errorMsg += '🔧 Camera không hỗ trợ chế độ Smart Scan.\n→ Thử "Bật Camera" thường hoặc "Tải lên ảnh"';
                        } else {
                            errorMsg += '→ Thử "Bật Camera" thường thay thế!';
                        }
                        
                        alert(errorMsg);
                    });
                } else {
                    alert('Không tìm thấy camera cho Smart Scan!');
                }
            });
        }
    });
}

function startCamera() {
    if (isScanning) return;
    
    waitForHtml5QrCode(() => {
        const qrVideo = document.getElementById('qrVideo');
        const startBtn = document.getElementById('startCameraBtn');
        const stopBtn = document.getElementById('stopCameraBtn');
        const cameraContainer = document.getElementById('cameraContainer');
        
        // Properly cleanup existing scanner
        if (html5QrCode) {
            // Only stop if scanner is actually running
            if (isScanning) {
                html5QrCode.stop().then(() => {
                    initializeCamera();
                }).catch((err) => {
                    console.log('Previous scanner cleanup:', err);
                    initializeCamera();
                });
            } else {
                // Scanner exists but not running, just recreate
                html5QrCode.clear();
                initializeCamera();
            }
        } else {
            initializeCamera();
        }
        
        function initializeCamera() {
            html5QrCode = new Html5Qrcode("qrVideo");
            
            // Show loading text
            document.getElementById('loadingText').textContent = 'Đang tìm camera...';
            
            Html5Qrcode.getCameras().then(cameras => {
                console.log('📷 Available cameras:', cameras);
                if (cameras && cameras.length) {
                    // Ưu tiên camera sau (back camera) cho QR scanning
                    let cameraId = cameras[0].id;
                    
                    // Tìm camera sau trước (tốt hơn cho QR scanning)
                    const backCamera = cameras.find(camera => 
                        camera.label.toLowerCase().includes('back') || 
                        camera.label.toLowerCase().includes('environment') ||
                        camera.label.toLowerCase().includes('rear')
                    );
                    if (backCamera) {
                        cameraId = backCamera.id;
                        console.log('🔍 Using back camera:', backCamera.label);
                    } else {
                        console.log('📱 Using default camera:', cameras[0].label);
                    }
                    
                    document.getElementById('loadingText').textContent = 'Đang khởi động camera...';
                    
                    // Primary config - try advanced first
                    const config = {
                        fps: 20, // Tăng FPS để quét nhanh hơn
                        qrbox: function(viewfinderWidth, viewfinderHeight) {
                            // Dynamic QR box size - thích ứng với kích thước camera
                            let minEdgePercentage = 0.7; // 70% of smaller edge
                            let minEdgeSize = Math.min(viewfinderWidth, viewfinderHeight);
                            let qrboxSize = Math.floor(minEdgeSize * minEdgePercentage);
                            return {
                                width: qrboxSize,
                                height: qrboxSize
                            };
                        },
                        aspectRatio: 1.777, // 16:9 ratio for modern cameras
                        disableFlip: false,
                        rememberLastUsedCamera: true,
                        supportedScanTypes: [Html5QrcodeScanType.SCAN_TYPE_CAMERA],
                        // Enhanced configuration for better detection
                        experimentalFeatures: {
                            useBarCodeDetectorIfSupported: true
                        },
                        videoConstraints: {
                            facingMode: "environment", // Đơn giản hơn
                            width: { 
                                min: 320, // Giảm min requirement
                                ideal: 640, // Giảm xuống mức an toàn
                                max: 1280 
                            },
                            height: { 
                                min: 240, // Giảm min requirement
                                ideal: 480, // Giảm xuống mức an toàn
                                max: 720 
                            }
                            // Bỏ các constraint có thể không support
                        }
                    };
                    
                    // Fallback config - minimal constraints
                    const fallbackConfig = {
                        fps: 10,
                        qrbox: 250,
                        aspectRatio: 1.0
                        // Không có videoConstraints - để browser tự chọn
                    };
                    
                    // Try primary config first, then fallback
                    function tryStartCamera(configToUse, isFallback = false) {
                        return html5QrCode.start(
                            cameraId,
                            configToUse,
                            (decodedText, decodedResult) => {
                                console.log(`🎯 QR Code quét được: ${decodedText}`);
                                // Success feedback (same as before)
                                const qrStatus = document.getElementById('qrStatus');
                                if (qrStatus) {
                                    qrStatus.textContent = '✅ QR đã quét thành công!';
                                    qrStatus.style.display = 'block';
                                    qrStatus.style.background = 'rgba(0,128,0,0.8)';
                                }
                                
                                // Success animation
                                try {
                                    if (navigator.vibrate) {
                                        navigator.vibrate([200, 100, 200]);
                                    }
                                    
                                    const qrBox = document.getElementById('qrBoxOverlay');
                                    if (qrBox) {
                                        qrBox.style.borderColor = '#00ff00';
                                        qrBox.style.boxShadow = '0 0 30px rgba(0,255,0,0.8), 0 0 0 9999px rgba(0,0,0,0.4)';
                                        setTimeout(() => {
                                            qrBox.style.borderColor = '#00ff00';
                                            qrBox.style.boxShadow = '0 0 0 9999px rgba(0,0,0,0.4)';
                                        }, 500);
                                    }
                                } catch (e) {
                                    console.log('Feedback effects not supported');
                                }
                                
                                handleQRResult(decodedText);
                                setTimeout(() => stopCamera(), 1000);
                            },
                            (errorMessage) => {
                                updateScanningGuidance();
                            }
                        );
                    }
                    
                    // Start with primary config
                    tryStartCamera(config, false).then(() => {
                        isScanning = true;
                        startBtn.style.display = 'none';
                        stopBtn.style.display = 'inline-block';
                        cameraContainer.style.display = 'block';
                        
                        // Show Smart Scan option after regular camera starts
                        const smartBtn = document.getElementById('smartScanBtn');
                        if (smartBtn) {
                            smartBtn.style.display = 'none'; // Hide when regular scanning
                        }
                        
                        // Hide loading text
                        const loadingText = document.getElementById('loadingText');
                        if (loadingText) {
                            loadingText.style.display = 'none';
                        }
                        
                        console.log('✅ Camera started successfully');
                        
                        // Wait a moment for video to load, then apply styling
                        setTimeout(() => {
                            const videoElement = document.querySelector('#qrVideo video');
                            if (videoElement) {
                                videoElement.style.width = '100%';
                                videoElement.style.height = '100%';
                                videoElement.style.objectFit = 'cover';
                                videoElement.style.transform = 'none'; // Remove any transforms that cause misalignment
                                console.log('📺 Video element styled:', videoElement);
                                
                                // Show scanning status
                                const qrStatus = document.getElementById('qrStatus');
                                if (qrStatus) {
                                    qrStatus.style.display = 'block';
                                }
                            } else {
                                console.warn('⚠️ Video element not found');
                            }
                        }, 1500); // Longer wait for better initialization
                        
                    }).catch(err => {
                        console.warn('⚠️ Primary config failed, trying fallback...', err);
                        
                        // Try fallback config
                        tryStartCamera(fallbackConfig, true).then(() => {
                            isScanning = true;
                            startBtn.style.display = 'none';
                            stopBtn.style.display = 'inline-block';
                            cameraContainer.style.display = 'block';
                            
                            const loadingText = document.getElementById('loadingText');
                            if (loadingText) {
                                loadingText.style.display = 'none';
                            }
                            
                            console.log('✅ Camera started with fallback config');
                            
                            // Show notification about fallback mode
                            const qrStatus = document.getElementById('qrStatus');
                            if (qrStatus) {
                                qrStatus.textContent = '📱 Chế độ tương thích - Quét chậm hơn';
                                qrStatus.style.display = 'block';
                                qrStatus.style.background = 'rgba(255,165,0,0.8)';
                            }
                            
                        }).catch(fallbackErr => {
                            console.error('❌ Both configs failed:', fallbackErr);
                            
                            // Safe error handling
                            const loadingText = document.getElementById('loadingText');
                            if (loadingText) {
                                loadingText.textContent = 'Lỗi: ' + (fallbackErr.message || 'Camera không khả dụng');
                            }
                            
                            // More user-friendly error messages
                            let errorMsg = 'Không thể bật camera!\n\n';
                            if (fallbackErr.name === 'OverconstrainedError') {
                                errorMsg += '🔧 Camera không hỗ trợ cấu hình yêu cầu.\n• Thử nút "Quét Thông Minh" thay thế\n• Hoặc dùng "Tải lên ảnh QR"';
                            } else if (fallbackErr.name === 'NotAllowedError') {
                                errorMsg += '🚫 Quyền truy cập camera bị từ chối.\n• Cho phép camera trong cài đặt trình duyệt\n• Refresh trang và thử lại';
                            } else if (fallbackErr.name === 'NotFoundError') {
                                errorMsg += '📷 Không tìm thấy camera.\n• Kiểm tra camera có được kết nối\n• Thử dùng "Tải lên ảnh QR"';
                            } else {
                                errorMsg += '• Thử "Quét Thông Minh"\n• Hoặc "Tải lên ảnh QR"\n• Refresh trang nếu cần';
                            }
                            
                            alert(errorMsg);
                        });
                    });
                } else {
                    document.getElementById('loadingText').textContent = 'Không tìm thấy camera';
                    alert('Không tìm thấy camera trên thiết bị!');
                }
            }).catch(err => {
                console.error('❌ Camera access error:', err);
                document.getElementById('loadingText').textContent = 'Lỗi truy cập camera';
                alert('Không thể truy cập camera. Vui lòng cho phép truy cập camera và thử lại!\n\nLưu ý: Nếu dùng HTTPS, hãy cho phép camera trong cài đặt trình duyệt.');
            });
        }
    });
}

function stopCamera() {
    // Stop AI Scanner if active
    if (aiScannerActive) {
        stopAIScanner();
        return;
    }
    
    // Stop regular scanner
    if (html5QrCode && isScanning) {
        html5QrCode.stop().then(() => {
            console.log('⏹️ Camera stopped successfully');
            cleanupCamera();
        }).catch(err => {
            console.error('❌ Camera stop error:', err);
            // Force cleanup even if stop failed
            cleanupCamera();
        });
    } else {
        console.log('⏹️ Camera already stopped or not initialized');
        cleanupCamera();
    }
}

function cleanupCamera() {
    // Stop AI Scanner if active
    if (aiScannerActive) {
        stopAIScanner();
        return;
    }
    
    isScanning = false;
    scanAttempts = 0;
    lastGuidanceUpdate = 0;
    
    document.getElementById('startCameraBtn').style.display = 'inline-block';
    document.getElementById('smartScanBtn').style.display = 'inline-block';
    document.getElementById('stopCameraBtn').style.display = 'none';
    document.getElementById('cameraContainer').style.display = 'none';
    document.getElementById('scanTips').style.display = 'none';
    
    // Hide QR status
    const qrStatus = document.getElementById('qrStatus');
    if (qrStatus) {
        qrStatus.style.display = 'none';
    }
    
    // Reset QR box appearance
    const qrBox = document.getElementById('qrBoxOverlay');
    if (qrBox) {
        qrBox.style.borderColor = '#00ff00';
        qrBox.style.boxShadow = '0 0 0 9999px rgba(0,0,0,0.4)';
        qrBox.style.animation = '';
    }
    
    // Show loading text for next time
    const loadingText = document.getElementById('loadingText');
    if (loadingText) {
        loadingText.style.display = 'block';
        loadingText.textContent = 'Đang khởi động camera...';
    }
}

// Handle image upload - with library check
document.addEventListener('DOMContentLoaded', function() {
    const qrImageInput = document.getElementById('qrImageInput');
    if (qrImageInput) {
        qrImageInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                waitForHtml5QrCode(() => {
                    // Create temporary div for image scanning
                    const tempDiv = document.createElement('div');
                    tempDiv.id = 'qr-reader-temp';
                    tempDiv.style.display = 'none';
                    document.body.appendChild(tempDiv);
                    
                    const html5QrCodeForImage = new Html5Qrcode("qr-reader-temp");
                    html5QrCodeForImage.scanFile(file, true)
                    .then(decodedText => {
                        console.log(`🖼️ QR từ ảnh: ${decodedText}`);
                        handleQRResult(decodedText);
                        document.body.removeChild(tempDiv);
                    })
                    .catch(err => {
                        console.error('❌ Image scan error:', err);
                        alert('Không thể đọc QR code từ ảnh này! Vui lòng chọn ảnh khác.');
                        document.body.removeChild(tempDiv);
                    });
                });
            }
        });
    }
});

function handleQRResult(qrText) {
    console.log('🔍 Processing QR result:', qrText);
    
    // Hiển thị kết quả
    document.getElementById('qrResult').textContent = qrText;
    document.getElementById('scanResult').style.display = 'block';
    
    // Parse QR content theo format: productID\n123\nvariantID\n456\nquantity\n1
    const lines = qrText.split('\n').map(line => line.trim());
    const qrData = {};
    
    for (let i = 0; i < lines.length; i += 2) {
        if (i + 1 < lines.length) {
            qrData[lines[i]] = lines[i + 1];
        }
    }
    
    console.log('📊 Raw QR text:', qrText);
    console.log('📊 Split lines:', lines);
    console.log('📊 Parsed QR data:', qrData);
    
    // Get userId from session (JSP renders this)
    const userId = '${sessionScope.user.userID}';
    console.log('👤 User ID from session:', userId);
    
    if (qrData.productID && qrData.variantID && userId && userId !== '') {
        qrScanResult = {
            userID: userId,
            productID: qrData.productID,
            variantID: qrData.variantID,
            quantity: qrData.quantity || '1'
        };
        console.log('✅ Ready to add to cart:', qrScanResult);
    } else {
        console.error('❌ Missing data:', {
            productID: qrData.productID,
            variantID: qrData.variantID, 
            userID: userId,
            qrData: qrData
        });
        alert('Mã QR không đúng định dạng hoặc chưa đăng nhập!\n\nDữ liệu thiếu:\n- Product ID: ' + (qrData.productID || 'Thiếu') + '\n- Variant ID: ' + (qrData.variantID || 'Thiếu') + '\n- User ID: ' + (userId || 'Chưa đăng nhập'));
        qrScanResult = null;
    }
}

function addQRToCart() {
    if (!qrScanResult) {
        alert('Chưa có dữ liệu QR hợp lệ!');
        return;
    }
    
    // Validate required fields
    if (!qrScanResult.userID || !qrScanResult.productID || !qrScanResult.variantID) {
        console.error('❌ Missing required data for addQRToCart:', qrScanResult);
        alert('❌ Thiếu thông tin cần thiết để thêm vào giỏ hàng!');
        return;
    }
    
    console.log('🛒 Adding QR to cart via AJAX:', qrScanResult);
    
    // Use AJAX like in TrangChu.jsp with exact parameter names
    $.ajax({
        url: 'addCart',
        type: 'POST',
        data: {
            userID: qrScanResult.userID,
            productID: qrScanResult.productID,
            variantID: qrScanResult.variantID,
            quantity: qrScanResult.quantity || 1
        },
        beforeSend: function() {
            console.log('📤 Sending QR AJAX request with data:', {
                userID: qrScanResult.userID,
                productID: qrScanResult.productID,
                variantID: qrScanResult.variantID,
                quantity: qrScanResult.quantity || 1
            });
        },
        success: function (response) {
            console.log('✅ addQRToCart response:', response);
            if (response.status === 'success') {
                // Success message
                alert('✅ Đã thêm sản phẩm vào giỏ hàng từ QR!');
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('qrScannerModal'));
                if (modal) {
                    modal.hide();
                }
                // Optional: Refresh cart count or redirect
                // window.location.reload();
            } else if (response.status === 'not_logged_in') {
                alert('⚠️ Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
                setTimeout(() => {
                    window.location.href = 'login';
                }, 1500);
            } else {
                alert('❌ ' + (response.message || 'Lỗi khi thêm sản phẩm vào giỏ hàng!'));
            }
        },
        error: function (xhr, status, error) {
            console.error('❌ QR AJAX Error:', {xhr, status, error});
            console.error('❌ Response text:', xhr.responseText);
            alert('❌ Lỗi kết nối server: ' + error);
        }
    });
}

// Cleanup when modal closes
document.addEventListener('DOMContentLoaded', function() {
    const qrModal = document.getElementById('qrScannerModal');
    if (qrModal) {
        qrModal.addEventListener('hidden.bs.modal', function () {
            console.log('🚪 Modal closing, cleaning up...');
            stopCamera();
            
            // Reset UI state
            document.getElementById('scanResult').style.display = 'none';
            qrScanResult = null;
            
            // Clear any file input
            const qrImageInput = document.getElementById('qrImageInput');
            if (qrImageInput) {
                qrImageInput.value = '';
            }
            
            // Reset result display
            document.getElementById('qrResult').textContent = '';
        });
        
        // Also cleanup when modal is being shown (fresh start)
        qrModal.addEventListener('show.bs.modal', function () {
            console.log('🚪 Modal opening, ensuring clean state...');
            if (html5QrCode && isScanning) {
                stopCamera();
            }
        });
    }
});
</script>
