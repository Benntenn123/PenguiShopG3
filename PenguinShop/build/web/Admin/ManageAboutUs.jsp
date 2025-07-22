<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>Quản lý About Us</title>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>

            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Quản lý About Us</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="TrangChu">Trang chủ</a></li>
                                            <li class="breadcrumb-item active">Quản lý About Us</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Form Update About Us -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-4">Thông tin About Us</h5>
                                        <c:if test="${not empty sessionScope.error}">
                                            <div class="alert alert-danger">${sessionScope.error}</div>
                                            <c:remove var="error" scope="session"/>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.success}">
                                            <div class="alert alert-success">${sessionScope.success}</div>
                                            <c:remove var="success" scope="session"/>
                                        </c:if>
                                        
                                        <form id="updateAboutForm" action="aboutus" method="post" enctype="multipart/form-data">
                                            <input type="hidden" name="action" value="update">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="title" class="form-label">Tiêu đề chính <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="title" name="title" 
                                                           value="${aboutInfo.title}" required maxlength="255">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="subtitle" class="form-label">Tiêu đề phụ <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="subtitle" name="subtitle" 
                                                           value="${aboutInfo.subtitle}" required maxlength="255">
                                                </div>
                                                <div class="col-md-12">
                                                    <label for="content" class="form-label">Nội dung <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" id="content" name="content" rows="5" 
                                                              required maxlength="2000">${aboutInfo.content}</textarea>
                                                    <div class="form-text">Tối đa 2000 ký tự</div>
                                                </div>
                                                <div class="col-md-12">
                                                    <label for="highlightPoints" class="form-label">Điểm nổi bật <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" id="highlightPoints" name="highlightPoints" rows="3" 
                                                              required placeholder="Nhập các điểm nổi bật cách nhau bằng dấu |">${aboutInfo.highlightPoints}</textarea>
                                                    <div class="form-text">Các điểm nổi bật cách nhau bằng dấu "|". Ví dụ: Chất lượng cao|Giao hàng nhanh|Dịch vụ tốt</div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="mainImage" class="form-label">Ảnh chính hiện tại</label>
                                                    <c:if test="${not empty aboutInfo.mainImage}">
                                                        <div class="mb-2">
                                                            <img src="${aboutInfo.mainImage}" alt="Ảnh hiện tại" 
                                                                 class="img-thumbnail" style="max-width: 200px; max-height: 150px;">
                                                        </div>
                                                    </c:if>
                                                    <input type="file" class="form-control" id="mainImage" name="mainImage" 
                                                           accept="image/*">
                                                    <div class="form-text">Chọn file để thay đổi ảnh (để trống nếu không muốn thay đổi)</div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="videoUrl" class="form-label">Video URL</label>
                                                    <input type="url" class="form-control" id="videoUrl" name="videoUrl" 
                                                           value="${aboutInfo.videoUrl}" placeholder="https://...">
                                                    <div class="form-text">Link video giới thiệu (tùy chọn)</div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="isActive" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                                    <select class="form-select" id="isActive" name="isActive" required>
                                                        <option value="1" ${aboutInfo.active ? 'selected' : ''}>Hiển thị</option>
                                                        <option value="0" ${!aboutInfo.active ? 'selected' : ''}>Ẩn</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="mt-4">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Cập nhật
                                                </button>
                                                <a href="../aboutus" target="_blank" class="btn btn-info">
                                                    <i class="fas fa-eye"></i> Xem trước
                                                </a>
                                                <button type="button" class="btn btn-secondary" onclick="resetForm()">
                                                    <i class="fas fa-undo"></i> Reset
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quản lý Services -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h5 class="card-title mb-0">Dịch vụ About Us</h5>
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                                                <i class="fas fa-plus"></i> Thêm dịch vụ
                                            </button>
                                        </div>
                                        
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Tên dịch vụ</th>
                                                        <th>Mô tả</th>
                                                        <th>Thứ tự</th>
                                                        <th>Trạng thái</th>
                                                        <th>Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="service" items="${aboutServices}" varStatus="status">
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${service.serviceName}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${service.serviceDescription.length() > 50}">
                                                                        ${service.serviceDescription.substring(0, 50)}...
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${service.serviceDescription}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>${service.displayOrder}</td>
                                                            <td>
                                                                <span class="badge ${service.active ? 'bg-success' : 'bg-danger'}">
                                                                    ${service.active ? 'Hiển thị' : 'Ẩn'}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                        onclick="editService(${service.serviceID})">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                        onclick="deleteService(${service.serviceID})">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Quản lý Company Stats -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h5 class="card-title mb-0">Thống kê công ty</h5>
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addStatModal">
                                                <i class="fas fa-plus"></i> Thêm thống kê
                                            </button>
                                        </div>
                                        
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Tên thống kê</th>
                                                        <th>Giá trị</th>
                                                        <th>Icon</th>
                                                        <th>Thứ tự</th>
                                                        <th>Trạng thái</th>
                                                        <th>Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="stat" items="${companyStats}" varStatus="status">
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${stat.statName}</td>
                                                            <td><strong>${stat.statValue}</strong></td>
                                                            <td>
                                                                <c:if test="${not empty stat.statIcon}">
                                                                    <i class="${stat.statIcon}"></i> ${stat.statIcon}
                                                                </c:if>
                                                            </td>
                                                            <td>${stat.displayOrder}</td>
                                                            <td>
                                                                <span class="badge ${stat.active ? 'bg-success' : 'bg-danger'}">
                                                                    ${stat.active ? 'Hiển thị' : 'Ẩn'}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                        onclick="editStat(${stat.statID})">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                        onclick="deleteStat(${stat.statID})">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>
        </div>

        <!-- Modal Add Service -->
        <div class="modal fade" id="addServiceModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm dịch vụ mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="aboutus" method="post">
                        <input type="hidden" name="action" value="addService">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên dịch vụ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="serviceName" required maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả <span class="text-danger">*</span></label>
                                <textarea class="form-control" name="serviceDescription" rows="3" required maxlength="500"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Thứ tự hiển thị</label>
                                <input type="number" class="form-control" name="displayOrder" value="1" min="1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="isActive">
                                    <option value="1">Hiển thị</option>
                                    <option value="0">Ẩn</option>
                                </select>
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

        <!-- Modal Add Stat -->
        <div class="modal fade" id="addStatModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm thống kê mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="aboutus" method="post">
                        <input type="hidden" name="action" value="addStat">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên thống kê <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="statName" required maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá trị <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="statValue" required maxlength="50" 
                                       placeholder="VD: 50,000+, 2020, 15+">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Icon (FontAwesome)</label>
                                <input type="text" class="form-control" name="statIcon" maxlength="255" 
                                       placeholder="VD: fas fa-users, fas fa-chart-line">
                                <div class="form-text">Để trống nếu sử dụng icon mặc định</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Thứ tự hiển thị</label>
                                <input type="number" class="form-control" name="displayOrder" value="1" min="1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="isActive">
                                    <option value="1">Hiển thị</option>
                                    <option value="0">Ẩn</option>
                                </select>
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

        <!-- Modal Edit Service -->
        <div class="modal fade" id="editServiceModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Sửa dịch vụ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="aboutus" method="post">
                        <input type="hidden" name="action" value="editService">
                        <input type="hidden" id="editServiceId" name="serviceId">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên dịch vụ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editServiceName" name="serviceName" required maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="editServiceDescription" name="serviceDescription" rows="3" required maxlength="500"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Thứ tự hiển thị</label>
                                <input type="number" class="form-control" id="editServiceOrder" name="displayOrder" value="1" min="1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" id="editServiceActive" name="isActive">
                                    <option value="1">Hiển thị</option>
                                    <option value="0">Ẩn</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Edit Stat -->
        <div class="modal fade" id="editStatModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Sửa thống kê</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="aboutus" method="post">
                        <input type="hidden" name="action" value="editStat">
                        <input type="hidden" id="editStatId" name="statId">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên thống kê <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editStatName" name="statName" required maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá trị <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editStatValue" name="statValue" required maxlength="50" 
                                       placeholder="VD: 50,000+, 2020, 15+">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Icon (FontAwesome)</label>
                                <input type="text" class="form-control" id="editStatIcon" name="statIcon" maxlength="255" 
                                       placeholder="VD: fas fa-users, fas fa-chart-line">
                                <div class="form-text">Để trống nếu sử dụng icon mặc định</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Thứ tự hiển thị</label>
                                <input type="number" class="form-control" id="editStatOrder" name="displayOrder" value="1" min="1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" id="editStatActive" name="isActive">
                                    <option value="1">Hiển thị</option>
                                    <option value="0">Ẩn</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        
        <script>
            // Form validation
            document.getElementById('updateAboutForm').addEventListener('submit', function (e) {
                let title = document.getElementById('title').value.trim();
                let subtitle = document.getElementById('subtitle').value.trim();
                let content = document.getElementById('content').value.trim();
                let highlights = document.getElementById('highlightPoints').value.trim();
                
                if (!title || !subtitle || !content || !highlights) {
                    e.preventDefault();
                    alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                    return;
                }
                
                if (content.length > 2000) {
                    e.preventDefault();
                    alert('Nội dung không được quá 2000 ký tự!');
                    return;
                }
                
                // Validate highlight points format
                if (!highlights.includes('|')) {
                    let confirm = confirm('Điểm nổi bật nên có nhiều mục cách nhau bằng dấu "|". Bạn có muốn tiếp tục?');
                    if (!confirm) {
                        e.preventDefault();
                        return;
                    }
                }
            });
            
            // Reset form function
            function resetForm() {
                if (confirm('Bạn có chắc muốn reset form về trạng thái ban đầu?')) {
                    location.reload();
                }
            }
            
            // Service management functions
            function editService(serviceId) {
                // Find service data from table
                let row = document.querySelector('button[onclick="editService(' + serviceId + ')"]').closest('tr');
                let cells = row.children;
                
                // Fill modal with data
                document.getElementById('editServiceId').value = serviceId;
                document.getElementById('editServiceName').value = cells[1].textContent;
                document.getElementById('editServiceDescription').value = getFullDescription(serviceId, 'service');
                document.getElementById('editServiceOrder').value = cells[3].textContent;
                document.getElementById('editServiceActive').value = cells[4].querySelector('.badge').textContent.trim() === 'Hiển thị' ? '1' : '0';
                
                // Show modal
                new bootstrap.Modal(document.getElementById('editServiceModal')).show();
            }
            
            function deleteService(serviceId) {
                if (confirm('Bạn có chắc muốn xóa dịch vụ này?')) {
                    // Tạo form POST để xóa
                    let form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'aboutus';
                    
                    let actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'deleteService';
                    
                    let idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'id';
                    idInput.value = serviceId;
                    
                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
            
            // Stat management functions
            function editStat(statId) {
                // Find stat data from table
                let row = document.querySelector('button[onclick="editStat(' + statId + ')"]').closest('tr');
                let cells = row.children;
                
                // Fill modal with data
                document.getElementById('editStatId').value = statId;
                document.getElementById('editStatName').value = cells[1].textContent;
                document.getElementById('editStatValue').value = cells[2].textContent;
                let iconCell = cells[3].textContent.trim();
                document.getElementById('editStatIcon').value = iconCell.includes('fa-') ? iconCell.split(' ')[1] : '';
                document.getElementById('editStatOrder').value = cells[4].textContent;
                document.getElementById('editStatActive').value = cells[5].querySelector('.badge').textContent.trim() === 'Hiển thị' ? '1' : '0';
                
                // Show modal
                new bootstrap.Modal(document.getElementById('editStatModal')).show();
            }
            
            function deleteStat(statId) {
                if (confirm('Bạn có chắc muốn xóa thống kê này?')) {
                    // Tạo form POST để xóa
                    let form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'aboutus';
                    
                    let actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'deleteStat';
                    
                    let idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'id';
                    idInput.value = statId;
                    
                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
            
            // Helper function to get full description (since it's truncated in table)
            function getFullDescription(id, type) {
                // This is a simple implementation - in real app you might need to fetch from server
                // For now, just return truncated text from table
                let functionName = type === 'service' ? 'editService' : 'editStat';
                let row = document.querySelector('button[onclick="' + functionName + '(' + id + ')"]').closest('tr');
                return row.children[type === 'service' ? 2 : 1].textContent.replace('...', '');
            }
            
            // Character count for textarea
            document.getElementById('content').addEventListener('input', function() {
                let current = this.value.length;
                let max = 2000;
                let remaining = max - current;
                let color = remaining < 100 ? 'text-danger' : 'text-muted';
                
                let helpText = this.nextElementSibling;
                helpText.innerHTML = `<span class="${color}">Còn lại ${remaining}/${max} ký tự</span>`;
            });
        </script>
    </body>
</html>
