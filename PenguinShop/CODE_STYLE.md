# Quy tắc code PenguinShop

## 1. Không code backend trong file JSP

### 1.1. Phong cách import và include JSP
- Luôn sử dụng `<jsp:include page="..."/>` để import các thành phần giao diện như Header, Sidebar, Footer, Js, Message, Css.
- Đặt các include ở đầu file (Header, Css) và cuối file (Footer, Js, Message) như các file mẫu.
- Sử dụng taglib JSTL `<%@ taglib ... %>` ở đầu file để hỗ trợ vòng lặp, điều kiện, format.
- Đặt các block giao diện theo layout chuẩn: header, sidebar, main-content, footer, ...
- Đặt các style nội bộ trong thẻ `<style>` ở phần `<head>`, ưu tiên import file css chung.
- Đặt các script nội bộ trong thẻ `<script>` ở cuối file, ưu tiên import file js chung.

### 1.2. Ví dụ import chuẩn (theo ListCart.jsp, AddGroupProduct.jsp)
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="Common/Css.jsp"/>
<jsp:include page="Common/Header.jsp"/>
<jsp:include page="Common/LeftSideBar.jsp"/>
...main content...
<jsp:include page="Common/Footer.jsp"/>
<jsp:include page="Common/Js.jsp"/>
<jsp:include page="Common/Message.jsp"/>
```

- Nếu chức năng phức tạp, chia nhỏ thành nhiều class/module.

## 3. Package riêng biệt cho từng module chức năng
- Ví dụ: Controller, DAL, Models, Utils, Filter, Const, APIKey...
- Không gộp nhiều chức năng vào chung 1 package.

## 4. Code giao diện chú ý các file sidebar, header, css, js
- Khi sửa giao diện, ưu tiên chỉnh sửa các file sidebar.jsp, header.jsp, các file .css, .js đã có.
- Không tạo mới file giao diện nếu chưa cần thiết, tận dụng code cũ.
- Đảm bảo giao diện đồng bộ, responsive, màu sắc và layout nhất quán.

## 5. Hạn chế dùng Stream, Collection
- Ưu tiên code Java truyền thống, dễ đọc, dễ bảo trì.
- Chỉ dùng Stream/Collection khi thực sự cần thiết và code ngắn gọn, rõ ràng.

## 6. Khai báo biến trạng thái bằng const
- Các biến trạng thái, hằng số phải khai báo trong package Const.
- Không hard-code giá trị trạng thái trong code, luôn dùng biến const.

---

## Ví dụ cấu trúc code chuẩn

```
src/
  java/
    Controller/
      ProductController.java
      QRAnalyzeServlet.java
    DAL/
      ProductDao.java
    Models/
      Product.java
      ProductVariant.java
    Const/
      StatusConst.java
    Utils/
      ImageUtils.java
    Filter/
      AuthFilter.java
    APIKey/
      GoogleAPIKey.java
```

## Ví dụ code giao diện chuẩn
```jsp
<!-- header.jsp -->
<%@ include file="/web/Common/header.jsp" %>
<link rel="stylesheet" href="/web/assets/css/main.css">
<script src="/web/assets/js/main.js"></script>
<nav class="navbar"> ... </nav>
```

## Ví dụ code backend chuẩn
```java
// QRAnalyzeServlet.java
@WebServlet(name = "QRAnalyzeServlet", urlPatterns = {"/qrAnalyze"})
public class QRAnalyzeServlet extends HttpServlet {
    // ...existing code...
}
```

## Lưu ý
- Luôn tuân thủ các quy tắc trên khi phát triển hoặc review code.
- Nếu có file CODE_STYLE.md, mọi thành viên phải đọc và làm theo.
