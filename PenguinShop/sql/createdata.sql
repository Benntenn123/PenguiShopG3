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
    + N' DROP CONSTRAINT ' 
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
EXEC sp_executesql @sql2 
GO

-- Bảng vai trò người dùng
CREATE TABLE tbRoles (
    roleID INT PRIMARY KEY IDENTITY(1,1),
    roleName NVARCHAR(50) NOT NULL
);

-- Bảng quyền hạn
CREATE TABLE tbPermissions (
    permissionID INT PRIMARY KEY IDENTITY(1,1),
    permissionName NVARCHAR(50) NOT NULL,
    permissionDescription NVARCHAR(200)
);

-- Bảng liên kết vai trò và quyền hạn
CREATE TABLE tbRolePermissions (
    rolePermissionID INT PRIMARY KEY IDENTITY(1,1),
    roleID INT,
    permissionID INT,
    FOREIGN KEY (roleID) REFERENCES tbRoles(roleID),
    FOREIGN KEY (permissionID) REFERENCES tbPermissions(permissionID)
);

-- Bảng thông tin người dùng
CREATE TABLE tbUsers (
    userID INT PRIMARY KEY IDENTITY(1,1),
    fullName NVARCHAR(100) NOT NULL,
    password NVARCHAR(100) NOT NULL,
    roleID INT,
    address NVARCHAR(200),
    birthday DATE,
    phone NVARCHAR(15),
    email NVARCHAR(100),
    image_user NVARCHAR(200),
    FOREIGN KEY (roleID) REFERENCES tbRoles(roleID)
);

-- Bảng nhật ký hệ thống
CREATE TABLE tbLogs (
    logID INT PRIMARY KEY IDENTITY(1,1),
    userID INT,
    action NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    logDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng thương hiệu
CREATE TABLE tbBrand (
    brandID INT PRIMARY KEY IDENTITY(1,1),
    brandName NVARCHAR(50) NOT NULL,
    logo NVARCHAR(200),
    description NVARCHAR(500)
);

-- Bảng danh mục sản phẩm
CREATE TABLE tbCategory (
    categoryID INT PRIMARY KEY IDENTITY(1,1),
    categoryName NVARCHAR(50) NOT NULL,
    sportType NVARCHAR(50),
    imageCategory NVARCHAR(255)
);

-- Bảng loại sản phẩm
CREATE TABLE tbProductType (
    productTypeID INT PRIMARY KEY IDENTITY(1,1),
    productTypeName NVARCHAR(50) NOT NULL
);

-- Bảng sản phẩm (đã xóa categoryID)
CREATE TABLE tbProduct (
    productID INT PRIMARY KEY IDENTITY(1,1),
    productName NVARCHAR(100) NOT NULL,
    SKU NVARCHAR(50) NOT NULL UNIQUE,
    productTypeID INT,
    brandID INT,
    importDate DATETIME,
    imageMainProduct NVARCHAR(200),
    description NVARCHAR(500),
    weight DECIMAL(5, 2),
    FOREIGN KEY (productTypeID) REFERENCES tbProductType(productTypeID),
    FOREIGN KEY (brandID) REFERENCES tbBrand(brandID)
);

-- Bảng liên kết sản phẩm và danh mục
CREATE TABLE tbProductCategory (
    productCategoryID INT PRIMARY KEY IDENTITY(1,1),
    productID INT NOT NULL,
    categoryID INT NOT NULL,
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (categoryID) REFERENCES tbCategory(categoryID),
    CONSTRAINT UK_ProductCategory UNIQUE (productID, categoryID)
);

-- Bảng chất liệu
CREATE TABLE tbMaterial (
    materialID INT PRIMARY KEY IDENTITY(1,1),
    materialName NVARCHAR(50) NOT NULL,
    materialDescription NVARCHAR(200)
);

-- Bảng màu sắc
CREATE TABLE tbColor (
    colorID INT PRIMARY KEY IDENTITY(1,1),
    colorName NVARCHAR(50) NOT NULL
);

-- Bảng kích cỡ
CREATE TABLE tbSize (
    sizeID INT PRIMARY KEY IDENTITY(1,1),
    sizeName NVARCHAR(10) NOT NULL
);

-- Bảng biến thể sản phẩm
CREATE TABLE tbProductVariant (
    variantID INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    colorID INT,
    sizeID INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stockStatus INT NOT NULL,
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (colorID) REFERENCES tbColor(colorID),
    FOREIGN KEY (sizeID) REFERENCES tbSize(sizeID)
);

-- Bảng đánh giá sản phẩm
CREATE TABLE tbFeedback (
    feedbackID INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    variantID INT,
    userID INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(500),
    feedbackDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng hình ảnh
CREATE TABLE tbImages (
    imageID INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    feedbackID INT,
    imageURL NVARCHAR(200) NOT NULL,
    imageCaption NVARCHAR(100),
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (feedbackID) REFERENCES tbFeedback(feedbackID),
    CONSTRAINT CHK_OneReference CHECK (
        (productID IS NOT NULL AND feedbackID IS NULL) OR 
        (productID IS NULL AND feedbackID IS NOT NULL)
    )
);

-- Bảng thẻ tag của sản phẩm
CREATE TABLE tbProductTag (
    tagID INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    tagName NVARCHAR(50) NOT NULL,
    tagDescription NVARCHAR(200),
    FOREIGN KEY (productID) REFERENCES tbProduct(productID)
);

-- Bảng liên kết biến thể sản phẩm với chất liệu
CREATE TABLE tbVariantMaterial (
    variantMaterialID INT PRIMARY KEY IDENTITY(1,1),
    variantID INT,
    materialID INT,
    percentage DECIMAL(5, 2),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    FOREIGN KEY (materialID) REFERENCES tbMaterial(materialID)
);

-- Bảng giỏ hàng
CREATE TABLE tbCart (
    cartID INT PRIMARY KEY IDENTITY(1,1),
    userID INT,
    variantID INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    addedDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);

-- Bảng phương thức thanh toán
CREATE TABLE tbPaymentMethod (
    paymentMethodID INT PRIMARY KEY IDENTITY(1,1),
    paymentMethodName NVARCHAR(50) NOT NULL,
    description NVARCHAR(200)
);

-- Bảng đơn hàng
CREATE TABLE tbOrder (
    orderID INT PRIMARY KEY IDENTITY(1,1),
    orderDate DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    userID INT,
    orderStatus INT NOT NULL,
    shippingAddress NVARCHAR(200),
    paymentMethod INT,
    paymentStatus BIT,
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY (paymentMethod) REFERENCES tbPaymentMethod(paymentMethodID)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE tbOrderDetail (
    detailID INT PRIMARY KEY IDENTITY(1,1),
    price DECIMAL(10, 2) NOT NULL,
    quantity_product INT NOT NULL,
    orderID INT,
    variantID INT,
    FOREIGN KEY (orderID) REFERENCES tbOrder(orderID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);

-- Bảng yêu cầu hỗ trợ
CREATE TABLE tbRequests (
    requestID INT PRIMARY KEY IDENTITY(1,1),
    userID INT,
    requestType NVARCHAR(50) NOT NULL,
    description NVARCHAR(500) NOT NULL,
    requestStatus INT NOT NULL DEFAULT 0,
    requestDate DATETIME NOT NULL DEFAULT GETDATE(),
    response NVARCHAR(500),
    responseDate DATETIME,
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng banner
CREATE TABLE Banner (
    bannerID INT IDENTITY(1,1) PRIMARY KEY,
    bannerLink NVARCHAR(255)
);

-- Bảng token người dùng
CREATE TABLE TokenUser (
    token_id INT IDENTITY(1,1) PRIMARY KEY,
    token NVARCHAR(255),
    userID INT,
    create_date_token DATETIME,
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng chương trình khuyến mãi
CREATE TABLE tbPromotion (
    promotionID INT PRIMARY KEY IDENTITY(1,1),
    promotionName NVARCHAR(100) NOT NULL,
    discountType NVARCHAR(20) NOT NULL CHECK (discountType IN ('PERCENTAGE', 'FIXED')),
    discountValue DECIMAL(10, 2) NOT NULL,
    startDate DATETIME NOT NULL,
    endDate DATETIME NOT NULL,
    description NVARCHAR(500),
    isActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT CHK_Dates CHECK (endDate > startDate)
);

-- Bảng liên kết sản phẩm và khuyến mãi
CREATE TABLE tbProductPromotion (
    productPromotionID INT PRIMARY KEY IDENTITY(1,1),
    promotionID INT NOT NULL,
    productID INT,
    variantID INT,
    FOREIGN KEY (promotionID) REFERENCES tbPromotion(promotionID),
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID),
    CONSTRAINT CHK_OneProductReference CHECK (
        (productID IS NOT NULL AND variantID IS NULL) OR 
        (productID IS NULL AND variantID IS NOT NULL)
    )
);