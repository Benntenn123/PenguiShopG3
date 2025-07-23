<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                            <h4 class="mb-sm-0 font-size-18">Danh sách Feedback</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý Feedback</a></li>
                                    <li class="breadcrumb-item active">Danh sách Feedback</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Search Form -->
                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Tìm kiếm Feedback</h5>
                            </div>
                            <div class="card-body">
                                <form method="get" action="feedbackList">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Tên sản phẩm</label>
                                                <input type="text" class="form-control" name="productName" 
                                                       value="${param.productName}" placeholder="Nhập tên sản phẩm">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <label class="form-label">Tên người đánh giá</label>
                                                <input type="text" class="form-control" name="userName" 
                                                       value="${param.userName}" placeholder="Nhập tên người dùng">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="mb-3">
                                                <label class="form-label">Số sao</label>
                                                <select class="form-select" name="rating">
                                                    <option value="">Tất cả</option>
                                                    <option value="5" ${param.rating == '5' ? 'selected' : ''}>5 sao</option>
                                                    <option value="4" ${param.rating == '4' ? 'selected' : ''}>4 sao</option>
                                                    <option value="3" ${param.rating == '3' ? 'selected' : ''}>3 sao</option>
                                                    <option value="2" ${param.rating == '2' ? 'selected' : ''}>2 sao</option>
                                                    <option value="1" ${param.rating == '1' ? 'selected' : ''}>1 sao</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="mb-3">
                                                <label class="form-label">Từ ngày</label>
                                                <input type="date" class="form-control" name="fromDate" 
                                                       value="${param.fromDate}">
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="mb-3">
                                                <label class="form-label">Đến ngày</label>
                                                <input type="date" class="form-control" name="toDate" 
                                                       value="${param.toDate}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary me-2">
                                                <i class="bx bx-search me-1"></i>Tìm kiếm
                                            </button>
                                            <a href="feedbackList" class="btn btn-secondary">
                                                <i class="bx bx-refresh me-1"></i>Đặt lại
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="table-responsive mb-4">
                    <c:if test="${not empty param.productName || not empty param.userName || not empty param.rating || not empty param.fromDate || not empty param.toDate}">
                        <div class="alert alert-info">
                            <i class="bx bx-info-circle me-1"></i>
                            Tìm thấy <strong>${feedbackList.size()}</strong> feedback phù hợp với điều kiện tìm kiếm.
                        </div>
                    </c:if>
                    <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                        <thead>
                        <tr>
                            <th scope="col">Thời gian</th>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Nội dung</th>
                            <th scope="col">Người đánh giá</th>
                            <th scope="col">Số sao</th>
                            <th scope="col">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty feedbackList}">
                                <tr>
                                    <td colspan="6" class="text-center py-4">
                                        <i class="bx bx-search-alt-2 font-size-24 text-muted"></i>
                                        <p class="text-muted mt-2">Không tìm thấy feedback nào</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${feedbackList}" var="fb">
                                    <tr>
                                        <td><fmt:formatDate value="${fb.feedbackDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>${fb.product != null ? fb.product.productName : ''}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(fb.comment) > 50}">
                                                    ${fn:substring(fb.comment, 0, 50)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${fb.comment}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${fb.user != null ? fb.user.fullName : ''}</td>
                                        <td>
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= fb.rating}">
                                                        <i class="bx bxs-star text-warning"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bx bx-star text-muted"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <span class="ms-1">(${fb.rating})</span>
                                        </td>
                                        <td>
                                            <a class="btn btn-info btn-sm" href="feedbackDetail?feedbackID=${fb.feedbackID}">
                                                <i class="bx bx-show me-1"></i>Xem chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function messageSeller(productID) {
        // Chuyển hướng sang trang nhắn tin cho người bán (cần BE hỗ trợ route)
        window.location.href = '../admin/messageSeller?productID=' + productID;
    }
</script>
<jsp:include page="Common/RightSideBar.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>
</body>
</html>
