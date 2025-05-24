-- Insert data into tbRoles
INSERT INTO tbRoles (roleName) VALUES
(N'Quản trị viên'),
(N'Khách hàng');

-- Insert data into tbUsers
INSERT INTO tbUsers (fullName, password, roleID, address, birthday, phone, email,image_user) VALUES
(N'Sơn', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'123 Đường Lê Lợi, Hà Nội', '1990-05-15', N'0987654321', N'son123@gmail.com','http://localhost:8080/PenguinShop/Images/vn-11134207-7ras8-m2j1kxknq7qqdd.jpeg');

-- Insert additional users into tbUsers
INSERT INTO tbUsers (fullName, password, roleID, address, birthday, phone, email) VALUES
(N'Lan', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'456 Đường Trần Hưng Đạo, TP.HCM', '1992-08-20', N'0912345678', N'lan456@gmail.com'),
(N'Hoàng', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'789 Đường Nguyễn Huệ, Đà Nẵng', '1988-12-10', N'0934567890', N'hoang789@gmail.com'),
(N'Hải', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, N'321 Đường Phạm Văn Đồng, Hải Phòng', '1995-03-25', N'0976543210', N'hai321@gmail.com');
-- Insert data into tbCategory
INSERT INTO tbCategory (categoryName, sportType) VALUES
(N'Chạy bộ', N'Chạy bộ'),
(N'Bóng rổ', N'Bóng rổ');

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
INSERT INTO tbProduct (productName, SKU, productTypeID, categoryID, importDate, imageMainProduct, description, weight) VALUES
(N'Áo chạy bộ nam', N'SKU001', 1, 1, '2023-01-01', N'https://product.hstatic.net/1000312752/product/73a210bb4f802f932adf41cc8fe23c179151b14a9cfb21d6f22ab2b38624078f777ed3_08b2ce3740cd43d8ba0a65db72a4cd24.jpg', N'Áo chạy bộ thoáng khí', 250.00),
(N'Quần chạy bộ nữ', N'SKU002', 2, 1, '2023-01-01', N'https://product.hstatic.net/1000312752/product/73a210bb4f802f932adf41cc8fe23c179151b14a9cfb21d6f22ab2b38624078f777ed3_08b2ce3740cd43d8ba0a65db72a4cd24.jpg', N'Quần chạy bộ co giãn', 300.00);

-- Insert data into tbProductImage
INSERT INTO tbProductImage (productID, imageURL, imageCaption) VALUES
(1, N'/images/ao-chay-bo-nam.jpg', N'Áo chạy bộ nam màu đỏ'),
(2, N'/images/quan-chay-bo-nu.jpg', N'Quần chạy bộ nữ màu xanh');

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

-- Insert data into tbPaymentMethod
INSERT INTO tbPaymentMethod (paymentMethodName, description) VALUES
(N'Transfer', N'Thanh toán qua chuyển khoản'),
(N'COD', N'Thanh toán khi nhận hàng');

-- Insert data into tbOrder
INSERT INTO tbOrder (orderDate, total, userID, orderStatus, shippingAddress, paymentMethod, paymentStatus) VALUES
('2025-04-20 11:49:23.787', 698000.00, 1, 1, N'123 Đường Lê Lợi, Hà Nội', 1, 1), -- PaymentStatus: 1 - Đã thanh toán
('2025-04-21 10:30:00.000', 299000.00, 1, 1, N'123 Đường Lê Lợi, Hà Nội', 2, 1), -- New order with COD payment
('2025-04-22 15:45:00.000', 399000.00, 1, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 1, 1), -- New order with transfer payment
('2025-04-23 09:20:00.000', 598000.00, 1, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 2, 1), -- New order with COD payment
('2025-04-24 14:10:00.000', 299000.00, 1, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 1, 1), -- New order with transfer payment
('2025-04-25 16:30:00.000', 499000.00, 3, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 2, 1), -- New order with COD payment
('2025-04-26 12:00:00.000', 698000.00, 4, 1, N'321 Đường Phạm Văn Đồng, Hải Phòng', 1, 1); -- New order with transfer payment

-- Insert data into tbOrderDetail
INSERT INTO tbOrderDetail (price, quantity_product, orderID, variantID) VALUES
(299000.00, 1, 1, 1),
(399000.00, 1, 1, 2),
(299000.00, 1, 2, 1), -- New order detail for order 2
(399000.00, 1, 3, 2), -- New order detail for order 3
(299000.00, 2, 4, 1), -- New order detail for order 4
(399000.00, 1, 5, 2), -- New order detail for order 5
(299000.00, 1, 6, 1), -- New order detail for order 6
(399000.00, 1, 7, 2); -- New order detail for order 7

INSERT INTO Banner (bannerLink) VALUES
('http://127.0.0.1:8080/PenguinShop/Images/banner/banner1.jpg'),
('http://127.0.0.1:8080/PenguinShop/Images/banner/banner2.webp'),
('http://127.0.0.1:8080/PenguinShop/Images/banner/banner3.webp');
