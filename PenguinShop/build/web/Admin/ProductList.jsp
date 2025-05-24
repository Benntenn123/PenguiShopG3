<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <jsp:include page="Common/Head.jsp" />
    </head>
    <body>


        <!--start wrapper-->
        <div class="wrapper">
            <!--start sidebar -->
            <jsp:include page="Common/Aside.jsp" />
            <jsp:include page="Common/Header.jsp"/>


            <!-- start page content wrapper-->
            <div class="page-content-wrapper">
                <!-- start page content-->
                <div class="page-content">

                    <!--start breadcrumb-->
                    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                        <div class="breadcrumb-title pe-3">Sản phẩm</div>
                        <div class="ps-3">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0 p-0 align-items-center">
                                    <li class="breadcrumb-item"><a href="javascript:;"><ion-icon name="home-outline"></ion-icon></a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">List View</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="ms-auto">
                            <div class="btn-group">
                                <button type="button" class="btn btn-outline-primary">Settings</button>
                                <button type="button" class="btn btn-outline-primary split-bg-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown">	<span class="visually-hidden">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-end">	<a class="dropdown-item" href="javascript:;">Action</a>
                                    <a class="dropdown-item" href="javascript:;">Another action</a>
                                    <a class="dropdown-item" href="javascript:;">Something else here</a>
                                    <div class="dropdown-divider"></div>	<a class="dropdown-item" href="javascript:;">Separated link</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--end breadcrumb-->

                    <!--start shop area-->
                    <section class="shop-page">
                        <div class="shop-container">
                            <div class="card shadow-sm border-0">
                                <div class="card-body">
                                    <div class="row">
                                        <!--              <div class="col-12">
                                                        <div class="card">
                                                          <div class="card-body">
                                                            <div class="toolbox d-flex flex-row align-items-center gap-2">
                                                              <div class="d-flex flex-wrap flex-grow-1 gap-1">
                                                                <div class="d-flex align-items-center flex-nowrap">
                                                                  <p class="mb-0 font-13 text-nowrap">Sort By:</p>
                                                                  <select class="form-select ms-3">
                                                                    <option value="menu_order" selected="selected">Default sorting</option>
                                                                    <option value="popularity">Sort by popularity</option>
                                                                    <option value="rating">Sort by average rating</option>
                                                                    <option value="date">Sort by newness</option>
                                                                    <option value="price">Sort by price: low to high</option>
                                                                    <option value="price-desc">Sort by price: high to low</option>
                                                                  </select>
                                                                </div>
                                                              </div>
                                                              <div class="d-flex flex-wrap">
                                                                <div class="d-flex align-items-center flex-nowrap">
                                                                  <p class="mb-0 font-13 text-nowrap">Show:</p>
                                                                  <select class="form-select ms-3">
                                                                    <option>9</option>
                                                                    <option>12</option>
                                                                    <option>16</option>
                                                                    <option>20</option>
                                                                    <option>50</option>
                                                                    <option>100</option>
                                                                  </select>
                                                                </div>
                                                              </div>
                                                              <div class="btn-group">	
                                                                <a href="ecommerce-shop-grid-view.html" class="btn btn-outline-primary"><i class='bx bxs-grid mx-0'></i></a>
                                                                <a href="ecommerce-shop-list-view.html" class="btn btn-primary"><i class='bx bx-list-ul mx-0'></i></a>
                                                              </div>
                                                            </div>
                                                          </div>
                                                        </div>
                                                      </div>-->
<!--                                        <div class="col-12 col-xl-3">
                                            <div class="btn-mobile-filter d-xl-none"><i class='bx bx-slider-alt'></i>
                                            </div>
                                            <div class="filter-sidebar d-none d-xl-flex">
                                                <div class="card w-100">
                                                    <div class="card-body">
                                                        <div class="align-items-center d-flex d-xl-none">
                                                            <h6 class="text-uppercase mb-0">Filter</h6>
                                                            <div class="btn-mobile-filter-close btn-close ms-auto cursor-pointer"></div>
                                                        </div>
                                                        <hr class="d-flex d-xl-none" />
                                                        <div class="product-categories">
                                                            <h6 class="text-uppercase mb-3">Categories</h6>
                                                            <ul class="list-unstyled mb-0 categories-list">
                                                                <li><a href="javascript:;">Clothings <span class="float-end badge rounded-pill bg-primary">42</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Sunglasses <span class="float-end badge rounded-pill bg-primary">32</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Bags <span class="float-end badge rounded-pill bg-primary">17</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Watches <span class="float-end badge rounded-pill bg-primary">217</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Furniture <span class="float-end badge rounded-pill bg-primary">28</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Shoes <span class="float-end badge rounded-pill bg-primary">145</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Accessories <span class="float-end badge rounded-pill bg-primary">15</span></a>
                                                                </li>
                                                                <li><a href="javascript:;">Headphones <span class="float-end badge rounded-pill bg-primary">8</span></a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <hr>
                                                        <div class="price-range">
                                                            <h6 class="text-uppercase mb-3">Price</h6>
                                                            <div class="my-4" id="slider"></div>
                                                            <div class="d-flex align-items-center">
                                                                <button type="button" class="btn btn-primary btn-sm text-uppercase rounded font-13 fw-500">Filter</button>
                                                                <div class="ms-auto">
                                                                    <p class="mb-0">Price: $200 - $900</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="size-range">
                                                            <h6 class="text-uppercase mb-3">Size</h6>
                                                            <ul class="list-unstyled mb-0 categories-list">
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Small">
                                                                        <label class="form-check-label" for="Small">Small</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Medium">
                                                                        <label class="form-check-label" for="Medium">Medium</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Large">
                                                                        <label class="form-check-label" for="Large">Large</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="ExtraLarge">
                                                                        <label class="form-check-label" for="ExtraLarge">Extra Large</label>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <hr>
                                                        <div class="product-brands">
                                                            <h6 class="text-uppercase mb-3">Brands</h6>
                                                            <ul class="list-unstyled mb-0 categories-list">
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Adidas">
                                                                        <label class="form-check-label" for="Adidas">Addidas (15)</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Armani">
                                                                        <label class="form-check-label" for="Armani">Armani (26)</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="CalvinKlein">
                                                                        <label class="form-check-label" for="CalvinKlein">Calvin Klein (24)</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Columbia">
                                                                        <label class="form-check-label" for="Columbia">Columbia (38)</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="JhonPlayers">
                                                                        <label class="form-check-label" for="JhonPlayers">Jhon Players (48)</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" value="" id="Diesel">
                                                                        <label class="form-check-label" for="Diesel">Diesel (64)</label>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <hr>
                                                        <div class="product-colors">
                                                            <h6 class="text-uppercase mb-3">Colors</h6>
                                                            <ul class="list-unstyled mb-0 categories-list">
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-dark"></div>
                                                                        <p class="mb-0 ms-3">Black</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-warning"></div>
                                                                        <p class="mb-0 ms-3">Yellow</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-danger"></div>
                                                                        <p class="mb-0 ms-3">Red</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-primary"></div>
                                                                        <p class="mb-0 ms-3">Blue</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator border bg-white"></div>
                                                                        <p class="mb-0 ms-3">White</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-success"></div>
                                                                        <p class="mb-0 ms-3">Green</p>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="d-flex align-items-center cursor-pointer">
                                                                        <div class="color-indigator bg-info"></div>
                                                                        <p class="mb-0 ms-3">Sky Blue</p>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->
                                        <div class="col-12 col-xl-9">
                                            <div class="product-wrapper">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="position-relative">
                                                            <input type="text" class="form-control ps-5" placeholder="Search Product...">
                                                            <span class="position-absolute top-50 product-show translate-middle-y"><ion-icon name="search-sharp" class="ms-3 fs-6"></ion-icon></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="product-grid">

                                                    <c:forEach var="p" items="${requestScope.listP}">
                                                    <div class="card product-card">
                                                        
                                                        <div class="row g-0">
                                                            <div class="col-md-4">
                                                                <div class="p-3">
                                                                    <img src="assets/images/products/02.png" class="img-fluid rounded" alt="...">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <div class="card-body">
                                                                    <div class="product-info">
                                                                        <a href="javascript:;">
                                                                            <p class="product-catergory font-13 mb-1">Thể loại: ${p.category.categoryName}</p>
                                                                        </a>
                                                                        <a href="ecommerce-product-details.html">
                                                                            <h6 class="product-name mb-2">${p.productName}</h6>
                                                                        </a>
                                                                        <p class="card-text">${p.description}</p>
                                                                        <div class="product-action mt-2">
                                                                            <div class="d-flex gap-2">
                                                                                <a href="javascript:;" class="btn btn-primary btn-ecomm"> <i class="bx bxs-cart-add"></i>Xem chi tiết</a>
                                                                                <a href="javascript:;" class="btn btn-light btn-ecomm"> <i class='bx bx-shopping-bag'></i>Xóa</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    </c:forEach>
                                                </div>
                                                <hr>
                                                <nav class="d-flex justify-content-between" aria-label="Page navigation">
                                                    <ul class="pagination">
                                                        <li class="page-item"><a class="page-link" href="javascript:;"><i class='bx bx-chevron-left'></i> Prev</a>
                                                        </li>
                                                    </ul>
                                                    <ul class="pagination">
                                                        <li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">1<span class="visually-hidden">(current)</span></span>
                                                        </li>
                                                        <li class="page-item d-none d-sm-block"><a class="page-link" href="javascript:;">2</a>
                                                        </li>
                                                        <li class="page-item d-none d-sm-block"><a class="page-link" href="javascript:;">3</a>
                                                        </li>
                                                        <li class="page-item d-none d-sm-block"><a class="page-link" href="javascript:;">4</a>
                                                        </li>
                                                        <li class="page-item d-none d-sm-block"><a class="page-link" href="javascript:;">5</a>
                                                        </li>
                                                    </ul>
                                                    <ul class="pagination">
                                                        <li class="page-item"><a class="page-link" href="javascript:;" aria-label="Next">Next <i class='bx bx-chevron-right'></i></a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div><!--end row-->
                                </div>
                            </div>
                        </div>
                    </section>
                    <!--end shop area-->

                </div>
                <!-- end page content-->
            </div>



            <!--Start Back To Top Button-->
            <a href="javaScript:;" class="back-to-top"><ion-icon name="arrow-up-outline"></ion-icon></a>
            <!--End Back To Top Button-->

            <!--start switcher-->
            <div class="switcher-body">
                <button class="btn btn-primary btn-switcher shadow-sm" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling"><ion-icon name="color-palette-sharp" class="me-0"></ion-icon></button>
                <div class="offcanvas offcanvas-end shadow border-start-0 p-2" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling">
                    <div class="offcanvas-header border-bottom">
                        <h5 class="offcanvas-title" id="offcanvasScrollingLabel">Theme Customizer</h5>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
                    </div>
                    <div class="offcanvas-body">
                        <h6 class="mb-0">Theme Variation</h6>
                        <hr>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="LightTheme" value="option1" checked>
                            <label class="form-check-label" for="LightTheme">Light</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="DarkTheme" value="option2">
                            <label class="form-check-label" for="DarkTheme">Dark</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="inlineRadioOptions" id="SemiDark" value="option3">
                            <label class="form-check-label" for="SemiDark">Semi Dark</label>
                        </div>
                        <hr/>
                        <h6 class="mb-0">Header Colors</h6>
                        <hr/>
                        <div class="header-colors-indigators">
                            <div class="row row-cols-auto g-3">
                                <div class="col">
                                    <div class="indigator headercolor1" id="headercolor1"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor2" id="headercolor2"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor3" id="headercolor3"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor4" id="headercolor4"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor5" id="headercolor5"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor6" id="headercolor6"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor7" id="headercolor7"></div>
                                </div>
                                <div class="col">
                                    <div class="indigator headercolor8" id="headercolor8"></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!--end switcher-->


            <!--start overlay-->
            <div class="overlay nav-toggle-icon"></div>
            <!--end overlay-->

        </div>
        <!--end wrapper-->





        <!-- JS Files-->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/plugins/simplebar/js/simplebar.min.js"></script>
        <script src="assets/plugins/metismenu/js/metisMenu.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <!--plugins-->
        <script src="assets/plugins/perfect-scrollbar/js/perfect-scrollbar.js"></script>
        <script src="assets/plugins/nouislider/nouislider.min.js"></script>
        <script src="assets/js/price-slider.js"></script>

        <!-- Main JS-->
        <script src="assets/js/main.js"></script>


    </body>
</html>
