<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="document.getElementById('paymentForm').submit();">
        <form id="paymentForm" action="vnpay_return" method="post">
            <input type="hidden" name="vnp_TxnRef" value="${vnp_TxnRef}">
            <input type="hidden" name="vnp_TransactionNo" value="${vnp_TransactionNo}">
            <input type="hidden" name="vnp_BankCode" value="${vnp_BankCode}">
            <input type="hidden" name="vnp_ResponseCode" value="${vnp_ResponseCode}">
            <input type="hidden" name="vnp_PayDate" value="${vnp_PayDate}">
            <input type="hidden" name="vnp_Amount" value="${vnp_Amount}">
            <input type="hidden" name="vnp_OrderInfo" value="${vnp_OrderInfo}">
            <input type="hidden" name="orderID" value="${orderID}">
            <input type="hidden" name="status" value="${status}">
        </form>
    </body>
</html>
