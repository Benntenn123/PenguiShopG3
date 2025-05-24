<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

        <style>
            #toast-container > .toast {
                font-size: 16px; /* chỉnh cỡ chữ */
                padding: 15px 20px;
                
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

            #toast-container > .toast .toast-close-button {
                font-size: 18px;
                right: 10px;
                top: 5px;
            }

            .toast-success {
                background-color: #51A351 !important;
            }

            .toast-error {
                background-color: #BD362F !important;
            }
        </style>
    </head>

    <body>
        <script type="text/javascript">
            $(document).ready(function () {
                toastr.options = {
                    "closeButton": true,             // ✅ Nút "x" đóng
                    "progressBar": true,             // ✅ Thanh tiến trình
                    "positionClass": "toast-top-right",
                    "timeOut": "5000",               // ⏲ Tự tắt sau 5s
                    "extendedTimeOut": "1000"
                };

                <c:if test="${not empty sessionScope.ms}">
                    toastr.success("${sessionScope.ms}");
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    toastr.error("${sessionScope.error}");
                </c:if>
            });
        </script>

        <% 
            session.removeAttribute("ms");
            session.removeAttribute("error");
        %>
    </body>
</html>
