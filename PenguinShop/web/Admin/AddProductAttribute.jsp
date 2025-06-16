<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
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
        .group-product-select {
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
                            <h4 class="mb-sm-0 font-size-18">Thêm Thuộc Tính Sản Phẩm</h4>
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="#">Sản Phẩm</a></li>
                                <li class="breadcrumb-item active">Thêm Thuộc Tính</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Thông Tin Thuộc Tính</h4>
                                <p class="card-title-desc">Chọn nhóm sản phẩm và điền thông tin thuộc tính bên dưới. Các trường có dấu * là bắt buộc.</p>
                                <p>Thiếu thuộc tình màu sắc, kích cỡ ? <a href="managevariant"> Thêm ngay </a></p>
                            </div>
                            <div class="card-body">
                                <!-- Dropdown chọn nhóm sản phẩm -->
                                <div class="group-product-select">
                                    <label class="form-label" for="groupProductID">Nhóm Sản Phẩm *</label>
                                    <input class="form-control" id="groupProductID" name="groupProductID" value="${pv.productName}" readonly=""/>
                                        
                                    <span id="groupProductID-error" class="error-message" style="display: none;"></span>
                                </div>

                                <!-- Form thêm thuộc tính -->
                                <form id="attribute-form" method="post" action="addAttributeProduct">
                                    <input type="hidden" name="groupProductID" value="${pv.productId}"/>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="colorID">Màu Sắc *</label>
                                                <select class="form-control form-select" id="colorID" name="colorID">
                                                    <option value="">Chọn màu sắc</option>
                                                    <c:forEach var="color" items="${colors}">
                                                        <option value="${color.colorID}">${color.colorName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span id="colorID-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="sizeID">Kích Thước *</label>
                                                <select class="form-control form-select" id="sizeID" name="sizeID">
                                                    <option value="">Chọn kích thước</option>
                                                    <c:forEach var="size" items="${sizes}">
                                                        <option value="${size.sizeID}">${size.sizeName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span id="sizeID-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="price">Giá Tiền (VND) *</label>
                                                <input type="number" class="form-control" id="price" name="price" placeholder="Nhập giá tiền" step="0.01" min="0"/>
                                                <span id="price-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="stock">Số Lượng Tồn Kho *</label>
                                                <input type="number" class="form-control" id="stock" name="stock" placeholder="Nhập số lượng tồn kho" min="0"/>
                                                <span id="stock-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label" for="status">Tình Trạng *</label>
                                                <select class="form-control form-select" name="status">
                                                    <option value="">Chọn tình trạng</option>
                                                    <option value="1">Mở bán</option>
                                                    <option value="0">Chưa mở bán</option>
                                                </select>
                                                <span id="status-error" class="error-message" style="display: none;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary" type="submit">Thêm Thuộc Tính</button>
                                </form>
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
        function loadGroupProduct(groupProductID) {
            if (groupProductID) {
                window.location.href = 'addProductAttribute?groupProductID=' + groupProductID;
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('attribute-form');

            function showError(fieldId, message) {
                const errorSpan = document.getElementById(fieldId + '-error');
                if (errorSpan) {
                    errorSpan.textContent = message;
                    errorSpan.style.display = 'block';
                }
            }

            function hideError(fieldId) {
                const errorSpan = document.getElementById(fieldId + '-error');
                if (errorSpan) {
                    errorSpan.style.display = 'none';
                }
            }

            form.addEventListener('submit', function(e) {
                let isValid = true;
                const fields = ['colorID', 'sizeID', 'price', 'stock', 'status'];

                fields.forEach(field => {
                    const value = document.getElementById(field).value;
                    if (!value) {
                        showError(field, 'Trường này không được để trống!');
                        isValid = false;
                    } else {
                        hideError(field);
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>