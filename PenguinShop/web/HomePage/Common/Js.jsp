

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <style>
        .partnership-chat-button {
            position: fixed;
            bottom: 25px;
            right: 220px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
            border-radius: 50%;
            border: none;
            cursor: pointer;
            box-shadow: 0 8px 25px rgba(174, 28, 154, 0.4);
            transition: all 0.3s ease;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .partnership-chat-button:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 30px rgba(174, 28, 154, 0.6);
        }
        .partnership-chat-button svg {
            width: 28px;
            height: 28px;
            fill: white;
        }

        /* Partnership Chat Window */
        .partnership-chat-window {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 400px;
            height: 600px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            transform: translateY(20px) scale(0.9);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 999;
            overflow: hidden;
        }

        .partnership-chat-window.active {
            transform: translateY(0) scale(1);
            opacity: 1;
            visibility: visible;
        }

        .partnership-chat-header {
            background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
            color: white;
            padding: 20px;
            text-align: center;
            position: relative;
        }

        .partnership-chat-header h3 {
            font-size: 1.3rem;
            font-weight: 600;
        }

        .partnership-chat-header p {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-top: 5px;
        }

        .partnership-close-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background 0.2s;
        }

        .partnership-close-btn:hover {
            background: rgba(255,255,255,0.2);
        }

        .partnership-chat-form {
            padding: 25px;
            height: calc(100% - 80px);
            overflow-y: auto;
        }

        .partnership-form-group {
            margin-bottom: 20px;
        }

        .partnership-form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .partnership-form-group input,
        .partnership-form-group select,
        .partnership-form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-family: inherit;
        }

        .partnership-form-group input:focus,
        .partnership-form-group select:focus,
        .partnership-form-group textarea:focus {
            outline: none;
            border-color: #AE1C9A;
            box-shadow: 0 0 0 3px rgba(174, 28, 154, 0.1);
        }

        .partnership-form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .partnership-submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #AE1C9A 0%, #c44ca8 100%);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .partnership-submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(174, 28, 154, 0.3);
        }

        .partnership-submit-btn:active {
            transform: translateY(0);
        }

        /* Responsive */
        @media (max-width: 480px) {
            .partnership-chat-window {
                width: calc(100vw - 20px);
                height: calc(100vh - 40px);
                bottom: 20px;
                right: 10px;
                left: 10px;
                border-radius: 15px;
            }

            .partnership-chat-button {
                bottom: 20px;
                right: 20px;
            }
        }

        /* Success Message */
        .partnership-success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }

        .partnership-success-message.show {
            display: block;
        }
        .penguinshop-membership-section {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #f8f9ff 0%, #eeebf7 100%);
            border-radius: 20px;
            padding: 40px;
            max-width: 1300px;
            margin: 0 auto;
            box-shadow: 0 10px 30px rgba(174, 28, 154, 0.1);
        }

        .penguinshop-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 30px;
        }

        .penguinshop-left-content {
            flex: 1;
        }

        .penguinshop-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 30px;
            line-height: 1.4;
        }

        .penguinshop-highlight-number {
            color: #AE1C9A;
            font-weight: 800;
        }

        .penguinshop-benefits-grid {
            display: flex;
            gap: 20px;
            flex-wrap: nowrap;
        }

        .penguinshop-benefit-card {
            background: #AE1C9A;
            color: white;
            padding: 20px 25px;
            border-radius: 15px;
            flex: 1;
            min-width: 180px;
            max-width: 200px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
            box-shadow: 0 5px 20px rgba(174, 28, 154, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .penguinshop-benefit-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(174, 28, 154, 0.4);
        }

        .penguinshop-benefit-icon {
            width: 24px;
            height: 24px;
            margin-bottom: 5px;
        }

        .penguinshop-benefit-title {
            font-weight: bold;
            font-size: 16px;
            line-height: 1.3;
        }

        .penguinshop-benefit-subtitle {
            font-size: 14px;
            opacity: 0.9;
            line-height: 1.2;
        }

        .penguinshop-multiplier {
            font-size: 48px;
            font-weight: 900;
            color: white;
            margin-left: 10px;
        }

        .penguinshop-right-content {
            flex-shrink: 0;
            text-align: center;
        }

        .penguinshop-activity-header {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .penguinshop-activity-text {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 14px;
            line-height: 1.6;
            color: #555;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
        }

        .penguinshop-join-button {
            background: #000;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .penguinshop-join-button:hover {
            background: #333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .penguinshop-arrow {
            font-size: 18px;
        }

        @media (max-width: 768px) {
            .penguinshop-container {
                flex-direction: column;
                gap: 30px;
            }

            .penguinshop-benefits-grid {
                flex-direction: column;
                flex-wrap: nowrap;
            }

            .penguinshop-benefit-card {
                max-width: none;
            }

            .penguinshop-membership-section {
                padding: 30px 20px;
            }

            .penguinshop-title {
                font-size: 20px;
            }
            .color-select, .size-select {
                width: 100%;
                height: 32px;
                padding: 6px 10px;
                border: 1.5px solid #e0e0e0;
                border-radius: 6px;
                font-size: 13px;
                color: #333;
                background-color: #fff;
                background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="%23666" d="M2 0L0 2h4zm0 5L0 3h4z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 8px center;
                background-size: 12px;
                appearance: none;
                cursor: pointer;
                transition: all 0.2s ease;
                outline: none;
            }

            .color-select:hover, .size-select:hover {
                border-color: #ccc;
            }

            .color-select:focus, .size-select:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.15);
            }

            .color-select option, .size-select option {
                padding: 8px;
                font-size: 13px;
            }

            .color-select option[disabled], .size-select option[disabled] {
                color: #999;
            }
            

        </style>
        <body>
            <!--        button messenger-->
            <!-- Nút Messenger Auto Fix - Link thật -->
<div id="messenger-widget">
    <style>
        #messenger-widget {
            position: fixed;
            bottom: -50px;
            right: 20px;
            z-index: 9999;
        }

        .messenger-btn {
            width: 60px;
            height: 60px;
            position: fixed;
            right: 120px;
            bottom: 25px;
            background: linear-gradient(135deg, #0084ff, #0066cc);
            border-radius: 50%;
            box-shadow: 0 4px 20px rgba(0, 132, 255, 0.4);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            border: none;
            outline: none;
            text-decoration: none;
            color: white;
        }

        
        .messenger-icon {
            width: 32px;
            height: 32px;
            fill: white;
        }

        .tooltip {
            position: absolute;
            bottom: 70px;
            right: 0;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            pointer-events: none;
        }

        

        /* Animation khi load */


        .messenger-btn:hover {
            animation: none;
        }

        /* Responsive */
        @media (max-width: 768px) {
            #messenger-widget {
                bottom: 15px;
                right: 15px;
            }
            
            .messenger-btn {
                width: 55px;
                height: 55px;
            }
            
            .messenger-icon {
                width: 28px;
                height: 28px;
            }
        }

       
    </style>

    <!-- Thay YOUR_PAGE_USERNAME bằng username Facebook Page của bạn -->
    <a href="https://m.me/619434397929140" 
       class="messenger-btn" 
       target="_blank" 
       rel="noopener noreferrer"
       title="Nhắn tin qua Messenger">
        
        <svg class="messenger-icon" viewBox="0 0 24 24">
            <path d="M12,2C6.36,2 2,6.13 2,11.7C2,14.61 3.19,17.14 5.14,18.87C5.26,19 5.46,19.27 5.46,19.84C5.46,20.46 5.12,21.85 4.91,22.43C4.66,23.08 5.31,23.72 5.96,23.47C6.54,23.26 7.93,22.92 8.55,22.92C8.69,22.92 8.82,22.88 8.94,22.8C9.88,22.95 10.93,23 12,23C17.64,23 22,18.87 22,13.3C22,7.13 17.64,2 12,2M12,4C16.5,4 20,7.25 20,11.7C20,15.15 16.5,18.4 12,18.4C11.2,18.4 10.42,18.3 9.68,18.12L9.29,18.03L8.93,18.21C8.32,18.5 7.26,18.86 6.46,19.06C6.81,18.35 7.04,17.46 7.04,16.84C7.04,15.1 6.14,14.3 5.68,13.87C4.25,12.61 4,11.23 4,9.7C4,6.25 7.5,4 12,4Z"/>
        </svg>
        
        <div class="tooltip">Nhắn tin Facebook</div>
    </a>
</div>

<script>
    // Optional: Track clicks
    document.querySelector('.messenger-btn').addEventListener('click', function() {
        console.log('Messenger button clicked');
        // Có thể thêm Google Analytics tracking ở đây
        // gtag('event', 'click', { 'event_category': 'messenger', 'event_label': 'chat_button' });
    });

    // Optional: Tự động ẩn hiện dựa trên scroll
    let lastScrollTop = 0;
    window.addEventListener('scroll', function() {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const messengerWidget = document.getElementById('messenger-widget');
        
        if (scrollTop > lastScrollTop && scrollTop > 200) {
            // Scroll down - có thể ẩn nút
            // messengerWidget.style.transform = 'translateY(100px)';
        } else {
            // Scroll up - hiện nút
            messengerWidget.style.transform = 'translateY(0)';
        }
        lastScrollTop = scrollTop;
    });
</script>
            <button class="partnership-chat-button" id="partnershipChatToggle">
                <svg viewBox="0 0 24 24">
                <path d="M12 2C13.1 2 14 2.9 14 4C14 5.1 13.1 6 12 6C10.9 6 10 5.1 10 4C10 2.9 10.9 2 12 2ZM21 9V7L15 1L9 7V9C9 10.1 9.9 11 11 11V16L12 17L13 16V11C14.1 11 15 10.1 15 9V7H21M7 10.5C7 9.7 6.3 9 5.5 9S4 9.7 4 10.5 4.7 12 5.5 12 7 11.3 7 10.5M20 10.5C20 9.7 19.3 9 18.5 9S17 9.7 17 10.5 17.7 12 18.5 12 20 11.3 20 10.5M12 20C12 21.1 11.1 22 10 22H6C4.9 22 4 21.1 4 20V18H8V20H12M20 18V20C20 21.1 19.1 22 18 22H14C12.9 22 12 21.1 12 20V18H20Z"/>
                </svg>
            </button>
            <!--------------- flash-section-end--------------->
            <div class="partnership-chat-window" id="partnershipChatWindow">
                <div class="partnership-chat-header">
                    <button class="partnership-close-btn" id="partnershipCloseChat">&times;</button>
                    <h3 style="font-size: 16px !important;
                        color: white">🤝 Hỗ trợ cộng tác</h3>
                    <p style="font-size: 16px !important;
                       color: white">Gửi thông tin để chúng tôi liên hệ!</p>
                </div>

                <div class="partnership-chat-form">

                    <form action="sendRequestSupport" method="post" id="partnershipSupportForm">
                        <div  class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipFullName">Họ và tên *</label>
                            <input style="font-size: 16px !important;" type="text" id="partnershipFullName" name="fullName" required placeholder="Nhập họ tên của bạn">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipPhone">Số điện thoại *</label>
                            <input style="font-size: 16px !important;" type="tel" id="partnershipPhone" name="phone" required placeholder="Nhập số điện thoại">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipEmail">Email *</label>
                            <input style="font-size: 16px !important;" type="email" id="partnershipEmail" name="email" required placeholder="Nhập địa chỉ email">
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipIssueType">Vấn đề gặp phải *</label>
                            <select style="font-size: 16px !important;" id="partnershipIssueType" name="issueType" required>
                                <option value="">-- Chọn loại vấn đề --</option>
                                <option value="Trạng thái tài khoản">Trạng thái tài khoản</option>
                                <option value="Vấn đề mua hàng">Vấn đề mua hàng</option>
                                <option value="Vấn đề thanh toán">Vấn đề thanh toán</option>
                                <option value="Vấn đề giao hàng">Vấn đề giao hàng</option>
                                <option value="Hoàn tiền/Đổi trả">Hoàn tiền/Đổi trả</option>
                                <option value="Lỗi kỹ thuật">Lỗi kỹ thuật</option>
                                <option value="Vấn đề khác">Vấn đề khác</option>
                            </select>
                        </div>

                        <div class="partnership-form-group">
                            <label style="font-size: 16px !important;" for="partnershipDescription">Nội dung mô tả *</label>
                            <textarea style="font-size: 16px !important;" id="partnershipDescription" name="description" required placeholder="Mô tả chi tiết vấn đề bạn đang gặp phải..."></textarea>
                        </div>

                        <button style="font-size: 16px !important;" type="submit" class="partnership-submit-btn">
                            📨 Gửi thông tin
                        </button>
                    </form>
                </div>
            </div>

            <!--support-->



            <!--------------- jQuery ---------------->
            <script src="./HomePage/assets/js/jquery_3.7.1.min.js"></script>

            <!--------------- bootstrap-js ---------------->
            <script src="./HomePage/assets/js/bootstrap_5.3.2.bundle.min.js"></script>

            <!--------------- Range-Slider-js ---------------->
            <script src="./HomePage/assets/js/nouislider.min.js"></script>

            <!--------------- scroll-Animation-js ---------------->
            <script src="./HomePage/assets/js/aos-3.0.0.js"></script>

            <!--------------- swiper-js ---------------->
            <script src="./HomePage/assets/js/swiper10-bundle.min.js"></script>

            <!--------------- additional-js ---------------->
            <script src="./HomePage/assets/js/shopus.js"></script>



            <!-- thm custom script -->
            <script src="homepage/js/custom.js"></script>
<!--            <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  intent="WELCOME"
  chat-title="PenguinShop"
  agent-id="a2050fde-ca64-464c-9eb2-4b85d94d1a6c"
  language-code="vi"
></df-messenger>-->
<!--<iframe 
    src="livechat.fpt.ai/v36/src/index.html?botcode=e5bf810c1d95b54ebd093b75801b93ab&botname=PenguinShop&sendername=&scendpoint=livechat.fpt.ai%3A443&time=1752845943174&subchannel=&themes=&styles=%7B%22headerColorType%22%3A%22gradient%22%2C%22headerSolid%22%3A%22%23ededf2ff%22%2C%22headerGradient1%22%3A%22%23891299FF%22%2C%22headerGradient2%22%3A%22%23AE31B7FF%22%2C%22headerTextColor%22%3A%22%23ffffffff%22%2C%22headerLogoEnable%22%3Afalse%2C%22headerLogoLink%22%3A%22https%3A%2F%2Fres.cloudinary.com%2Fdcdwqd5up%2Fimage%2Fupload%2Fv1752845674%2Flogo_fvc6ie.png%22%2C%22headerText%22%3A%22PenguinShop%22%2C%22primaryColor%22%3A%22%23AF36A3FF%22%2C%22secondaryColor%22%3A%22%23ecececff%22%2C%22primaryTextColor%22%3A%22%23ffffffff%22%2C%22secondaryTextColor%22%3A%22%23000000DE%22%2C%22buttonColor%22%3A%22%23b4b4b4ff%22%2C%22buttonTextColor%22%3A%22%23ffffffff%22%2C%22bodyBackgroundEnable%22%3Afalse%2C%22bodyBackgroundLink%22%3A%22%22%2C%22avatarBot%22%3A%22https%3A%2F%2Fres.cloudinary.com%2Fdcdwqd5up%2Fimage%2Fupload%2Fv1752845785%2Ficon2_tegwls.png%22%2C%22sendMessagePlaceholder%22%3A%22Enter%20your%20message%20here%22%2C%22floatButtonLogo%22%3A%22https%3A%2F%2Fres.cloudinary.com%2Fdcdwqd5up%2Fimage%2Fupload%2Fv1752845785%2Ficon2_tegwls.png%22%2C%22floatButtonTooltip%22%3A%22T%C3%B4i%20c%C3%B3%20th%E1%BB%83%20gi%C3%BAp%20g%C3%AC%20cho%20b%E1%BA%A1n%22%2C%22floatButtonTooltipEnable%22%3Atrue%2C%22customerLogo%22%3A%22https%3A%2F%2Fres.cloudinary.com%2Fdcdwqd5up%2Fimage%2Fupload%2Fv1752845674%2Flogo_fvc6ie.png%22%2C%22customerWelcomeText%22%3A%22Vui%20l%C3%B2ng%20nh%E1%BA%ADp%20t%C3%AAn%20c%E1%BB%A7a%20b%E1%BA%A1n%22%2C%22customerButtonText%22%3A%22B%E1%BA%AFt%20%C4%91%E1%BA%A7u%20%22%2C%22prefixEnable%22%3Afalse%2C%22prefixType%22%3A%22radio%22%2C%22prefixOptions%22%3A%5B%22Anh%22%2C%22Ch%E1%BB%8B%22%5D%2C%22prefixPlaceholder%22%3A%22Danh%20x%C6%B0ng%22%2C%22headerBackground%22%3A%22linear-gradient(86.7deg%2C%20%23891299FF%200.85%25%2C%20%23AE31B7FF%2098.94%25)%22%2C%22css%22%3A%22%22%7D"
  width="400" 
  height="600" 
  frameborder="0">
</iframe>
-->



<script>
    // Configs
    let liveChatBaseUrl   = document.location.protocol + '//' + 'livechat.fpt.ai/v36/src'
    let LiveChatSocketUrl = 'livechat.fpt.ai:443'
    let FptAppCode        = 'b5f5dfafa4459d587c21b20c8116adbc'
    let FptAppName        = 'PenguinShop'
    // Define custom styles
    let CustomStyles = {
        // header
        headerBackground: 'linear-gradient(86.7deg, #B619B8FF 0.85%, #B7319EFF 98.94%)',
        headerTextColor: '#ffffffff',
        headerLogoEnable: false,
        headerLogoLink: 'https://res.cloudinary.com/dcdwqd5up/image/upload/v1752845674/logo_fvc6ie.png',
        headerText: 'PenguinShop',
        // main
        primaryColor: '#C213BFFF',
        secondaryColor: '#ecececff',
        primaryTextColor: '#ffffffff',
        secondaryTextColor: '#000000DE',
        buttonColor: '#b4b4b4ff',
        buttonTextColor: '#ffffffff',
        bodyBackgroundEnable: false,
        bodyBackgroundLink: '',
        avatarBot: 'https://res.cloudinary.com/dcdwqd5up/image/upload/v1752845785/icon2_tegwls.png',
        sendMessagePlaceholder: 'Nhập tin nhắn ở đây',
        // float button
        floatButtonLogo: 'https://res.cloudinary.com/dcdwqd5up/image/upload/v1752845785/icon2_tegwls.png',
        floatButtonTooltip: 'Tôi có thể giúp gì cho bạn',
        floatButtonTooltipEnable: true,
        // start screen
        customerLogo: 'https://res.cloudinary.com/dcdwqd5up/image/upload/v1752845674/logo_fvc6ie.png',
        customerWelcomeText: 'Vui lòng nhập tên của bạn',
        customerButtonText: 'Bắt đầu',
        prefixEnable: false,
        prefixType: 'radio',
        prefixOptions: ["Anh","Chị"],
        prefixPlaceholder: 'Danh xưng',
        // custom css
        css: ''
    }
    // Get bot code from url if FptAppCode is empty
    if (!FptAppCode) {
        let appCodeFromHash = window.location.hash.substr(1)
        if (appCodeFromHash.length === 32) {
            FptAppCode = appCodeFromHash
        }
    }
    // Set Configs
    let FptLiveChatConfigs = {
        appName: FptAppName,
        appCode: FptAppCode,
        themes : '',
        styles : CustomStyles
    }
    // Append Script
    let FptLiveChatScript  = document.createElement('script')
    FptLiveChatScript.id   = 'fpt_ai_livechat_script'
    FptLiveChatScript.src  = liveChatBaseUrl + '/static/fptai-livechat.js'
    document.body.appendChild(FptLiveChatScript)
    // Append Stylesheet
    let FptLiveChatStyles  = document.createElement('link')
    FptLiveChatStyles.id   = 'fpt_ai_livechat_script'
    FptLiveChatStyles.rel  = 'stylesheet'
    FptLiveChatStyles.href = liveChatBaseUrl + '/static/fptai-livechat.css'
    document.body.appendChild(FptLiveChatStyles)
    // Init
    FptLiveChatScript.onload = function () {
        fpt_ai_render_chatbox(FptLiveChatConfigs, liveChatBaseUrl, LiveChatSocketUrl)
    }
</script>




    </body>
</html>

