USE PenguinShop
GO

-- tbRoles
INSERT INTO tbRoles (roleName) VALUES
(N'Admin'),
(N'Khách hàng'),
(N'Bán hàng');

-- tbUsers
INSERT INTO tbUsers (fullName, password, roleID, birthday, phone, email, image_user, status_account, created_at) VALUES
(N'Sơn', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 1, '1990-05-15', N'0987654321', N'kn1802204@gmail.com', N'vn-11134207-7ras8-m2j1kxknq7qqdd_vk04rb.jpg', 1, '2025-05-25 16:00:00'),
(N'Lan', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, '1992-08-20', N'0912345678', N'lan456@gmail.com', NULL, 1, '2025-05-25 16:00:00'),
(N'Hoàng', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 2, '1988-12-10', N'0934567890', N'hoang789@gmail.com', NULL, 1, '2025-05-25 16:00:00'),
(N'Hải', N'50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee', 3, '1995-03-25', N'0976543210', N'hai321@gmail.com', NULL, 1, '2025-05-25 16:00:00');


INSERT INTO tbDeliveryInfo (userID, fullName, phone, email, addressDetail, city, country, postalCode, isDefault, created_at) VALUES
(1, N'Sơn', N'0987654321', N'kn1802204@gmail.com', N'123 Đường Lê Lợi', N'Hà Nội', N'Việt Nam', NULL, 1, '2025-05-25 16:00:00'),
(2, N'Lan', N'0912345678', N'lan456@gmail.com', N'456 Đường Trần Hưng Đạo', N'TP.HCM', N'Việt Nam', NULL, 1, '2025-05-25 16:00:00'),
(3, N'Hoàng', N'0934567890', N'hoang789@gmail.com', N'789 Đường Nguyễn Huệ', N'Đà Nẵng', N'Việt Nam', NULL, 1, '2025-05-25 16:00:00'),
(4, N'Hải', N'0976543210', N'hai321@gmail.com', N'321 Đường Phạm Văn Đồng', N'Hải Phòng', N'Việt Nam', NULL, 1, '2025-05-25 16:00:00');

-- tbBrand
INSERT INTO tbBrand (brandName, logo, description) VALUES
(N'Nike', N'nike_vaan5l.png', N'Thương hiệu thể thao hàng đầu thế giới, nổi tiếng với giày và quần áo chất lượng cao.'),
(N'Adidas', N'Adidas-Logo.wine_abwuqn.png', N'Thương hiệu thể thao toàn cầu, chuyên về sản phẩm thời trang và hiệu suất.'),
(N'Puma', N'puma_cyxspq.png', N'Thương hiệu thể thao hàng đầu thế giới, nổi tiếng với giày và quần áo chất lượng cao.'),
(N'Coolmate', N'coolmate-1736836047_debeza.png', N'Thương hiệu thể thao toàn cầu, chuyên về sản phẩm thời trang và hiệu suất.'),
(N'Fila', N'fila_ac08cq.png', N'Thương hiệu thể thao hàng đầu thế giới, nổi tiếng với giày và quần áo chất lượng cao.'),
(N'Li-ning', N'lining_wvzlba.png', N'Thương hiệu thể thao toàn cầu, chuyên về sản phẩm thời trang và hiệu suất.');

-- tbCategory
INSERT INTO tbCategory (categoryName, sportType, imageCategory) VALUES
(N'Chạy bộ', N'Chạy bộ', N'groupbuy_4_img_compact_jaryu8.jpg'),
(N'Bóng rổ', N'Bóng rổ', N'groupbuy_7_img_compact_kodog0.jpg'),
(N'Pickerball', N'Pickerball', N'groupbuy_1_img_compact_knwb7m.png'),
(N'Tập Luyện', N'Tập Luyện', N'groupbuy_6_img_compact_wbgp8p.jpg'),
(N'Cầu Lông', N'Cầu Lông', N'groupbuy_8_img_compact_fbymod.jpg'),
(N'Golf', N'Golf', N'groupbuy_9_img_compact_iuwo9h.jpg'),
(N'Bóng Đá', N'Bóng Đá', N'groupbuy_10_img_compact_iax4uh.png'),
(N'Bóng Bàn', N'Bóng Bàn', N'groupbuy_11_img_compact_yqncbz.png'),
(N'Sản phẩm hot', N'Sản phẩm hot', N'pngtree-hot-sale-png-image_4961154_e12lav-removebg-preview_mnerk5.png'),
(N'Giảm giá', N'Giảm giá', N'retro-comic-style-flash-sale-banner-with-yellow-lightning-sign_1308-154191_mrch38.jpg'),
(N'Hàng mới về', N'Hàng mới về', N'pngtree-new-arrival-rounded-poster-png-image_3751044_nx306c.jpg');

-- tbProductType
INSERT INTO tbProductType (productTypeName) VALUES
(N'Áo'),
(N'Quần'),
(N'Giày'),
(N'Vợt Pickerball');

-- tbMaterial
INSERT INTO tbMaterial (materialName, materialDescription) VALUES
(N'Polyester', N'Chất liệu bền, thoáng khí'),
(N'Cotton', N'Chất liệu mềm mại, thấm hút tốt');

-- tbColor
INSERT INTO tbColor (colorName) VALUES
(N'Đỏ'),
(N'Xanh');

-- tbSize
INSERT INTO tbSize (sizeName) VALUES
(N'S'),
(N'M');

-- tbProduct
INSERT INTO tbProduct (productName, SKU, productTypeID, brandID, importDate, imageMainProduct, description, full_description, weight) VALUES
(N'Áo thun chạy bộ Advanced Vent Tech Graphic Camo', N'SKU001', 1, 1, '2025-05-25 16:00:00', N'aos_u9893e.jpg', N'Áo chạy bộ thoáng khí', N'Áo thun chạy bộ Advanced Vent Tech Graphic Camo là sản phẩm cao cấp được thiết kế dành riêng cho những người yêu thích chạy bộ và các hoạt động thể thao ngoài trời. Với chất liệu polyester thoáng khí tiên tiến, áo giúp giữ mát cơ thể, loại bỏ mồ hôi nhanh chóng nhờ công nghệ Dri-FIT độc quyền từ Nike. Thiết kế họa tiết camo thời trang mang lại phong cách cá tính, phù hợp cho cả nam và nữ. Sản phẩm có đường may chắc chắn, độ co giãn tốt, hỗ trợ tối đa các chuyển động linh hoạt trong suốt quá trình tập luyện. Áo phù hợp cho chạy bộ đường dài, tập gym hoặc các buổi dạo chơi ngoài trời dưới điều kiện thời tiết nóng ẩm. Hướng dẫn bảo quản: Giặt máy ở nhiệt độ thấp, tránh sử dụng chất tẩy mạnh để giữ màu sắc và chất lượng vải lâu dài. Đây là lựa chọn lý tưởng cho những ai tìm kiếm sự kết hợp hoàn hảo giữa hiệu suất và phong cách.', 250.00),
(N'Biker Shorts nữ chạy bộ 8inch', N'SKU002', 2, 2, '2025-05-25 16:00:00', N'biker-short-nu-chay-bo-8-inch-631_-den_mu1koi.jpg', N'Quần chạy bộ co giãn', N'Biker Shorts nữ chạy bộ 8inch từ Adidas là dòng sản phẩm được thiết kế dành riêng cho phụ nữ yêu thích vận động, đặc biệt là chạy bộ và yoga. Chất liệu chính là hỗn hợp elastane và polyester với khả năng co giãn 4 chiều, mang lại cảm giác thoải mái tối đa và hỗ trợ cơ bắp hiệu quả trong suốt quá trình tập luyện. Độ dài 8 inch lý tưởng để che phủ vừa phải, kết hợp với đường may phẳng chống cọ xát, giúp giảm kích ứng da. Quần có thiết kế ôm sát cơ thể, tôn dáng và tích hợp túi nhỏ để đựng chìa khóa hoặc điện thoại. Phù hợp cho các buổi chạy bộ buổi sáng, tập luyện trong phòng gym hoặc các hoạt động ngoài trời. Lưu ý bảo quản: Giặt tay hoặc giặt máy ở chế độ nhẹ, tránh sấy khô để giữ độ đàn hồi. Sản phẩm là sự kết hợp hoàn hảo giữa tính năng và phong cách thời trang hiện đại.', 300.00),
(N'Áo Polo Nam APLV047-10V', N'APLV047-10VXL', 1, 6, '2025-05-25 16:00:00', N'b6ba5dcd6d0f3b22b520fcb8ca87397b68adae246206ae7873d6fdb38624078f777ed3_7f0e6e24d0b44a58af496d1d86089c6f_dp22ri.webp', N'Áo polo thoáng khí', N'Áo Polo Nam APLV047-10V từ Li-Ning mang đến sự kết hợp hoàn hảo giữa phong cách lịch lãm và tính năng thể thao. Được may từ chất liệu cotton pha polyester thoáng khí, áo giúp thấm hút mồ hôi nhanh, giữ cho cơ thể khô ráo trong các hoạt động nhẹ nhàng như đi bộ, chơi golf hoặc tham dự sự kiện ngoài trời. Thiết kế cổ polo cổ điển với hàng khuy tinh tế, kết hợp các đường cắt hiện đại, tạo nên vẻ ngoài thanh lịch nhưng không kém phần năng động. Sản phẩm có độ bền cao nhờ kỹ thuật may tinh xảo, phù hợp cho cả nam giới yêu thích phong cách đa dụng. Hướng dẫn sử dụng: Giặt máy ở nhiệt độ trung bình, tránh sử dụng chất tẩy mạnh để giữ màu sắc tươi mới. Đây là lựa chọn lý tưởng cho những ai muốn nổi bật trong cả công việc và giải trí.', 250.00),
(N'Giày chạy bộ Nike Air Max', N'SKU003', 3, 1, '2025-05-26 10:00:00', N'v1748241783/W_AIR_MAX_DN8_sxh4ag.jpg', N'Giày chạy bộ nhẹ, êm ái, công nghệ Air Max', N'Giày chạy bộ Nike Air Max là biểu tượng của sự đổi mới trong ngành thể thao với công nghệ đệm khí Air Max độc quyền, mang lại cảm giác êm ái và giảm chấn vượt trội cho từng bước chạy. Được chế tạo từ chất liệu lưới thoáng khí kết hợp với da tổng hợp cao cấp, giày không chỉ nhẹ nhàng mà còn bền bỉ, phù hợp cho chạy bộ đường dài, tập luyện cường độ cao hoặc sử dụng hàng ngày. Thiết kế hiện đại với đế ngoài bằng cao su chống trơn trượt, tăng độ bám trên nhiều bề mặt. Sản phẩm hướng đến người chơi từ nghiệp dư đến chuyên nghiệp, với các tùy chọn màu sắc đa dạng. Hướng dẫn bảo quản: Vệ sinh bằng khăn ẩm, tránh ngâm nước quá lâu để bảo vệ lớp đệm khí. Đây là đôi giày hoàn hảo cho những ai đam mê tốc độ và phong cách.', 350.00),
(N'Áo bóng rổ Adidas Pro', N'SKU004', 1, 2, '2025-05-26 10:00:00', N'Ao_Thun_Bong_Ro_Khong_Tay_adidas_Unisex_JD6133_01_laydown_ioit2d.jpg', N'Áo bóng rổ thoáng khí, thiết kế chuyên nghiệp', N'Áo bóng rổ Adidas Pro được thiết kế dành riêng cho các vận động viên chuyên nghiệp, với chất liệu polyester thoáng khí và công nghệ Climalite giúp thấm hút mồ hôi nhanh chóng, giữ cơ thể khô ráo trong các trận đấu gay cấn. Thiết kế không tay tối ưu hóa phạm vi chuyển động, kết hợp các chi tiết in ấn tinh tế, tạo nên phong cách mạnh mẽ trên sân. Áo phù hợp cho cả thi đấu chính thức và tập luyện, hỗ trợ tối đa trong các pha bật nhảy hoặc di chuyển nhanh. Sản phẩm lý tưởng cho người chơi bóng rổ từ cấp độ bán chuyên đến chuyên nghiệp. Hướng dẫn bảo quản: Giặt máy ở chế độ nhẹ, tránh dùng nước nóng để giữ màu sắc và độ co giãn. Một lựa chọn không thể thiếu cho đam mê bóng rổ!', 200.00),
(N'Vợt Pickerball Puma Elite', N'SKU005', 4, 3, '2025-05-26 10:00:00', N'Vot-Pickleball-Facolos-Pro-Elite-Neon-1_lyvvbt.png', N'Vợt Pickerball chất lượng cao, độ bền tốt', N'Vợt Pickerball Puma Elite là sản phẩm cao cấp được chế tạo từ vật liệu composite tiên tiến, mang lại độ bền vượt trội và hiệu suất tối ưu cho mọi cú đánh. Thiết kế mặt vợt phẳng với lớp phủ đặc biệt giúp tăng độ kiểm soát bóng, trong khi tay cầm ergonomics giảm căng thẳng cho cổ tay trong các trận đấu dài. Sản phẩm phù hợp cho cả người chơi nghiệp dư muốn nâng cao kỹ năng lẫn vận động viên chuyên nghiệp. Vợt có trọng lượng nhẹ, cân bằng tốt, lý tưởng cho các kiểu chơi tấn công hoặc phòng ngự. Hướng dẫn bảo quản: Lau sạch sau khi sử dụng, tránh để tiếp xúc với ánh nắng trực tiếp quá lâu. Đây là người bạn đồng hành hoàn hảo trên sân Pickerball!', 300.00),
(N'Quần Thể Thao Nam 7" Ultra Shorts', N'SKU006', 2, 4, '2025-05-26 10:00:00', N'QTT.7.US_-Ultra-Short-7in-Xanh_-ForestNight-1_sfqfvc.webp', N'Quần tập luyện co giãn, thoải mái', N'Quần Thể Thao Nam 7" Ultra Shorts từ Coolmate mang đến sự thoải mái tối đa với chất liệu cotton pha elastane co giãn 4 chiều, hỗ trợ mọi chuyển động trong các bài tập gym, chạy bộ hoặc yoga. Thiết kế ngắn 7 inch giúp tăng sự thoáng mát, kết hợp với túi hai bên tiện lợi để đựng đồ dùng cá nhân như chìa khóa hoặc điện thoại. Đường may chắc chắn, chống xước, phù hợp cho nam giới yêu thích phong cách thể thao hiện đại. Sản phẩm có độ bền cao, dễ dàng giặt máy và nhanh khô. Hướng dẫn bảo quản: Giặt ở nhiệt độ thấp, tránh sấy khô để giữ độ co giãn. Đây là lựa chọn hoàn hảo cho các buổi tập luyện năng động!', 250.00),
(N'Giày Sneaker Unisex Fila Rayflide Canvas - Đen', N'SKU007', 3, 5, '2025-05-26 10:00:00', N'1RM02742F-978-1_vrcdgs.jpg', N'Giày cầu lông nhẹ, bám sân tốt', N'Giày Sneaker Unisex Fila Rayflide Canvas - Đen là sản phẩm lý tưởng cho những ai đam mê cầu lông với đế cao su chống trơn trượt, đảm bảo độ bám sân vượt trội trên nhiều bề mặt. Chất liệu vải canvas pha lưới thoáng khí giúp đôi chân luôn khô ráo, trong khi lớp đệm EVA mang lại cảm giác êm ái. Thiết kế unisex với kiểu dáng tối giản nhưng phong cách, phù hợp cho cả thi đấu và sử dụng hàng ngày. Giày có trọng lượng nhẹ, hỗ trợ tối đa trong các pha di chuyển nhanh. Hướng dẫn bảo quản: Lau bằng khăn ẩm, tránh ngâm nước để bảo vệ lớp đế. Một đôi giày hoàn hảo cho mọi sân chơi!', 400.00),
(N'Quần short Nam AKSU895-2V', N'SKU008', 1, 6, '2025-05-26 10:00:00', N'v1748242135/xx_00273_56727614041f462daf940bbe20b7fb56_tey71l.jpg', N'Quần short nam thoải mái, phong cách thể thao', N'Quần short Nam AKSU895-2V từ Li-Ning được thiết kế với chất liệu polyester thoáng khí và elastane co giãn, mang lại sự thoải mái tối ưu cho các hoạt động thể thao ngoài trời như chạy bộ, bóng đá hoặc leo núi. Thiết kế hiện đại với các đường cắt tinh tế, kết hợp túi sâu tiện lợi, phù hợp cho nam giới yêu thích phong cách năng động. Quần có khả năng chống nhăn, dễ giặt và nhanh khô, lý tưởng cho các chuyến đi dài ngày. Hướng dẫn bảo quản: Giặt máy ở chế độ nhẹ, tránh chất tẩy mạnh để giữ màu sắc và độ bền. Sản phẩm là sự kết hợp hoàn hảo giữa chức năng và thời trang!', 600.00),
(N'Áo thun nữ HER', N'SKU009', 1, 1, '2025-05-26 10:00:00', N'C3_81o-thun-n_E1_BB_AF-HER_d3sgys.jpg', N'Áo ba lỗ thể thao nữ thoáng khí, thời trang', N'Áo thun nữ HER từ Nike là lựa chọn hoàn hảo cho phụ nữ yêu thích thể thao với thiết kế ba lỗ thoáng khí, giúp tối ưu hóa sự thoải mái trong các bài tập như yoga, chạy bộ hoặc gym. Chất liệu cotton pha polyester mềm mại, thấm hút mồ hôi nhanh, kết hợp đường cắt ôm sát tôn lên vóc dáng nữ tính. Áo có màu sắc tươi sáng và họa tiết tinh tế, phù hợp cho cả mặc tập luyện lẫn dạo phố. Sản phẩm bền bỉ, dễ dàng bảo quản với khả năng chống xù lông. Hướng dẫn bảo quản: Giặt máy ở nhiệt độ thấp, tránh sấy khô để giữ form áo. Một item không thể thiếu trong tủ đồ thể thao của bạn!', 500.00),
(N'Áo jersey hình trang trí nam PUMA x KIDSUPER', N'SKU010', 1, 3, '2025-05-26 10:00:00', N'C3_81o-jersey-h_C3_ACnh-trang-tr_C3_AD-nam-PUMA-x-KIDSUPER_d7btsb.jpg', N'Áo jersey nam PUMA x KIDSUPER, phong cách độc đáo', N'Áo jersey nam PUMA x KIDSUPER là sản phẩm hợp tác độc quyền, mang đến sự kết hợp giữa phong cách thể thao và nghệ thuật đường phố. Thiết kế nổi bật với các họa tiết trang trí độc đáo, in ấn chất lượng cao, cùng chất liệu polyester thoáng khí giúp giữ mát trong các hoạt động ngoài trời. Áo có độ co giãn tốt, đường may chắc chắn, phù hợp cho nam giới yêu thích thể hiện cá tính qua thời trang. Sản phẩm lý tưởng cho các buổi dạo chơi, biểu diễn hoặc tập luyện nhẹ. Hướng dẫn bảo quản: Giặt tay hoặc giặt máy ở chế độ nhẹ, tránh dùng nước nóng để giữ màu sắc sống động. Một tuyên ngôn phong cách từ PUMA và KIDSUPER!', 200.00);
-- tbProductCategory
INSERT INTO tbProductCategory (productID, categoryID) VALUES
(1, 1),(1,9), -- Áo chạy bộ nam: Chạy bộ
(2, 1), -- Quần chạy bộ nữ: Chạy bộ
(3, 11), -- Áo Polo Nam APLV047-10V: Hàng mới về
(4, 11), (4, 1),(4, 9), -- Giày Nike Air Max: Hàng mới về, Chạy bộ
(5, 11), (5, 2),(5, 9), -- Áo Adidas Pro: Hàng mới về, Bóng rổ
(6, 11), (6, 3),(6, 9), -- Vợt Puma Elite: Hàng mới về, Pickerball
(7, 11), (7, 4),(7, 9), -- Quần Coolmate Active: Hàng mới về, Tập Luyện
(8, 11), (8, 5),(8, 9), -- Giày Fila Pro: Hàng mới về, Cầu Lông
(9, 11), (9, 6),-- Gậy Li-ning Precision: Hàng mới về, Golf
(10, 11), (10, 7), -- Bóng Nike Strike: Hàng mới về, Bóng Đá
(11, 11), (11, 8); -- Vợt Puma Speed: Hàng mới về, Bóng Bàn



-- tbProductVariant
INSERT INTO tbProductVariant (productID, colorID, sizeID, quantity, price, stockStatus) VALUES
(1, 1, 1, 50, 299000.00, 1), -- Áo chạy bộ nam, Đỏ, S
(2, 2, 2, 30, 399000.00, 1), -- Quần chạy bộ nữ, Xanh, M
(3, 1, 1, 40, 499000.00, 1), -- Áo Polo Nam APLV047-10V, Đỏ, S
(4, 1, 1, 100, 999000.00, 1), -- Giày Nike Air Max, Đỏ, S
(5, 2, 2, 80, 499000.00, 1), -- Áo Adidas Pro, Xanh, M
(6, 1, 1, 50, 799000.00, 1), -- Vợt Puma Elite, Đỏ, S
(7, 2, 2, 60, 399000.00, 1), -- Quần Coolmate Active, Xanh, M
(8, 1, 1, 70, 1099000.00, 1), -- Giày Fila Pro, Đỏ, S
(9, 2, 2, 40, 2999000.00, 1), -- Gậy Li-ning Precision, Xanh, M
(10, 1, 1, 90, 599000.00, 1), -- Bóng Nike Strike, Đỏ, S
(11, 2, 2, 50, 699000.00, 1); -- Vợt Puma Speed, Xanh, M


-- tbVariantMaterial
INSERT INTO tbVariantMaterial (variantID, materialID, percentage) VALUES
(1, 1, 80.00),
(1, 2, 20.00),
(2, 2, 100.00),
(3, 1, 90.00),
(4, 1, 70.00),
(5, 2, 100.00),
(6, 1, 80.00),
(7, 2, 90.00),
(8, 1, 70.00),
(9, 1, 60.00),
(10, 1, 80.00),
(11, 2, 90.00);

-- tbFeedback
INSERT INTO tbFeedback (productID, variantID, userID, rating, comment, feedbackDate) VALUES
(1, 1, 2, 5, N'Áo đỏ size S rất thoải mái, thoáng khí!', '2025-05-25 16:30:00'),
(2, 2, 3, 4, N'Quần xanh size M đẹp nhưng hơi chật.', '2025-05-25 16:35:00');

-- tbImages
INSERT INTO tbImages (productID, feedbackID, imageURL, imageCaption) VALUES
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-504-xam-ghi_43_dbwx2y.jpg', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-504-xam-ghi_43_ogbrij.jpg', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-506-xam-ghi_40_kvqzhg.webp', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-514-xam-ghi_hcdqrl.webp', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-538-xam-ghi_atahag.webp', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-515-xam-ghi_yimi9v.webp', N'Áo chạy bộ nam màu đỏ'),
(1, NULL, N'ao-thun-chay-bo-advanced-vent-techgraphic-camo-523-xam-ghi_xjotnv.jpg', N'Áo chạy bộ nam màu đỏ'),
(2, NULL, N'quan_chay_bo_nu.jpg', N'Quần chạy bộ nữ màu xanh'),
(NULL, 1, N'feedback_ao_chay_bo.jpg', N'Hình ảnh áo chạy bộ đỏ size S từ khách hàng'),
(NULL, 2, N'feedback_quan_chay_bo.jpg', N'Hình ảnh quần chạy bộ xanh size M từ khách hàng');


-- tbProductTag
INSERT INTO tbTag (tagName, tagDescription) VALUES
(N'Thoáng khí', N'Chất liệu thoáng khí, phù hợp cho các hoạt động thể thao'),
(N'Nhẹ', N'Trọng lượng nhẹ, dễ dàng vận động'),
(N'Chống mồ hôi', N'Công nghệ chống thấm mồ hôi hiệu quả'),
(N'Co giãn', N'Chất liệu co giãn, thoải mái khi vận động'),
(N'Êm ái', N'Đệm êm ái, giảm chấn tốt'),
(N'Chuyên nghiệp', N'Thiết kế dành cho vận động viên chuyên nghiệp');

-- Dữ liệu cho tbProductTag
INSERT INTO tbProductTag (productID, tagID) VALUES
(1, 1), -- Áo chạy bộ nam: Thoáng khí
(1, 2), -- Áo chạy bộ nam: Nhẹ
(1, 3), -- Áo chạy bộ nam: Chống mồ hôi
(2, 4), -- Quần chạy bộ nữ: Co giãn
(4, 5), -- Giày Nike Air Max: Êm ái
(4, 1), -- Giày Nike Air Max: Thoáng khí (reusing the tag)
(5, 6), -- Áo Adidas Pro: Chuyên nghiệp
(5, 1); -- Áo Adidas Pro: Thoáng khí (reusing the tag)
-- tbCart
INSERT INTO tbCart (userID, variantID, quantity, productID) VALUES
(1, 1, 2, 1);

-- tbRequests
INSERT INTO tbRequests (userID, requestType, description, requestStatus, requestDate) VALUES
(2, N'Hỗ trợ đơn hàng', N'Cần kiểm tra trạng thái đơn hàng #123', 0, '2025-05-25 16:40:00'),
(3, N'Báo lỗi', N'Hình ảnh sản phẩm không hiển thị đúng', 0, '2025-05-25 16:45:00');

-- tbPaymentMethod
INSERT INTO tbPaymentMethod (paymentMethodName, description) VALUES
(N'Transfer', N'Thanh toán qua chuyển khoản'),
(N'COD', N'Thanh toán khi nhận hàng');

-- tbOrder
INSERT INTO tbOrder (orderDate, total, userID, orderStatus, shippingAddress, paymentMethod, paymentStatus) VALUES
('2025-04-20 11:49:23.787', 698000.00, 1, 1, N'123 Đường Lê Lợi, Hà Nội', 1, 1),
('2025-04-21 10:30:00.000', 299000.00, 2, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 2, 1),
('2025-04-22 15:45:00.000', 399000.00, 2, 1, N'456 Đường Trần Hưng Đạo, TP.HCM', 1, 1),
('2025-04-23 09:20:00.000', 598000.00, 3, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 2, 1),
('2025-04-24 14:10:00.000', 299000.00, 3, 1, N'789 Đường Nguyễn Huệ, Đà Nẵng', 1, 1),
('2025-04-25 16:30:00.000', 499000.00, 4, 1, N'321 Đường Phạm Văn Đồng, Hải Phòng', 2, 1),
('2025-04-26 12:00:00.000', 698000.00, 4, 1, N'321 Đường Phạm Văn Đồng, Hải Phòng', 1, 1);

-- tbOrderDetail
INSERT INTO tbOrderDetail (price, quantity_product, orderID, variantID) VALUES
(299000.00, 1, 1, 1),
(399000.00, 1, 1, 2),
(299000.00, 1, 2, 1),
(399000.00, 1, 3, 2),
(299000.00, 2, 4, 1),
(399000.00, 1, 5, 2),
(299000.00, 1, 6, 1),
(399000.00, 1, 7, 2);

-- Banner
INSERT INTO Banner (bannerLink) VALUES
(N'v1748442991/1920x788_29_dhbmyl.webp'),
(N'T-SHIRT__POLO_THE_THAO_-_Desktop2_qhzqio.webp'),
(N'v1748443170/1920x788_1_promax_w62d1k.webp'),
(N'T-SHIRT__POLO_THE_THAO_-_Desktop-1_dhf83g.webp'),
(N'T-SHIRT__POLO_THE_THAO_-_Desktopzz_vw9vp7.jpg');

-- tbPromotion
INSERT INTO tbPromotion (promotionName, discountType, discountValue, startDate, endDate, description, isActive) VALUES
(N'Sale Hàng Mới Về', N'PERCENTAGE', 20.00, '2025-05-26', '2025-05-28', N'Giảm giá 20% cho sản phẩm mới', 1);

-- tbProductPromotion
INSERT INTO tbProductPromotion (promotionID, productID) VALUES
(1, 4); -- Giảm giá 20% cho Giày Nike Air Max

INSERT INTO tbLogs (userID, action, description, logDate)
VALUES 
(1, N'Yêu cầu lấy lại mật khẩu', N'Người dùng đã yêu cầu gửi mã OTP để lấy lại mật khẩu qua email.', '2025-05-27 14:45:00'),
(1, N'Gửi mã OTP', N'Hệ thống đã gửi mã OTP thành công đến email của người dùng.', '2025-05-27 14:46:00'),
(1, N'Xác nhận OTP', N'Người dùng đã nhập mã OTP chính xác để xác minh danh tính.', '2025-05-27 14:50:00'),
(1, N'Đặt lại mật khẩu', N'Người dùng đã đặt lại mật khẩu thành công.', '2025-05-27 14:55:00'),
(1, N'Hoàn tất lấy lại mật khẩu', N'Quy trình lấy lại mật khẩu đã hoàn tất cho người dùng.', '2025-05-27 15:00:00'),
(1, N'Yêu cầu lấy lại mật khẩu', N'Người dùng đã yêu cầu gửi mã OTP để lấy lại mật khẩu qua email.', '2025-05-14 10:30:00'),
(1, N'Xác nhận OTP', N'Người dùng đã nhập mã OTP chính xác để xác minh danh tính.', '2025-05-14 10:35:00');