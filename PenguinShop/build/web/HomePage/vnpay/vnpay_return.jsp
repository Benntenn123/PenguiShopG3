<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background-color: #eaf8e6;
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 600px;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                margin-top: 50px;
            }
            h3 {
                color: #2e7d32;
                text-align: center;
            }
            .form-group {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            .form-group:last-child {
                border-bottom: none;
            }
            label {
                font-weight: bold;
                color: #388e3c;
            }
            .footer {
                text-align: center;
                padding: 10px;
                margin-top: 20px;
                color: #666;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h3>Kết Quả Thanh Toán</h3>
            <div class="table-responsive">
                <div class="form-group"><label>Mã giao dịch thanh toán:</label> <span><%= request.getParameter("vnp_TxnRef") %></span></div>
                <div class="form-group"><label>Số tiền:</label> <span><%= request.getParameter("vnp_Amount") %></span></div>
                <div class="form-group"><label>Mô tả giao dịch:</label> <span><%= request.getParameter("vnp_OrderInfo") %></span></div>
                <div class="form-group"><label>Mã lỗi thanh toán:</label> <span><%= request.getParameter("vnp_ResponseCode") %></span></div>
                <div class="form-group"><label>Mã giao dịch tại VNPAY:</label> <span><%= request.getParameter("vnp_TransactionNo") %></span></div>
                <div class="form-group"><label>Mã ngân hàng:</label> <span><%= request.getParameter("vnp_BankCode") %></span></div>
                <div class="form-group"><label>Thời gian thanh toán:</label> <span><%= request.getParameter("vnp_PayDate") %></span></div>
                <div class="form-group"><label>Tình trạng giao dịch:</label> <span><%= request.getParameter("status") %></span></div>
            </div>
            <footer class="footer">&copy; VNPAY 2025</footer>
        </div>
    </body>
</html>
