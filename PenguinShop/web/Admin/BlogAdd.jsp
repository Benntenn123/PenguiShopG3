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
                                                <h4 class="mb-sm-0 font-size-18">Thêm Blog mới</h4>
                                                <ol class="breadcrumb m-0">
                                                    <li class="breadcrumb-item"><a href="#">Blog</a></li>
                                                    <li class="breadcrumb-item active">Thêm Blog</li>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h4 class="card-title">Thông Tin Blog</h4>
                                                    <p class="card-title-desc">Điền thông tin blog bên dưới. Các trường có dấu * là bắt buộc.</p>
                                                </div>
                                                <div class="card-body">
                                                    <form id="blog-form" action="BlogAdd" method="post" enctype="multipart/form-data">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="title">Tiêu đề bài viết *</label>
                                                                    <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề bài viết" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="image">Ảnh tiêu đề</label>
                                                                    <input type="file" class="form-control" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                                                                    <div id="imagePreview" class="mt-2">
                                                                        <img id="preview" style="display:none; max-width: 200px; max-height: 200px;" class="img-thumbnail"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <label class="form-label" for="content">Nội dung *</label>
                                                                    <div id="content-editor"></div>
                                                                    <textarea class="form-control" id="content" name="content" style="display: none;"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <button class="btn btn-primary" type="submit">Đăng bài</button>
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
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Khởi tạo CKEditor cho Nội dung blog
                let contentEditor;
                ClassicEditor
                    .create(document.querySelector('#content-editor'), {
                        placeholder: 'Nhập nội dung blog...',
                        extraPlugins: [CustomUploadAdapterPlugin],
                        toolbar: [
                            'heading', '|',
                            'bold', 'italic', '|',
                            'link', 'bulletedList', 'numberedList', '|',
                            'imageUpload', 'undo', 'redo'
                        ],
                        heading: {
                            options: [
                                {model: 'paragraph', title: 'Đoạn văn', class: 'ck-heading_paragraph'},
                                {model: 'heading1', view: 'h1', title: 'Tiêu đề 1', class: 'ck-heading_heading1'},
                                {model: 'heading2', view: 'h2', title: 'Tiêu đề 2', class: 'ck-heading_heading2'},
                                {model: 'heading3', view: 'h3', title: 'Tiêu đề 3', class: 'ck-heading_heading3'}
                            ]
                        }
                    })
                    .then(editor => {
                        contentEditor = editor;
                        editor.model.document.on('change:data', () => {
                            const html = editor.getData();
                            document.getElementById('content').value = html; // Lưu HTML
                        });
                    })
                    .catch(error => {
                        console.error('Khởi tạo CKEditor cho Nội dung thất bại:', error);
                    });

                // Xử lý preview hình ảnh
                function previewImage(event) {
                    const [file] = event.target.files;
                    const preview = document.getElementById('preview');
                    if (file) {
                        preview.src = URL.createObjectURL(file);
                        preview.style.display = 'inline-block';
                    } else {
                        preview.src = '';
                        preview.style.display = 'none';
                    }
                }
                
                // Gán function vào window để có thể gọi từ onchange
                window.previewImage = previewImage;
            });
        </script>
    </body>
</html>
