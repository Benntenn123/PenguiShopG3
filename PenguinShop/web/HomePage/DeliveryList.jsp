
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #AE1C9A;
                --primary-light: #D946C7;
                --primary-dark: #8B1477;
                --secondary-color: #F3E8FF;
                --accent-color: #FFB84D;
                --text-dark: #374151;
                --text-light: #6B7280;
                --border-color: #E5E7EB;
                --success-color: #10B981;
                --danger-color: #EF4444;
                --bg-gradient: linear-gradient(135deg, #AE1C9A 0%, #D946C7 100%);
            }

            a {
                text-decoration: none;
            }

            /* Add Address Button */
            .shop-btn {
                background: var(--bg-gradient);
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(174, 28, 154, 0.3);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .shop-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(174, 28, 154, 0.4);
                background: linear-gradient(135deg, #8B1477 0%, #AE1C9A 100%);
            }

            /* Address Card */
            .seller-info {
                background: white;
                border-radius: 20px;
                padding: 25px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
                border: 2px solid transparent;
                transition: all 0.3s ease;
                position: relative;
                animation: slideInUp 0.5s ease forwards;
            }

            .seller-info::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--bg-gradient);
            }

            .seller-info:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(174, 28, 154, 0.15);
                border-color: var(--primary-color);
            }

            .seller-info .heading {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 18px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .seller-info .heading::before {
                content: '\f3c5';
                font-family: 'Font Awesome 6 Free';
                font-weight: 900;
                color: var(--primary-color);
            }

            /* Dropdown Menu */
            .delivery-menu-container {
                position: relative;
            }

            .delivery-dots-btn {
                background: var(--secondary-color);
                border: none;
                cursor: pointer;
                padding: 8px 12px;
                border-radius: 10px;
                transition: all 0.3s ease;
                font-size: 18px;
                color: var(--primary-color);
                font-weight: bold;
            }

            .delivery-dots-btn:hover {
                background: var(--primary-color);
                color: white;
                transform: scale(1.1);
            }

            .delivery-dropdown-menu {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                border: none;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                min-width: 180px;
                z-index: 1000;
                opacity: 0;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.3s ease;
            }

            .delivery-dropdown-menu.show {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .delivery-dropdown-item {
                padding: 15px 20px;
                cursor: pointer;
                color: var(--text-dark);
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .delivery-dropdown-item:hover {
                background: var(--secondary-color);
                color: var(--primary-color);
                padding-left: 25px;
            }

            .delivery-dropdown-item.delete {
                color: var(--danger-color);
            }

            .delivery-dropdown-item.delete:hover {
                background: #FEF2F2;
                color: var(--danger-color);
            }

            .delivery-dropdown-item:first-child::before {
                content: '\f044';
                font-family: 'Font Awesome 6 Free';
                font-weight: 900;
            }



            .delivery-dropdown-item:last-child::before {
                content: '\f2ed';
                font-family: 'Font Awesome 6 Free';
                font-weight: 900;
            }

            /* Info Table */
            .info-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            .info-table td {
                padding: 8px 0;
                vertical-align: top;
                border-bottom: 1px solid #F3F4F6;
            }

            .info-table tr:last-child td {
                border-bottom: none;
            }

            .info-table .label {
                font-weight: 600;
                width: 120px;
                color: var(--text-dark);
                font-size: 14px;
                padding-right: 15px;
                position: relative;
            }

            .info-table .label::after {
                content: ':';
                position: absolute;
                right: 8px;
                color: var(--primary-color);
                font-weight: bold;
            }

            .info-table .value {
                color: var(--text-light);
                font-size: 14px;
                word-break: break-word;
                line-height: 1.4;
            }

            /* Default Badge */
            .default-badge {
                background: var(--bg-gradient);
                color: white;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .default-badge::before {
                content: '\f005';
                font-family: 'Font Awesome 6 Free';
                font-weight: 900;
                font-size: 10px;
            }

            /* Modal */
            .modal-wrapper {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                z-index: 9999;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
                backdrop-filter: blur(5px);
            }

            .modal-wrapper.active {
                opacity: 1;
                visibility: visible;
            }

            .modal-wrapper .modal-main {
                max-width: 550px;
                overflow-y: auto; /* Cho phép cuộn dọc */
                scrollbar-width: none; /* Firefox */
                -ms-overflow-style: none;  /* IE/Edge */
            }

            .modal-wrapper .modal-main::-webkit-scrollbar {
                display: none; /* Chrome, Safari */
            }



            /* Thêm giới hạn và cuộn nội dung form */
            .login-section {
                border-radius: 20px;
                flex: 1; /* chiếm toàn bộ chiều cao còn lại */
                overflow-y: auto;
                padding: 40px 30px;
                overflow-y: auto;
                flex: 1;
            }


            .modal-wrapper.active .modal-main {
                transform: scale(1) translateY(0);
            }



            .comment-title {
                color: var(--primary-color);
                font-weight: 700;
                text-align: center;
                margin-bottom: 30px;
                font-size: 22px;
            }

            .close-btn {
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
                padding: 10px;
                border-radius: 50%;
                transition: all 0.3s ease;
            }

            .close-btn:hover {
                background: var(--secondary-color);
                transform: scale(1.1);
            }

            .close-btn img {
                width: 20px;
                height: 20px;
                filter: hue-rotate(280deg);
            }

            /* Form */
            .form-label {
                color: var(--text-dark);
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .form-control, .form-select {
                border: 2px solid var(--border-color);
                border-radius: 10px;
                padding: 12px 15px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
                outline: none;
            }

            .review-form {
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .review-form-name {
                margin-bottom: 20px;
            }

            .account-inner-form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .city-inner-form {
                grid-template-columns: 1fr 1fr;
            }

            .address-form {
                margin-bottom: 30px;
            }

            /* Disabled Select */
            .form-select:disabled {
                background-color: #f9f9f9;
                opacity: 0.7;
                cursor: not-allowed;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .seller-info {
                    margin-bottom: 20px;
                }

                .account-inner-form {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }

                .info-table .label {
                    width: 100px;
                    font-size: 13px;
                }

                .info-table .value {
                    font-size: 13px;
                }

                .login-section {
                    padding: 30px 20px;
                }
            }

            /* Animation */
            @keyframes slideInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .seller-info:nth-child(even) {
                animation-delay: 0.1s;
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
                                <div class="profile-section address-section addresses">
                                    <div class="row">
                                        <div class="col-12 mb-4">
                                            <a href="#" class="shop-btn" onclick="modalAction('.submit')">
                                                <i class="fas fa-plus me-2"></i>Thêm địa chỉ nhận mới
                                            </a>
                                        </div>
                                    </div>
                                    <div class="row gy-4">

                                        <c:forEach var="deInfo" items="${deInfo}" varStatus="loop">
                                            <div class="col-md-6">
                                                <div class="seller-info">
                                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                                        <h5 class="heading">Địa chỉ ${loop.index + 1}</h5>
                                                        <div class="delivery-menu-container">
                                                            <button class="delivery-dots-btn" onclick="toggleDeliveryDropdown(event, ${deInfo.deliveryInfoID})">⋮</button>
                                                            <div class="delivery-dropdown-menu" data-delivery-id="${deInfo.deliveryInfoID}">
                                                                <div class="delivery-dropdown-item" onclick="editDeliveryAddress(${deInfo.deliveryInfoID}, '${deInfo.fullName}', '${deInfo.email}', '${deInfo.phone}', '${deInfo.city}', '${deInfo.addessDetail}')">Chỉnh sửa</div>
                                                                <div class="delivery-dropdown-item" onclick="statusDeliveryAddress(${deInfo.deliveryInfoID})">Đặt làm mặc định</div>
                                                                <div class="delivery-dropdown-item delete" onclick="deleteDeliveryAddress(${deInfo.deliveryInfoID})">Xóa</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <table class="info-table">
                                                        <tr>
                                                            <td class="label">Người nhận</td>
                                                            <td class="value">${deInfo.fullName}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Địa chỉ Email</td>
                                                            <td class="value">${deInfo.email}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Số điện thoại</td>
                                                            <td class="value">${deInfo.phone}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Thành Phố</td>
                                                            <td class="value">${deInfo.city}</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Địa chỉ</td>
                                                            <td class="value">${deInfo.addessDetail}</td>
                                                        </tr>
                                                        <c:if test="${deInfo.isDefault eq 1}">
                                                            <tr>
                                                                <td class="label">Trạng thái</td>
                                                                <td class="value"><span class="default-badge">Mặc định</span></td>
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
                                                            <h5 class="comment-title" style="margin-bottom: 50px">Thêm thông tin người nhận mới</h5>
                                                            <div class="close-btn">
                                                                <img src="./HomePage/assets/images/homepage-one/close-btn.png"
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
                                                        <div class="form-label" style="margin-bottom: 10px; font-size: 15px">Địa chỉ sẽ lưu:</div>
                                                        <div id="preview-address" style="font-weight: 600; color: var(--primary-color); margin-bottom: 30px; font-size: 15px"></div>

                                                        <div class="login-btn text-center">
                                                            <button type="submit" class="shop-btn">
                                                                <i class="fas fa-save me-2"></i>Thêm địa chỉ
                                                            </button>
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
                                                                <img src="./HomePage/assets/images/homepage-one/close-btn.png"
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
                                                        <div class="review-form-name address-form">
                                                            <label for="edit-useraddress-old" class="form-label">Địa chỉ cũ*</label>
                                                            <input type="text" id="edit-useraddress-old" name="addressDetailOld" class="form-control"
                                                                   readonly="">
                                                        </div>
                                                        <div class="login-btn text-center">
                                                            <button type="submit" class="shop-btn">
                                                                <i class="fas fa-edit me-2"></i>Cập nhật địa chỉ
                                                            </button>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                                    function updatePreview() {
                                                                        const detail = document.getElementById('useraddress')?.value.trim();
                                                                        const ward = document.getElementById('ward')?.options[document.getElementById('ward').selectedIndex]?.text || '';
                                                                        const district = document.getElementById('district')?.options[document.getElementById('district').selectedIndex]?.text || '';
                                                                        const province = document.getElementById('province')?.options[document.getElementById('province').selectedIndex]?.text || '';

                                                                        const parts = [detail, ward, district, province].filter(part => part !== '');
                                                                        const previewEl = document.getElementById('preview-address');
                                                                        if (previewEl)
                                                                            previewEl.textContent = parts.join(' - ');
                                                                    }

                                                                    // Gắn sự kiện theo dõi thay đổi
                                                                    document.getElementById('province')?.addEventListener('change', updatePreview);
                                                                    document.getElementById('district')?.addEventListener('change', updatePreview);
                                                                    document.getElementById('ward')?.addEventListener('change', updatePreview);
                                                                    document.getElementById('useraddress')?.addEventListener('input', updatePreview);
        </script>
        <script>
            var deInfoSize = ${deInfo.size()};

            function toggleDeliveryDropdown(event, deliveryId) {
                event.preventDefault();
                var dropdown = event.target.nextElementSibling;
                if (dropdown && dropdown.classList.contains('delivery-dropdown-menu')) {
                    if (dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    } else {
                        document.querySelectorAll('.delivery-dropdown-menu.show').forEach(item => item.classList.remove('show'));
                        dropdown.classList.add('show');
                    }
                }
            }

            function parseCity(addressDetail) {
                if (!addressDetail)
                    return {province: '', district: '', ward: ''};
                const parts = addressDetail.split(' - ').map(part => part.trim());
                let province = '', district = '', ward = '';
                if (parts.length >= 3) {
                    province = parts[parts.length - 1]; // Tỉnh/thành phố
                    district = parts[parts.length - 2]; // Huyện/quận
                    ward = parts[parts.length - 3]; // Xã/phường (bỏ "Thôn" nếu có)
                    ward = ward.replace(/Thôn\s+\d+\s*-/, '').trim();
                }
                return {province, district, ward};
            }

            function editDeliveryAddress(deliveryId, fullName, email, phone, city, addressDetail) {
                document.querySelectorAll('.delivery-dropdown-menu.show').forEach(dropdown => dropdown.classList.remove('show'));

                // Điền dữ liệu cơ bản
                document.getElementById('edit-delivery-id').value = deliveryId;
                document.getElementById('edit-fullname').value = fullName || '';
                document.getElementById('edit-useremail').value = email || '';
                document.getElementById('edit-userphone').value = phone || '';
                document.getElementById('edit-useraddress-old').value = addressDetail || '';

                // Tách chuỗi từ addressDetail
                console.log('AddressDetail:', addressDetail);
                const {province, district, ward} = parseCity(addressDetail);
                console.log('Parsed:', {province, district, ward});

                // Gán giá trị tạm thời
                document.getElementById('edit-province').value = province;
                document.getElementById('edit-district').value = district;
                document.getElementById('edit-ward').value = ward;

                // Disable district và ward ban đầu
                $('#edit-district').prop('disabled', true);
                $('#edit-ward').prop('disabled', true);

                modalAction('.edit');
                console.log('Editing address:', deliveryId);
            }

            function loadDistricts(province) {
                console.log('Calling loadDistricts with province:', province);
                if (!province) {
                    $('#district').empty().append('<option value="">Lựa chọn...</option>');
                    $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {method: "getDistricts", province: province},
                    success: function (data) {
                        console.log('Received districts:', data);
                        if (!data || !Array.isArray(data) || data.length === 0) {
                            console.warn('Districts data is empty or invalid:', data);
                            alert('Không có dữ liệu quận/huyện.');
                            $('#district').empty().append('<option value="">Lựa chọn...</option>');
                            $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                            return;
                        }
                        var districtSelect = $('#district');
                        districtSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, district) {
                            districtSelect.append('<option value="' + district + '">' + district + '</option>');
                        });
                        $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX error in loadDistricts:', error, xhr.responseText);
                        alert('Lỗi tải danh sách quận/huyện.');
                    }
                });
            }

            function loadWards(district) {
                console.log('Calling loadWards with district:', district);
                if (!district) {
                    $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {method: "getWards", district: district},
                    success: function (data) {
                        console.log('Received wards:', data);
                        if (!data || !Array.isArray(data) || data.length === 0) {
                            console.warn('Wards data is empty or invalid:', data);
                            alert('Không có dữ liệu phường/xã.');
                            $('#ward').empty().append('<option value="">Lựa chọn...</option>');
                            return;
                        }
                        var wardSelect = $('#ward');
                        wardSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, ward) {
                            wardSelect.append('<option value="' + ward + '">' + ward + '</option>');
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX error in loadWards:', error, xhr.responseText);
                        alert('Lỗi tải danh sách phường/xã.');
                    }
                });
            }

            function loadDistrictsForEdit(province) {
                console.log('Calling loadDistrictsForEdit with province:', province);
                if (!province) {
                    $('#edit-district').empty().append('<option value="">Lựa chọn...</option>');
                    $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                    $('#edit-district').prop('disabled', true);
                    $('#edit-ward').prop('disabled', true);
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {method: "getDistricts", province: province},
                    success: function (data) {
                        console.log('Received districts:', data);
                        if (!data || !Array.isArray(data) || data.length === 0) {
                            console.warn('Districts data is empty or invalid:', data);
                            alert('Không có dữ liệu quận/huyện.');
                            $('#edit-district').empty().append('<option value="">Lựa chọn...</option>');
                            $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                            $('#edit-district').prop('disabled', true);
                            $('#edit-ward').prop('disabled', true);
                            return;
                        }
                        var districtSelect = $('#edit-district');
                        districtSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, district) {
                            districtSelect.append('<option value="' + district + '">' + district + '</option>');
                        });
                        // Enable district và gán giá trị tạm thời
                        $('#edit-district').prop('disabled', false);
                        const tempDistrict = districtSelect.val() || '';
                        if (tempDistrict) {
                            loadWardsForEdit(tempDistrict);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX error in loadDistrictsForEdit:', error, xhr.responseText);
                        alert('Lỗi tải danh sách quận/huyện.');
                        $('#edit-district').empty().append('<option value="">Lựa chọn...</option>');
                        $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                        $('#edit-district').prop('disabled', true);
                        $('#edit-ward').prop('disabled', true);
                    }
                });
            }

            function loadWardsForEdit(district) {
                console.log('Calling loadWardsForEdit with district:', district);
                if (!district) {
                    $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                    $('#edit-ward').prop('disabled', true);
                    return;
                }
                $.ajax({
                    url: "deliveryinfo",
                    type: "POST",
                    data: {method: "getWards", district: district},
                    success: function (data) {
                        console.log('Received wards:', data);
                        if (!data || !Array.isArray(data) || data.length === 0) {
                            console.warn('Wards data is empty or invalid:', data);
                            alert('Không có dữ liệu phường/xã.');
                            $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                            $('#edit-ward').prop('disabled', true);
                            return;
                        }
                        var wardSelect = $('#edit-ward');
                        wardSelect.empty().append('<option value="">Lựa chọn...</option>');
                        $.each(data, function (index, ward) {
                            wardSelect.append('<option value="' + ward + '">' + ward + '</option>');
                        });
                        // Enable ward
                        $('#edit-ward').prop('disabled', false);
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX error in loadWardsForEdit:', error, xhr.responseText);
                        alert('Lỗi tải danh sách phường/xã.');
                        $('#edit-ward').empty().append('<option value="">Lựa chọn...</option>');
                        $('#edit-ward').prop('disabled', true);
                    }
                });
            }

            function statusDeliveryAddress(deliveryId) {
                document.querySelector(`.delivery-dropdown-menu[data-delivery-id="${deliveryId}"]`)?.classList.remove('show');
                if (confirm('Bạn có muốn đặt địa chỉ này làm mặc định?')) {
                    alert('Địa chỉ đã được đặt làm mặc định!');
                    window.location.href = "updatedelidefault?deID=" + deliveryId;
                }
                console.log('Set as default:', deliveryId);
            }

            function deleteDeliveryAddress(deliveryId) {
                document.querySelector(`.delivery-dropdown-menu[data-delivery-id="${deliveryId}"]`)?.classList.remove('show');
                if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                    alert('Địa chỉ đã được xóa!');
                    window.location.href = "deletedelivery?deID=" + deliveryId;
                }
                console.log('Delete address:', deliveryId);
            }

            function modalAction(selector) {
                document.querySelector(selector).classList.toggle('active');
            }

            document.addEventListener('click', function (event) {
                if (!event.target.closest('.delivery-menu-container')) {
                    document.querySelectorAll('.delivery-dropdown-menu.show').forEach(dropdown => dropdown.classList.remove('show'));
                }
            });
        </script>
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>