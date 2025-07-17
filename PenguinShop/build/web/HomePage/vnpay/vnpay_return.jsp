<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Kết quả thanh toán VNPAY">
    <meta name="author" content="VNPAY">
    <title>Kết Quả Thanh Toán - VNPAY</title>
    
    <jsp:include page="../Common/Css.jsp"/>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #AE1C9A;
            --success-color: #28a745;
            --error-color: #dc3545;
            --warning-color: #ffc107;
            --cancelled-color: #6c757d;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 20px 0;
            background: linear-gradient(135deg, #f8f9fa, #ffffff);
        }

        .result-container {
            max-width: 700px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(174, 28, 154, 0.3);
            overflow: hidden;
            position: relative;
        }

        .result-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #AE1C9A, #e91e63, #AE1C9A);
        }

        .vnpay-header {
            background: linear-gradient(135deg, #AE1C9A, #d63384);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .vnpay-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .vnpay-header h1 {
            margin: 0;
            font-size: 2.2em;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .vnpay-header .subtitle {
            margin-top: 10px;
            font-size: 1.1em;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .status-icon {
            font-size: 3.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .status-icon.success { color: var(--success-color); }
        .status-icon.error { color: var(--error-color); }
        .status-icon.warning { color: var(--warning-color); }
        .status-icon.cancelled { color: var(--cancelled-color); }

        .transaction-details {
            padding: 40px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.3s ease;
        }

        .detail-item:hover {
            background-color: #f8f9fa;
            margin: 0 -20px;
            padding-left: 20px;
            padding-right: 20px;
            border-radius: 8px;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1.1em;
        }

        .detail-value {
            font-weight: 500;
            color: #212529;
            text-align: right;
            max-width: 60%;
            word-break: break-word;
            font-size: 1.1em;
        }

        .amount-highlight {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--success-color);
        }

        .badge {
            padding: 8px 12px;
            border-radius: 12px;
            font-size: 0.9em;
        }

        .actions {
            padding: 30px 40px;
            background: linear-gradient(135deg, #f8f9fa, #ffffff);
            text-align: center;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 12px 30px;
            border-radius: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #AE1C9A, #d63384);
            color: white;
            box-shadow: 0 8px 20px rgba(174, 28, 154, 0.3);
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(174, 28, 154, 0.4);
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-secondary-custom {
            background: #fff;
            color: #6c757d;
            border: 2px solid #e0e0e0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .btn-secondary-custom:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-3px);
        }

        .vnpay-footer {
            text-align: center;
            padding: 20px;
            color: #6c757d;
            background: #f8f9fa;
        }

        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 15px;
            color: #28a745;
            font-size: 0.9em;
        }

        .security-badge i {
            margin-right: 5px;
        }

        @media (max-width: 768px) {
            .result-container {
                margin: 10px;
                border-radius: 15px;
            }

            .vnpay-header {
                padding: 20px;
            }

            .vnpay-header h1 {
                font-size: 1.8em;
            }

            .transaction-details {
                padding: 20px;
            }

            .detail-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .detail-value {
                text-align: left;
                max-width: 100%;
            }

            .actions {
                padding: 20px;
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../Common/Header.jsp"/>

    <section class="result-section" style="margin: 50px 0px 50px 0px">
        <div class="result-container">
            <!-- Header với trạng thái -->
            <div class="vnpay-header">
                <c:choose>
                    <c:when test="${vnp_ResponseCode == '00'}">
                        <i class="fas fa-check-circle status-icon success"></i>
                        <h1>Thanh Toán Thành Công!</h1>
                        <div class="subtitle">Giao dịch của bạn đã được xử lý thành công</div>
                    </c:when>
                    <c:when test="${vnp_ResponseCode == '24'}">
                        <i class="fas fa-times-circle status-icon cancelled"></i>
                        <h1>Giao Dịch Bị Hủy</h1>
                        <div class="subtitle">Bạn đã hủy giao dịch thanh toán</div>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-triangle status-icon error"></i>
                        <h1>Thanh Toán Thất Bại</h1>
                        <div class="subtitle">Có lỗi xảy ra trong quá trình thanh toán</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Chi tiết giao dịch -->
            <div class="transaction-details">
                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-receipt"></i>
                        Mã giao dịch
                    </div>
                    <div class="detail-value">
                        <code><c:out value="${vnp_TxnRef}" default="N/A"/></code>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-money-bill-wave"></i>
                        Số tiền
                    </div>
                    <div class="detail-value amount-highlight">
                        <c:choose>
                            <c:when test="${not empty vnp_Amount}">
                                <%
                                    String amount = (String) request.getAttribute("vnp_Amount");
                                    String formattedAmount = amount;
                                    try {
                                        long amountValue = Long.parseLong(amount) / 100;
                                        formattedAmount = String.format("%,d", amountValue) + " VNĐ";
                                    } catch (NumberFormatException e) {
                                        formattedAmount = amount;
                                    }
                                    out.print(formattedAmount);
                                %>
                            </c:when>
                            <c:otherwise>N/A</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-info-circle"></i>
                        Mô tả giao dịch
                    </div>
                    <div class="detail-value">
                        <c:out value="${vnp_OrderInfo}" default="N/A"/>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-hashtag"></i>
                        Mã giao dịch VNPAY
                    </div>
                    <div class="detail-value">
                        <code><c:out value="${vnp_TransactionNo}" default="N/A"/></code>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-university"></i>
                        Ngân hàng
                    </div>
                    <div class="detail-value">
                        <c:out value="${vnp_BankCode}" default="N/A"/>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-clock"></i>
                        Thời gian thanh toán
                    </div>
                    <div class="detail-value">
                        <c:choose>
                            <c:when test="${not empty vnp_PayDate and vnp_PayDate.length() == 14}">
                                <%
                                    String payDate = (String) request.getAttribute("vnp_PayDate");
                                    String formattedDate = payDate;
                                    try {
                                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                                        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                        Date date = inputFormat.parse(payDate);
                                        formattedDate = outputFormat.format(date);
                                    } catch (Exception e) {
                                        formattedDate = payDate;
                                    }
                                    out.print(formattedDate);
                                %>
                            </c:when>
                            <c:otherwise><c:out value="${vnp_PayDate}" default="N/A"/></c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-info"></i>
                        Mã phản hồi
                    </div>
                    <div class="detail-value">
                        <span class="badge bg-${vnp_ResponseCode == '00' ? 'success' : vnp_ResponseCode == '24' ? 'secondary' : vnp_ResponseCode != null ? 'danger' : 'warning'}">
                            <c:out value="${vnp_ResponseCode}" default="N/A"/>
                        </span>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">
                        <i class="fas fa-flag"></i>
                        Trạng thái
                    </div>
                    <div class="detail-value">
                        <c:choose>
                            <c:when test="${vnp_ResponseCode == '00'}">
                                <span class="badge bg-success">Thành công</span>
                            </c:when>
                            <c:when test="${vnp_ResponseCode == '24'}">
                                <span class="badge bg-secondary">Giao dịch bị hủy</span>
                            </c:when>
                            <c:when test="${not empty vnp_ResponseCode}">
                                <span class="badge bg-danger">Thất bại</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning">Không xác định</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Các hành động -->
            <div class="actions">
                <c:choose>
                    <c:when test="${vnp_ResponseCode == '00'}">
                        <button onclick="window.print()" class="btn-custom btn-secondary-custom">
                            <i class="fas fa-print"></i>
                            In hóa đơn
                        </button>
                        <a href="trangchu" class="btn-custom">
                            <i class="fas fa-home"></i>
                            Về trang chủ
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="/vnpayajax" class="btn-custom">
                            <i class="fas fa-redo"></i>
                            Thử lại
                        </a>
                        <a href="trangchu" class="btn-custom btn-secondary-custom">
                            <i class="fas fa-home"></i>
                            Về trang chủ
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Footer -->
            <div class="vnpay-footer">
                <p><i class="fas fa-copyright"></i> VNPAY 2020 - Thanh toán trực tuyến an toàn</p>
                <div class="security-badge">
                    <i class="fas fa-shield-alt"></i>
                    Được bảo mật bởi SSL 256-bit
                </div>
            </div>
        </div>
    </section>
    <div style="margin-bottom: 100px"></div>
    
    <jsp:include page="../Common/Footer.jsp"/>
    <jsp:include page="../Common/Js.jsp"/>

    <script>
        // Copy transaction ID to clipboard
        document.querySelectorAll('code').forEach(code => {
            code.style.cursor = 'pointer';
            code.title = 'Click để copy';
            code.addEventListener('click', function() {
                navigator.clipboard.writeText(this.textContent).then(() => {
                    const original = this.textContent;
                    this.textContent = 'Đã copy!';
                    this.style.color = 'var(--success-color)';
                    setTimeout(() => {
                        this.textContent = original;
                        this.style.color = '';
                    }, 1000);
                });
            });
        });
    </script>
</body>
</html>