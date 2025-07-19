# Hệ thống quản lý Nhà cung cấp và Đơn nhập hàng

## Mô tả
Hệ thống này bao gồm các chức năng cơ bản để quản lý nhà cung cấp và đơn nhập hàng với hỗ trợ tìm kiếm, sắp xếp và phân trang.

## Cấu trúc Database

### 1. Bảng tbSupplier (Nhà cung cấp)
```sql
- supplierID (INT, PK, IDENTITY)
- supplierName (NVARCHAR(100), NOT NULL)
- contactName (NVARCHAR(100))
- phone (NVARCHAR(20))
- email (NVARCHAR(100))
- address (NVARCHAR(255))
- note (NVARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)
```

### 2. Bảng tbImportOrder (Đơn nhập hàng)
```sql
- importOrderID (INT, PK, IDENTITY)
- supplierID (INT, FK)
- importDate (DATETIME)
- totalImportAmount (DECIMAL(18,2))
- note (NVARCHAR(255))
- created_by (INT, FK)
- created_at (DATETIME)
- updated_at (DATETIME)
```

### 3. Bảng tbImportOrderDetail (Chi tiết đơn nhập hàng)
```sql
- importOrderDetailID (INT, PK, IDENTITY)
- importOrderID (INT, FK)
- variantID (INT, FK) - Liên kết với tbProductVariant
- quantity (INT, NOT NULL)
- importPrice (DECIMAL(18,2), NOT NULL)
- note (NVARCHAR(255))
```

## Các lớp chính

### 1. Models
- **Supplier.java**: Model cho nhà cung cấp
- **ImportOrder.java**: Model cho đơn nhập hàng
- **ImportOrderDetail.java**: Model cho chi tiết đơn nhập hàng
- **VariantDTO.java**: DTO đơn giản cho product variant

### 2. DAL (Data Access Layer)
- **SupplierDAO.java**: Xử lý database cho nhà cung cấp
- **ImportOrderDAO.java**: Xử lý database cho đơn nhập hàng
- **ProductVariantDAO.java**: Xử lý database cho product variant

### 3. Controllers/Services
- **SupplierService.java**: Business logic cho nhà cung cấp
- **ImportOrderService.java**: Business logic cho đơn nhập hàng

## Các chức năng chính

### Quản lý Nhà cung cấp
1. **Danh sách nhà cung cấp** với phân trang, tìm kiếm, sắp xếp
2. **Thêm nhà cung cấp mới**
3. **Chỉnh sửa thông tin nhà cung cấp**
4. **Xóa nhà cung cấp**
5. **Xem chi tiết nhà cung cấp**

### Quản lý Đơn nhập hàng
1. **Danh sách đơn nhập hàng** với phân trang, tìm kiếm, sắp xếp
2. **Tạo đơn nhập hàng mới** (theo variantID)
3. **Xem chi tiết đơn nhập hàng**
4. **Xóa đơn nhập hàng**
5. **Danh sách đơn nhập gần đây**

### Chức năng hỗ trợ
1. **Tìm kiếm sản phẩm variant** để thêm vào đơn nhập
2. **Tự động cập nhật số lượng kho** khi nhập hàng
3. **Thống kê** số lượng nhà cung cấp, đơn nhập, tổng tiền

## Cách sử dụng

### 1. Khởi tạo Service
```java
SupplierService supplierService = new SupplierService();
ImportOrderService importService = new ImportOrderService();
```

### 2. Lấy danh sách nhà cung cấp có phân trang
```java
List<Supplier> suppliers = supplierService.getAllSuppliers(
    page,      // Trang hiện tại (1, 2, 3...)
    pageSize,  // Số item mỗi trang
    search,    // Từ khóa tìm kiếm (có thể null)
    sortBy,    // Trường sắp xếp (supplierName, contactName, etc.)
    sortDir    // Hướng sắp xếp (ASC/DESC)
);
```

### 3. Tạo đơn nhập hàng mới
```java
ImportOrderService.ImportOrderRequest request = 
    new ImportOrderService.ImportOrderRequest(supplierID, "Ghi chú", userID);

// Thêm chi tiết
request.addDetail(variantID, quantity, importPrice, "Ghi chú chi tiết");
request.addDetail(variantID2, quantity2, importPrice2, "Ghi chú chi tiết 2");

boolean success = importService.createImportOrder(request);
```

### 4. Tìm kiếm sản phẩm variant
```java
List<VariantDTO> variants = importService.searchVariants("từ khóa");
```

## Các tính năng đã hỗ trợ

✅ **Phân trang**: Hỗ trợ phân trang cho tất cả danh sách  
✅ **Tìm kiếm**: Tìm kiếm theo nhiều trường  
✅ **Sắp xếp**: Sắp xếp theo các trường khác nhau  
✅ **Validation**: Kiểm tra dữ liệu đầu vào  
✅ **Transaction**: Xử lý transaction khi tạo/xóa đơn nhập  
✅ **Auto update**: Tự động cập nhật số lượng kho khi nhập hàng  
✅ **Statistics**: Thống kê cơ bản  

## Ghi chú quan trọng

1. **Sử dụng variantID**: Chi tiết đơn nhập sử dụng variantID thay vì productID để quản lý chính xác từng biến thể (màu, size) của sản phẩm.

2. **Auto increment quantity**: Khi tạo đơn nhập, hệ thống sẽ tự động tăng số lượng trong bảng tbProductVariant.

3. **Error handling**: Tất cả các method đều có xử lý exception và trả về boolean để báo thành công/thất bại.

4. **SQL Server compatible**: Tất cả câu SQL đều tương thích với SQL Server (sử dụng TOP, IDENTITY, etc.)

## Mở rộng

Có thể dễ dàng mở rộng thêm các chức năng:
- Báo cáo chi tiết
- Export Excel
- Quản lý trạng thái đơn nhập
- Workflow phê duyệt
- Tích hợp email/SMS thông báo
