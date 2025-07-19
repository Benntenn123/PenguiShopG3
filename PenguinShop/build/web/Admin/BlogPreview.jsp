<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${blog.title} - Blog Preview</title>
        <jsp:include page="../HomePage/Common/Css.jsp"/>
        <style>
            body {
                padding-top: 0 !important;
            }
            .blog-preview-container {
                margin-top: 120px;
                margin-bottom: 50px;
            }
            .blog-title {
                font-size: 2.5rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
                line-height: 1.3;
            }
            .blog-meta {
                color: #666;
                margin-bottom: 30px;
                border-bottom: 1px solid #eee;
                padding-bottom: 15px;
            }
            .blog-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 30px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            .blog-content {
                font-size: 1.1rem;
                line-height: 1.8;
                color: #444;
                text-align: justify;
            }
            .blog-content h1, .blog-content h2, .blog-content h3, 
            .blog-content h4, .blog-content h5, .blog-content h6 {
                margin-top: 2rem;
                margin-bottom: 1rem;
                color: #333;
            }
            .blog-content p {
                margin-bottom: 1.5rem;
            }
            .blog-content img {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
                margin: 1.5rem auto;
                display: block;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .blog-content blockquote {
                border-left: 4px solid #007bff;
                padding-left: 1.5rem;
                margin: 1.5rem 0;
                color: #666;
                font-style: italic;
                background-color: #f8f9fa;
                padding: 1rem 1.5rem;
                border-radius: 4px;
            }
            .blog-content table {
                width: 100%;
                border-collapse: collapse;
                margin: 1.5rem 0;
            }
            .blog-content table th,
            .blog-content table td {
                border: 1px solid #dee2e6;
                padding: 0.75rem;
                text-align: left;
            }
            .blog-content table th {
                background-color: #f8f9fa;
                font-weight: bold;
            }
            .preview-notice {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 15px;
                text-align: center;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 9999;
                font-weight: 600;
                box-shadow: 0 2px 10px rgba(0,0,0,0.2);
                transition: transform 0.3s ease;
            }
            .preview-actions {
                margin-top: 50px;
                padding-top: 30px;
                border-top: 2px solid #eee;
                text-align: center;
            }
            .back-to-admin, .edit-blog {
                padding: 12px 25px;
                border: none;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-block;
                margin: 0 10px 10px 0;
            }
            .back-to-admin {
                background: #6c757d;
                color: white;
            }
            .back-to-admin:hover {
                background: #545b62;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
            }
            .edit-blog {
                background: #007bff;
                color: white;
            }
            .edit-blog:hover {
                background: #0056b3;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
            }
            @media (max-width: 768px) {
                .blog-title {
                    font-size: 2rem;
                }
                .blog-preview-container {
                    margin-top: 100px;
                }
                .back-to-admin, .edit-blog {
                    display: block;
                    margin: 10px 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Preview Notice -->
        <div class="preview-notice">
            <i class="fas fa-eye"></i> CHẾ ĐỘ XEM TRƯỚC - Đây là cách bài viết sẽ hiển thị trên trang web
        </div>

        <!-- Include Homepage Header -->
        <jsp:include page="../HomePage/Common/Header.jsp"/>

        <!-- Blog Content -->
        <div class="container blog-preview-container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Blog Title -->
                    <h1 class="blog-title">${blog.title}</h1>
                    
                    <!-- Blog Meta -->
                    <div class="blog-meta">
                        <div class="row">
                            <div class="col-md-6">
                                <i class="fas fa-calendar-alt"></i>
                                <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy 'lúc' HH:mm"/>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <c:choose>
                                    <c:when test="${blog.status == 1}">
                                        <span class="badge bg-success">
                                            <i class="fas fa-eye"></i> Đã xuất bản
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning">
                                            <i class="fas fa-eye-slash"></i> Chưa xuất bản
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Blog Image -->
                    <c:if test="${not empty blog.imageUrl}">
                        <img src="${blog.imageUrl}" alt="${blog.title}" class="blog-image">
                    </c:if>

                    <!-- Blog Content -->
                    <div class="blog-content">
                        ${blog.content}
                    </div>

                    <!-- Preview Actions -->
                    <div class="preview-actions">
                        <a href="javascript:history.back()" class="back-to-admin">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                        <a href="BlogEdit?id=${blog.blogID}" class="edit-blog" target="_blank">
                            <i class="fas fa-edit"></i> Chỉnh sửa bài viết
                        </a>
                        <a href="javascript:window.close()" class="back-to-admin">
                            <i class="fas fa-times"></i> Đóng cửa sổ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Homepage Footer -->
        <jsp:include page="../HomePage/Common/Footer.jsp"/>
        
        <!-- Include Homepage JS -->
        <jsp:include page="../HomePage/Common/Js.jsp"/>
        
        <script>
            // Additional preview-specific JavaScript
            document.addEventListener('DOMContentLoaded', function() {
                // Smooth scrolling for any anchor links in blog content
                const links = document.querySelectorAll('.blog-content a[href^="#"]');
                links.forEach(link => {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        const target = document.querySelector(this.getAttribute('href'));
                        if (target) {
                            target.scrollIntoView({
                                behavior: 'smooth'
                            });
                        }
                    });
                });

                // Handle external links - open in new tab
                const externalLinks = document.querySelectorAll('.blog-content a[href^="http"]');
                externalLinks.forEach(link => {
                    link.setAttribute('target', '_blank');
                    link.setAttribute('rel', 'noopener noreferrer');
                });

                // Auto-close notice after 5 seconds
                setTimeout(function() {
                    const notice = document.querySelector('.preview-notice');
                    if (notice) {
                        notice.style.transform = 'translateY(-100%)';
                        notice.style.transition = 'transform 0.3s ease';
                    }
                }, 5000);
            });
        </script>
    </body>
</html>
