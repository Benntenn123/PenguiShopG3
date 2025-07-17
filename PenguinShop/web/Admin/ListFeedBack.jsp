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
                <div class="table-responsive mb-4">
                    <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                        <thead>
                        <tr>
                            <th scope="col">Thời gian</th>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Nội dung</th>
                            <th scope="col">Người đánh giá</th>
                            <th scope="col">Số sao</th>
                        </tr>
                        </thead>
                        <tbody>
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
                                <td>${fb.rating}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="Common/RightSideBar.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>
</body>
</html>
