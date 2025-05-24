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
CREATE TABLE tbRoles (
    roleID INT PRIMARY KEY identity(1,1), -- ID vai trò tự động tăng
    roleName NVARCHAR(50) NOT NULL -- Tên vai trò, ví dụ: Quản trị viên, Khách hàng
);
CREATE TABLE Banner(
	bannerID INT IDENTITY(1,1) PRIMARY KEY,
	bannerLink NVARCHAR(255),
)
-- Bảng thông tin người dùng
CREATE TABLE tbUsers (
    userID INT PRIMARY KEY identity(1,1), -- ID người dùng tự động tăng
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

-- Bảng danh mục sản phẩm theo môn thể thao
CREATE TABLE tbCategory (
    categoryID INT PRIMARY KEY identity(1,1), -- ID danh mục tự động tăng
    categoryName NVARCHAR(50) NOT NULL, -- Tên danh mục, ví dụ: Chạy bộ, Bóng rổ
    sportType NVARCHAR(50), -- Loại thể thao, ví dụ: Chạy bộ, Bóng rổ, Yoga
	imageCategory NVARCHAR(255); -- Image Category
);

-- Bảng loại sản phẩm
CREATE TABLE tbProductType (
    productTypeID INT PRIMARY KEY identity(1,1), -- ID loại sản phẩm tự động tăng
    productTypeName NVARCHAR(50) NOT NULL -- Tên loại sản phẩm, ví dụ: Áo, Quần
);

-- Bảng chất liệu
CREATE TABLE tbMaterial (
    materialID INT PRIMARY KEY identity(1,1), -- ID chất liệu tự động tăng
    materialName NVARCHAR(50) NOT NULL, -- Tên chất liệu, ví dụ: Polyester, Cotton
    materialDescription NVARCHAR(200) -- Mô tả chất liệu
);

-- Bảng màu sắc
CREATE TABLE tbColor (
    colorID INT PRIMARY KEY identity(1,1), -- ID màu sắc tự động tăng
    colorName NVARCHAR(50) NOT NULL -- Tên màu, ví dụ: Đỏ, Xanh, Đen
);

-- Bảng kích cỡ
CREATE TABLE tbSize (
    sizeID INT PRIMARY KEY identity(1,1), -- ID kích cỡ tự động tăng
    sizeName NVARCHAR(10) NOT NULL -- Tên cỡ, ví dụ: S, M, L, XL
);

-- Bảng sản phẩm
CREATE TABLE tbProduct (
    productID INT PRIMARY KEY identity(1,1), -- ID sản phẩm tự động tăng
    productName NVARCHAR(100) NOT NULL, -- Tên sản phẩm, ví dụ: Áo chạy bộ
    SKU NVARCHAR(50) NOT NULL UNIQUE, -- Mã SKU duy nhất cho sản phẩm
    productTypeID INT, -- Liên kết với loại sản phẩm (Áo, Quần)
    categoryID INT, -- Liên kết với danh mục (Chạy bộ, Bóng rổ, v.v.)
    importDate DATETIME, -- Ngày nhập hàng
    imageMainProduct NVARCHAR(200), -- Đường dẫn hình ảnh chính của sản phẩm
    description NVARCHAR(500), -- Mô tả sản phẩm
    weight DECIMAL(5, 2), -- Trọng lượng tính bằng gram
    FOREIGN KEY (productTypeID) REFERENCES tbProductType(productTypeID),
    FOREIGN KEY (categoryID) REFERENCES tbCategory(categoryID)
);

-- Bảng hình ảnh sản phẩm
CREATE TABLE tbProductImage (
    imageID INT PRIMARY KEY identity(1,1), -- ID hình ảnh tự động tăng
    productID INT,
    imageURL NVARCHAR(200) NOT NULL, -- Đường dẫn hình ảnh
    imageCaption NVARCHAR(100), -- Chú thích hình ảnh
    FOREIGN KEY (productID) REFERENCES tbProduct(productID)
);

-- Bảng thẻ tag của sản phẩm
CREATE TABLE tbProductTag (
    tagID INT PRIMARY KEY identity(1,1), -- ID tag tự động tăng
    productID INT,
    tagName NVARCHAR(50) NOT NULL, -- Tên tag, ví dụ: Thoáng khí, Co giãn
    tagDescription NVARCHAR(200), -- Mô tả tag
    FOREIGN KEY (productID) REFERENCES tbProduct(productID)
);

-- Bảng biến thể sản phẩm (quản lý màu, cỡ, số lượng)
CREATE TABLE tbProductVariant (
    variantID INT PRIMARY KEY identity(1,1), -- ID biến thể tự động tăng
    productID INT,
    colorID INT, -- Liên kết với bảng màu
    sizeID INT, -- Liên kết với bảng kích cỡ
    quantity INT NOT NULL, -- Số lượng tồn kho cho tổ hợp màu-cỡ này
    price DECIMAL(10, 2) NOT NULL, -- Giá tiền
    stockStatus int NOT NULL, -- Trạng thái tồn kho, ví dụ: 1 - Còn hàng, 0 - Sắp hết, 2 - Hết hàng
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (colorID) REFERENCES tbColor(colorID),
    FOREIGN KEY (sizeID) REFERENCES tbSize(sizeID)
);

-- Bảng liên kết biến thể sản phẩm với chất liệu
CREATE TABLE tbVariantMaterial (
    variantMaterialID INT PRIMARY KEY identity(1,1), -- ID liên kết tự động tăng
    variantID INT,
    materialID INT,
    percentage DECIMAL(5, 2), -- Tỷ lệ phần trăm chất liệu, ví dụ: 80% Polyester
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    FOREIGN KEY (materialID) REFERENCES tbMaterial(materialID)
);
CREATE TABLE tbPaymentMethod (
    paymentMethodID INT PRIMARY KEY identity(1,1), -- ID phương thức thanh toán tự động tăng
    paymentMethodName NVARCHAR(50) NOT NULL, -- Tên phương thức thanh toán, ví dụ: Thanh toán khi nhận hàng, Chuyển khoản ngân hàng
    description NVARCHAR(200) -- Mô tả phương thức thanh toán
);
-- Bảng đơn hàng
CREATE TABLE tbOrder (
    orderID INT PRIMARY KEY identity(1,1), -- ID đơn hàng tự động tăng
    orderDate DATETIME NOT NULL, -- Ngày đặt hàng
    total DECIMAL(10, 2) NOT NULL, -- Tổng tiền
    userID INT,
    orderStatus INT NOT NULL, -- Trạng thái đơn hàng, ví dụ: 1 - Đang xử lý, 0 - Đã giao hàng, 2- Đang giao hàng, 3-Đã hủy
    shippingAddress NVARCHAR(200), -- Địa chỉ giao hàng
    paymentMethod INT, -- Phương thức thanh toán, ví dụ: Thanh toán khi nhận hàng, Chuyển khoản ngân hàng
    paymentStatus BIT, -- Trạng thái thanh toán, ví dụ: 1 - Đã thanh toán, 0 - Chưa thanh toán
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY (paymentMethod) REFERENCES tbPaymentMethod(paymentMethodID)
);


-- Bảng chi tiết đơn hàng
CREATE TABLE tbOrderDetail (
    detailID INT PRIMARY KEY identity(1,1), -- ID chi tiết đơn hàng tự động tăng
    price DECIMAL(10, 2) NOT NULL, -- Giá tại thời điểm mua
    quantity_product INT NOT NULL, -- Số lượng mua
    orderID INT,
    variantID INT, -- Liên kết với biến thể sản phẩm (màu, cỡ)
    FOREIGN KEY (orderID) REFERENCES tbOrder(orderID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);