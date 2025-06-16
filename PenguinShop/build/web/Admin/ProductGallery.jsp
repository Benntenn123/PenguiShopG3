<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .gallery-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .gallery-item {
            position: relative;
            width: 150px;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .delete-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 14px;
        }
        .delete-btn:hover {
            background: #c82333;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 5px;
            display: block;
        }
        .add-image-container {
            margin-bottom: 20px;
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
                            <h4 class="mb-sm-0 font-size-18">Quản Lý Gallery Sản Phẩm</h4>
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="#">Sản Phẩm</a></li>
                                <li class="breadcrumb-item active">Gallery</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Gallery Sản Phẩm: ${product.productName}</h4>
                                <p class="card-title-desc">Thêm hoặc xóa ảnh trong gallery sản phẩm. Nhấn vào dấu X để xóa ảnh.</p>
                            </div>
                            <div class="card-body">
                                <!-- Form thêm ảnh -->
                                <div class="add-image-container">
                                    <form id="add-image-form" method="post" action="addGalleryImage" enctype="multipart/form-data">
                                        <input type="hidden" name="productID" value="${product.productId}"/>
                                        <div class="mb-3">
                                            <label class="form-label" for="imageFile">Chọn Ảnh *</label>
                                            <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*"/>
                                            <span id="imageFile-error" class="error-message" style="display: none;"></span>
                                        </div>
                                        <button class="btn btn-primary" type="submit">Thêm Ảnh</button>
                                    </form>
                                </div>

                                <!-- Danh sách ảnh -->
                                <div class="gallery-container">
                                    <c:forEach var="image" items="${galleryImages}">
                                        <div class="gallery-item">
                                            <img src="../api/img/${image}" alt="Gallery Image"/>
                                            <button class="delete-btn" data-image-url="${image}" data-product-id="${product.productId}">X</button>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

    <jsp:include page="Common/RightSideBar.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Binding sự kiện xóa
            const deleteButtons = document.querySelectorAll('.delete-btn');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const imageUrl = this.getAttribute('data-image-url');
                    const productID = this.getAttribute('data-product-id');
                    if (confirm('Bạn có chắc chắn muốn xóa ảnh này khỏi gallery?')) {
                        window.location.href = 'deleteGalleryImage?imageUrl=' + encodeURIComponent(imageUrl) + '&productID=' + productID;
                    }
                });
            });

            // Validate form thêm ảnh
            const form = document.getElementById('add-image-form');
            form.addEventListener('submit', function(e) {
                const imageFile = document.getElementById('imageFile').value;
                if (!imageFile) {
                    e.preventDefault();
                    document.getElementById('imageFile-error').textContent = 'Vui lòng chọn một file ảnh!';
                    document.getElementById('imageFile-error').style.display = 'block';
                } else if (!confirm('Bạn có chắc chắn muốn thêm ảnh này vào gallery?')) {
                    e.preventDefault();
                } else {
                    document.getElementById('imageFile-error').style.display = 'none';
                }
            });

           
        });
    </script>
</body>
</html>