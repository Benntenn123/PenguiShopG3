<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>${blog.title} - Penguin Shop Blog</title>
        <meta name="description" content="${blog.title}">
        <style>
            .blog-detail-section {
                padding: 80px 0;
                background: #f8f9fa;
            }
            .blog-content i{
                font-size:16px;
            }
            .blog-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 40px;
            }
            .blog-header {
                text-align: center;
                padding: 50px 40px 30px;
                border-bottom: 1px solid #eee;
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
                font-size: 1.1rem;
                display: flex;
                justify-content: center;
                gap: 30px;
                flex-wrap: wrap;
            }
            .blog-meta-item {
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .blog-image {
                width: 100%;
                max-height: 500px;
                object-fit: cover;
            }
            .blog-content {
                padding: 50px;
            }
            .blog-text {
                font-size: 1.2rem;
                line-height: 1.8;
                color: #444;
                text-align: justify;
            }
            .blog-text h1, .blog-text h2, .blog-text h3, 
            .blog-text h4, .blog-text h5, .blog-text h6 {
                margin-top: 2.5rem;
                margin-bottom: 1.5rem;
                color: #333;
            }
            .blog-text p {
                margin-bottom: 1.8rem;
            }
            .blog-text img {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
                margin: 2rem auto;
                display: block;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .blog-text blockquote {
                border-left: 4px solid #007bff;
                padding-left: 2rem;
                margin: 2rem 0;
                color: #666;
                font-style: italic;
                background-color: #f8f9fa;
                padding: 1.5rem 2rem;
                border-radius: 8px;
            }
            .blog-text table {
                width: 100%;
                border-collapse: collapse;
                margin: 2rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            .blog-text table th,
            .blog-text table td {
                border: 1px solid #dee2e6;
                padding: 1rem;
                text-align: left;
            }
            .blog-text table th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }
            .blog-actions {
                padding: 30px 50px;
                background: #f8f9fa;
                border-top: 1px solid #eee;
                text-align: center;
            }
            .btn-back {
                background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 25px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-block;
                margin: 0 10px;
            }
            .btn-back:hover {
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(108,117,125,0.3);
            }
            .sidebar {
                position: sticky;
                top: 100px;
            }
            .sidebar-card {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 3px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .sidebar-title {
                font-size: 1.3rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
                border-bottom: 2px solid #007bff;
                padding-bottom: 10px;
            }
            .related-post-item {
                border-bottom: 1px solid #eee;
                padding-bottom: 10px;
            }
            .related-post-item:last-child {
                border-bottom: none;
                padding-bottom: 0;
                margin-bottom: 0 !important;
            }
            .related-post-item:hover {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 10px;
                margin: -10px;
            }
            #playBtn {
                transition: all 0.3s ease;
            }
            #playBtn:hover {
                transform: translateY(-1px);
                box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            }
            @media (max-width: 768px) {
                .blog-title {
                    font-size: 2rem;
                }
                .blog-header {
                    padding: 30px 20px 20px;
                }
                .blog-content {
                    padding: 30px 20px;
                }
                .blog-actions {
                    padding: 20px;
                }
                .blog-meta {
                    flex-direction: column;
                    gap: 15px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="Common/Header.jsp"/>

        <!-- Blog Detail Section -->
        <section class="blog-detail-section">
            <div class="container">
                <div class="row">
                    <!-- Main Content -->
                    <div class="col-lg-8">
                        <div class="blog-container">
                            <!-- Blog Header -->
                            <div class="blog-header position-relative">
                                <div class="d-flex align-items-center justify-content-between flex-wrap">
                                    <h1 class="blog-title mb-0">${blog.title}</h1>
                                    <div class="d-flex align-items-center gap-2 mt-2 mt-lg-0 position-relative" style="z-index:1100;">
                                        <button class="btn btn-outline-primary btn-sm rounded-circle d-flex align-items-center justify-content-center" id="playBtn" onclick="toggleTextToSpeech()" style="width: 38px; height: 38px;">
                                            <i class="fas fa-play fa-lg" id="playIcon"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm rounded-circle d-flex align-items-center justify-content-center" id="stopBtn" onclick="stopTextToSpeech()" style="width: 38px; height: 38px;">
                                            <i class="fas fa-stop fa-lg"></i>
                                        </button>
                                        <button class="btn btn-primary btn-sm rounded-circle d-flex align-items-center justify-content-center" id="shareBtn" onclick="showShareMenu()" style="width: 38px; height: 38px;" title="Chia sẻ">
                                            <i class="fas fa-share-alt fa-lg"></i>
                                        </button>
                                        <div id="shareMenu" style="display:none; position: absolute; top: 46px; right: 0; z-index: 1060; background: white; border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.18); padding: 18px 20px; min-width: 180px;">
                                            <div class="d-flex gap-2 justify-content-end">
                                                <button class="btn btn-primary btn-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;" onclick="shareOnFacebook()" title="Chia sẻ lên Facebook">
                                                    <i class="fab fa-facebook-f fa-lg"></i>
                                                </button>
                                                <button class="btn btn-info btn-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;" onclick="shareOnTwitter()" title="Chia sẻ lên Twitter">
                                                    <i class="fab fa-twitter fa-lg"></i>
                                                </button>
                                                <button class="btn btn-success btn-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;" onclick="copyLink()" title="Copy link">
                                                    <i class="fas fa-link fa-lg"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="font-size: 14px" class="blog-meta mt-3">
                                    <div class="blog-meta-item">
                                        <i class="fas fa-calendar-alt"></i>
                                        <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="blog-meta-item">
                                        <i class="fas fa-clock"></i>
                                        <fmt:formatDate value="${blog.created_at}" pattern="HH:mm"/>
                                    </div>
                                    <div class="blog-meta-item">
                                        <i class="fas fa-eye"></i>
                                        Đã xuất bản
                                    </div>
                                </div>
                            </div>

                            

                            <!-- Blog Content -->
                            <div class="blog-content">
                                <div class="blog-text">
                                    ${blog.content}
                                </div>
                            </div>

                            <!-- Blog Actions -->
                            <div class="blog-actions">
                                <a href="blog" class="btn-back">
                                    <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <div class="sidebar">
                            <!-- Related Posts -->
                            <div class="sidebar-card">
                                <h3 style="font-size: 16px" class="sidebar-title">
                                    <i class="fas fa-newspaper me-2"></i>Bài viết liên quan
                                </h3>
                                <c:choose>
                                    <c:when test="${not empty relatedBlogs}">
                                        <div class="related-posts">
                                            <c:forEach var="relatedBlog" items="${relatedBlogs}">
                                                <div class="related-post-item mb-3">
                                                    <div class="row g-2">
                                                        <div class="col-4">
                                                            <c:choose>
                                                                <c:when test="${not empty relatedBlog.imageUrl}">
                                                                    <img src="${relatedBlog.imageUrl}" alt="${relatedBlog.title}" 
                                                                         class="img-fluid rounded" 
                                                                         style="width: 100%; height: 60px; object-fit: cover;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="bg-light rounded d-flex align-items-center justify-content-center" 
                                                                         style="width: 100%; height: 60px;">
                                                                        <i class="fas fa-image text-muted"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div style="font-size: 14px" class="col-8">
                                                            <a href="blogDetail?id=${relatedBlog.blogID}" 
                                                               class="text-decoration-none text-dark">
                                                                <h6 style="font-size: 14px" class="mb-1 lh-sm" style="font-size: 0.85rem;">
                                                                    <c:choose>
                                                                        <c:when test="${fn:length(relatedBlog.title) > 50}">
                                                                            ${fn:substring(relatedBlog.title, 0, 50)}...
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${relatedBlog.title}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </h6>
                                                            </a>
                                                            <div style="font-size: 14px; margin-right: 5px" class="d-flex align-items-center">
                                                                <c:choose>
                                                                    <c:when test="${not empty relatedBlog.authorImage}">
                                                                        <img src="${relatedBlog.authorImage}" alt="${relatedBlog.authorName}" 
                                                                             class="rounded-circle me-1" 
                                                                             style="width: 16px; height: 16px; object-fit: cover;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="rounded-circle me-1 bg-primary d-flex align-items-center justify-content-center" 
                                                                             style="width: 16px; height: 16px; color: white; font-size: 8px;">
                                                                            ${fn:substring(relatedBlog.authorName, 0, 1)}
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <small style="font-size: 14px" class="text-muted" style="font-size: 0.7rem;">
                                                                    ${relatedBlog.authorName}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-muted">
                                            <i class="fas fa-newspaper" style="font-size: 2rem; margin-bottom: 15px;"></i>
                                            <p>Chưa có bài viết liên quan</p>
                                            <a href="blog" class="btn btn-primary btn-sm">
                                                Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Share Button Fixed đã được chuyển lên header -->
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="Common/Footer.jsp"/>
        
        <!-- Scripts -->
        <jsp:include page="Common/Js.jsp"/>
        
        <script>
            // Text to Speech functionality
            let isPlaying = false;
            let speechSynthesis = window.speechSynthesis;
            let currentUtterance = null;

            function toggleTextToSpeech() {
                const playBtn = document.getElementById('playBtn');
                const playIcon = document.getElementById('playIcon');
                if (!isPlaying) {
                    // Start playing
                    const blogContent = document.querySelector('.blog-text').innerText;
                    const blogTitle = document.querySelector('.blog-title').innerText;
                    const textToRead = blogTitle + ". " + blogContent;

                    currentUtterance = new SpeechSynthesisUtterance(textToRead);
                    currentUtterance.lang = 'vi-VN'; // Vietnamese
                    currentUtterance.rate = 0.9;
                    currentUtterance.pitch = 1;

                    currentUtterance.onstart = function() {
                        isPlaying = true;
                        playIcon.className = 'fas fa-pause';
                        playBtn.className = 'btn btn-warning btn-sm rounded-circle d-flex align-items-center justify-content-center';
                    };

                    currentUtterance.onend = function() {
                        isPlaying = false;
                        playIcon.className = 'fas fa-play';
                        playBtn.className = 'btn btn-outline-primary btn-sm rounded-circle d-flex align-items-center justify-content-center';
                    };

                    currentUtterance.onerror = function() {
                        isPlaying = false;
                        playIcon.className = 'fas fa-play';
                        playBtn.className = 'btn btn-outline-primary btn-sm rounded-circle d-flex align-items-center justify-content-center';
                        
                    };

                    speechSynthesis.speak(currentUtterance);
                } else {
                    // Stop playing
                    speechSynthesis.cancel();
                    isPlaying = false;
                    playIcon.className = 'fas fa-play';
                    playBtn.className = 'btn btn-outline-primary btn-sm rounded-circle d-flex align-items-center justify-content-center';
                }
            }

            function stopTextToSpeech() {
                if (speechSynthesis.speaking) {
                    speechSynthesis.cancel();
                    isPlaying = false;
                    const playBtn = document.getElementById('playBtn');
                    const playIcon = document.getElementById('playIcon');
                    playIcon.className = 'fas fa-play';
                    playBtn.className = 'btn btn-outline-primary btn-sm rounded-circle d-flex align-items-center justify-content-center';
                }
            }
            // Share menu popup logic
            function showShareMenu() {
                const menu = document.getElementById('shareMenu');
                if (menu.style.display === 'none' || menu.style.display === '') {
                    menu.style.display = 'block';
                    setTimeout(() => {
                        document.addEventListener('mousedown', hideShareMenuOnClickOutside);
                    }, 0);
                } else {
                    menu.style.display = 'none';
                    document.removeEventListener('mousedown', hideShareMenuOnClickOutside);
                }
            }

            function hideShareMenuOnClickOutside(e) {
                const menu = document.getElementById('shareMenu');
                const btn = document.getElementById('shareBtn');
                if (menu && !menu.contains(e.target) && (!btn || !btn.contains(e.target))) {
                    menu.style.display = 'none';
                    document.removeEventListener('mousedown', hideShareMenuOnClickOutside);
                }
            }
            
            // Social sharing functions
            function shareOnFacebook() {
                const url = encodeURIComponent(window.location.href);
                const title = encodeURIComponent('${blog.title}');
                window.open(`https://www.facebook.com/sharer/sharer.php?u=` + url, '_blank', 'width=600,height=400');
            }
            
            function shareOnTwitter() {
                const url = encodeURIComponent(window.location.href);
                const title = encodeURIComponent('${blog.title}');
                window.open(`https://twitter.com/intent/tweet?url=` + url + `&text=` + title, '_blank', 'width=600,height=400');
            }
            
            function copyLink() {
                navigator.clipboard.writeText(window.location.href).then(function() {
                    // Show success message
                    const btn = event.target.closest('button');
                    const originalHtml = btn.innerHTML;
                    btn.innerHTML = '<i class="fas fa-check"></i>';
                    btn.className = 'btn btn-success btn-sm w-100';
                    
                    setTimeout(() => {
                        btn.innerHTML = originalHtml;
                        btn.className = 'btn btn-success btn-sm w-100';
                    }, 2000);
                }, function(err) {
                    console.error('Không thể copy link: ', err);
                    alert('Không thể copy link. Vui lòng copy thủ công.');
                });
            }
            
            // Stop speech when page unloads
            window.addEventListener('beforeunload', function() {
                if (speechSynthesis.speaking) {
                    speechSynthesis.cancel();
                }
            });
        </script>
    </body>
</html>
