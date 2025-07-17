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
                                    <h4 class="mb-sm-0 font-size-18">Chi tiết yêu cầu #${customerRequest.requestID}</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="listRequestSupport">Yêu cầu người dùng</a></li>
                                            <li class="breadcrumb-item active">Chi tiết yêu cầu</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-12">
                                <!-- Left sidebar -->

                                <!-- End Left sidebar -->

                                <!-- Right Sidebar -->
                                <div class="email mb-3">

                                    <div class="card">


                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-4">

                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 mb-0">${customerRequest.name_request}</h5>
                                                    <small class="text-muted">${customerRequest.email_request} - </small>
                                                    <small class="text-muted">${customerRequest.phone_request}</small>
                                                </div>
                                            </div>

                                            <h4 class="font-size-16">${customerRequest.requestType}</h4>

                                            <p>${customerRequest.description}</p>

                                            <hr/>

                                            <div class="row">
                                                <div class="d-flex align-items-center mb-4">
                                                    <div class="flex-grow-1">
                                                        <h4 class="font-size-16 mb-0">Tình trạng:</h4>
                                                        <small class="text-muted">${customerRequest.requestStatus == 0 ? 'Chưa phản hồi' : 'Đã phản hồi'} </small>
                                                        <c:if test="${customerRequest.requestStatus == 1}">
                                                            <small class="text-muted">Phản hồi: ${customerRequest.response} - </small>
                                                            <small class="text-muted">
                                                                Thời gian phản hồi: 
                                                                ${customerRequest.responseDate}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <a href="responseSupport?requestID=${customerRequest.requestID}" style="margin-left: 20px; margin-bottom: 25px" class="btn btn-secondary waves-effect mt-5 w-25"><i class="mdi mdi-reply me-1"></i> Reply</a>
                                    </div>

                                </div>
                            </div>
                            <!-- card -->

                        </div>
                        <!-- end Col -->

                    </div>
                    <!-- end row -->

                </div> <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <!-- Modal -->
            <div class="modal fade" id="composemodal" tabindex="-1" role="dialog" aria-labelledby="composemodalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title font-size-16" id="composemodalTitle">New Message</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div>
                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="To">
                                </div>

                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Subject">
                                </div>
                                <div class="mb-3 email-editor">
                                    <div id="email-editor"></div>
                                </div>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Send <i class="fab fa-telegram-plane ms-1"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end modal -->

        </div>

        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>

    </body>
</html>
```