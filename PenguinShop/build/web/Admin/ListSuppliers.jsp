<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <style>
            .status-active {
                backgroun                                                            <th width="20%">Tên nhà cung cấp</th>
                                                            <th width="15%">Người liên hệ</th>
                                                            <th width="15%">Điện thoại</th>
                                                            <th width="20%">Email</th>
                                                            <th width="15%" class="text-center">Thao tác</th>r: #28a745;
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
            .stats-card {
                transition: transform 0.2s ease-in-out;
            }
            .stats-card:hover {
                transform: translateY(-2px);
            }
            .avatar-sm {
                width: 48px;
                height: 48px;
            }
            .avatar-title {
                width: 100%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;

                .content-header {
                    background: white;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    margin-bottom: 20px;
                }

                .content-header h1 {
                    color: #2c3e50;
                    margin: 0;
                    font-size: 24px;
                    font-weight: 600;
                }

                .breadcrumb {
                    background: none;
                    padding: 0;
                    margin: 10px 0 0 0;
                }

                .card {
                    border: none;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    border-radius: 8px;
                }

                .card-header {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 8px 8px 0 0 !important;
                    padding: 15px 20px;
                }

                .card-header h5 {
                    margin: 0;
                    font-weight: 600;
                }

                .search-section {
                    background: white;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    margin-bottom: 20px;
                }

                .btn-primary {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border: none;
                    border-radius: 6px;
                    padding: 8px 16px;
                    font-weight: 500;
                }

                .btn-primary:hover {
                    background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                }

                .btn-success {
                    background: linear-gradient(135deg, #56ab2f 0%, #a8e6cf 100%);
                    border: none;
                    border-radius: 6px;
                    padding: 8px 16px;
                    font-weight: 500;
                }

                .btn-info {
                    background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                    border: none;
                    border-radius: 6px;
                    padding: 6px 12px;
                    font-size: 12px;
                }

                .btn-warning {
                    background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                    border: none;
                    border-radius: 6px;
                    padding: 6px 12px;
                    font-size: 12px;
                }

                .btn-danger {
                    background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                    border: none;
                    border-radius: 6px;
                    padding: 6px 12px;
                    font-size: 12px;
                }

                .table {
                    margin-bottom: 0;
                }

                .table th {
                    background-color: #f8f9fa;
                    color: #2c3e50;
                    font-weight: 600;
                    border-top: none;
                    padding: 15px 12px;
                    font-size: 14px;
                }

                .table td {
                    padding: 12px;
                    vertical-align: middle;
                    border-top: 1px solid #dee2e6;
                    font-size: 14px;
                }

                .table tbody tr:hover {
                    background-color: #f8f9fa;
                }

                .pagination {
                    margin: 0;
                    justify-content: center;
                }

                .pagination .page-link {
                    border: none;
                    border-radius: 6px !important;
                    margin: 0 2px;
                    padding: 8px 12px;
                    color: #667eea;
                    background: white;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }

                .pagination .page-item.active .page-link {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                }

                .pagination .page-link:hover {
                    color: white;
                    background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                }

                .alert {
                    border: none;
                    border-radius: 8px;
                    padding: 15px 20px;
                }

                .alert-success {
                    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                    color: #155724;
                }

                .alert-danger {
                    background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                    color: #721c24;
                }

                .stats-card {
                    background: white;
                    border-radius: 8px;
                    padding: 20px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    margin-bottom: 20px;
                    text-align: center;
                }

                .stats-number {
                    font-size: 28px;
                    font-weight: bold;
                    color: #667eea;
                    margin-bottom: 5px;
                }

                .stats-label {
                    color: #6c757d;
                    font-size: 14px;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #6c757d;
                }

                .empty-state i {
                    font-size: 64px;
                    margin-bottom: 20px;
                    color: #dee2e6;
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
                            <!-- Content Header -->
                            <div class="content-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h1><i class="fas fa-truck me-2"></i>Quản lý nhà cung cấp</h1>
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="TrangChu.jsp">Trang chủ</a></li>
                                                <li class="breadcrumb-item active">Nhà cung cấp</li>
                                            </ol>
                                        </nav>
                                    </div>
                                    <div>
                                        <a href="AddSupplier" class="btn btn-success">
                                            <i class="fas fa-plus me-2"></i>Thêm nhà cung cấp
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Alert Messages -->
                            <c:if test="${param.success == 'added'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>Thêm nhà cung cấp thành công!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${param.success == 'updated'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>Cập nhật nhà cung cấp thành công!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${param.success == 'deleted'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>Xóa nhà cung cấp thành công!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            

                            <!-- Search Section -->
                            <div class="search-section">
                                <form method="get" action="supplier">
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label">Tìm kiếm nhà cung cấp</label>
                                            <input type="text" class="form-control" name="search" 
                                                   value="${search}" placeholder="Tên, email, số điện thoại...">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Sắp xếp theo</label>
                                            <select class="form-select" name="sortBy">
                                                <option value="supplierName" ${sortBy == 'supplierName' ? 'selected' : ''}>Tên nhà cung cấp</option>
                                                <option value="contactName" ${sortBy == 'contactName' ? 'selected' : ''}>Tên liên hệ</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">Thứ tự</label>
                                            <select class="form-select" name="sortDir">
                                                <option value="ASC" ${sortDir == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                                <option value="DESC" ${sortDir == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 d-flex align-items-end">
                                            <button type="submit" class="btn btn-primary me-2">
                                                <i class="fas fa-search me-1"></i>Tìm kiếm
                                            </button>
                                            <a href="supplier" class="btn btn-outline-secondary">
                                                <i class="fas fa-redo me-1"></i>Làm mới
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Suppliers Table -->
                            <div style="margin-top: 20px" class="card">
                                <div class="card-header">
                                    <h5><i class="fas fa-list me-2"></i>Danh sách nhà cung cấp</h5>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${empty suppliers}">
                                            <div style="text-align: center; margin: 30px 10px" class="empty-state">
                                                <i class="fas fa-truck"></i>
                                                <h5>Không có nhà cung cấp nào</h5>
                                                <p class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${not empty search}">
                                                            Không tìm thấy nhà cung cấp nào phù hợp với từ khóa "${search}"
                                                        </c:when>
                                                        <c:otherwise>
                                                            Hãy thêm nhà cung cấp đầu tiên của bạn
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <a href="AddSupplier" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm nhà cung cấp
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th width="5%">#</th>
                                                            <th width="20%">Tên nhà cung cấp</th>
                                                            <th width="15%">Người liên hệ</th>
                                                            <th width="15%">Số điện thoại</th>
                                                            <th width="20%">Email</th>
                                                            <th width="15%" class="text-center">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="supplier" items="${suppliers}" varStatus="status">
                                                            <tr>
                                                                <td><strong>${(currentPage - 1) * 10 + status.index + 1}</strong></td>
                                                                <td>
                                                                    <strong class="text-primary">${supplier.supplierName}</strong>
                                                                    
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty supplier.contactName}">
                                                                            ${supplier.contactName}
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="text-muted">Chưa có</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty supplier.phone}">
                                                                            <i class="fas fa-phone me-1"></i>${supplier.phone}
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="text-muted">Chưa có</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty supplier.email}">
                                                                            <i class="fas fa-envelope me-1"></i>
                                                                            <a href="mailto:${supplier.email}">${supplier.email}</a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="text-muted">Chưa có</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                
                                                                <td class="text-center">
                                                                    <div class="btn-group" role="group">
                                                                        <a href="supplier-details?id=${supplier.supplierID}" 
                                                                           class="btn btn-info btn-sm" title="Xem chi tiết">
                                                                            <i class="mdi mdi-eye"></i>
                                                                        </a>
                                                                        <a href="supplier?action=edit&id=${supplier.supplierID}" 
                                                                           class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                                            <i class="mdi mdi-pencil"></i>
                                                                        </a>
                                                                        <button type="button" class="btn btn-danger btn-sm" 
                                                                                onclick="confirmDelete(${supplier.supplierID}, '${supplier.supplierName}')"
                                                                                title="Xóa">
                                                                            <i class="mdi mdi-delete"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="card-footer bg-light">
                                        <nav aria-label="Supplier pagination">
                                            <ul class="pagination">
                                                <!-- Previous page -->
                                                <c:if test="${currentPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${currentPage - 1}&search=${search}&sortBy=${sortBy}&sortDir=${sortDir}">
                                                            <i class="fas fa-chevron-left"></i> Trước
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <!-- Page numbers -->
                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <c:if test="${i <= currentPage + 2 && i >= currentPage - 2}">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="?page=${i}&search=${search}&sortBy=${sortBy}&sortDir=${sortDir}">
                                                                ${i}
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>

                                                <!-- Next page -->
                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${currentPage + 1}&search=${search}&sortBy=${sortBy}&sortDir=${sortDir}">
                                                            Sau <i class="fas fa-chevron-right"></i>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->

            </div>
            <!-- end main content-->
        </div>
    </div></div>
    <jsp:include page="Common/RightSideBar.jsp"/>
<!-- END layout-wrapper -->

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa nhà cung cấp <strong id="supplierName"></strong>?</p>
                <p class="text-muted">Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteForm" method="post" action="DeleteSupplier" style="display: inline;">
                    <input type="hidden" name="supplierID" id="deleteSupplierID">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>

<script>
    function confirmDelete(supplierID, supplierName) {
        document.getElementById('deleteSupplierID').value = supplierID;
        document.getElementById('supplierName').textContent = supplierName;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }
</script>
</body>
</html>
