<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        <title>Chi tiết Feedback</title>
    </head>
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết Feedback</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="ListFeedBack.jsp">Quản lý Feedback</a></li>
                                            <li class="breadcrumb-item active">Chi tiết Feedback</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty feedback}">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-4 text-center">
                                                <h5 style="font-size: 18px">${feedback.user != null ? feedback.user.fullName : ''}</h5>
                                                <span style="font-size: 16px" >${feedback.product != null ? feedback.product.productName : ''}</span>

                                                <div class="mt-2">Số sao: <b>${feedback.rating}</b></div>
                                            </div>
                                            <div class="col-md-8">
                                                <div style="font-size: 16px; margin-bottom: 10px"><b>Thời gian:</b> <fmt:formatDate value="${feedback.feedbackDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                                                <div style="font-size: 16px ; margin-bottom: 10px"><b>Nội dung:</b> ${feedback.comment}</div>
                                                <div style="font-size: 16px ; margin-bottom: 10px"><b>Ảnh feedback:</b><br/>
                                                    <c:choose>
                                                        <c:when test="${not empty feedback.images}">
                                                            <c:forEach items="${feedback.images}" var="img">
                                                                <img src="../api/img/${img}" class="img-thumbnail me-2 mb-2" style="max-width:100px;"/>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>Không có ảnh</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div style="margin-top: 20px">
                                                    <button class="btn btn-warning" onclick="showReplyModal()">Phản hồi người mua</button>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger">Không tìm thấy feedback.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!-- Modal phản hồi người mua -->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="replyModalLabel">Phản hồi người mua</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="replyContent" class="form-label">Nội dung phản hồi</label>
                    <textarea class="form-control" id="replyContent" rows="5" placeholder="Nhập nội dung phản hồi..."></textarea>
                </div>
                <div id="replyError" class="text-danger" style="display:none"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-primary" onclick="sendReplyToBuyer()">Gửi phản hồi</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal xác nhận gửi thành công -->
<div class="modal fade" id="replySuccessModal" tabindex="-1" aria-labelledby="replySuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="replySuccessModalLabel">Gửi phản hồi thành công</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Phản hồi đã được gửi tới email của người mua.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Common/RightSideBar.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>

<script>
    var FEEDBACK_DETAIL_DATA = {
        feedbackID: '<c:out value="${feedback.feedbackID}"/>',
        email: '<c:out value="${feedback.user.email}" default=""/>',
        name: '<c:out value="${feedback.user.fullName}" default=""/>'
    };
    function showReplyModal() {
        document.getElementById('replyContent').value = '';
        document.getElementById('replyError').style.display = 'none';
        var modal = new bootstrap.Modal(document.getElementById('replyModal'));
        modal.show();
    }

    function sendReplyToBuyer() {
        var content = document.getElementById('replyContent').value.trim();
        if (!content) {
            document.getElementById('replyError').innerText = 'Vui lòng nhập nội dung phản hồi.';
            document.getElementById('replyError').style.display = 'block';
            return;
        }
        document.getElementById('replyError').style.display = 'none';
        fetch('../api/sendFeedbackReply', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                feedbackID: FEEDBACK_DETAIL_DATA.feedbackID,
                email: FEEDBACK_DETAIL_DATA.email,
                name: FEEDBACK_DETAIL_DATA.name,
                content: content
            })
        })
                .then(res => res.json())
                .then(data => {
                    if (data && data.success) {
                        var modal = new bootstrap.Modal(document.getElementById('replySuccessModal'));
                        modal.show();
                        bootstrap.Modal.getInstance(document.getElementById('replyModal')).hide();
                    } else {
                        document.getElementById('replyError').innerText = data && data.message ? data.message : 'Gửi phản hồi thất bại.';
                        document.getElementById('replyError').style.display = 'block';
                    }
                })
                .catch(() => {
                    document.getElementById('replyError').innerText = 'Có lỗi xảy ra khi gửi phản hồi.';
                    document.getElementById('replyError').style.display = 'block';
                });
    }

</script>

</body>
</html>
