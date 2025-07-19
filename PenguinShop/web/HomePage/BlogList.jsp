<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .blog-section {
                padding: 80px 0;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            }
            .blog-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            .blog-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            }
            .blog-image {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-bottom: 1px solid #eee;
            }
            .blog-content {
                padding: 25px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }
            .blog-title {
                font-size: 1.4rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            .blog-meta {
                color: #888;
                font-size: 0.9rem;
                border-top: 1px solid #eee;
                padding-top: 15px;
                margin-top: auto;
            }
            .blog-date {
                display: inline-flex;
                align-items: center;
                gap: 5px;
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
                font-size: 2.5rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }
            .page-subtitle {
                font-size: 1.2rem;
                color: #666;
                margin-bottom: 0;
            }
            .pagination-wrapper {
                padding: 50px 0;
                text-align: center;
            }
            .pagination .page-link {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: #fff;
                border: none;
                font-size: 16px;
                border-radius: 25px !important;
                margin: 0 4px;
                min-width: 44px;
                min-height: 44px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                box-shadow: 0 2px 8px rgba(174,28,154,0.08);
            }
            .pagination .page-link:hover, .pagination .page-item.active .page-link {
                background: linear-gradient(135deg, #c44ca8 0%, #AE1C9A 100%);
                color: #fff;
                box-shadow: 0 4px 16px rgba(174,28,154,0.18);
                text-decoration: none;
            }
            .pagination .page-item.disabled .page-link {
                background: #eee;
                color: #bbb;
                box-shadow: none;
            }
            .no-blogs {
                text-align: center;
                padding: 100px 0;
                color: #666;
            }
            .no-blogs i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: #ddd;
            }
            .btn-read-more {
                background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 25px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-block;
            }
            .btn-read-more:hover {
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
                            <form method="get" action="blog">
                                <div class="row g-3 align-items-end">
                                    <div style="font-size: 16px" class="col-md-5">
                                        <label  class="form-label fw-bold">Tìm kiếm blog</label>
                                        <input style="font-size: 16px" type="text" class="form-control" name="searchTitle" 
                                               value="${searchTitle}" placeholder="Nhập từ khóa...">
                                    </div>
                                    <div style="font-size: 16px" class="col-md-4">
                                        <label  class="form-label fw-bold">Ngày đăng</label>
                                        <input style="font-size: 16px" type="date" class="form-control" name="searchDate" value="${searchDate}">
                                    </div>
                                    <div style="font-size: 16px" class="col-md-3">
                                        <button type="submit" class="btn-search-custom w-100">
                                            <i class="fas fa-search me-2"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Blog Section -->
        <section class="blog-section">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Blog Penguin Shop</h1>
                    <p class="page-subtitle">
                        Khám phá những bài viết hữu ích và thú vị từ chúng tôi
                        <c:if test="${totalBlogs > 0}">
                            (${totalBlogs} bài viết)
                        </c:if>
                    </p>
                </div>

                <!-- Blog Grid -->
                <c:choose>
                    <c:when test="${empty blogs}">
                        <div class="no-blogs">
                            <i class="fas fa-search"></i>
                            <h3>Không tìm thấy bài viết nào</h3>
                            <p>Hãy thử tìm kiếm với từ khóa khác hoặc <a href="blog">xem tất cả bài viết</a></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="blog" items="${blogs}">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <article class="blog-card">
                                        <!-- Blog Image -->
                                        <c:choose>
                                            <c:when test="${not empty blog.imageUrl}">
                                                <img src="${blog.imageUrl}" alt="${blog.title}" class="blog-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="blog-image bg-light d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-image text-muted" style="font-size: 3rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Blog Content -->
                                        <div class="blog-content">
                                            <h2 class="blog-title" style="min-height: 3.2em; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${blog.title}</h2>

                                            <!-- Author Info -->
                                            <div class="blog-author mb-3">
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${not empty blog.authorImage}">
                                                            <img src="${blog.authorImage}" alt="${blog.authorName}" 
                                                                 class="author-avatar rounded-circle me-2" 
                                                                 style="width: 32px; height: 32px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="author-avatar rounded-circle me-2 bg-primary d-flex align-items-center justify-content-center" 
                                                                 style="width: 32px; height: 32px; color: white; font-size: 14px; font-weight: bold;">
                                                                ${fn:substring(blog.authorName, 0, 1)}
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                            <div style="margin-left: 200px" class="d-flex justify-content-between align-items-center mt-auto">
                                                                <a style="font-size: 14px" href="blogDetail?id=${blog.blogID}" class="btn-read-more">
                                                            Đọc thêm <i class="fas fa-arrow-right ms-1"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="blog-meta">
                                                <div style="font-size: 14px" class="blog-date">
                                                    <i class="fas fa-calendar-alt"></i>
                                                    <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy"/>
                                                    <small class="text-muted">Bởi <strong>${blog.authorName}</strong></small>
                                                </div>

                                            </div>
                                        </div>
                                    </article>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 0}">
                            <div class="pagination-wrapper">
                                <nav aria-label="Blog pagination">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}&searchTitle=${searchTitle}&searchDate=${searchDate}">
                                                    <i class="fas fa-chevron-left"></i> Trước
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <li class="page-item active">
                                                        <span class="page-link">${i}</span>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${i}&searchTitle=${searchTitle}&searchDate=${searchDate}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}&searchTitle=${searchTitle}&searchDate=${searchDate}">
                                                    Sau <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="Common/Footer.jsp"/>

        <!-- Scripts -->
        <jsp:include page="Common/Js.jsp"/>
    </body>
</html>
