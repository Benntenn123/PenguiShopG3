<%-- 
    Document   : DeliveryList
    Created on : May 28, 2025, 4:16:14 PM
    Author     : fptshop
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <!-- Thêm Bootstrap CSS nếu chưa có trong Common/Css.jsp -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            a {
                text-decoration: none; /* Loại bỏ gạch chân */
            }
            /* Giữ nguyên CSS hiện tại */
            .delivery-menu-container {
                position: relative;
            }

            .delivery-dots-btn {
                background: none;
                border: none;
                cursor: pointer;
                padding: 8px;
                border-radius: 50%;
                transition: background-color 0.2s;
                font-size: 20px;

                color: #666;
            }

            .delivery-dots-btn:hover {
                background-color: #f5f5f5;
            }

            .delivery-dropdown-menu {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                border: 1px solid #ddd;
                border-radius: 6px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                min-width: 120px;
                z-index: 1000;
                opacity: 0;
                width: 200px;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.2s ease;
            }

            .delivery-dropdown-menu.show {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            /* Style cho modal animation */
            .modal-wrapper {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 9999;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
            }

            .modal-wrapper.active {
                opacity: 1;
                visibility: visible;
            }

            .modal-wrapper .modal-main {
                transform: scale(0.7) translateY(-50px);
                transition: all 0.3s ease;
                max-width: 500px;
                width: 90%;
                max-height: 90vh;
                overflow-y: auto;
            }

            .modal-wrapper.active .modal-main {
                transform: scale(1) translateY(0);
            }

            .delivery-dropdown-item {
                padding: 10px 15px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
                color: #333;
                font-size: 14px;
                transition: background-color 0.2s;
            }

            .delivery-dropdown-item:last-child {
                border-bottom: none;
            }

            .delivery-dropdown-item:hover {
                background-color: #f8f9fa;
            }

            .delivery-dropdown-item.delete {
                color: #dc3545;
            }

            /* Thêm style cho card địa chỉ */
            .seller-info {
                height: 300px; /* Fix cứng chiều cao card */
                overflow-y: auto; /* Thêm scroll dọc nếu nội dung vượt quá */
                border: 1px solid #ddd; /* Thêm viền để dễ nhìn */
                border-radius: 8px; /* Bo góc */
                padding: 15px; /* Padding bên trong */
            }

            /* Style cho bảng */
            .info-table {
                width: 100%;
                border-collapse: collapse;
            }

            .info-table td {
                padding: 5px 0;
                vertical-align: top; /* Căn trên cùng */
            }

            .info-table .label {
                font-weight: bold;
                width: 120px; /* Chiều rộng cố định cho tiêu đề */
                text-align: left; /* Căn phải tiêu đề */
                padding-right: 10px; /* Khoảng cách giữa tiêu đề và nội dung */
                font-size: 16px;

            }

            .info-table .value {
                word-break: break-word;
                font-size: 16px;/* Ngắt chữ nếu nội dung dài */
            }
        </style>
    </head>
    <body>
        <jsp:include page="Common/Header.jsp" />
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">
                    <div class="user-dashboard">
                        <jsp:include page="Common/CommonUser.jsp" />
                        <div class="nav-content" id="v-pills-tabContent" style="flex: 1 0%;">
                            <div class="tab-pane" id="v-pills-address" role="tabpanel"
                                 aria-labelledby="v-pills-address-tab" tabindex="0">
                                <div class="profile-section address-section addresses ">
                                    <!-- Row chứa nút Thêm địa chỉ trên cùng -->
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <a href="#" class="shop-btn" onclick="modalAction('.submit')">Thêm địa chỉ nhận mới</a>
                                        </div>
                                    </div>
                                    <!-- Row chứa các card địa chỉ -->
                                    <div class="row gy-md-0 g-5">
                                        <c:forEach var="deInfo" items="${deInfo}" varStatus="loop">
                                            <div class="col-md-6">
                                                <div class="seller-info">
                                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                                        <h5 class="heading">Địa chỉ - ${loop.index + 1}</h5> <!-- Sử dụng index + 1 để bắt đầu từ 1 -->
                                                        <div class="delivery-menu-container">
                                                            <button class="delivery-dots-btn" onclick="toggleDeliveryDropdown(event, ${deInfo.deliveryInfoID})">⋮</button>
                                                            <div class="delivery-dropdown-menu" data-delivery-id="${deInfo.deliveryInfoID}">
                                                                <div class="delivery-dropdown-item" onclick="editDeliveryAddress(${deInfo.deliveryInfoID}, '${deInfo.fullName}', '${deInfo.email}', '${deInfo.phone}', '${deInfo.city}', '${deInfo.addessDetail}')">Chỉnh sửa</div>
                                                                <div class="delivery-dropdown-item delete" onclick="statusDeliveryAddress(${deInfo.deliveryInfoID})">Đặt làm mặc định</div>
                                                                <div class="delivery-dropdown-item delete" onclick="deleteDeliveryAddress(${deInfo.deliveryInfoID})">Xóa</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <table class="info-table">
                                                        <tr>
                                                            <td class="label">Người nhận:</td>
                                                            <td class="value">${deInfo.fullName}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Địa chỉ Email:</td>
                                                            <td class="value">${deInfo.email}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Số điện thoại:</td>
                                                            <td class="value">${deInfo.phone}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Thành Phố:</td>
                                                            <td class="value">${deInfo.city}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Địa chỉ:</td>
                                                            <td class="value">${deInfo.addessDetail}</td>
                                                        </tr>
                                                        <c:if test="${deInfo.isDefault eq 1}">
                                                            <tr>
                                                                <td style="color:red" class="label">Trạng thái:</td>
                                                                <td style="color: red; font-weight: bold" class="value"><span class="default-badge">Mặc định</span></td>
                                                            </tr>
                                                        </c:if>
                                                    </table>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="col-lg-6">
                                        <!-- Modal thêm địa chỉ -->
                                        <div class="modal-wrapper submit">
                                            <div onclick="modalAction('.submit')" class="anywhere-away"></div>
                                            <div class="login-section account-section modal-main">
                                                <form action="addDelivery" method="POST">
                                                    <div class="review-form">
                                                        <div class="review-content">
                                                            <h5 style="margin-bottom: 30px" class="comment-title">Thêm thông tin người nhận mới</h5>
                                                            <div class="close-btn">
                                                                <img style="margin-bottom: 30px;width: 30px; height: auto" src="./HomePage/assets/images/homepage-one/close-btn.png"
                                                                     onclick="modalAction('.submit')" alt="close-btn">
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="fullname" class="form-label">Tên người nhận</label>
                                                                <input type="text" id="fullname" name="fullname" class="form-control"
                                                                       placeholder="Nhập họ tên của bạn" required>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="useremail" class="form-label">Địa chỉ Email*</label>
                                                                <input type="email" id="useremail" name="email" class="form-control"
                                                                       placeholder="user@gmail.com" required>
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="userphone" class="form-label">Số điện thoại*</label>
                                                                <input type="tel" id="userphone" name="phone" class="form-control"
                                                                       placeholder="0388**0899" required>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="province" class="form-label">Tỉnh*</label>
                                                                <select id="province" name="province" class="form-select" onchange="loadDistricts(this.value)" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                    <c:forEach var="province" items="${provinces}">
                                                                        <option value="${province}">${province}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form city-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="district" class="form-label">Quận/Huyện*</label>
                                                                <select id="district" name="district" class="form-select" onchange="loadWards(this.value)" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                </select>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="ward" class="form-label">Phường/Xã*</label>
                                                                <select id="ward" name="ward" class="form-select" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="review-form-name address-form">
                                                            <label for="useraddress" class="form-label">Địa chỉ bổ sung*</label>
                                                            <input type="text" id="useraddress" name="addressDetail" class="form-control"
                                                                   placeholder="Bao gồm ngách số bao nhiêu, số nhà bao nhiêu,..." required>
                                                        </div>
                                                        <div class="login-btn text-center">
                                                            <button type="submit" class="shop-btn">Thêm địa chỉ</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Modal chỉnh sửa địa chỉ -->
                                        <div class="modal-wrapper edit">
                                            <div onclick="modalAction('.edit')" class="anywhere-away"></div>
                                            <div class="login-section account-section modal-main">
                                                <form action="updateDelivery" method="POST">
                                                    <input type="hidden" id="edit-delivery-id" name="deliveryId">
                                                    <div class="review-form">
                                                        <div class="review-content">
                                                            <h5 style="margin-bottom: 30px" class="comment-title">Chỉnh sửa thông tin người nhận</h5>
                                                            <div class="close-btn">
                                                                <img style="margin-bottom: 30px;width: 30px; height: auto" src="./HomePage/assets/images/homepage-one/close-btn.png"
                                                                     onclick="modalAction('.edit')" alt="close-btn">
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="edit-fullname" class="form-label">Tên người nhận</label>
                                                                <input type="text" id="edit-fullname" name="fullname" class="form-control"
                                                                       placeholder="Nhập họ tên của bạn" required>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="edit-useremail" class="form-label">Địa chỉ Email*</label>
                                                                <input type="email" id="edit-useremail" name="email" class="form-control"
                                                                       placeholder="user@gmail.com" required>
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="edit-userphone" class="form-label">Số điện thoại*</label>
                                                                <input type="tel" id="edit-userphone" name="phone" class="form-control"
                                                                       placeholder="0388**0899" required>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="edit-province" class="form-label">Tỉnh*</label>
                                                                <select id="edit-province" name="province" class="form-select" onchange="loadDistrictsForEdit(this.value)" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                    <c:forEach var="province" items="${provinces}">
                                                                        <option value="${province}">${province}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="account-inner-form city-inner-form">
                                                            <div class="review-form-name">
                                                                <label for="edit-district" class="form-label">Quận/Huyện*</label>
                                                                <select id="edit-district" name="district" class="form-select" onchange="loadWardsForEdit(this.value)" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                </select>
                                                            </div>
                                                            <div class="review-form-name">
                                                                <label for="edit-ward" class="form-label">Phường/Xã*</label>
                                                                <select id="edit-ward" name="ward" class="form-select" required>
                                                                    <option value="">Lựa chọn...</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="review-form-name address-form">
                                                            <label for="edit-useraddress" class="form-label">Địa chỉ bổ sung*</label>
                                                            <input type="text" id="edit-useraddress" name="addressDetail" class="form-control"
                                                                   placeholder="Bao gồm ngách số bao nhiêu, số nhà bao nhiêu,..." required>
                                                        </div>
                                                        <div class="login-btn text-center">
                                                            <button type="submit" class="shop-btn">Cập nhật địa chỉ</button>
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
        </section>
        <script>
            var deInfoSize = ${deInfo.size()};

            function toggleDeliveryDropdown(event, deliveryId) {
                event.preventDefault(); // Ngăn chặn hành vi mặc định
                var dropdown = event.target.nextElementSibling; // Lấy dropdown ngay sau nút
                if (dropdown && dropdown.classList.contains('delivery-dropdown-menu')) {
                    if (dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    } else {
                        // Ẩn tất cả dropdown khác trước khi hiển thị cái hiện tại
                        document.querySelectorAll('.delivery-dropdown-menu.show').forEach(function (item) {
                            item.classList.remove('show');
                        });
                        dropdown.classList.add('show');
                    }
                }
            }

            function editDeliveryAddress(deliveryId, fullName, email, phone, city, addressDetail) {
                // Ẩn tất cả dropdown trước
                document.querySelectorAll('.delivery-dropdown-menu.show').forEach(function (dropdown) {
                    dropdown.classList.remove('show');
                });
                
                // Fill dữ liệu vào form edit
                document.getElementById('edit-delivery-id').value = deliveryId;
                document.getElementById('edit-fullname').value = fullName;
                document.getElementById('edit-useremail').value = email;
                document.getElementById('edit-userphone').value = phone;
                document.getElementById('edit-useraddress').value = addressDetail;
                
                // Tách city thành province, district, ward (giả sử format: "Province, District, Ward")
                var cityParts = city.split(', ');
                if (cityParts.length >= 1) {
                    document.getElementById('edit-province').value = cityParts[0];
                    if (cityParts.length >= 2) {
                        // Load districts và set district
                        loadDistrictsForEdit(cityParts[0], cityParts[1]);
                        if (cityParts.length >= 3) {
                            // Load wards và set ward
                            setTimeout(function() {
                                loadWardsForEdit(cityParts[1], cityParts[2]);
                            }, 500);
                        }
                    }
                }
                
                // Hiển thị modal edit
                modalAction('.edit');
                
                console.log('Chỉnh sửa địa chỉ:', deliveryId);
            }

            function statusDeliveryAddress(deliveryId) {
                var dropdown = document.querySelector(`.delivery-dropdown-menu[data-delivery-id="${deliveryId}"]`);
                if (dropdown)
                    dropdown.classList.remove('show');
                if (confirm('Bạn có muốn đặt địa chỉ này làm mặc định?')) {
                    alert('Địa chỉ đã được đặt làm mặc định!');
                     window.location.href = "updatedelidefault?deID=" + deliveryId;
                }
                console.log('Đặt làm mặc định:', deliveryId);
            }

            function deleteDeliveryAddress(deliveryId) {
                var dropdown = document.querySelector(`.delivery-dropdown-menu[data-delivery-id="${deliveryId}"]`);
                if (dropdown)
                    dropdown.classList.remove('show');

                if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                    alert('Địa chỉ đã được xóa!');
                    window.location.href = "deletedelivery?deID=" + deliveryId; // Redirect về trang danh sách địa chỉ
                }
                console.log('Xóa địa chỉ:', deliveryId);
            }

            function modalAction(selector) {
                document.querySelector(selector).classList.toggle('active');
            }

            // Đóng dropdown khi click ra ngoài
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.delivery-menu-container')) {
                    document.querySelectorAll('.delivery-dropdown-menu.show').forEach(function (dropdown) {
                        dropdown.classList.remove('show');
                    });
                }
            });

            // AJAX tải quận/huyện theo tỉnh cho form add
            function loadDistricts(province) {
                console.log('Gọi loadDistricts với province:', province); // Debug
                if (province === '') {
                    $('#district').empty().append('<option value="">Lựa chọn...</option>');
                    $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {
                        method: "getDistricts",
                        province: province
                    },
                    success: function (data) {
                        console.log('Nhận response districts:', data); // Debug
                        var districtSelect = $('#district');
                        districtSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, district) {
                            districtSelect.append('<option value="' + district + '">' + district + '</option>');
                        });
                        // Reset dropdown phường/xã
                        $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi AJAX loadDistricts:', error); // Debug
                        toastr.error("Lỗi kết nối server khi tải danh sách quận/huyện.");
                    }
                });
            }

            // AJAX tải phường/xã theo quận/huyện cho form add
            function loadWards(district) {
                console.log('Gọi loadWards với district:', district); // Debug
                if (district === '') {
                    $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {
                        method: "getWards",
                        district: district
                    },
                    success: function (data) {
                        console.log('Nhận response wards:', data); // Debug
                        var wardSelect = $('#ward');
                        wardSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, ward) {
                            wardSelect.append('<option value="' + ward + '">' + ward + '</option>');
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi AJAX loadWards:', error); // Debug
                        toastr.error("Lỗi kết nối server khi tải danh sách phường/xã.");
                    }
                });
            }

            // AJAX tải quận/huyện theo tỉnh cho form edit
            function loadDistrictsForEdit(province, selectedDistrict) {
                console.log('Gọi loadDistrictsForEdit với province:', province); // Debug
                if (province === '') {
                    $('#edit-district').empty().append('<option value="">Lựa chọn...</option>');
                    $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
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
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
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
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi AJAX loadWardsForEdit:', error); // Debug
                        toastr.error("Lỗi kết nối server khi tải danh sách phường/xã.");
                    }
                });
            }
        </script>
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>