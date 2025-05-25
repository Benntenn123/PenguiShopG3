USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'PenguinShop')
BEGIN
	ALTER DATABASE PenguinShop SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE PenguinShop SET ONLINE;
	DROP DATABASE PenguinShop;
END

GO

CREATE DATABASE PenguinShop
GO

USE PenguinShop
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO
-- Bảng vai trò người dùng
-- Bảng vai trò người dùng
-- Bảng vai trò người dùng
CREATE TABLE tbRoles (
    roleID INT PRIMARY KEY IDENTITY(1,1), -- ID vai trò tự động tăng
    roleName NVARCHAR(50) NOT NULL -- Tên vai trò, ví dụ: Admin, Khách hàng, Bán hàng
);

-- Bảng quyền hạn
CREATE TABLE tbPermissions (
    permissionID INT PRIMARY KEY IDENTITY(1,1), -- ID quyền hạn tự động tăng
    permissionName NVARCHAR(50) NOT NULL, -- Tên quyền, ví dụ: Quản lý sản phẩm, Xem đơn hàng
    permissionDescription NVARCHAR(200) -- Mô tả quyền hạn
);

-- Bảng liên kết vai trò và quyền hạn
CREATE TABLE tbRolePermissions (
    rolePermissionID INT PRIMARY KEY IDENTITY(1,1), -- ID liên kết tự động tăng
    roleID INT,
    permissionID INT,
    FOREIGN KEY (roleID) REFERENCES tbRoles(roleID),
    FOREIGN KEY (permissionID) REFERENCES tbPermissions(permissionID)
);

-- Bảng thông tin người dùng
CREATE TABLE tbUsers (
    userID INT PRIMARY KEY IDENTITY(1,1), -- ID người dùng tự động tăng
    fullName NVARCHAR(100) NOT NULL, -- Họ và tên
    password NVARCHAR(100) NOT NULL, -- Mật khẩu
    roleID INT,
    address NVARCHAR(200), -- Địa chỉ
    birthday DATE, -- Ngày sinh
    phone NVARCHAR(15), -- Số điện thoại
    email NVARCHAR(100), -- Email
    image_user NVARCHAR(200), -- Avatar User
    FOREIGN KEY (roleID) REFERENCES tbRoles(roleID)
);

-- Bảng nhật ký hệ thống
CREATE TABLE tbLogs (
    logID INT PRIMARY KEY IDENTITY(1,1), -- ID log tự động tăng
    userID INT, -- Người thực hiện hành động
    action NVARCHAR(100) NOT NULL, -- Hành động, ví dụ: Thêm sản phẩm, Cập nhật đơn hàng
    description NVARCHAR(500), -- Mô tả chi tiết
    logDate DATETIME NOT NULL DEFAULT GETDATE(), -- Thời gian thực hiện
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng thương hiệu
CREATE TABLE tbBrand (
    brandID INT PRIMARY KEY IDENTITY(1,1), -- ID thương hiệu tự động tăng
    brandName NVARCHAR(50) NOT NULL, -- Tên thương hiệu, ví dụ: Nike, Adidas
    logo NVARCHAR(200), -- Đường dẫn đến logo thương hiệu
    description NVARCHAR(500) -- Mô tả thương hiệu
);

-- Bảng danh mục sản phẩm theo môn thể thao
CREATE TABLE tbCategory (
    categoryID INT PRIMARY KEY IDENTITY(1,1), -- ID danh mục tự động tăng
    categoryName NVARCHAR(50) NOT NULL, -- Tên danh mục, ví dụ: Chạy bộ, Bóng rổ
    sportType NVARCHAR(50), -- Loại thể thao, ví dụ: Chạy bộ, Bóng rổ, Yoga
    imageCategory NVARCHAR(255) -- Image Category
);

-- Bảng loại sản phẩm
CREATE TABLE tbProductType (
    productTypeID INT PRIMARY KEY IDENTITY(1,1), -- ID loại sản phẩm tự động tăng
    productTypeName NVARCHAR(50) NOT NULL -- Tên loại sản phẩm, ví dụ: Áo, Quần
);

-- Bảng sản phẩm
CREATE TABLE tbProduct (
    productID INT PRIMARY KEY IDENTITY(1,1), -- ID sản phẩm tự động tăng
    productName NVARCHAR(100) NOT NULL, -- Tên sản phẩm, ví dụ: Áo chạy bộ
    SKU NVARCHAR(50) NOT NULL UNIQUE, -- Mã SKU duy nhất cho sản phẩm
    productTypeID INT, -- Liên kết với loại sản phẩm (Áo, Quần)
    categoryID INT, -- Liên kết với danh mục (Chạy bộ, Bóng rổ, v.v.)
    brandID INT, -- Liên kết với thương hiệu
    importDate DATETIME, -- Ngày nhập hàng
    imageMainProduct NVARCHAR(200), -- Đường dẫn hình ảnh chính của sản phẩm
    description NVARCHAR(500), -- Mô tả sản phẩm
    weight DECIMAL(5, 2), -- Trọng lượng tính bằng gram
    FOREIGN KEY (productTypeID) REFERENCES tbProductType(productTypeID),
    FOREIGN KEY (categoryID) REFERENCES tbCategory(categoryID),
    FOREIGN KEY (brandID) REFERENCES tbBrand(brandID)
);

-- Bảng chất liệu
CREATE TABLE tbMaterial (
    materialID INT PRIMARY KEY IDENTITY(1,1), -- ID chất liệu tự động tăng
    materialName NVARCHAR(50) NOT NULL, -- Tên chất liệu, ví dụ: Polyester, Cotton
    materialDescription NVARCHAR(200) -- Mô tả chất liệu
);

-- Bảng màu sắc
CREATE TABLE tbColor (
    colorID INT PRIMARY KEY IDENTITY(1,1), -- ID màu sắc tự động tăng
    colorName NVARCHAR(50) NOT NULL -- Tên màu, ví dụ: Đỏ, Xanh
);

-- Bảng kích cỡ
CREATE TABLE tbSize (
    sizeID INT PRIMARY KEY IDENTITY(1,1), -- ID kích cỡ tự động tăng
    sizeName NVARCHAR(10) NOT NULL -- Tên cỡ, ví dụ: S, M, L, XL
);

-- Bảng biến thể sản phẩm (quản lý màu, cỡ, số lượng)
CREATE TABLE tbProductVariant (
    variantID INT PRIMARY KEY IDENTITY(1,1), -- ID biến thể tự động tăng
    productID INT,
    colorID INT, -- Liên kết với bảng màu
    sizeID INT, -- Liên kết với bảng kích cỡ
    quantity INT NOT NULL, -- Số lượng tồn kho cho tổ hợp màu-cỡ này
    price DECIMAL(10, 2) NOT NULL, -- Giá tiền
    stockStatus INT NOT NULL, -- Trạng thái tồn kho, ví dụ: 1 - Còn hàng, 0 - Sắp hết, 2 - Hết hàng
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (colorID) REFERENCES tbColor(colorID),
    FOREIGN KEY (sizeID) REFERENCES tbSize(sizeID)
);

-- Bảng đánh giá sản phẩm
CREATE TABLE tbFeedback (
    feedbackID INT PRIMARY KEY IDENTITY(1,1), -- ID đánh giá tự động tăng
    productID INT, -- Liên kết với sản phẩm
    variantID INT, -- Liên kết với biến thể sản phẩm (màu, cỡ)
    userID INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Điểm đánh giá từ 1 đến 5
    comment NVARCHAR(500), -- Bình luận
    feedbackDate DATETIME NOT NULL DEFAULT GETDATE(), -- Ngày gửi đánh giá
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng hình ảnh (cho cả sản phẩm và feedback)
CREATE TABLE tbImages (
    imageID INT PRIMARY KEY IDENTITY(1,1), -- ID hình ảnh tự động tăng
    productID INT, -- Liên kết với sản phẩm (nullable)
    feedbackID INT, -- Liên kết với feedback (nullable)
    imageURL NVARCHAR(200) NOT NULL, -- Đường dẫn hình ảnh
    imageCaption NVARCHAR(100), -- Chú thích hình ảnh
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (feedbackID) REFERENCES tbFeedback(feedbackID),
    CONSTRAINT CHK_OneReference CHECK (
        (productID IS NOT NULL AND feedbackID IS NULL) OR 
        (productID IS NULL AND feedbackID IS NOT NULL)
    )
);

-- Bảng thẻ tag của sản phẩm
CREATE TABLE tbProductTag (
    tagID INT PRIMARY KEY IDENTITY(1,1), -- ID tag tự động tăng
    productID INT,
    tagName NVARCHAR(50) NOT NULL, -- Tên tag, ví dụ: Thoáng khí, Co giãn
    tagDescription NVARCHAR(200), -- Mô tả tag
    FOREIGN KEY (productID) REFERENCES tbProduct(productID)
);

-- Bảng liên kết biến thể sản phẩm với chất liệu
CREATE TABLE tbVariantMaterial (
    variantMaterialID INT PRIMARY KEY IDENTITY(1,1), -- ID liên kết tự động tăng
    variantID INT,
    materialID INT,
    percentage DECIMAL(5, 2), -- Tỷ lệ phần trăm chất liệu, ví dụ: 80% Polyester
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    FOREIGN KEY (materialID) REFERENCES tbMaterial(materialID)
);

-- Bảng giỏ hàng
CREATE TABLE tbCart (
    cartID INT PRIMARY KEY IDENTITY(1,1), -- ID giỏ hàng tự động tăng
    userID INT,
    variantID INT,
    quantity INT NOT NULL CHECK (quantity > 0), -- Số lượng sản phẩm
    addedDate DATETIME NOT NULL DEFAULT GETDATE(), -- Thời gian thêm vào giỏ
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);

-- Bảng phương thức thanh toán
CREATE TABLE tbPaymentMethod (
    paymentMethodID INT PRIMARY KEY IDENTITY(1,1), -- ID phương thức thanh toán tự động tăng
    paymentMethodName NVARCHAR(50) NOT NULL, -- Tên phương thức thanh toán
    description NVARCHAR(200) -- Mô tả phương thức thanh toán
);

-- Bảng đơn hàng
CREATE TABLE tbOrder (
    orderID INT PRIMARY KEY IDENTITY(1,1), -- ID đơn hàng tự động tăng
    orderDate DATETIME NOT NULL, -- Ngày đặt hàng
    total DECIMAL(10, 2) NOT NULL, -- Tổng tiền
    userID INT,
    orderStatus INT NOT NULL, -- Trạng thái đơn hàng
    shippingAddress NVARCHAR(200), -- Địa chỉ giao hàng
    paymentMethod INT, -- Phương thức thanh toán
    paymentStatus BIT, -- Trạng thái thanh toán
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY (paymentMethod) REFERENCES tbPaymentMethod(paymentMethodID)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE tbOrderDetail (
    detailID INT PRIMARY KEY IDENTITY(1,1), -- ID chi tiết đơn hàng tự động tăng
    price DECIMAL(10, 2) NOT NULL, -- Giá tại thời điểm mua
    quantity_product INT NOT NULL, -- Số lượng mua
    orderID INT,
    variantID INT, -- Liên kết với biến thể sản phẩm
    FOREIGN KEY (orderID) REFERENCES tbOrder(orderID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);

-- Bảng yêu cầu hỗ trợ
CREATE TABLE tbRequests (
    requestID INT PRIMARY KEY IDENTITY(1,1), -- ID yêu cầu tự động tăng
    userID INT,
    requestType NVARCHAR(50) NOT NULL, -- Loại yêu cầu, ví dụ: Hỗ trợ đơn hàng, Báo lỗi
    description NVARCHAR(500) NOT NULL, -- Mô tả yêu cầu
    requestStatus INT NOT NULL DEFAULT 0, -- Trạng thái: 0 - Chưa xử lý, 1 - Đang xử lý, 2 - Đã hoàn thành
    requestDate DATETIME NOT NULL DEFAULT GETDATE(), -- Ngày gửi yêu cầu
    response NVARCHAR(500), -- Phản hồi từ admin
    responseDate DATETIME, -- Ngày phản hồi
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng banner
CREATE TABLE Banner (
    bannerID INT IDENTITY(1,1) PRIMARY KEY,
    bannerLink NVARCHAR(255)
);