```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .tabs {
            display: flex;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }
        .tab-button {
            flex: 1;
            padding: 15px 20px;
            background: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
        }
        .tab-button.active {
            background: #5156be;
            color: white;
            border-bottom-color: #3d42a1;
        }
        .tab-content {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            min-height: 500px;
        }
        .tab-panel {
            display: none;
        }
        .tab-panel.active {
            display: block;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #5156be;
            padding-bottom: 15px;
        }
        .section-title {
            font-size: 24px;
            font-weight: 600;
            color: #5156be;
        }
        .add-form {
            background: #f8f9ff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 1px solid #e0e4ff;
        }
        .form-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .form-group input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #5156be;
            box-shadow: 0 0 0 3px rgba(81, 86, 190, 0.1);
        }
        .btn-primary {
            background: #5156be;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background: #3d42a1;
        }
        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        .item-card {
            background: white;
            border: 1px solid #e0e4ff;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .item-name {
            font-size: 18px;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .item-meta {
            color: #666;
            font-size: 14px;
        }
        .color-preview {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin: 0 auto 10px;
            border: 2px solid #ddd;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #ccc;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #5156be;
            margin-bottom: 8px;
        }
        .stat-label {
            color: #666;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        @media (max-width: 768px) {
            .container { padding: 10px; }
            .tabs { flex-direction: column; }
            .tab-content { padding: 20px; }
            .form-group { flex-direction: column; align-items: stretch; }
            .section-header { flex-direction: column; gap: 15px; align-items: stretch; }
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
                <!-- Start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                            <h4 class="mb-sm-0 font-size-18">Quản lí thuộc tính</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="listRequestSupport">Sản phẩm</a></li>
                                    <li class="breadcrumb-item active">Quản lí thuộc tính</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="margin-top: 50px" class="container">
                    <div class="stats">
                        <div class="stat-card">
                            <div class="stat-number">${sizes.size()}</div>
                            <div class="stat-label">Kích cỡ</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${colors.size()}</div>
                            <div class="stat-label">Màu Sắc</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${brands.size()}</div>
                            <div class="stat-label">Nhãn Hiệu</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${categories.size()}</div>
                            <div class="stat-label">Danh Mục</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${types.size()}</div>
                            <div class="stat-label">Loại sản phẩm</div>
                        </div>
                    </div>

                    <div class="tabs">
                        <button class="tab-button active" onclick="switchTab('sizes')">Kích cỡ</button>
                        <button class="tab-button" onclick="switchTab('colors')">Màu Sắc</button>
                        <button class="tab-button" onclick="switchTab('brands')">Nhãn hiệu</button>
                        <button class="tab-button" onclick="switchTab('categories')">Danh mục</button>
                        <button class="tab-button" onclick="switchTab('types')">Loại sản phẩm</button>
                    </div>

                    <div class="tab-content">
                        <!-- Size Tab -->
                        <div id="sizes-panel" class="tab-panel active">
                            <div class="section-header">
                                <h2 class="section-title">Quản Lý Kích Cỡ</h2>
                            </div>
                            <div class="add-form">
                                <div class="form-group">
                                    <input type="text" id="size-input" placeholder="Nhập tên size (VD: S, M, L, XL, 38, 39, 40...)">
                                    <button class="btn-primary" data-bs-toggle="modal" data-bs-target="#addSizeModal" onclick="addSize()">Thêm Kích Cỡ</button>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty sizes}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">📏</div>
                                        <p>Chưa có size nào được thêm</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="sizes-list" class="items-grid">
                                        <c:forEach var="size" items="${sizes}">
                                            <div class="item-card">
                                                <div class="item-name"><c:out value="${size.sizeName}"/></div>
                                                <div class="item-meta">Kích cỡ</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Colors Tab -->
                        <div id="colors-panel" class="tab-panel">
                            <div class="section-header">
                                <h2 class="section-title">Quản Lý Màu Sắc</h2>
                            </div>
                            <div class="add-form">
                                <div class="form-group">
                                    <input type="text" id="color-name-input" placeholder="Tên màu (VD: Đỏ, Xanh, Đen...)">
                                    
                                    <button class="btn-primary" data-bs-toggle="modal" data-bs-target="#addColorModal" onclick="addColor()">Thêm Màu</button>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty colors}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">🎨</div>
                                        <p>Chưa có màu sắc nào được thêm</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="colors-list" class="items-grid">
                                        <c:forEach var="color" items="${colors}">
                                            <div class="item-card">
                                                <div class="item-name"><c:out value="${color.colorName}"/></div>
                                                <div class="item-meta">Màu sắc</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Brands Tab -->
                        <div id="brands-panel" class="tab-panel">
                            <div class="section-header">
                                <h2 class="section-title">Quản Lý Nhãn Hiệu</h2>
                            </div>
                            <div class="add-form">
                                <div class="form-group">
                                    <input type="text" id="brand-input" placeholder="Tên thương hiệu (VD: Nike, Adidas, Gucci...)">
                                    <button class="btn-primary" data-bs-toggle="modal" data-bs-target="#addBrandModal" onclick="addBrand()">Thêm Nhãn Hiệu</button>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty brands}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">🏷️</div>
                                        <p>Chưa có thương hiệu nào được thêm</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="brands-list" class="items-grid">
                                        <c:forEach var="brand" items="${brands}">
                                            <div class="item-card">
                                                <img width="70px" height="50px" src="../api/img/${brand.logo}"/>
                                                <div class="item-name"><c:out value="${brand.brandName}"/></div>
                                                <div class="item-meta">Thương hiệu</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Categories Tab -->
                        <div id="categories-panel" class="tab-panel">
                            <div class="section-header">
                                <h2 class="section-title">Quản Lý Danh Mục</h2>
                            </div>
                            <div class="add-form">
                                <div class="form-group">
                                    <input type="text" id="category-input" placeholder="Tên danh mục (VD: Áo thun, Quần jean, Giày sneaker...)">
                                    <button class="btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal" onclick="addCategory()">Thêm Danh Mục</button>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">📂</div>
                                        <p>Chưa có danh mục nào được thêm</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="categories-list" class="items-grid">
                                        <c:forEach var="category" items="${categories}">
                                            <div class="item-card">
                                                <img width="70px" height="70px" style="border-radius: 50px" src="../api/img/${category.imageCategory}"/>
                                                <div class="item-name"><c:out value="${category.categoryName}"/></div>
                                                <div class="item-meta">Danh mục</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Product Types Tab -->
                        <div id="types-panel" class="tab-panel">
                            <div class="section-header">
                                <h2 class="section-title">Quản Lý Loại Sản Phẩm</h2>
                            </div>
                            <div class="add-form">
                                <div class="form-group">
                                    <input type="text" id="type-input" placeholder="Loại sản phẩm (VD: Thời trang nam, Thời trang nữ, Phụ kiện...)">
                                    <button class="btn-primary" data-bs-toggle="modal" data-bs-target="#addProductTypeModal" onclick="addType()">Thêm Loại Sản Phẩm</button>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty types}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">🏪</div>
                                        <p>Chưa có loại sản phẩm nào được thêm</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="types-list" class="items-grid">
                                        <c:forEach var="type" items="${types}">
                                            <div class="item-card">
                                                <div class="item-name"><c:out value="${type.typeName}"/></div>
                                                <div class="item-meta">Loại sản phẩm</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                    </div>
                    <div class="modal fade" id="addSizeModal" tabindex="-1" aria-labelledby="addSizeModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addSizeModalLabel">Thêm Kích Cỡ</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="add-size" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="sizeName" class="form-label">Tên Kích Cỡ</label>
                                            <input type="text" class="form-control" id="sizeName" name="sizeName" placeholder="VD: S, M, L, 38..." required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" style="background-color: #5156be " class="btn btn-secondary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Add Color Modal -->
                    <div class="modal fade" id="addColorModal" tabindex="-1" aria-labelledby="addColorModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addColorModalLabel">Thêm Màu Sắc</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="add-color" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="colorName" class="form-label">Tên Màu</label>
                                            <input type="text" class="form-control" id="colorName" name="colorName" placeholder="VD: Đỏ, Xanh..." required>
                                        </div>
                                        
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Add Brand Modal -->
                    <div class="modal fade" id="addBrandModal" tabindex="-1" aria-labelledby="addBrandModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addBrandModalLabel">Thêm Nhãn Hiệu</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="/PenguinShop/admin/add-brand" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="brandName" class="form-label">Tên Nhãn Hiệu</label>
                                            <input type="text" class="form-control" id="brandName" name="brandName" placeholder="VD: Nike, Adidas..." required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Add Category Modal -->
                    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addCategoryModalLabel">Thêm Danh Mục</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="/PenguinShop/admin/add-category" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="categoryName" class="form-label">Tên Danh Mục</label>
                                            <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="VD: Áo thun, Quần jean..." required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Add Product Type Modal -->
                    <div class="modal fade" id="addProductTypeModal" tabindex="-1" aria-labelledby="addProductTypeModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addProductTypeModalLabel">Thêm Loại Sản Phẩm</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="/PenguinShop/admin/add-product-type" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="typeName" class="form-label">Tên Loại Sản Phẩm</label>
                                            <input type="text" class="form-control" id="typeName" name="typeName" placeholder="VD: Thời trang nam, Phụ kiện..." required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
        </div>

        <script>
            // Tab switching
            function switchTab(tabName) {
                document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
                event.target.classList.add('active');
                document.querySelectorAll('.tab-panel').forEach(panel => panel.classList.remove('active'));
                document.getElementById(tabName + '-panel').classList.add('active');
            }

            // Temporary client-side data for add functions
            let data = {
                sizes: [],
                colors: [],
                brands: [],
                categories: [],
                types: []
            };

            // Add functions (to be synced with DB via API later)
            function addSize() {
                const input = document.getElementById('size-input');
                const value = input.value.trim();
                if (value && !data.sizes.includes(value)) {
                    data.sizes.push(value);
                    input.value = '';
                    // TODO: Call API to save to DB
                    location.reload(); // Reload to reflect DB changes
                }
            }

            function addColor() {
                const nameInput = document.getElementById('color-name-input');
                const valueInput = document.getElementById('color-value-input');
                const name = nameInput.value.trim();
                const value = valueInput.value;
                if (name && !data.colors.find(c => c.name === name)) {
                    data.colors.push({ name, value });
                    nameInput.value = '';
                    valueInput.value = '#ff0000';
                    // TODO: Call API to save to DB
                    location.reload();
                }
            }

            function addBrand() {
                const input = document.getElementById('brand-input');
                const value = input.value.trim();
                if (value && !data.brands.includes(value)) {
                    data.brands.push(value);
                    input.value = '';
                    // TODO: Call API to save to DB
                    location.reload();
                }
            }

            function addCategory() {
                const input = document.getElementById('category-input');
                const value = input.value.trim();
                if (value && !data.categories.includes(value)) {
                    data.categories.push(value);
                    input.value = '';
                    // TODO: Call API to save to DB
                    location.reload();
                }
            }

            function addType() {
                const input = document.getElementById('type-input');
                const value = input.value.trim();
                if (value && !data.types.includes(value)) {
                    data.types.push(value);
                    input.value = '';
                    // TODO: Call API to save to DB
                    location.reload();
                }
            }

            // Handle Enter key press
            document.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    const activePanel = document.querySelector('.tab-panel.active');
                    const id = activePanel.id;
                    switch (id) {
                        case 'sizes-panel': addSize(); break;
                        case 'colors-panel': addColor(); break;
                        case 'brands-panel': addBrand(); break;
                        case 'categories-panel': addCategory(); break;
                        case 'types-panel': addType(); break;
                    }
                }
            });
        </script>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
</body>
</html>
```