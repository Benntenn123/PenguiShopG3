<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quên Mật Khẩu - Nhập Email</title>
    <jsp:include page="Common/Css.jsp"/>
    <style>
        .forgot-password-container {
            max-width: 400px;
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
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-input:focus {
            outline: none;
            border-color: #AE1C9A;
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
        }
        .btn-primary:hover {
            background-color: #8a1579;
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
        .form-description {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <jsp:include page="Common/Header.jsp"/>
    
    <div class="forgot-password-container">
        <h2 class="form-title">Quên Mật Khẩu</h2>
        <p class="form-description">
            Vui lòng nhập địa chỉ email của bạn để tiếp tục quá trình khôi phục mật khẩu.
        </p>
        
        <form action="forgotpassword" method="POST">
            <input type="hidden" name="step" value="1">
            
            <div class="form-group">
                <label style="font-size: 12px;" class="form-label" for="email">Địa chỉ Email *</label>
                <input type="email" 
                       id="email" 
                       name="email" 
                       class="form-input" 
                       placeholder="Nhập địa chỉ email của bạn"
                       required>
            </div>
            
            <button type="submit" class="btn-primary">
                Tiếp Tục
            </button>
        </form>
        
        <div class="back-link">
            <a href="login">← Quay lại đăng nhập</a>
        </div>
    </div>
    <div style="margin-bottom: 150px"></div>
    
    <jsp:include page="Common/Footer.jsp"/>
    <jsp:include page="Common/Js.jsp"/>
    <jsp:include page="Common/Message.jsp"/>
</body>
</html>