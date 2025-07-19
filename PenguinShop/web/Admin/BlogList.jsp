<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .blog-thumbnail {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: 4px;
            }
            .status-active {
                background-color: #28a745;
                color: white;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.875rem;
            }
            .status-inactive {
                background-color: #6c757d;
                color: white;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.875rem;
            }
            .blog-content-preview {
                max-width: 300px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <!-- Breadcrumb -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Quản lý Blog</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="#">Blog</a></li>
                                            <li class="breadcrumb-item active">Danh sách Blog</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Search and Actions -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h4 class="card-title mb-0">
                                                Danh sách Blog 
                                                <c:if test="${sessionScope.uAdmin.roleID != 1}">
                                                    (Của tôi)
                                                </c:if>
                                            </h4>
                                            <a href="BlogAdd" class="btn btn-primary">
                                                <i class="mdi mdi-plus"></i> Thêm Blog Mới
                                            </a>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <!-- Search Form -->
                                        <form method="get" action="BlogList" class="mb-3">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label class="form-label">Tìm theo tiêu đề</label>
                                                    <input type="text" class="form-control" name="searchTitle" 
                                                           value="${searchTitle}" placeholder="Nhập tiêu đề blog...">
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="form-label">Trạng thái</label>
                                                    <select class="form-select" name="searchStatus">
                                                        <option value="">Tất cả</option>
                                                        <option value="1" ${searchStatus == '1' ? 'selected' : ''}>Hoạt động</option>
                                                        <option value="0" ${searchStatus == '0' ? 'selected' : ''}>Không hoạt động</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="form-label">Ngày tạo</label>
                                                    <input type="date" class="form-control" name="searchDate" value="${searchDate}">
                                                </div>
                                                <div class="col-md-2 d-flex align-items-end">
                                                    <button type="submit" class="btn btn-primary me-2">
                                                        <i class="mdi mdi-magnify"></i> Tìm kiếm
                                                    </button>
                                                    <a href="BlogList" class="btn btn-secondary">
                                                        <i class="mdi mdi-refresh"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </form>

                                        <!-- Blog List -->
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th >ID</th>
                                                        <th >Ảnh</th>
                                                        <th>Tiêu đề</th>
                                                        
                                                        <th >Ngày tạo</th>
                                                        <th >Trạng thái</th>
                                                        <th >Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${empty blogs}">
                                                            <tr>
                                                                <td colspan="7" class="text-center py-4">
                                                                    <div class="text-muted">
                                                                        <i class="mdi mdi-inbox-outline" style="font-size: 48px;"></i>
                                                                        <p class="mt-2 mb-0">Không có blog nào</p>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="blog" items="${blogs}">
                                                                <tr>
                                                                    <td class="text-center">${blog.blogID}</td>
                                                                    <td class="text-center">
                                                                        <c:choose>
                                                                            <c:when test="${not empty blog.image}">
                                                                                <img src="../api/img/${blog.image}" alt="Blog Image" class="blog-thumbnail" 
                                                                                     >
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="blog-thumbnail bg-light d-flex align-items-center justify-content-center">
                                                                                    <i class="mdi mdi-image-off text-muted"></i>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <strong>${blog.title}</strong>
                                                                    </td>
                                                                    
                                                                    <td>
                                                                        <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <c:choose>
                                                                            <c:when test="${blog.status == 1}">
                                                                                <span class="status-active">Hoạt động</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="status-inactive">Không hoạt động</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="btn-group" role="group">
                                                                            <!-- Edit Button -->
                                                                            <a href="BlogEdit?id=${blog.blogID}" class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                                                <i class="mdi mdi-pencil"></i>
                                                                            </a>
                                                                            
                                                                            <!-- Status Toggle -->
                                                                            <c:choose>
                                                                                <c:when test="${blog.status == 1}">
                                                                                    <a href="BlogToggleStatus?id=${blog.blogID}" 
                                                                                       class="btn btn-sm btn-outline-warning" 
                                                                                       onclick="return confirm('Bạn có chắc chắn muốn vô hiệu hóa blog này?')" 
                                                                                       title="Vô hiệu hóa">
                                                                                        <i class="mdi mdi-eye-off"></i>
                                                                                    </a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a href="BlogToggleStatus?id=${blog.blogID}" 
                                                                                       class="btn btn-sm btn-outline-success" 
                                                                                       onclick="return confirm('Bạn có chắc chắn muốn kích hoạt blog này?')" 
                                                                                       title="Kích hoạt">
                                                                                        <i class="mdi mdi-eye"></i>
                                                                                    </a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            
                                                                            <!-- Delete Button -->
                                                                            <a href="BlogDelete?id=${blog.blogID}" 
                                                                               class="btn btn-sm btn-outline-danger" 
                                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa blog này? Thao tác này không thể hoàn tác.')" 
                                                                               title="Xóa">
                                                                                <i class="mdi mdi-delete"></i>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Pagination -->
                                        <c:if test="${totalPages > 1}">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination justify-content-center">
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="?page=${currentPage - 1}&searchTitle=${searchTitle}&searchStatus=${searchStatus}&searchDate=${searchDate}">
                                                                Trước
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
                                                                    <a class="page-link" href="?page=${i}&searchTitle=${searchTitle}&searchStatus=${searchStatus}&searchDate=${searchDate}">
                                                                        ${i}
                                                                    </a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="?page=${currentPage + 1}&searchTitle=${searchTitle}&searchStatus=${searchStatus}&searchDate=${searchDate}">
                                                                Sau
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </c:if>

                                        <!-- Results Info -->
                                        <div class="d-flex justify-content-between align-items-center mt-3">
                                            <div class="text-muted">
                                                Hiển thị blog ${((currentPage - 1) * 10) + 1} - ${currentPage * 10 > totalBlogs ? totalBlogs : currentPage * 10} 
                                                trong tổng số ${totalBlogs} blog
                                                <c:if test="${sessionScope.uAdmin.roleID != 1}">
                                                    của bạn
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
        </div>

        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
    </body>
</html>
