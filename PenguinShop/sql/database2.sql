USE PenguinShop
GO

INSERT INTO dbo.tbModules(moduleName,icon)VALUES
(N'Trang Chủ','home'),
(N'Người dùng','user'),
(N'Quyền truy cập','shield'),
(N'Sản Phẩm','box'),
(N'Khuyến Mãi','tag'),
(N'Hóa đơn','file'),
(N'Yêu cầu người dùng','send'),
(N'Lịch sử','clock'),
(N'Nhân sự', 'users'),
(N'Đánh giá', 'message-square'),
(N'Bài viết', 'message-square');

INSERT INTO dbo.tbPermissions
(permissionName,url_permission,moduleID,isHide,permissionDescription)VALUES
(N'Dashboard','/admin/dashboard', 1 , 0 , NULL),
(N'Chi tiết người dùng','/admin/customer_details', 2 , 1 , NULL),
(N'Danh sách người dùng','/admin/listCustomerAdmin', 2 , 0 , NULL),
(N'Ban tài khoản người dùng','/admin/banAccount', 2 , 0 , NULL),
(N'Danh sách quyền','/admin/listPermission',3,0,NULL),
(N'Danh sách nhóm quyền','/admin/listRoleAdmin',3,0,NULL),
(N'Quản lí quyền','/admin/manage_role_permissions',3,0,NULL),
(N'Thêm sản phẩm thuộc tính','/admin/addAttributeProduct',4,1,NULL),
(N'Thêm nhãn hàng','/admin/add-brand',4,1,NULL),
(N'Thêm danh mục','/admin/add-category',4,1,NULL),
(N'Thêm màu sắc','/admin/add-color',4,1,NULL),
(N'Thêm ảnh bộ sưu tập sản phẩm','/admin/addGalleryImage',4,1,NULL),
(N'Thêm nhóm sản phẩm','/admin/addGroupProduct',4,1,NULL),
(N'Chỉnh sửa nhóm sản phẩm','/admin/editGroupProduct',4,1,NULL),
(N'Thêm loại sản phẩm','/admin/add-product-type',4,1,NULL),
(N'Thêm kích cỡ sản phẩm','/admin/add-size',4,1,NULL),
(N'Xóa ảnh bộ sưu tập sản phẩm','/admin/deleteGalleryImage',4,1,NULL),
(N'Danh sách ảnh bộ sưu tập sản phẩm','/admin/galleryProduct',4,1,NULL),
(N'Danh sách nhóm sản phẩm','/admin/listGroupProduct',4,0,NULL),
(N'Danh sách sản phẩm thuộc tính','/admin/listProductAdmin',4,0,NULL),
(N'Quản lí chất liệu sản phẩm','/admin/managevariant',4,0,NULL),
(N'Chi tiết thuộc tính sản phẩm','/admin/variant_details',4,1,NULL),
(N'UPDATE thuộc tính sản phẩm','/admin/update_variant',4,1,NULL),
(N'Danh sách mã giảm giá','/admin/listPromotion',5,0,NULL),
(N'Thêm mã giảm giá','/admin/addPromotion',5,0,NULL),
(N'Chỉnh sửa mã giảm giá','/admin/promotion',5,1,NULL),
(N'Chỉnh sửa sản phẩm cho mã giảm giá','/admin/promotionVariant',5,1,NULL),
(N'Danh sách ORDER ','/admin/listOrderAdmin',6,0,NULL),
(N'Đổi thông tin order','/admin/changeInformationOrder',6,1,NULL),
(N'Thay đổi khoảng cách order','/admin/loadDistanceOrder',6,1,NULL),
(N'Chi tiết order','/admin/orderDetailsAdmin',6,1,NULL),
(N'Danh sách yêu cầu người dùng','/admin/listRequestSupport',7,0,NULL),
(N'Chi tiết request','/admin/requestDetails',7,1,NULL),
(N'Phản hồi yêu cầu người dùng','/admin/responseSupport',7,1,NULL),
(N'Chi tiết order','/admin/orderDetailsAdmin',7,1,NULL),
(N'Danh sách nhân sự','/admin/listSales',9,0,NULL),
(N'Thêm nhân sự','/admin/addSales',9,0,NULL),
(N'Chỉnh sửa thông tin sales','/admin/editSales',9,1,NULL),
(N'Thông tin tài khoản sales','/admin/profile',9,1,NULL),
(N'Danh sách đánh giá','/admin/feedbackList',10,0,NULL),
(N'Chi tiết đánh giá','/admin/feedbackDetail',10,1,NULL),
(N'Lịch sử hoạt động','/admin/list-logs',8,0,NULL),
(N'Đổi mật khẩu admin','/admin/changePasswordAdmin',3,1,NULL),
(N'Thay đổi thông tin hồ sơ','/admin/editProfileAdmin',3,1,NULL),
(N'Trang welcome','/admin/welcomeAdmin',1,0,NULL),
(N'Sales Dashboard','/admin/salesDashboard',1,0,NULL),
(N'Thêm bài viết','/admin/BlogAdd',11,0,NULL),
(N'Danh sách bài viết','/admin/BlogList',11,0,NULL);
-- Gán tất cả các quyền cho role admin (roleID = 1)
INSERT INTO tbRolePermissions (roleID, permissionID)
SELECT 1, permissionID
FROM tbPermissions;

