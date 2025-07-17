
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-container .form-label {
            font-weight: bold;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
        .is-invalid ~ .error-message {
            display: block;
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
                                <h4 class="mb-sm-0 font-size-18">Thêm Khuyến Mãi Mới</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="promotion">Khuyến Mãi</a></li>
                                        <li class="breadcrumb-item active">Thêm Mới</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-container">
                        <form action="addPromotion" method="post" id="addPromotionForm">
                            <input type="hidden" name="action" value="add">

                            <div class="mb-3">
                                <label for="promotionName" class="form-label">Tên Khuyến Mãi</label>
                                <input type="text" class="form-control" id="promotionName" name="promotionName" required>
                                <c:if test="${not empty errors.promotionName}">
                                    <span class="error-message">${errors.promotionName}</span>
                                </c:if>
                                <c:if test="${not empty errors.general}">
                                    <span class="error-message">${errors.general}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="discountType" class="form-label">Loại Giảm</label>
                                <select class="form-select" id="discountType" name="discountType" required>
                                    <option value="PERCENTAGE">Phần trăm</option>
                                    <option value="FIXED">Cố định</option>
                                </select>
                                <c:if test="${not empty errors.discountType}">
                                    <span class="error-message">${errors.discountType}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="discountValue" class="form-label">Giá Trị Giảm</label>
                                <input type="number" step="0.01" class="form-control" id="discountValue" name="discountValue" required>
                                <span class="error-message" id="discountValueError" style="display: none;">Giá trị giảm phải lớn hơn 0.</span>
                                <c:if test="${not empty errors.discountValue}">
                                    <span class="error-message">${errors.discountValue}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="startDate" class="form-label">Ngày Bắt Đầu</label>
                                <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                                <span class="error-message" id="startDateError" style="display: none;">Ngày bắt đầu phải là ngày hiện tại hoặc trong tương lai.</span>
                                <c:if test="${not empty errors.startDate}">
                                    <span class="error-message">${errors.startDate}</span>
                                </c:if>
                                <c:if test="${not empty errors.date}">
                                    <span class="error-message">${errors.date}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="endDate" class="form-label">Ngày Kết Thúc</label>
                                <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                                <span class="error-message" id="endDateError" style="display: none;">Ngày kết thúc phải sau ngày bắt đầu ít nhất 1 phút.</span>
                                <c:if test="${not empty errors.endDate}">
                                    <span class="error-message">${errors.endDate}</span>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="isActive" class="form-label">Trạng Thái</label>
                                <select class="form-select" id="isActive" name="isActive" required>
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Ngừng hoạt động</option>
                                </select>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary" id="submitBtn">Thêm Khuyến Mãi</button>
                                <a href="promotion" class="btn btn-secondary">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <script>
            // Hàm để lấy ngày giờ hiện tại theo định dạng datetime-local (UTC+7 cho Việt Nam)
            function getCurrentDateTime() {
                const now = new Date();
                const vietnamTime = new Date(now.getTime() + (7 * 60 * 60 * 1000));
                const year = vietnamTime.getUTCFullYear();
                const month = String(vietnamTime.getUTCMonth() + 1).padStart(2, '0');
                const day = String(vietnamTime.getUTCDate()).padStart(2, '0');
                const hours = String(vietnamTime.getUTCHours()).padStart(2, '0');
                const minutes = String(vietnamTime.getUTCMinutes()).padStart(2, '0');
                return `${year}-${month}-${day}T${hours}:${minutes}`;
            }

            // Hàm để set min attribute cho các input datetime-local
            function setMinDateTime() {
                const currentDateTime = getCurrentDateTime();
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                if (startDateInput) startDateInput.setAttribute('min', currentDateTime);
                if (endDateInput) endDateInput.setAttribute('min', currentDateTime);
            }

            // Hàm validate ngày bắt đầu
            function validateStartDate() {
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const startDateError = document.getElementById('startDateError');
    const submitBtn = document.getElementById('submitBtn');

    if (!startDateInput || !startDateError || !submitBtn) {
        console.error('Required elements not found');
        return false;
    }

    if (!startDateInput.value) {
        startDateInput.classList.add('is-invalid');
        startDateError.style.display = 'block';
        submitBtn.disabled = true;
        return false;
    }

    // Lấy thời gian hiện tại theo múi giờ Việt Nam (UTC+7)
    const now = new Date();
    const vietnamNow = new Date(now.toLocaleString('en-US', { timeZone: 'Asia/Ho_Chi_Minh' }));

    // Chuyển đổi giá trị input sang thời gian Việt Nam
    const selectedStartDate = new Date(startDateInput.value);

    // So sánh thời gian (bỏ qua mili-giây để tránh lỗi nhỏ)
    if (selectedStartDate.getTime() <= vietnamNow.getTime()) {
        startDateInput.classList.add('is-invalid');
        startDateError.style.display = 'block';
        submitBtn.disabled = true;
        return false;
    } else {
        startDateInput.classList.remove('is-invalid');
        startDateError.style.display = 'none';
        submitBtn.disabled = false;

        if (endDateInput && endDateInput.value) {
            validateEndDate();
        }
        return true;
    }
}

            // Hàm validate ngày kết thúc
            function validateEndDate() {
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                const endDateError = document.getElementById('endDateError');
                const submitBtn = document.getElementById('submitBtn');

                if (!startDateInput || !endDateInput || !endDateError || !submitBtn) {
                    console.error('Required elements not found');
                    return false;
                }

                if (!startDateInput.value || !endDateInput.value) {
                    endDateInput.classList.add('is-invalid');
                    endDateError.style.display = 'block';
                    submitBtn.disabled = true;
                    return false;
                }

                const selectedStartDate = new Date(startDateInput.value);
                const selectedEndDate = new Date(endDateInput.value);

                if (selectedEndDate <= selectedStartDate) {
                    endDateInput.classList.add('is-invalid');
                    endDateError.style.display = 'block';
                    submitBtn.disabled = true;
                    return false;
                } else {
                    endDateInput.classList.remove('is-invalid');
                    endDateError.style.display = 'none';
                    submitBtn.disabled = false;
                    return true;
                }
            }

            // Hàm validate giá trị giảm
            function validateDiscountValue() {
                const discountValueInput = document.getElementById('discountValue');
                const discountValueError = document.getElementById('discountValueError');
                const submitBtn = document.getElementById('submitBtn');

                if (!discountValueInput || !discountValueError || !submitBtn) {
                    console.error('Required elements not found');
                    return false;
                }

                const discountValue = parseFloat(discountValueInput.value);
                if (isNaN(discountValue) || discountValue <= 0) {
                    discountValueInput.classList.add('is-invalid');
                    discountValueError.style.display = 'block';
                    submitBtn.disabled = true;
                    return false;
                } else {
                    discountValueInput.classList.remove('is-invalid');
                    discountValueError.style.display = 'none';
                    submitBtn.disabled = false;
                    return true;
                }
            }

            // Chạy khi trang được load
            document.addEventListener('DOMContentLoaded', function() {
                setMinDateTime();

                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                const discountValueInput = document.getElementById('discountValue');

                if (startDateInput) {
                    startDateInput.addEventListener('change', validateStartDate);
                }
                if (endDateInput) {
                    endDateInput.addEventListener('change', validateEndDate);
                }
                if (discountValueInput) {
                    discountValueInput.addEventListener('change', validateDiscountValue);
                }

                // Validate form on submit
                document.getElementById('addPromotionForm').addEventListener('submit', function(e) {
                    const isStartDateValid = validateStartDate();
                    const isEndDateValid = validateEndDate();
                    const isDiscountValueValid = validateDiscountValue();

                    if (!isStartDateValid || !isEndDateValid || !isDiscountValueValid) {
                        e.preventDefault();
                        alert('Vui lòng kiểm tra lại thông tin: ngày bắt đầu, ngày kết thúc, và giá trị giảm.');
                    }
                });
            });
        </script>
    </body>
</html>