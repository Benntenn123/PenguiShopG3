<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quên Mật Khẩu - Chọn Phương Thức Xác Thực</title>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .forgot-password-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            background-color: white;
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            font-weight: 600;
        }
        .form-description {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        .verification-select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
            appearance: none;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="%23AE1C9A"><polygon points="0,0 12,0 6,12"/></svg>') no-repeat right 12px center;
            background-color: white;
            transition: border-color 0.3s;
        }
        .verification-select:focus {
            border-color: #AE1C9A;
            outline: none;
            box-shadow: 0 0 5px rgba(174, 28, 154, 0.3);
        }
        .option-details {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
            padding-left: 10px;
        }
        .masked-info {
            font-weight: 500;
            color: #333;
        }
        .btn-primary {
            width: 100%;
            padding: 12px;
            background-color: #AE1C9A;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
        }
        .btn-primary:hover {
            background-color: #8B156F;
        }
        .btn-primary:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #AE1C9A;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="Common/Header.jsp"/>
    
    <div class="forgot-password-container">
        <h2 class="form-title">Chọn Phương Thức Xác Thực</h2>
        <p class="form-description">
            Chúng tôi sẽ gửi mã xác thực đến phương thức bạn chọn bên dưới.
        </p>
        
        <form action="verification_method" method="POST" id="verificationForm">
            <input type="hidden" name="step" value="2">
            <input type="hidden" name="email" value="${email}">
            
            <select name="verification_method" class="verification-select" required>
                <option value="email">Gửi qua Email - ${email}</option>
                <option value="phone">Gửi qua SMS - ${phone}</option>
            </select>
            <div class="option-details">
                Chọn phương thức để nhận mã xác thực.
            </div>
            
            <button type="submit" class="btn-primary">
                Gửi Mã Xác Thực
            </button>
        </form>
        
        <div class="back-link">
            <a href="forgotpassword">← Quay lại</a>
        </div>
    </div>
            <div style="margin-bottom: 150px">
            </div>
    <jsp:include page="Common/Footer.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
</body>
</html>