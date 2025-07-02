<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <style>
        .ck-editor__editable_inline {
            min-height: 150px;
            max-height: 300px;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 5px;
            display: block;
        }
        .success-message {
            color: #28a745;
            font-size: 0.875em;
            margin-bottom: 10px;
        }
        .img-thumbnail {
            max-width: 200px;
            max-height: 200px;
        }
    </style>
</head>
<body>
<div id="layout-wrapper">
    <fmt:setLocale value="vi_VN"/>
    <jsp:include page="Common/Header.jsp"/>
    <jsp:include page="Common/LeftSideBar.jsp"/>

    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                            <h4 class="mb-sm-0 font-size-18">Chỉnh Sửa Sản Phẩm</h4>
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="product">Sản Phẩm</a></li>
                                <li class="breadcrumb-item active">Chỉnh Sửa Sản Phẩm</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Thông Tin Sản Phẩm</h4>
                                <p class="card-title-desc">Chỉnh sửa thông tin sản phẩm bên dưới. Các trường có dấu * là bắt buộc.</p>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty successMessage}">
                                    <div class="success-message">${successMessage}</div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="error-message">${errorMessage}</div>
                                </c:if>
                                <form id="product-form" method="post" action="${pageContext.request.contextPath}/admin/editGroupProduct" enctype="multipart/form-data">
                                    <input type="hidden" name="productID" value="${product.productId}">
                                    <input type="hidden" name="existingImage" value="${product.imageMainProduct}">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="productName">Tên Sản Phẩm *</label>
                                                <input type="text" class="form-control" id="productName" name="productName" placeholder="Nhập tên sản phẩm" value="${product.productName}" />
                                                <span id="productName-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="productTypeID">Loại Sản Phẩm *</label>
                                                <select class="form-control form-select" id="productTypeID" name="productTypeID">
                                                    <option value="">Chọn loại sản phẩm</option>
                                                    <c:forEach var="type" items="${types}">
                                                        <option value="${type.typeId}" ${type.typeId == product.type.typeId ? 'selected' : ''}>${type.typeName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span id="productTypeID-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="brandID">Thương Hiệu *</label>
                                                <select class="form-control form-select" id="brandID" name="brandID">
                                                    <option value="">Chọn thương hiệu</option>
                                                    <c:forEach var="brand" items="${brands}">
                                                        <option value="${brand.brandID}" ${brand.brandID == product.brand.brandID ? 'selected' : ''}>${brand.brandName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span id="brandID-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="categories">Danh Mục *</label>
                                                <select style="width: 500px" class="form-control form-select" id="categories" name="categories" multiple>
                                                    <c:forEach var="cate" items="${cates}">
                                                        <option value="${cate.categoryId}"
                                                                <c:forEach var="productCate" items="${product.categories}">
                                                                    <c:if test="${productCate.categoryId == cate.categoryId}">selected</c:if>
                                                                </c:forEach>>
                                                            ${cate.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <span id="categories-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="imageMainProduct">Hình Ảnh Chính</label>
                                                <input type="file" class="form-control" id="imageMainProduct" name="imageMainProduct" accept="image/*" />
                                                <span id="imageMainProduct-error" class="error-message" style="display: none;"></span>
                                                <div id="imagePreview" class="mt-2">
                                                    <c:if test="${not empty product.imageMainProduct}">
                                                        <img src="../api/img/${product.imageMainProduct}" alt="Hình ảnh chính" class="img-thumbnail" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label" for="description">Mô Tả Ngắn *</label>
                                                <div id="description-editor">${product.description}</div>
                                                <textarea class="form-control" id="description" name="description" style="display: none;">${product.description}</textarea>
                                                <span id="description-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label" for="full_description">Mô Tả Chi Tiết</label>
                                                <div id="full-description-editor">${product.full_description}</div>
                                                <textarea class="form-control" id="full_description" name="full_description" style="display: none;">${product.full_description}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <button class="btn btn-primary" type="submit">Cập Nhật Sản Phẩm</button>
                                        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Hủy</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6">
                        <script>document.write(new Date().getFullYear())</script> © Minia.
                    </div>
                    <div class="col-sm-6">
                        <div class="text-sm-end d-none d-sm-block">
                            Thiết kế & Phát triển bởi <a href="#!" class="text-decoration-underline">Themesbrand</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <jsp:include page="Common/RightSideBar.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
    <script src="../Admin/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
    <script src="../Admin/assets/js/ckeditor-upload-adapter.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            if (typeof toastr === 'undefined') {
                console.error('Toastr is not defined. Please check if toastr.js is included.');
            } else {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    positionClass: 'toast-top-right',
                    timeOut: 3000,
                    preventDuplicates: true,
                    showMethod: 'slideDown',
                    hideMethod: 'slideUp'
                };
            }

            function htmlToPlainText(html) {
                const div = document.createElement('div');
                div.innerHTML = html;
                return div.textContent || div.innerText || '';
            }

            function showError(fieldId, message) {
                const errorSpan = document.getElementById(fieldId + '-error');
                if (errorSpan) {
                    errorSpan.textContent = message;
                    errorSpan.style.display = 'block';
                }
                console.log('Lỗi ' + fieldId + ': ' + message);
            }

            function hideError(fieldId) {
                const errorSpan = document.getElementById(fieldId + '-error');
                if (errorSpan) {
                    errorSpan.style.display = 'none';
                }
            }

            function hideAllErrors() {
                const errorSpans = document.querySelectorAll('.error-message');
                errorSpans.forEach(span => span.style.display = 'none');
            }

            const initialCategories = Array.from(document.querySelector('#categories').selectedOptions).map(option => option.value);

            let descriptionEditor;
            ClassicEditor
                .create(document.querySelector('#description-editor'), {
                    placeholder: 'Nhập mô tả ngắn (tối đa 500 ký tự)...',
                    toolbar: ['heading', '|', 'bold', 'italic', '|', 'link', 'bulletedList', 'numberedList', '|', 'undo', 'redo'],
                    heading: {
                        options: [
                            {model: 'paragraph', title: 'Đoạn văn', class: 'ck-heading_paragraph'},
                            {model: 'heading3', view: 'h3', title: 'Tiêu đề 3', class: 'ck-heading_heading3'}
                        ]
                    }
                })
                .then(editor => {
                    descriptionEditor = editor;
                    editor.model.document.on('change:data', () => {
                        const html = editor.getData();
                        const plainText = htmlToPlainText(html);
                        document.getElementById('description').value = plainText;
                        if (plainText.length > 500) {
                            showError('description', 'Mô tả ngắn vượt quá 500 ký tự!');
                        } else {
                            hideError('description');
                        }
                    });
                })
                .catch(error => {
                    console.error('Khởi tạo CKEditor cho Mô Tả Ngắn thất bại:', error);
                });

            let fullDescriptionEditor;
            ClassicEditor
                .create(document.querySelector('#full-description-editor'), {
                    placeholder: 'Nhập mô tả chi tiết...',
                    extraPlugins: [CustomUploadAdapterPlugin],
                    toolbar: ['heading', '|', 'bold', 'italic', '|', 'link', 'bulletedList', 'numberedList', '|', 'imageUpload', 'undo', 'redo'],
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
                    fullDescriptionEditor = editor;
                    editor.model.document.on('change:data', () => {
                        const html = editor.getData();
                        document.getElementById('full_description').value = html;
                    });
                })
                .catch(error => {
                    console.error('Khởi tạo CKEditor cho Mô Tả Chi Tiết thất bại:', error);
                });

            document.getElementById('imageMainProduct').addEventListener('change', function(e) {
                const file = e.target.files[0];
                const preview = document.getElementById('imagePreview');
                preview.innerHTML = '';
                hideError('imageMainProduct');

                if (file) {
                    if (file.size > 5 * 1024 * 1024) {
                        showError('imageMainProduct', 'Kích thước hình ảnh không được vượt quá 5MB');
                        e.target.value = '';
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.className = 'img-thumbnail';
                        preview.appendChild(img);
                        if (typeof toastr !== 'undefined') {
                            toastr.info('Hình ảnh chính đã được thay đổi!');
                        }
                    };
                    reader.readAsDataURL(file);
                }
            });

            document.getElementById('categories').addEventListener('change', function() {
                const currentCategories = Array.from(this.selectedOptions).map(option => option.value);
                if (JSON.stringify(currentCategories) !== JSON.stringify(initialCategories)) {
                    if (typeof toastr !== 'undefined') {
                        toastr.info('Danh mục đã được thay đổi!');
                    }
                }
            });

            document.getElementById('product-form').addEventListener('submit', function(e) {
                hideAllErrors();

                const productName = document.getElementById('productName').value.trim();
                const productTypeID = document.getElementById('productTypeID').value;
                const brandID = document.getElementById('brandID').value;
                const categories = document.getElementById('categories').selectedOptions;
                const description = htmlToPlainText(descriptionEditor.getData()).trim();

                let hasError = false;
                if (!productName) {
                    showError('productName', 'Vui lòng nhập tên sản phẩm');
                    hasError = true;
                }
                if (!productTypeID) {
                    showError('productTypeID', 'Vui lòng chọn loại sản phẩm');
                    hasError = true;
                }
                if (!brandID) {
                    showError('brandID', 'Vui lòng chọn thương hiệu');
                    hasError = true;
                }
                if (categories.length === 0) {
                    showError('categories', 'Vui lòng chọn ít nhất một danh mục');
                    hasError = true;
                }
                if (!description) {
                    showError('description', 'Vui lòng nhập mô tả ngắn');
                    hasError = true;
                } else if (description.length > 500) {
                    showError('description', 'Mô tả ngắn vượt quá 500 ký tự');
                    hasError = true;
                }

                if (hasError) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>