<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <!-- Page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Chỉnh sửa Banner</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listBanner">Danh sách Banner</a></li>
                                            <li class="breadcrumb-item active">Chỉnh sửa Banner</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Edit form -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Thông tin Banner</h4>
                                    </div>
                                    <div class="card-body">
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger">${error}</div>
                                        </c:if>
                                        
                                        <form method="post" action="editBanner" enctype="multipart/form-data">
                                            <input type="hidden" name="bannerID" value="${banner.bannerID}"/>
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label for="bannerName" class="form-label">Tên Banner <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="bannerName" name="bannerName" 
                                                               value="${banner.bannerName}" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label for="bannerHref" class="form-label">Đường dẫn Href <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="bannerHref" name="bannerHref" 
                                                               value="${banner.bannerHref}">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label for="bannerImageFile" class="form-label">Chọn hình ảnh mới</label>
                                                        <input type="file" class="form-control" id="bannerImageFile" name="bannerImageFile" 
                                                               accept="image/*" onchange="previewImage(this)">
                                                        <small class="text-muted">Để trống nếu không muốn thay đổi hình ảnh</small>
                                                        <input type="hidden" name="currentBannerLink" value="${banner.bannerLink}">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label for="bannerStatus" class="form-label">Trạng thái</label>
                                                        <select class="form-select" id="bannerStatus" name="bannerStatus">
                                                            <option value="1" ${banner.bannerStatus == 1 ? 'selected' : ''}>Hoạt động</option>
                                                            <option value="0" ${banner.bannerStatus == 0 ? 'selected' : ''}>Không hoạt động</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${not empty banner.bannerLink}">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Hình ảnh hiện tại</label>
                                                            <div>
                                                                <img id="currentImage" src="../api/img/${banner.bannerLink}" alt="Banner" style="max-width:300px;max-height:150px;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            
                                            <!-- Preview new image -->
                                            <div class="row" id="imagePreviewRow" style="display:none;">
                                                <div class="col-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Hình ảnh mới (Preview)</label>
                                                        <div>
                                                            <img id="imagePreview" src="#" alt="Preview" style="max-width:300px;max-height:150px;"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="d-flex justify-content-end">
                                                <a href="listBanner" class="btn btn-secondary me-2">Hủy</a>
                                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>
            function previewImage(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('imagePreview').src = e.target.result;
                        document.getElementById('imagePreviewRow').style.display = 'block';
                    };
                    reader.readAsDataURL(input.files[0]);
                } else {
                    document.getElementById('imagePreviewRow').style.display = 'none';
                }
            }
        </script>
    </body>
</html>
