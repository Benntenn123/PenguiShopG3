<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <style>
            .social-icon {
                display: inline-flex;
                gap: 20px;
                padding: 0;
                list-style: none;
            }
            .social-icon li a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                text-decoration: none;
                font-size: 24px;
                transition: all 0.3s ease;
            }
            .social-icon li.google a {
                background-color: #db4437;
                color: #fff;
            }
            .social-icon li.google a:hover {
                background-color: #c1351d;
            }
            .social-icon li.comeback a {
                background-color: #28a745;
                color: #fff;
            }
            .social-icon li.comeback a:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        

        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp" />
        <!--------------- header-section-end --------------->
        <h5>Đăng kí thành công. Vui lòng check email của bạn để xác thực tài khoản</h5>
        <!--------------- login-section --------------->
        
        <!--------------- footer-section--------------->
        <jsp:include page="Common/Footer.jsp" />
        <!--------------- footer-section-end--------------->

        <jsp:include page="Common/Js.jsp" />
        <jsp:include page="Common/Message.jsp" />
    </body>
</html>