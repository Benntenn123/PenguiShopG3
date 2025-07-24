<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .brand-section {
                padding: 80px 0;
                display: flex;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            }
            .brand-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                height: 450px;
                display: flex;
                flex-direction: column;
            }
            .brand-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            }
            .brand-logo {
                width: 100%;
                height: 180px;
                object-fit: contain;
                padding: 20px;
                background-color: #f8f9fa;
                border-bottom: 1px solid #eee;
                flex-shrink: 0;
            }
            .brand-content {
                padding: 20px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                text-align: center;
                justify-content: space-between;
            }
            .brand-name {
                font-size: 1.5rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 12px;
                line-height: 1.4;
            }
            .brand-description {
                color: #666;
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 15px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                min-height: 3.2em;
            }
            .brand-actions {
                margin-top: 10px;
            }
            .search-section {
                background: white;
                padding: 40px 0;
                border-bottom: 1px solid #eee;
            }
            .search-card {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }
            .page-header {
                text-align: center;
                margin-bottom: 50px;
            }
            .page-title {
                font-size: 2.8rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }
            .page-subtitle {
                font-size: 1.3rem;
                color: #666;
                margin-bottom: 0;
            }
            .no-brands {
                text-align: center;
                padding: 100px 0;
                color: #666;
            }
            .no-brands i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: #ddd;
            }
            .btn-explore {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 25px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-block;
                font-weight: 500;
                font-size: 1rem;
            }
            .btn-explore:hover {
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(174, 28, 154, 0.3);
            }
            .btn-search-custom {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: #fff;
                border: none;
                font-size: 16px;
                border-radius: 25px;
                min-width: 44px;
                min-height: 44px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                box-shadow: 0 2px 8px rgba(174,28,154,0.08);
            }
            .btn-search-custom:hover, .btn-search-custom:focus {
                background: linear-gradient(135deg, #c44ca8 0%, #AE1C9A 100%);
                color: #fff;
                box-shadow: 0 4px 16px rgba(174,28,154,0.18);
                text-decoration: none;
            }
            .brand-stats {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 14px;
                margin: 15px 0;
                color: #666;
                font-size: 0.95rem;
            }
            .stats-item {
                display: flex;
                align-items: center;
                gap: 6px;
                margin-bottom: 4px;
                justify-content: center;
            }
            .stats-item:last-child {
                margin-bottom: 0;
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .brand-card {
                    height: auto;
                    min-height: 400px;
                }
                .brand-logo {
                    height: 150px;
                    padding: 15px;
                }
                .brand-content {
                    padding: 18px;
                }
                .page-title {
                    font-size: 2.2rem;
                }
                .page-subtitle {
                    font-size: 1.1rem;
                }
                .search-section {
                    padding: 30px 0;
                }
                .search-card {
                    padding: 25px;
                }
                .col-md-6, .col-md-3 {
                    margin-bottom: 15px;
                }
            }
            
            @media (max-width: 576px) {
                .brand-card {
                    min-height: 370px;
                }
                .brand-section {
                    padding: 60px 0;
                }
                .search-card .row {
                    flex-direction: column;
                }
                .search-card .col-md-6,
                .search-card .col-md-3 {
                    margin-bottom: 15px;
                }
                input[type="text"] {
                    font-size: 16px !important;
                    height: 44px !important;
                }
                .btn-search-custom,
                .btn {
                    height: 44px !important;
                    font-size: 15px !important;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="Common/Header.jsp"/>

        <!-- Search Section -->
        <section class="search-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="search-card">
                            <form method="get" action="brands">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold" style="font-size: 18px">Tìm kiếm thương hiệu</label>
                                        <input style="font-size: 16px; padding: 12px 16px; height: 48px;" type="text" class="form-control" name="searchName" 
                                               value="${searchName}" placeholder="Nhập tên thương hiệu...">
                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn-search-custom w-100" style="font-size: 16px; height: 48px;">
                                            <i class="fas fa-search me-2"></i> Tìm kiếm
                                        </button>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="brands" class="btn btn-outline-secondary w-100" style="font-size: 16px; height: 48px; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-refresh me-2"></i> Làm mới
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Brand Section -->
        <section class="brand-section">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Thương Hiệu</h1>
                    <p class="page-subtitle">
                        Khám phá các thương hiệu hàng đầu tại Penguin Shop
                        <c:if test="${totalBrands > 0}">
                            (${totalBrands} thương hiệu)
                        </c:if>
                    </p>
                </div>

                <!-- Brand Grid -->
                <c:choose>
                    <c:when test="${empty brands}">
                        <div class="no-brands">
                            <i class="fas fa-search"></i>
                            <h3>Không tìm thấy thương hiệu nào</h3>
                            <p>Hãy thử tìm kiếm với từ khóa khác hoặc <a href="brands">xem tất cả thương hiệu</a></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="brand" items="${brands}">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <article class="brand-card">
                                        <!-- Brand Logo -->
                                        <c:choose>
                                            <c:when test="${not empty brand.logo}">
                                                <img src="api/img/${brand.logo}" alt="${brand.brandName}" class="brand-logo">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="brand-logo bg-light d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-building text-muted" style="font-size: 3rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Brand Content -->
                                        <div class="brand-content">
                                            <h2 class="brand-name">${brand.brandName}</h2>

                                            <!-- Brand Description -->
                                            <c:if test="${not empty brand.description}">
                                                <p class="brand-description">${brand.description}</p>
                                            </c:if>

                                            <!-- Brand Stats -->
                                            <div class="brand-stats">
                                                <div class="stats-item">
                                                    <i class="fas fa-tag text-primary"></i>
                                                    <span>Thương hiệu chính hãng</span>
                                                </div>
                                                <div class="stats-item">
                                                    <i class="fas fa-shipping-fast text-success"></i>
                                                    <span>Giao hàng toàn quốc</span>
                                                </div>
                                                <div class="stats-item">
                                                    <i class="fas fa-shield-alt text-info"></i>
                                                    <span>Bảo hành chính hãng</span>
                                                </div>
                                            </div>

                                            <!-- Actions -->
                                            <div class="brand-actions">
                                                <a href="search?brand=${brand.brandID}" class="btn-explore">
                                                    Khám phá sản phẩm <i class="fas fa-arrow-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </article>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Pagination -->
                <c:if test="${totalPages > 0}">
                    <div class="row">
                        <div class="col-12 d-flex justify-content-center">
                            <ul class="pagination custom-pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="brands?page=${currentPage - 1}
                                            <c:if test='${not empty searchName}'>
                                                &amp;searchName=${fn:escapeXml(searchName)}
                                            </c:if>">
                                            &laquo;
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                        <a class="page-link" href="brands?page=${i}
                                            <c:if test='${not empty searchName}'>
                                                &amp;searchName=${fn:escapeXml(searchName)}
                                            </c:if>">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="brands?page=${currentPage + 1}
                                            <c:if test='${not empty searchName}'>
                                                &amp;searchName=${fn:escapeXml(searchName)}
                                            </c:if>">
                                            &raquo;
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </c:if>

        <style>
            .custom-pagination {
                background: none;
                border-radius: 32px;
                box-shadow: none;
                padding: 0 8px;
            }
            .custom-pagination .page-item {
                margin: 0 4px;
            }
            .custom-pagination .page-link {
                min-width: 48px;
                height: 48px;
                font-size: 1.25rem;
                font-weight: 600;
                border-radius: 50px !important;
                border: none;
                color: #AE1C9A;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                box-shadow: 0 2px 8px rgba(174,28,154,0.08);
            }
            .custom-pagination .page-link:hover, .custom-pagination .page-item.active .page-link {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: #fff;
                box-shadow: 0 4px 16px rgba(174,28,154,0.18);
                text-decoration: none;
            }
            .custom-pagination .page-item.active .page-link {
                font-weight: bold;
                border: none;
            }
        </style>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="Common/Footer.jsp"/>

        <!-- Scripts -->
        <jsp:include page="Common/Js.jsp"/>
    </body>
</html>
