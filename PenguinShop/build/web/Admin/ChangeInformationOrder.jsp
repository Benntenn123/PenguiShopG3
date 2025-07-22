<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <div class="row mb-3">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Thay đổi thông tin hóa đơn #${o.orderID}</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listOrderAdmin">Hóa Đơn</a></li>
                                            <li class="breadcrumb-item active">Thay đổi thông tin hóa đơn</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="col-xl-10" style="margin: 0px 100px">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Thay đổi order #${o.orderID}</h4>

                                </div>
                                <div class="card-body">
                                    <form method="post" action="changeInformationOrder" class="needs-validation" novalidate>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <input type="hidden" name="orderID" value="${o.orderID}"/>
                                                <div class="mb-3">
                                                    <label for="choices-single-default" class="form-label font-size-13 text-muted">Trạng thái order</label>
                                                    <select class="form-control" data-trigger name="orderStatus"
                                                            id="orderStatus" name="orderStatus" placeholder="Chọn trạng thái đơn hàng" required
                                                            ${o.orderStatus == '0' || o.orderStatus == '1'|| o.orderStatus == '2' ||o.orderStatus == '3'? 'disabled' : ''}>
                                                        <option value="">Lựa chọn trạng thái</option>
                                                        <option value="0" ${o.orderStatus == '0' ? 'selected' : ''}>Đã Hủy</option>
                                                        <option value="1" ${o.orderStatus == '1' ? 'selected' : ''}>Giao Hàng Thành Công</option>
                                                        <option value="2" ${o.orderStatus == '2' ? 'selected' : ''}>Đang Giao</option>
                                                        <option value="3" ${o.orderStatus == '3' ? 'selected' : ''}>Hoàn Hàng</option>
                                                        <option value="4" ${o.orderStatus == '4' ? 'selected' : ''}>Đang Chờ Xử Lí</option>
                                                        <option value="5" ${o.orderStatus == '5' ? 'selected' : ''}>Đã Xác Nhận</option>
                                                    </select>
                                                    <input type="hidden" name="statusOld" value="${o.orderStatus}"/>
                                                    <!-- Thêm thông báo cho user hiểu tại sao không thể thay đổi -->
                                                    <c:if test="${o.orderStatus == '0'}">
                                                        <small class="text-muted">
                                                            <i class="fas fa-lock"></i> Đơn hàng đã hủy không thể thay đổi trạng thái
                                                        </small>
                                                    </c:if>
                                                    <c:if test="${o.orderStatus == '1'}">
                                                        <small class="text-muted">
                                                            <i class="fas fa-lock"></i> Đơn hàng đã giao thành công không thể thay đổi trạng thái
                                                        </small>
                                                    </c:if>
                                                    <c:if test="${o.orderStatus == '2'}">
                                                        <small class="text-muted">
                                                            <i class="fas fa-lock"></i> Đơn hàng đã được xử lí không thể thay đổi trạng thái
                                                        </small>
                                                    </c:if>
                                                    <c:if test="${o.orderStatus == '3'}">
                                                        <small class="text-muted">
                                                            <i class="fas fa-lock"></i> Đơn hàng đã được hoàn trả không thể thay đổi trạng thái
                                                        </small>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="validationCustom01">Tên người nhận</label>
                                                    <input type="text" class="form-control" name="name" id="validationCustom01" placeholder="Nhập tên người nhận" value="${o.name_receiver}" required>
                                                    <div class="valid-feedback">
                                                        Trường nhập hợp lí
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="validationCustom02">Email người nhận</label>
                                                    <input type="text" class="form-control" name="email" id="validationCustom02" placeholder="Nhập email người nhận" value="${o.emall_receiver}" required>
                                                    <div class="valid-feedback">
                                                        Trường nhập hợp lí
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="validationCustom02">Số điện thoại người nhận</label>
                                                    <input type="text" class="form-control" name="phone" id="validationCustom02" placeholder="Nhập số điện thoại người nhận" value="${o.phone_receiver}" required>
                                                    <div class="valid-feedback">
                                                        Trường nhập hợp lí
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="validationCustom02">Địa chỉ người nhận</label>
                                                    <div class="d-flex">
                                                        <input readonly="" type="text" class="form-control me-2" id="current-address" placeholder="Nhập địa chỉ người nhận" value="${o.shippingAddress}" required>
                                                        <button type="button" style="width: 150px" class="btn btn-outline-primary" id="change-address-btn" onclick="toggleAddressChange()">Thay đổi</button>
                                                    </div>
                                                    <div class="valid-feedback">
                                                        Trường nhập hợp lí
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Address change section - initially hidden -->
                                            
                                            <div id="address-change-section" style="display: none;">
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="validationCustom02">Địa chỉ đang có : </label>
                                                        <select id="edit-province" name="province" class="form-select" onchange="loadDistrictsForEdit(this.value)" required>
                                                            <option value="">Chọn 1 địa chỉ đang có của bạn</option>
                                                            <c:forEach var="deli" items="${deli}">
                                                                <option value="${deli.addessDetail}">${deli.addessDetail}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <script>
// Khi chọn địa chỉ có sẵn, disable các select tỉnh/huyện/xã và input bổ sung
document.getElementById('edit-province').addEventListener('change', function() {
    var selected = this.value;
    // Select địa chỉ đang có: KHÔNG khóa chính nó
    var provinceSelect2 = document.querySelectorAll('select[id="edit-province"]')[1]; // select tỉnh
    var districtSelect = document.getElementById('edit-district');
    var wardSelect = document.getElementById('edit-ward');
    var additionalInput = document.getElementById('additional-address');
    if (selected !== '') {
        // Disable các select tỉnh/huyện/xã và input bổ sung
        if (provinceSelect2) provinceSelect2.disabled = true;
        if (districtSelect) districtSelect.disabled = true;
        if (wardSelect) wardSelect.disabled = true;
        if (additionalInput) additionalInput.disabled = true;
    } else {
        // Enable lại nếu chọn rỗng
        if (provinceSelect2) provinceSelect2.disabled = false;
        if (districtSelect) districtSelect.disabled = false;
        if (wardSelect) wardSelect.disabled = false;
        if (additionalInput) additionalInput.disabled = false;
    }
});
                                                        </script>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="validationCustom02">Tỉnh : </label>
                                                        <select id="edit-province" name="province" class="form-select" onchange="loadDistrictsForEdit(this.value)" required>
                                                            <option value="">Lựa chọn...</option>
                                                            <c:forEach var="province" items="${provinces}">
                                                                <option value="${province}">${province}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="validationCustom02">Huyện : </label>
                                                        <select id="edit-district" name="district" class="form-select" onchange="loadWardsForEdit(this.value)" required>
                                                            <option value="">Lựa chọn...</option>
                                                        </select>
                                                    </div>
                                                </div>  
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="validationCustom02">Phường,Xã : </label>
                                                        <select id="edit-ward" name="ward" class="form-select" onchange="updateNewAddress()" required>
                                                            <option value="">Lựa chọn...</option>
                                                        </select>
                                                    </div>
                                                </div> 
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="additional-address">Địa chỉ bổ sung: </label>
                                                        <input type="text" class="form-control" id="additional-address" placeholder="Nhập địa chỉ bổ sung" value="" onchange="updateNewAddress()" required>
                                                    </div>
                                                </div>  
                                            </div>

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="new-shipping-address">Địa chỉ vận chuyển mới: </label>
                                                    <input type="text" name="address" class="form-control" id="new-shipping-address" readonly placeholder="Địa chỉ vận chuyển sẽ được tạo tự động" value="${o.shippingAddress}" required>
                                                </div>
                                            </div>        
                                        </div>

                                        <button class="btn btn-primary" type="submit" 
                                                ${o.orderStatus == '0' || o.orderStatus == '1'|| o.orderStatus == '2'||o.orderStatus == '3' ? 'disabled' : ''}>
                                            <c:choose>
                                                <c:when test="${o.orderStatus == '0' || o.orderStatus == '1'|| o.orderStatus == '2'|| o.orderStatus == '3'}">
                                                    <i class="fas fa-lock me-2"></i>Không thể cập nhật
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-save me-2"></i>Cập nhật đơn hàng
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                    </div> 
                </div>
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
        <script>

            // Toggle address change section
            function toggleAddressChange() {
                const section = document.getElementById('address-change-section');
                const btn = document.getElementById('change-address-btn');

                if (section.style.display === 'none') {
                    section.style.display = 'block';
                    btn.textContent = 'Hủy thay đổi';
                    btn.classList.remove('btn-outline-primary');
                    btn.classList.add('btn-outline-danger');
                } else {
                    section.style.display = 'none';
                    btn.textContent = 'Thay đổi';
                    btn.classList.remove('btn-outline-danger');
                    btn.classList.add('btn-outline-primary');
                    // Reset form when hiding
                    resetAddressForm();
                }
            }

            // Reset address form
            function resetAddressForm() {
                document.getElementById('edit-province').value = '';
                document.getElementById('edit-district').innerHTML = '<option value="">Lựa chọn...</option>';
                document.getElementById('edit-ward').innerHTML = '<option value="">Lựa chọn...</option>';
                document.getElementById('additional-address').value = '';
                document.getElementById('new-shipping-address').value = '';
            }

            // Update new shipping address based on selections
            function updateNewAddress() {
                const province = document.getElementById('edit-province').value;
                const district = document.getElementById('edit-district').value;
                const ward = document.getElementById('edit-ward').value;
                const additional = document.getElementById('additional-address').value;

                let newAddress = '';

                if (additional) {
                    newAddress += additional;
                }
                if (ward) {
                    newAddress += (newAddress ? ' - ' : '') + ward;
                }
                if (district) {
                    newAddress += (newAddress ? ' - ' : '') + district;
                }
                if (province) {
                    newAddress += (newAddress ? ' - ' : '') + province;
                }

                document.getElementById('new-shipping-address').value = newAddress;
            }

            function loadDistrictsForEdit(province, selectedDistrict) {
                console.log('Gọi loadDistrictsForEdit với province:', province); // Debug
                if (province === '') {
                    $('#edit-district').empty().append('<option value="">Lựa chọn...</option>');
                    $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                    updateNewAddress(); // Update address when province changes
                    return;
                }
                $.ajax({
                    url: "loadDistanceOrder",
                    type: "POST",
                    data: {
                        method: "getDistricts",
                        province: province
                    },
                    success: function (data) {
                        console.log('Nhận response districts:', data); // Debug
                        var districtSelect = $('#edit-district');
                        districtSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, district) {
                            var selected = (selectedDistrict && district === selectedDistrict) ? 'selected' : '';
                            districtSelect.append('<option value="' + district + '" ' + selected + '>' + district + '</option>');
                        });
                        // Reset dropdown phường/xã
                        $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                        updateNewAddress(); // Update address when districts load
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi AJAX loadDistrictsForEdit:', error); // Debug
                        toastr.error("Lỗi kết nối server khi tải danh sách quận/huyện.");
                    }
                });
            }

            // AJAX tải phường/xã theo quận/huyện cho form edit
            function loadWardsForEdit(district, selectedWard) {
                console.log('Gọi loadWardsForEdit với district:', district); // Debug
                if (district === '') {
                    $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                    updateNewAddress(); // Update address when district changes
                    return;
                }
                $.ajax({
                    url: "loadDistanceOrder",
                    type: "POST",
                    data: {
                        method: "getWards",
                        district: district
                    },
                    success: function (data) {
                        console.log('Nhận response wards:', data); // Debug
                        var wardSelect = $('#edit-ward');
                        wardSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, ward) {
                            var selected = (selectedWard && ward === selectedWard) ? 'selected' : '';
                            wardSelect.append('<option value="' + ward + '" ' + selected + '>' + ward + '</option>');
                        });
                        updateNewAddress(); // Update address when wards load
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi AJAX loadWardsForEdit:', error); // Debug
                        toastr.error("Lỗi kết nối server khi tải danh sách phường/xã.");
                    }
                });
            }

        </script>
    </body>
</html>