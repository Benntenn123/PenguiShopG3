<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Tạo mới đơn hàng</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    </head>

    <body style="background-color: #f4f4f4; font-family: Arial, sans-serif;">
        <div class="container" style="max-width: 600px; margin: 30px auto; background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div class="header clearfix" style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e0e0e0;">
                <h3 class="text-muted" style="color: #333; text-align: center;">VNPAY DEMO</h3>
            </div>
            <h3 style="color: #2c3e50; margin-bottom: 20px; text-align: center;">Tạo mới đơn hàng</h3>
            <div class="table-responsive">
                <form action="vnpayajax" id="frmCreateOrder" method="post" style="background-color: #f9f9f9; padding: 20px; border-radius: 5px;">   
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label for="amount" style="display: block; margin-bottom: 5px; color: #34495e;">Số tiền</label>
                        <input class="form-control" 
                               style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: white;"
                               data-val="true" 
                               data-val-number="The field Amount must be a number." 
                               data-val-required="The Amount field is required." 
                               id="amount" 
                               max="100000000" 
                               min="1" 
                               name="amount" 
                               type="number" 
                               value="${amount}" />
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 15px; background-color: #f0f0f0; padding: 15px; border-radius: 5px;">
                        <h4 style="color: #2c3e50; margin-bottom: 10px;">Chọn phương thức thanh toán</h4>
                        <h5 style="color: #34495e; margin-top: 10px;">Cách 1: Chuyển hướng sang Cổng VNPAY chọn phương thức thanh toán</h5>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" Checked="True" id="bankCode" name="bankCode" value="" style="margin-right: 8px;">
                            <label for="bankCode" style="color: #2c3e50;">Cổng thanh toán VNPAYQR</label>
                        </div>

                        <h5 style="color: #34495e; margin-top: 10px;">Cách 2: Tách phương thức tại site của đơn vị kết nối</h5>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="bankCode" name="bankCode" value="VNPAYQR" style="margin-right: 8px;">
                            <label for="bankCode" style="color: #2c3e50;">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="bankCode" name="bankCode" value="VNBANK" style="margin-right: 8px;">
                            <label for="bankCode" style="color: #2c3e50;">Thanh toán qua thẻ ATM/Tài khoản nội địa</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="bankCode" name="bankCode" value="INTCARD" style="margin-right: 8px;">
                            <label for="bankCode" style="color: #2c3e50;">Thanh toán qua thẻ quốc tế</label>
                        </div>
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 15px; background-color: #f0f0f0; padding: 15px; border-radius: 5px;">
                        <h5 style="color: #34495e; margin-bottom: 10px;">Chọn ngôn ngữ giao diện thanh toán:</h5>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="language" Checked="True" name="language" value="vn" style="margin-right: 8px;">
                            <label for="language" style="color: #2c3e50;">Tiếng việt</label>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <input type="radio" id="language" name="language" value="en" style="margin-right: 8px;">
                            <label for="language" style="color: #2c3e50;">Tiếng anh</label>
                        </div>
                    </div>
                    
                    <input name="appointment_id" value="${appointment_id}" type="hidden"/>
                    <button type="submit" class="btn btn-default" style="
                        width: 100%; 
                        padding: 12px; 
                        background-color: #3498db; 
                        color: white; 
                        border: none; 
                        border-radius: 5px; 
                        font-weight: bold; 
                        transition: background-color 0.3s ease;">Thanh toán</button>
                </form>
            </div>
            <p>&nbsp;</p>
            <footer class="footer" style="text-align: center; padding: 10px; color: #7f8c8d;">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>

        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>       
    </body>
</html>