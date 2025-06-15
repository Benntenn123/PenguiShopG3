<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Gửi phản hồi #${customerRequest.requestID}</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listRequestSupport">Yêu cầu người dùng</a></li>
                                            <li class="breadcrumb-item active">Gửi phản hồi</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Thông tin yêu cầu gốc -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Thông tin yêu cầu</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Khách hàng:</label>
                                                    <p class="form-control-static">${customerRequest.name_request}</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email:</label>
                                                    <p class="form-control-static">${customerRequest.email_request}</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Số điện thoại:</label>
                                                    <p class="form-control-static">${customerRequest.phone_request}</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày gửi:</label>
                                                    <p class="form-control-static">
                                                        ${customerRequest.requestDate}
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Loại yêu cầu:</label>
                                                    <p class="form-control-static">
                                                        <span class="badge badge-soft-primary">${customerRequest.requestType}</span>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Tình trạng:</label>
                                                    <p class="form-control-static">
                                                        <c:if test="${customerRequest.requestStatus == 0}">
                                                            <span class="badge badge-soft-primary">Chưa phản hồi</span>
                                                        </c:if>
                                                        <c:if test="${customerRequest.requestStatus == 1}">
                                                            <span class="badge badge-soft-primary">Đã phản hồi</span>
                                                        </c:if>
                                                    </p>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Nội dung yêu cầu:</label>
                                                    <div class="border p-3 bg-light rounded">
                                                        ${customerRequest.description}
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${customerRequest.requestStatus == 1}">
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Nội dung phản hồi:</label>
                                                        <div class="border p-3 bg-light rounded">
                                                            ${customerRequest.response}
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form gửi phản hồi -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Soạn phản hồi</h4>
                                        <p class="card-title-desc">Nhập nội dung phản hồi cho khách hàng</p>
                                    </div>
                                    <div class="card-body">
                                        <form action="responseSupport" method="post" id="responseForm">
                                            <input type="hidden" name="requestID" value="${customerRequest.requestID}"/>
                                            <input type="hidden" name="fullName" value="${customerRequest.name_request}"/>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label for="subject" class="form-label">Địa chỉ Email <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="email" name="email" 
                                                               value="${customerRequest.email_request}" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label for="subject" class="form-label">Tiêu đề phản hồi <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="subject" name="subject" 
                                                               value="Re: ${customerRequest.requestType} - Yêu cầu #${customerRequest.requestID}" required>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="mb-3">
                                                <label for="ckeditor-classic" class="form-label">Nội dung phản hồi <span class="text-danger">*</span></label>
                                                <div id="ckeditor-classic"></div>
                                                <textarea name="responseContent" id="responseContent" style="display: none;"></textarea>
                                            </div>


                                            <div class="text-end">
                                                <!--                                                <button type="button" class="btn btn-secondary me-2" onclick="saveDraft()">
                                                                                                    <i class="bx bx-save me-1"></i> Lưu nháp
                                                                                                </button>-->

                                                <a href="listRequestSupport" class="btn btn-light me-2">
                                                    <i class="bx bx-arrow-back me-1"></i> Quay lại
                                                </a>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bx bx-send me-1"></i> Gửi phản hồi
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <!-- end Col -->
                    </div>
                    <!-- end row -->
                </div> <!-- container-fluid -->
            </div>
            <!-- End Page-content -->


            <!-- end modal -->
        </div>
        <script src="../Admin/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
        <script src="../Admin/assets/js/ckeditor-upload-adapter.js"></script>
        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

        <!-- CKEditor Script -->
        <script>
            let ckEditor;

            // Khởi tạo CKEditor
            ClassicEditor
                    .create(document.querySelector('#ckeditor-classic'), {
                        placeholder: 'Nhập nội dung...',
                        extraPlugins: [CustomUploadAdapterPlugin],
                        toolbar: [
                            'heading', '|',
                            'bold', 'italic', 'underline', '|',
                            'link', 'bulletedList', 'numberedList', '|',
                            'imageUpload', // ✅ nút upload ảnh từ local
                            'undo', 'redo'
                        ],

                        heading: {
                            options: [
                                {model: 'paragraph', title: 'Đoạn văn', class: 'ck-heading_paragraph'},
                                {model: 'heading1', view: 'h1', title: 'Tiêu đề 1', class: 'ck-heading_heading1'},
                                {model: 'heading2', view: 'h2', title: 'Tiêu đề 2', class: 'ck-heading_heading2'},
                                {model: 'heading3', view: 'h3', title: 'Tiêu đề 3', class: 'ck-heading_heading3'}
                            ]
                        },
                        fontSize: {
                            options: [
                                9, 11, 13, 'default', 17, 19, 21
                            ]
                        }
                    })
                    .then(editor => {
                        ckEditor = editor;

                        // Template mặc định
                    })
                    .catch(error => {
                        console.error(error);
                    });

            // Xử lý form submit
            document.getElementById('responseForm').addEventListener('submit', function (e) {
                e.preventDefault();

                // Lấy nội dung từ CKEditor
                if (ckEditor) {
                    document.getElementById('responseContent').value = ckEditor.getData();
                }

                // Validate
                if (!document.getElementById('subject').value.trim()) {
                    alert('Vui lòng nhập tiêu đề phản hồi');
                    return;
                }

                if (!ckEditor.getData().trim()) {
                    alert('Vui lòng nhập nội dung phản hồi');
                    return;
                }

                // Confirm trước khi gửi
                if (confirm('Bạn có chắc chắn muốn gửi phản hồi này?')) {
                    this.submit();
                }
            });

            // Lưu nháp
            function saveDraft() {
                if (ckEditor) {
                    const draftData = {
                        subject: document.getElementById('subject').value,
                        content: ckEditor.getData(),
                        requestID: '${customerRequest.requestID}'
                    };

                    // Lưu vào localStorage hoặc gửi Ajax
                    localStorage.setItem('draft_' + draftData.requestID, JSON.stringify(draftData));

                    // Hiển thị thông báo
                    showToast('Đã lưu nháp thành công', 'success');
                }
            }

            // Xem trước
            function previewResponse() {
                if (ckEditor) {
                    document.getElementById('previewSubject').textContent = document.getElementById('subject').value;
                    document.getElementById('previewContent').innerHTML = ckEditor.getData();

                    // Mở modal
                    const modal = new bootstrap.Modal(document.getElementById('previewModal'));
                    modal.show();
                }
            }

            // Submit form từ modal
            function submitForm() {
                document.getElementById('responseForm').dispatchEvent(new Event('submit'));
            }

            // Load draft nếu có
            window.addEventListener('load', function () {
                const draftKey = 'draft_${customerRequest.requestID}';
                const savedDraft = localStorage.getItem(draftKey);

                if (savedDraft) {
                    const draft = JSON.parse(savedDraft);
                    document.getElementById('subject').value = draft.subject || '';

                    if (ckEditor && draft.content) {
                        ckEditor.setData(draft.content);
                    }

                    showToast('Đã tải nháp đã lưu', 'info');
                }
            });

            // Utility function hiển thị toast
            function showToast(message, type = 'success') {
                // Implement toast notification
                const toast = document.createElement('div');
                toast.className = `toast align-items-center text-white bg-${type} border-0`;
                toast.setAttribute('role', 'alert');
                toast.innerHTML = `
                    <div class="d-flex">
                        <div class="toast-body">${message}</div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                `;

                document.body.appendChild(toast);
                const bsToast = new bootstrap.Toast(toast);
                bsToast.show();

                setTimeout(() => {
                    document.body.removeChild(toast);
                }, 5000);
            }
        </script>
    </body>
</html>