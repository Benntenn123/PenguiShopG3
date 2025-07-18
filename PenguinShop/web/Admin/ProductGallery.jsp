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
                cursor: pointer;
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
                z-index: 10;
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
            .preview-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
                min-height: 100px;
                border: 1px dashed #ddd;
                padding: 10px;
                background-color: #f9f9f9;
            }
            .preview-item {
                position: relative;
                width: 100px;
                height: 100px;
                border: 1px solid #ddd;
                border-radius: 5px;
                overflow: hidden;
            }
            .preview-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .remove-preview-btn {
                position: absolute;
                top: 5px;
                right: 5px;
                background: #dc3545;
                color: white;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 12px;
            }
            .remove-preview-btn:hover {
                background: #c82333;
            }
            #imageModal .modal-dialog {
                max-width: 80vw;
            }
            #imageModal img {
                width: 100%;
                height: auto;
                max-height: 80vh;
                object-fit: contain;
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
                                        <p class="card-title-desc">Thêm hoặc xóa ảnh trong gallery sản phẩm. Nhấn vào dấu X để xóa ảnh, nhấn vào ảnh để xem lớn.</p>
                                    </div>
                                    <div class="card-body">
                                        <!-- Form thêm ảnh -->
                                        <div class="add-image-container">
                                            <form id="add-image-form" method="post" action="addGalleryImage" enctype="multipart/form-data">
                                                <input type="hidden" name="productID" value="${product.productId}"/>
                                                <div class="mb-3">
                                                    <label class="form-label" for="imageFile">Chọn Ảnh (có thể chọn nhiều ảnh) *</label>
                                                    <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" multiple/>
                                                    <span id="imageFile-error" class="error-message" style="display: none;"></span>
                                                </div>
                                                <div class="preview-container" id="preview-container"></div>
                                                <button class="btn btn-primary" type="submit">Thêm Ảnh</button>
                                            </form>
                                        </div>

                                        <!-- Danh sách ảnh -->
                                        <div class="gallery-container">
                                            <c:forEach var="image" items="${galleryImages}">
                                                <div class="gallery-item">
                                                    <img src="../api/img/${image}" alt="Gallery Image" onerror="this.src='/path/to/fallback-image.jpg'; console.error('Failed to load image: ../api/img/${image}');" onclick="openImageModal('../api/img/${image}')"/>
                                                    <button class="delete-btn" data-image-url="${image}" data-product-id="${product.productId}" onclick="event.stopPropagation(); deleteImage('${image}', ${product.productId});">X</button>
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

            <!-- Modal xem ảnh -->
            <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="imageModalLabel">Xem Ảnh</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <img id="modalImage" src="" alt="Large Image"/>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="Common/RightSideBar.jsp"/>
            <jsp:include page="Common/Js.jsp"/>
            <jsp:include page="Common/Message.jsp"/>

            <script>
function openImageModal(imageUrl) {
    document.getElementById('modalImage').src = imageUrl;
    const modal = new bootstrap.Modal(document.getElementById('imageModal'));
    modal.show();
}

function deleteImage(imageUrl, productId) {
    if (confirm('Bạn có chắc chắn muốn xóa ảnh này?')) {
        
        console.log(imageUrl);
        console.log(productId);
        const url = "deleteGalleryImage?imageUrl="+imageUrl+"&productID="+productId;
        console.log(url);
        window.location.href = url;
    }
}



 function initializeGallery() {
    console.log('=== MULTI IMAGE PREVIEW INIT ===');
    
    const imageInput = document.getElementById('imageFile');
    const previewContainer = document.getElementById('preview-container');
    
    if (!imageInput || !previewContainer) {
        console.error('Missing elements');
        return;
    }

    let selectedFiles = []; // Danh sách tất cả files đã chọn
    let fileCounter = 0; // Unique ID cho mỗi file

    imageInput.addEventListener('change', function(e) {
        console.log('=== NEW FILES SELECTED ===');
        const newFiles = Array.from(e.target.files);
        console.log('New files count:', newFiles.length);
        
        if (newFiles.length === 0) {
            console.log('No new files selected');
            return;
        }

        // Validate và thêm files mới
        const validFiles = [];
        const errorMessages = [];
        
        newFiles.forEach(file => {
            console.log('Processing file:', file.name, file.type, file.size);
            
            // Check if file already exists
            const existingFile = selectedFiles.find(f => 
                f.file.name === file.name && 
                f.file.size === file.size && 
                f.file.lastModified === file.lastModified
            );
            
            if (existingFile) {
                console.log('File already exists:', file.name);
                errorMessages.push(`File ${file.name} đã được chọn!`);
                return;
            }
            
            if (!file.type.startsWith('image/')) {
                errorMessages.push(`${file.name} không phải ảnh hợp lệ!`);
                return;
            }
            
            if (file.size > 5 * 1024 * 1024) {
                errorMessages.push(`${file.name} vượt quá 5MB!`);
                return;
            }
            
            // Thêm file với unique ID
            validFiles.push({
                file: file,
                id: fileCounter++,
                name: file.name
            });
        });

        // Show errors
        const errorElement = document.getElementById('imageFile-error');
        if (errorMessages.length > 0) {
            errorElement.textContent = errorMessages.join(' ');
            errorElement.style.display = 'block';
        } else {
            errorElement.style.display = 'none';
        }

        if (validFiles.length === 0) {
            console.log('No valid files to add');
            return;
        }

        // THÊM vào danh sách hiện có (không replace)
        selectedFiles = [...selectedFiles, ...validFiles];
        console.log('Total files after adding:', selectedFiles.length);
        
        // Update preview
        updatePreview();
        
        // Clear input để có thể chọn lại
        imageInput.value = '';
    });

    function updatePreview() {
        console.log('=== UPDATE PREVIEW ===');
        console.log('Total files to preview:', selectedFiles.length);
        
        // Clear container
        previewContainer.innerHTML = '';

        if (selectedFiles.length === 0) {
            previewContainer.innerHTML = '<p style="color: #666; margin: 10px; text-align: center;">Chưa có ảnh được chọn. Bạn có thể chọn nhiều ảnh cùng lúc.</p>';
            return;
        }

        // Show loading
        previewContainer.innerHTML = '<p style="color: #666; margin: 10px; text-align: center;">Đang tải preview...</p>';

        let loadedCount = 0;
        const totalFiles = selectedFiles.length;

        selectedFiles.forEach((fileObj, index) => {
            const file = fileObj.file;
            const fileId = fileObj.id;
            
            console.log(`Creating preview for: ${file.name} (ID: ${fileId})`);
            
            const reader = new FileReader();
            
            reader.onload = function(e) {
                console.log(`FileReader SUCCESS: ${file.name}`);
                
                const dataURL = e.target.result;
                
                if (!dataURL || !dataURL.startsWith('data:image/')) {
                    console.error('Invalid data URL for:', file.name);
                    handleLoadError(fileObj, index);
                    return;
                }

                // Create preview item
                const previewItem = document.createElement('div');
                previewItem.className = 'preview-item';
                previewItem.setAttribute('data-file-id', fileId);
                
                // Create image
                const img = document.createElement('img');
                img.style.cssText = 'display: block; width: 100%; height: 100%; object-fit: cover;';
                img.alt = `Preview ${file.name}`;
                
                img.onload = function() {
                    console.log(`Image displayed: ${file.name}`);
                };
                
                img.onerror = function(err) {
                    console.error(`Image display error: ${file.name}`, err);
                    this.style.display = 'none';
                    const errorDiv = document.createElement('div');
                    errorDiv.style.cssText = 'display: flex; align-items: center; justify-content: center; height: 100%; background: #f8f9fa; color: #dc3545; text-align: center; font-size: 11px; padding: 2px;';
                    errorDiv.innerHTML = `Lỗi hiển thị<br>${file.name}`;
                    previewItem.appendChild(errorDiv);
                };
                
                img.src = dataURL;
                
                // Create remove button
                const removeBtn = document.createElement('button');
                removeBtn.type = 'button';
                removeBtn.className = 'remove-preview-btn';
                removeBtn.setAttribute('data-file-id', fileId);
                removeBtn.title = `Xóa ảnh ${file.name}`;
                removeBtn.textContent = 'X';
                removeBtn.style.cssText = 'position: absolute; top: 5px; right: 5px; background: #dc3545; color: white; border: none; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; cursor: pointer; font-size: 12px; z-index: 10;';
                
                // Add to preview item
                previewItem.appendChild(img);
                previewItem.appendChild(removeBtn);
                
                // Add to container
                loadedCount++;
                addPreviewToContainer(previewItem, loadedCount, totalFiles);
            };
            
            reader.onerror = function(e) {
                console.error(`FileReader ERROR: ${file.name}`, e);
                handleLoadError(fileObj, index);
            };
            
            reader.readAsDataURL(file);
        });

        function handleLoadError(fileObj, index) {
            const errorItem = document.createElement('div');
            errorItem.className = 'preview-item';
            errorItem.setAttribute('data-file-id', fileObj.id);
            errorItem.innerHTML = `
                <div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f8f9fa; color: #dc3545; text-align: center; font-size: 11px; padding: 2px;">
                    Lỗi tải<br>${fileObj.name}
                </div>
                <button type="button" class="remove-preview-btn" data-file-id="${fileObj.id}" title="Xóa ảnh ${fileObj.name}" style="position: absolute; top: 5px; right: 5px; background: #dc3545; color: white; border: none; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; cursor: pointer; font-size: 12px;">X</button>
            `;
            
            loadedCount++;
            addPreviewToContainer(errorItem, loadedCount, totalFiles);
        }

        function addPreviewToContainer(item, loaded, total) {
            if (loaded === 1) {
                previewContainer.innerHTML = '';
            }
            
            previewContainer.appendChild(item);
            
            if (loaded === total) {
                console.log(`All ${total} previews loaded!`);
                updateFileCounter();
            }
        }
    }

    // Update file counter display
    function updateFileCounter() {
        const counterElement = document.getElementById('file-counter');
        if (counterElement) {
            counterElement.textContent = `Đã chọn ${selectedFiles.length} ảnh`;
        } else {
            // Create counter if not exists
            const counter = document.createElement('p');
            counter.id = 'file-counter';
            counter.style.cssText = 'margin: 10px 0; font-weight: bold; color: #28a745;';
            counter.textContent = `Đã chọn ${selectedFiles.length} ảnh`;
            previewContainer.parentNode.insertBefore(counter, previewContainer);
        }
    }

    // Remove preview event - sử dụng file ID thay vì index
    previewContainer.addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-preview-btn')) {
            e.preventDefault();
            e.stopPropagation();
            
            const fileId = parseInt(e.target.getAttribute('data-file-id'));
            console.log('Removing file with ID:', fileId);
            
            const fileIndex = selectedFiles.findIndex(f => f.id === fileId);
            if (fileIndex !== -1) {
                const fileName = selectedFiles[fileIndex].name;
                if (confirm(`Bạn có chắc chắn muốn xóa ảnh "${fileName}"?`)) {
                    selectedFiles.splice(fileIndex, 1);
                    console.log('File removed, remaining files:', selectedFiles.length);
                    updatePreview();
                    updateFormData();
                }
            }
        }
    });

    // Update form data để submit đúng files
    function updateFormData() {
        console.log('Updating form data with', selectedFiles.length, 'files');
        
        // Create new DataTransfer object
        const dataTransfer = new DataTransfer();
        selectedFiles.forEach(fileObj => {
            dataTransfer.items.add(fileObj.file);
        });
        
        // Update input files
        imageInput.files = dataTransfer.files;
        console.log('Form updated with', imageInput.files.length, 'files');
    }

    // Form validation
    const form = document.getElementById('add-image-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            console.log('Form submitted with', selectedFiles.length, 'files');
            
            if (selectedFiles.length === 0) {
                e.preventDefault();
                alert('Vui lòng chọn ít nhất một file ảnh!');
                return;
            }

            if (!confirm(`Bạn có chắc chắn muốn thêm ${selectedFiles.length} ảnh vào gallery?`)) {
                e.preventDefault();
                return;
            }

            // Update form data trước khi submit
            updateFormData();

            const submitButton = form.querySelector('button[type="submit"]');
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.textContent = `Đang tải lên ${selectedFiles.length} ảnh...`;
            }
        });
    }

    // Thêm button "Chọn thêm ảnh"
   

    // Insert button sau input
    imageInput.parentNode.appendChild(addMoreButton);

    console.log('Multi-image gallery initialized!');
}

// Initialize
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeGallery);
} else {
    initializeGallery();
}
            </script>
    </body>
</html>