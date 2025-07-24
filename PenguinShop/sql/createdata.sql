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

CREATE TABLE tbRoles (
    roleID INT PRIMARY KEY IDENTITY(1,1),
    roleName NVARCHAR(50) NOT NULL,
    roleDescription NVARCHAR(max),
    createdAt DATETIME NOT NULL DEFAULT GETDATE(), -- ngày tạo role
);
CREATE TABLE tbModules (
    moduleID INT PRIMARY KEY IDENTITY(1,1),
    moduleName NVARCHAR(50) NOT NULL,
    icon NVARCHAR(100) -- Lưu tên icon (ví dụ: 'fa-home', 'mdi-user')
);

-- Bảng quyền hạn
CREATE TABLE tbPermissions (
    permissionID INT PRIMARY KEY IDENTITY(1,1),
    permissionName NVARCHAR(50) NOT NULL,
    url_permission NVARCHAR(100),
    moduleID INT,
    isHide INT,
    permissionDescription NVARCHAR(200),
    FOREIGN KEY(moduleID) REFERENCES dbo.tbModules(moduleID)
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
    fullName NVARCHAR(100),
    password NVARCHAR(256),
    roleID INT,
    birthday DATE,
    phone NVARCHAR(15),
    email NVARCHAR(100),
    image_user NVARCHAR(200),
    status_account INT,
    google_id NVARCHAR(255),
    created_at DATETIME, -- Bỏ CURRENT_TIMESTAMP
    updated_at DATETIME, -- Bỏ CURRENT_TIMESTAMP
    wallet DECIMAL(18,2) DEFAULT 0, -- Số dư ví
    FOREIGN KEY (roleID) REFERENCES tbRoles(roleID)
);

CREATE TABLE tbDeliveryInfo (
    deliveryInfoID INT PRIMARY KEY IDENTITY(1,1),
    userID INT NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    phone NVARCHAR(15) NOT NULL,
    email NVARCHAR(100),
    addressDetail NVARCHAR(255) NOT NULL,
    city NVARCHAR(100),
    country NVARCHAR(100),
    postalCode NVARCHAR(50),
    isDefault BIT NOT NULL DEFAULT 0, -- Đánh dấu thông tin giao hàng mặc định
    created_at DATETIME, -- Bỏ CURRENT_TIMESTAMP
    updated_at DATETIME, -- Bỏ CURRENT_TIMESTAMP
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
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
    full_description NVARCHAR(Max),
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
CREATE TABLE tbTag (
    tagID INT PRIMARY KEY IDENTITY(1,1),
    tagName NVARCHAR(50) NOT NULL UNIQUE, -- Ensure tags are unique
    tagDescription NVARCHAR(200)
);

-- Bảng liên kết sản phẩm và tag (junction table cho many-to-many)
CREATE TABLE tbProductTag (
    productTagID INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    tagID INT,
    FOREIGN KEY (productID) REFERENCES tbProduct(productID),
    FOREIGN KEY (tagID) REFERENCES tbTag(tagID),
    CONSTRAINT UK_ProductTag UNIQUE (productID, tagID) -- Prevent duplicate associations
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
    quantity INT,
    productID INT,
    FOREIGN KEY (userID) REFERENCES tbUsers(userID),
    FOREIGN KEY(productID) REFERENCES tbProduct(productID),
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
    emall_receiver NVARCHAR(255),
    phone_receiver NVARCHAR(255),
    name_receiver NVARCHAR(255),
    shipFee DECIMAL(10, 2),
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
    email_request NVARCHAR(255),
    phone_request NVARCHAR(255),
    name_request NVARCHAR(255),
    requestType NVARCHAR(50) NOT NULL,
    description NVARCHAR(500) NOT NULL,
    requestStatus INT NOT NULL DEFAULT 0,
    requestDate DATETIME NOT NULL DEFAULT GETDATE(),
    response NVARCHAR(500),
    responseDate DATETIME,
);

CREATE TABLE Banner (
    bannerID INT IDENTITY(1,1) PRIMARY KEY,
    bannerName NVARCHAR(255) NULL, -- Tên banner
    bannerHref NVARCHAR(255) NULL, -- Đường dẫn href
    bannerStatus BIT NOT NULL DEFAULT 1, -- 1: mở, 0: đóng
    createdAt DATETIME NOT NULL DEFAULT GETDATE(), -- Ngày tạo
    bannerLink NVARCHAR(255) -- Đường dẫn hình ảnh banner (nếu cần)
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
    
);

CREATE TABLE OTPCode(
    otpID INT PRIMARY KEY IDENTITY(1,1),
    userID INT NOT NULL,
    otpCode NVARCHAR(6) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT GETDATE(),
    isUsed BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (userID) REFERENCES tbUsers(userID)
);

-- Bảng blog
CREATE TABLE tbBlog (
    blogID INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    image NVARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    authorID INT,
    status INT NOT NULL DEFAULT 1, -- 1: Hiển thị, 0: Ẩn
    FOREIGN KEY (authorID) REFERENCES tbUsers(userID)
);

-- Bảng nhà cung cấp
CREATE TABLE tbSupplier (
    supplierID INT PRIMARY KEY IDENTITY(1,1),
    supplierName NVARCHAR(100) NOT NULL,
    contactName NVARCHAR(100),
    phone NVARCHAR(20),
    email NVARCHAR(100),
    address NVARCHAR(255),
    description NVARCHAR(255)
);

-- Bảng phiếu nhập hàng
CREATE TABLE tbImportOrder (
    importOrderID INT PRIMARY KEY IDENTITY(1,1),
    supplierID INT NOT NULL,
    importDate DATETIME NOT NULL,
    totalAmount DECIMAL(18,2) NOT NULL,
    note NVARCHAR(255),
    FOREIGN KEY (supplierID) REFERENCES tbSupplier(supplierID)
);

-- Bảng chi tiết phiếu nhập
CREATE TABLE tbImportOrderDetail (
    importOrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    importOrderID INT NOT NULL,
    variantID INT NOT NULL,
    quantity INT NOT NULL,
    importPrice DECIMAL(18,2) NOT NULL,
    expiryDate DATETIME,
    FOREIGN KEY (importOrderID) REFERENCES tbImportOrder(importOrderID),
    FOREIGN KEY (variantID) REFERENCES tbProductVariant(variantID)
);

-- Bảng thông tin về chúng tôi
CREATE TABLE tbAboutUs (
    aboutID INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255) NOT NULL,
    subtitle NVARCHAR(500),
    mainImage NVARCHAR(255),
    content NVARCHAR(MAX) NOT NULL,
    highlightPoints NVARCHAR(MAX), -- Lưu các điểm nổi bật dưới dạng JSON hoặc string phân cách bằng |
    videoUrl NVARCHAR(255), -- URL video quảng cáo
    isActive BIT NOT NULL DEFAULT 1,
    createdAt DATETIME NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME,
    updatedBy INT,
    FOREIGN KEY (updatedBy) REFERENCES tbUsers(userID)
);

-- Bảng dịch vụ của công ty
CREATE TABLE tbAboutServices (
    serviceID INT PRIMARY KEY IDENTITY(1,1),
    serviceName NVARCHAR(100) NOT NULL,
    serviceDescription NVARCHAR(500),
    serviceIcon NVARCHAR(255), -- Lưu SVG hoặc icon class
    displayOrder INT DEFAULT 1,
    isActive BIT NOT NULL DEFAULT 1
);

-- Bảng thống kê công ty
CREATE TABLE tbCompanyStats (
    statID INT PRIMARY KEY IDENTITY(1,1),
    statName NVARCHAR(100) NOT NULL, -- Ví dụ: "Customers Served", "Products Available"
    statValue NVARCHAR(50) NOT NULL, -- Ví dụ: "50,000+", "10,000+"
    statIcon NVARCHAR(255), -- Icon tương ứng
    displayOrder INT DEFAULT 1,
    isActive BIT NOT NULL DEFAULT 1
);

-- Thêm dữ liệu mẫu cho bảng tbAboutUs
INSERT INTO tbAboutUs (
    title, 
    subtitle, 
    mainImage, 
    content, 
    highlightPoints,
    videoUrl,
    isActive
) VALUES (
    N'Về chúng tôi',
    N'Điểm đến mua sắm trực tuyến đáng tin cậy của bạn',
    N'./assets/images/homepage-one/about/about-img-1.webp',
    N'PenguinShop không chỉ là một cửa hàng trực tuyến - chúng tôi là đối tác đáng tin cậy trong việc cung cấp sản phẩm chất lượng và trải nghiệm mua sắm tuyệt vời. Từ khi thành lập, chúng tôi cam kết mang đến cho khách hàng những sản phẩm tốt nhất với giá cả cạnh tranh, được hỗ trợ bởi dịch vụ khách hàng xuất sắc.',
    N'Khử trùng và vệ sinh hoàn toàn phòng tắm|Khi nhìn vào bố cục của nó. Đó là một thực tế được thiết lập từ lâu|Khử trùng và vệ sinh hoàn toàn phòng tắm',
    N'./assets/images/homepage-one/about/advertrisement-vedio.mp4',
    1
);

-- Thêm dữ liệu mẫu cho bảng tbAboutServices
INSERT INTO tbAboutServices (serviceName, serviceDescription, displayOrder, isActive) VALUES
(N'Chọn sản phẩm', N'Nếu bạn định sử dụng một đoạn văn, bạn cần chắc chắn rằng không có gì ngại ngùng ẩn giữa', 1, 1),
(N'Thanh toán', N'Trải nghiệm mua sắm trực tuyến không rắc rối với dịch vụ của chúng tôi! Chỉ cần chọn sản phẩm bạn muốn', 2, 1),
(N'Giao hàng nhanh', N'Trải nghiệm mua sắm trực tuyến không rắc rối với dịch vụ của chúng tôi! Tận hưởng giao hàng nhanh chóng ngay tại cửa nhà bạn.', 3, 1);

-- Thêm dữ liệu mẫu cho bảng tbCompanyStats
INSERT INTO tbCompanyStats (statName, statValue, displayOrder, isActive) VALUES
(N'Năm thành lập', N'2020', 1, 1),
(N'Khách hàng phục vụ', N'50,000+', 2, 1),
(N'Sản phẩm có sẵn', N'10,000+', 3, 1),
(N'Quốc gia giao hàng', N'15+', 4, 1);