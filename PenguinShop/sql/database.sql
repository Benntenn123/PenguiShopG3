USE PenguinShop;
-- Insert data into tbRoles
INSERT INTO tbRoles (roleName) VALUES
(N'Admin'),
(N'Khách hàng'),
(N'Bán hàng');

-- Insert data into tbUsers
INSERT INTO tbUsers (fullName, password, roleID, address, birthday, phone, email, image_user) VALUES
(N'Sơn', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 1, N'123 Đường Lê Lợi, Hà Nội', '1990-05-15', N'0987654321', N'son123@gmail.com', N'http://localhost:8080/PenguinShop/Images/vn-11134207-7ras8-m2j1kxknq7qqdd.jpeg'),
(N'Lan', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'456 Đường Trần Hưng Đạo, TP.HCM', '1992-08-20', N'0912345678', N'lan456@gmail.com', NULL),
(N'Hoàng', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'789 Đường Nguyễn Huệ, Đà Nẵng', '1988-12-10', N'0934567890', N'hoang789@gmail.com', NULL),
(N'Hải', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 3, N'321 Đường Phạm Văn Đồng, Hải Phòng', '1995-03-25', N'0976543210', N'hai321@gmail.com', NULL);

-- Insert data into tbBrand
INSERT INTO tbBrand (brandName, logo, description) VALUES
(N'Nike', N'/images/brands/nike-logo.png', N'Thương hiệu thể thao hàng đầu thế giới, nổi tiếng với giày và quần áo chất lượng cao.'),
(N'Adidas', N'/images/brands/adidas-logo.png', N'Thương hiệu thể thao toàn cầu, chuyên về sản phẩm thời trang và hiệu suất.');

-- Insert data into tbLogs (log changes to data)
INSERT INTO tbLogs (userID, action, description, logDate) VALUES
(1, N'Add Brand', N'Added brand: Nike', '2025-05-25 15:55:00'), -- Admin Sơn adds brand
(1, N'Add Brand', N'Added brand: Adidas', '2025-05-25 15:56:00'), -- Admin Sơn adds brand
(1, N'Add Product', N'Added product: Áo chạy bộ nam (SKU001)', '2025-05-25 16:00:00'), -- Admin Sơn adds product
(1, N'Add Product', N'Added product: Quần chạy bộ nữ (SKU002)', '2025-05-25 16:05:00'), -- Admin Sơn adds product
(2, N'Add Feedback', N'Added feedback for productID: 1, variantID: 1', '2025-05-25 16:30:00'), -- Lan adds feedback
(3, N'Add Cart Item', N'Added 1 pair of shorts to cart (variantID: 2)', '2025-05-25 16:25:00'), -- Hoàng adds to cart
(4, N'Update Order', N'Updated order status to Processing for orderID: 6', '2025-05-25 16:35:00'); -- Sales Hải updates order

-- Insert data into tbCategory
INSERT INTO tbCategory (categoryName, sportType, imageCategory) VALUES
(N'Chạy bộ', N'Chạy bộ', N'/images/categories/running.jpg'),
(N'Bóng rổ', N'Bóng rổ', N'/images/categories/basketball.jpg');

-- Insert data into tbProductType
INSERT INTO tbProductType (productTypeName) VALUES
(N'Áo'),
(N'Quần');

-- Insert data into tbMaterial
INSERT INTO tbMaterial (materialName, materialDescription) VALUES
(N'Polyester', N'Chất liệu bền, thoáng khí'),
(N'Cotton', N'Chất liệu mềm mại, thấm hút tốt');

-- Insert data into tbColor
INSERT INTO tbColor (colorName) VALUES
(N'Đỏ'),
(N'Xanh');

-- Insert data into tbSize
INSERT INTO tbSize (sizeName) VALUES
(N'S'),
(N'M');

-- Insert data into tbProduct
INSERT INTO tbProduct (productName, SKU, productTypeID, categoryID, brandID, importDate, imageMainProduct, description, weight) VALUES
(N'Áo chạy bộ nam', N'SKU001', 1, 1, 1, '2023-01-01', N'https://product.hstatic.net/1000312752/product/73a210bb4f802f932adf41cc8fe23c179151b14a9cfb21d6f22ab2b38624078f777ed3_08b2ce3740cd43d8ba0a65db72a4cd24.jpg', N'Áo chạy bộ thoáng khí', 250.00),
(N'Quần chạy bộ nữ', N'SKU002', 2, 1, 2, '2023-01-01', N'https://product.hstatic.net/1000312752/product/73a210bb4f802f932adf41cc8fe23c179151b14a9cfb21d6f22ab2b38624078f777ed3_08b2ce3740cd43d8ba0a65db72a4cd24.jpg', N'Quần chạy bộ co giãn', 300.00);

-- Insert data into tbImages (for products)
INSERT INTO tbImages (productID, feedbackID, imageURL, imageCaption) VALUES
(1, NULL, N'/images/ao-chay-bo-nam.jpg', N'Áo chạy bộ nam màu đỏ'),
(2, NULL, N'/images/quan-chay-bo-nu.jpg', N'Quần chạy bộ nữ màu xanh');

-- Insert data into tbProductTag
INSERT INTO tbProductTag (productID, tagName, tagDescription) VALUES
(1, N'Thoáng khí', N'Chất liệu thoáng khí, phù hợp chạy bộ'),
(2, N'Co giãn', N'Chất liệu co giãn, thoải mái khi vận động');

-- Insert data into tbProductVariant
INSERT INTO tbProductVariant (productID, colorID, sizeID, quantity, price, stockStatus) VALUES
(1, 1, 1, 50, 299000.00, 1), -- StockStatus: 1 - Còn hàng
(2, 2, 2, 30, 399000.00, 1); -- StockStatus: 1 - Còn hàng

-- Insert data into tbVariantMaterial
INSERT INTO tbVariantMaterial (variantID, materialID, percentage) VALUES
(1, 1, 80.00),
(1, 2, 20.00),
(2, 2, 100.00);

-- Insert data into tbFeedback
INSERT INTO tbFeedback (productID, variantID, userID, rating, comment, feedbackDate) VALUES
(1, 1, 2, 5, N'Áo đỏ size S rất thoải mái, thoáng khí!', '2025-05-25 16:30:00'), -- Feedback for red shirt, size S
(2, 2, 3, 4, N'Quần xanh size M đẹp nhưng hơi chật.', '2025-05-25 16:35:00'); -- Feedback for green shorts, size M

-- Insert data into tbImages (for feedback)
INSERT INTO tbImages (productID, feedbackID, imageURL, imageCaption) VALUES
(NULL, 1, N'/images/feedback-ao-chay-bo.jpg', N'Hình ảnh áo chạy bộ đỏ size S từ khách hàng'),
(NULL, 2, N'/images/feedback-quan-chay-bo.jpg', N'Hình ảnh quần chạy bộ xanh size M từ khách hàng');

-- Insert data into tbCart
INSERT INTO tbCart (userID, variantID, quantity, addedDate) VALUES
(2, 1, 2, '2025-05-25 16:20:00'), -- Lan adds 2 shirts
(3, 2, 1, '2025-05-25 16:25:00'); -- Hoàng adds 1 pair of shorts

-- Insert data into tbRequests
INSERT INTO tbRequests (userID, requestType, description, requestStatus, requestDate) VALUES
(2, N'Hỗ trợ đơn hàng', N'Cần kiểm tra trạng thái đơn hàng #123', 0, '2025-05-25 16:40:00'),
(3, N'Báo lỗi', N'Hình ảnh sản phẩm không hiển thị đúng', 0, '2025-05-25 16:45:00');

-- Insert data into tbPaymentMethod
INSERT INTO tbPaymentMethod (paymentMethodName, description) VALUES
(N'Transfer', N'Thanh toán qua chuyển khoản'),
(N'COD', N'Thanh toán khi nhận hàng');

-- Insert data into tbOrder
INSERT INTO tbOrder (orderDate, total, userID, orderStatus, shippingAddress, paymentMethod, paymentStatus) VALUES
('2025-04-20 11:49:23.787', 698000.00, 1, 1, N'123 Đường Lê Lợi, Hà Nội', 1, 1),
('2025-04-21 10:30:00.000', 299000.00, 2, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 2, 1),
('2025-04-22 15:45:00.000', 399000.00, 2, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 1, 1),
('2025-04-23 09:20:00.000', 598000.00, 3, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 2, 1),
('2025-04-24 14:10:00.000', 299000.00, 3, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 1, 1),
('2025-04-25 16:30:00.000', 499000.00, 4, 1, N'321 Đường Phạm Văn Đồng, Hải Phòng', 2, 1),
('2025-04-26 12:00:00.000', 698000.00, 4, 1, N'321 Đường Phạm Văn Đồng, Hải Phòng', 1, 1);

-- Insert data into tbOrderDetail
INSERT INTO tbOrderDetail (price, quantity_product, orderID, variantID) VALUES
(299000.00, 1, 1, 1),
(399000.00, 1, 1, 2),
(299000.00, 1, 2, 1),
(399000.00, 1, 3, 2),
(299000.00, 2, 4, 1),
(399000.00, 1, 5, 2),
(299000.00, 1, 6, 1),
(399000.00, 1, 7, 2);

-- Insert data into Banner
INSERT INTO Banner (bannerLink) VALUES
(N'http://127.0.0.1:8080/PenguinShop/Images/banner/banner1.jpg'),
(N'http://127.0.0.1:8080/PenguinShop/Images/banner/banner2.webp'),
(N'http://127.0.0.1:8080/PenguinShop/Images/banner/banner3.webp');