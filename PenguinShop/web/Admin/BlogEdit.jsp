<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <script src="../Admin/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
        <script src="../Admin/assets/js/ckeditor-upload-adapter.js"></script>
        <style>
            .ck-editor__editable_inline {
                min-height: 300px;
                max-height: 500px;
            }
            .current-image-preview {
                max-width: 200px;
                max-height: 150px;
                object-fit: cover;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 10px;
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
                        <div class="row justify-content-center">
                            <div class="col-lg-12 col-md-12">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                                <h4 class="mb-sm-0 font-size-18">Chỉnh sửa Blog</h4>
                                                <ol class="breadcrumb m-0">
                                                    <li class="breadcrumb-item"><a href="BlogList">Blog</a></li>
                                                    <li class="breadcrumb-item active">Chỉnh sửa</li>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Alert Messages -->
                                    <c:if test="${not empty sessionScope.ms}">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                    ${sessionScope.ms}
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                                </div>
                                            </div>
                                        </div>
                                        <c:remove var="ms" scope="session"/>
                                    </c:if>
                                    
                                    <c:if test="${not empty sessionScope.error}">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                    ${sessionScope.error}
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                                </div>
                                            </div>
                                        </div>
                                        <c:remove var="error" scope="session"/>
                                    </c:if>
                                    
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h4 class="card-title">Chỉnh sửa Blog</h4>
                                                    <p class="card-title-desc">Cập nhật thông tin blog. Các trường có dấu * là bắt buộc.</p>
                                                </div>
                                                <div class="card-body">
                                                    <form id="blog-form" action="BlogEdit" method="post" enctype="multipart/form-data">
                                                        <input type="hidden" name="blogId" value="${blog.blogID}">
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="title">Tiêu đề bài viết *</label>
                                                                    <input type="text" class="form-control" id="title" name="title" 
                                                                           value="${blog.title}" placeholder="Nhập tiêu đề bài viết" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="image">Ảnh tiêu đề</label>
                                                                    
                                                                    <!-- Current Image Preview -->
                                                                    <c:if test="${not empty currentImageUrl}">
                                                                        <div class="mb-2">
                                                                            <p class="text-muted mb-1">Ảnh hiện tại:</p>
                                                                            <img src="${currentImageUrl}" alt="Current Image" class="current-image-preview">
                                                                        </div>
                                                                    </c:if>
                                                                    
                                                                    <input type="file" class="form-control" id="image" name="image" 
                                                                           accept="image/*" onchange="previewImage(event)">
                                                                    <small class="text-muted">Chọn ảnh mới để thay thế ảnh hiện tại (không bắt buộc)</small>
                                                                    <div id="imagePreview" class="mt-2">
                                                                        <!-- New image preview will appear here -->
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="content">Nội dung bài viết *</label>
                                                                    <textarea class="form-control" id="content" name="content" rows="10" required>${blog.content}</textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="d-flex justify-content-between">
                                                                    <a href="BlogList" class="btn btn-secondary">
                                                                        <i class="mdi mdi-arrow-left"></i> Quay lại danh sách
                                                                    </a>
                                                                    <button class="btn btn-primary" type="submit">
                                                                        <i class="mdi mdi-content-save"></i> Cập nhật bài viết
                                                                    </button>
                                                                </div>
                                                            </div>
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
            </div>
            <jsp:include page="Common/RightSideBar.jsp"/>
        </div>

        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize CKEditor
                ClassicEditor
                    .create(document.querySelector('#content'), {
                        toolbar: [
                            'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|',
                            'outdent', 'indent', '|', 'blockQuote', 'insertTable', 'mediaEmbed', '|',
                            'imageUpload', 'undo', 'redo'
                        ],
                        image: {
                            toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                        }
                    })
                    .then(editor => {
                        console.log('CKEditor initialized for blog edit');
                        
                        // Add custom upload adapter
                        if (typeof MyUploadAdapter !== 'undefined') {
                            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                                return new MyUploadAdapter(loader);
                            };
                        }
                    })
                    .catch(error => {
                        console.error('CKEditor initialization error:', error);
                    });

                // Image preview function
                function previewImage(event) {
                    const file = event.target.files[0];
                    const preview = document.getElementById('imagePreview');
                    
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            preview.innerHTML = `
                                <p class="text-muted mb-1">Ảnh mới (xem trước):</p>
                                <img src="\${e.target.result}" alt="New Image Preview" class="current-image-preview">
                            `;
                        };
                        reader.readAsDataURL(file);
                    } else {
                        preview.innerHTML = '';
                    }
                }
                
                // Make function globally available
                window.previewImage = previewImage;
            });
        </script>
    </body>
</html>
