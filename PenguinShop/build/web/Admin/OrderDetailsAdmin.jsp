<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết hóa đơn #${o.orderID}</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listOrderAdmin">Hóa Đơn</a></li>
                                            <li class="breadcrumb-item active">Chi tiết hóa đơn</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="invoice-title">
                                            <div class="d-flex align-items-start">
                                                <div class="flex-grow-1">
                                                    <div class="mb-4">
                                                        <img src="assets/images/logo-sm.svg" alt="" height="24"><span class="logo-txt">${o.user.fullName}</span>
                                                    </div>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="mb-4">
                                                        <h4 class="float-end font-size-16">Hóa đơn # ${o.orderID}</h4>
                                                    </div>
                                                </div>
                                            </div>



                                            <p class="mb-1"><i class="mdi mdi-email align-middle me-1"></i> ${o.user.email}</p>
                                            <p><i class="mdi mdi-phone align-middle me-1"></i> ${o.user.phone}</p>
                                        </div>
                                        <hr class="my-4">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div>
                                                    <h5 class="font-size-15">Địa chỉ người nhận</h5>
                                                    <h5 class="font-size-14 mb-2">Khách hàng : ${o.name_receiver}</h5>
                                                    <p class="mb-4">${o.shippingAddress}</p>

                                                </div>
                                                <div>
                                                    <h5 class="font-size-15 mb-1">Thông tin liên hệ</h5>
                                                    <p class="mb-1">${o.emall_receiver}</p>
                                                    <p>${o.phone_receiver}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div>
                                                    <div>
                                                        <h5 class="font-size-15">Ngày đặt hàng:</h5>
                                                        <p>${o.orderDate}</p>
                                                    </div>

                                                    <div class="mt-4">
                                                        <h5 class="font-size-15">Phương thức thanh toán</h5>
                                                        <p class="mb-1">${o.paymentMethod.paymentMethodName}</p>

                                                    </div>
                                                    <div class="mt-4">
                                                        <h5 class="font-size-15">Tình trạng đơn hàng</h5>
                                                        <p class="mb-1">
                                                            <c:choose>
                                                                <c:when test="${o.orderStatus == 0}">Đã hủy</c:when>
                                                                <c:when test="${o.orderStatus == 1}">Đã giao thành công</c:when>
                                                                <c:when test="${o.orderStatus == 2}">Đang giao</c:when>
                                                                <c:when test="${o.orderStatus == 3}">Hoàn Hàng</c:when>
                                                                <c:when test="${o.orderStatus == 4}">Đang chờ xử lí</c:when>
                                                                <c:when test="${o.orderStatus == 5}">Đã xác nhận</c:when>
                                                                <c:otherwise>Lỗi</c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="py-2 mt-3">
                                            <h5 class="font-size-15">Tóm tắt đơn hàng</h5>
                                        </div>
                                        <div class="p-4 border rounded">
                                            <div class="table-responsive">
                                                <table class="table table-nowrap align-middle mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 70px;">Số thứ tự</th>
                                                            <th>Sản phẩm</th>
                                                            <th class="text-end" style="width: 120px;">Giá tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="detail" items="${o.orderDetails}" varStatus="status">
                                                            <tr>
                                                                <th scope="row">${status.count}</th>
                                                                <td>
                                                                    <h5 class="font-size-15 mb-1">Tên sản phẩm: ${detail.variant.product.productName}</h5>
                                                                    <p class="font-size-13 text-muted mb-0">Số lượng: ${detail.quantity_product} -
                                                                        Màu: ${detail.variant.color.colorName} - Kích cỡ: ${detail.variant.size.sizeName}</p>
                                                                </td>
                                                                <td class="text-end"><fmt:formatNumber value="${detail.price * detail.quantity_product}" type="currency" currencyCode="VND"/></td>
                                                            </tr>
                                                        </c:forEach>
                                                        <tr>
                                                            <th scope="row" colspan="2" class="text-end">Phí Ship</th>
                                                            <td class="text-end"><fmt:formatNumber value="${o.shipFee}" type="currency" currencyCode="VND"/></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <th scope="row" colspan="2" class="border-0 text-end">Tổng</th>
                                                            <td class="border-0 text-end"><h4 class="m-0"><fmt:formatNumber value="${o.total}" type="currency" currencyCode="VND"/></h4></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="d-print-none mt-3">
                                            <div class="float-end">
                                                <a href="javascript:window.print()" class="btn btn-success waves-effect waves-light me-1"><i class="fa fa-print"></i></a>
                                                <a href="changeInformationOrder?orderID=${o.orderID}" class="btn btn-primary w-md waves-effect waves-light">Chỉnh sửa</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->
            </div>

        </div>
        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
    </body>
</html>
