# KẾ HOẠCH KIỂM THỬ - HỆ THỐNG POLYCOFFEE

**Dự án**: PolyCoffee - Hệ thống quản lý bán hàng (POS) quán cà phê  
**Phiên bản**: 1.0  
**Ngày lập**: 11/04/2026  
**Người thực hiện**: [Sinh viên]  
**Môn học**: JAV202 - Lập trình Java  
**Phạm vi**: Kiểm thử toàn diện (Controller / Service / Repository / Filter / Bảo mật)  

---

## 1. GIỚI THIỆU

### 1.1. Mục đích
Tài liệu này mô tả kế hoạch kiểm thử cho hệ thống PolyCoffee - ứng dụng POS (Point of Sale) dành cho chuỗi quán cà phê. Kế hoạch bao gồm 150 test case kiểm thử chức năng, phi chức năng và bảo mật trên toàn bộ các tầng của hệ thống.

### 1.2. Phạm vi kiểm thử
- Xác thực và phân quyền người dùng
- Quản lý nhân viên
- Quản lý danh mục sản phẩm
- Quản lý thức uống
- Quản lý bàn
- Quy trình bán hàng (POS)
- Đặt hàng tự phục vụ (Guest Self-Order)
- Hệ thống tích điểm và voucher
- Quản lý hóa đơn
- Thống kê và báo cáo
- Xử lý hình ảnh và file
- Bộ lọc và tiện ích
- Bảo mật hệ thống

### 1.3. Môi trường kiểm thử
- **Ngôn ngữ**: Java 21
- **Server**: Apache Tomcat 11 (Jakarta EE 10 / Servlet 6.1)
- **Cơ sở dữ liệu**: MySQL 8 (Docker)
- **Lưu trữ file**: MinIO (Docker)
- **ORM**: Hibernate 7
- **Build**: Apache Maven
- **Framework kiểm thử**: JUnit 5, Mockito

### 1.4. Phân loại mức độ ưu tiên
- **Nghiêm trọng (Critical)**: Lỗi gây ảnh hưởng đến chức năng chính, bảo mật, hoặc mất dữ liệu
- **Cao (High)**: Lỗi ảnh hưởng đến trải nghiệm người dùng hoặc logic nghiệp vụ quan trọng
- **Trung bình (Medium)**: Lỗi nhỏ, không ảnh hưởng đến luồng chính
- **Thấp (Low)**: Lỗi thẩm mỹ, hiển thị

---

## 2. CÁC TRƯỜNG HỢP KIỂM THỬ

---

### Module 1: Xác thực và Phân quyền (TC-001 đến TC-020)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-001 | Đăng nhập với tài khoản quản lý hợp lệ | Tồn tại user quản lý (email=admin@test.com, active=true) | 1. Truy cập trang đăng nhập 2. Nhập email và mật khẩu hợp lệ 3. Nhấn nút đăng nhập | Chuyển hướng đến /employee/pos?tab=stats, session chứa thông tin User | Nghiêm trọng |
| TC-002 | Đăng nhập với tài khoản nhân viên hợp lệ | Tồn tại user nhân viên (role=false, active=true) | 1. Truy cập trang đăng nhập 2. Nhập email và mật khẩu hợp lệ 3. Nhấn nút đăng nhập | Chuyển hướng đến /employee/pos, session chứa thông tin User | Nghiêm trọng |
| TC-003 | Đăng nhập với mật khẩu sai | Tồn tại user trong hệ thống | 1. Nhập email đúng, mật khẩu sai 2. Nhấn đăng nhập | Hiển thị thông báo lỗi "login.error" trên trang đăng nhập | Nghiêm trọng |
| TC-004 | Đăng nhập với email không tồn tại | Không có user với email đã nhập | 1. Nhập email không tồn tại 2. Nhấn đăng nhập | Hiển thị thông báo lỗi trên trang đăng nhập | Cao |
| TC-005 | Đăng nhập với tài khoản bị vô hiệu hóa | Tồn tại user nhưng active=false | 1. Nhập thông tin đăng nhập của tài khoản bị khóa 2. Nhấn đăng nhập | Đăng nhập thất bại, hiển thị lỗi | Nghiêm trọng |
| TC-006 | Đăng nhập với email trống | Không có | 1. Để trống trường email 2. Nhấn đăng nhập | Đăng nhập thất bại, hiển thị lỗi | Trung bình |
| TC-007 | Đăng nhập với mật khẩu trống | Không có | 1. Nhập email, để trống mật khẩu 2. Nhấn đăng nhập | Đăng nhập thất bại, hiển thị lỗi | Trung bình |
| TC-008 | Đăng xuất xóa session | Người dùng đã đăng nhập | 1. Nhấn nút đăng xuất | Session bị xóa, chuyển hướng về trang đăng nhập | Nghiêm trọng |
| TC-009 | Bộ lọc chặn truy cập /employee/* khi chưa xác thực | Chưa đăng nhập | 1. Truy cập /employee/pos khi chưa đăng nhập | Chuyển hướng đến /auth/login, lưu REDIRECT_URL vào session | Nghiêm trọng |
| TC-010 | Bộ lọc chặn truy cập /manager/* khi chưa xác thực | Chưa đăng nhập | 1. Truy cập /manager/bills khi chưa đăng nhập | Chuyển hướng đến /auth/login | Nghiêm trọng |
| TC-011 | Bộ lọc cho phép nhân viên truy cập /employee/* | Nhân viên đã đăng nhập | 1. Truy cập /employee/pos | Yêu cầu đi qua bộ lọc, trang hiển thị bình thường | Nghiêm trọng |
| TC-012 | Bộ lọc chặn nhân viên truy cập /manager/* | Nhân viên đăng nhập (role=false) | 1. Truy cập /manager/staff | Trả về lỗi 403 Forbidden | Nghiêm trọng |
| TC-013 | Bộ lọc cho phép quản lý truy cập /manager/* | Quản lý đã đăng nhập | 1. Truy cập /manager/staff | Yêu cầu đi qua bộ lọc, trang hiển thị bình thường | Nghiêm trọng |
| TC-014 | Bộ lọc lưu URL chuyển hướng kèm query string | Chưa đăng nhập | 1. Truy cập /employee/pos?billId=5 khi chưa đăng nhập | REDIRECT_URL = "/employee/pos?billId=5" được lưu trong session | Cao |
| TC-015 | Chuyển hướng sau đăng nhập đến URL đã lưu | Có REDIRECT_URL trong session | 1. Đăng nhập thành công | Chuyển hướng đến URL đã lưu, REDIRECT_URL bị xóa khỏi session | Cao |
| TC-016 | Trang hồ sơ yêu cầu xác thực | Chưa đăng nhập | 1. Truy cập /auth/profile khi chưa đăng nhập | Chuyển hướng đến trang đăng nhập | Trung bình |
| TC-017 | Trang hồ sơ hiển thị khi đã xác thực | Người dùng đã đăng nhập | 1. Truy cập /auth/profile | Hiển thị trang profile.jsp | Trung bình |
| TC-018 | Trang đăng nhập hiển thị thống kê tổng quan | Có hóa đơn trong CSDL | 1. Truy cập trang đăng nhập | Hiển thị tổng số hóa đơn và tổng doanh thu | Thấp |
| TC-019 | Tấn công SQL Injection qua trường email | Không có | 1. Nhập email = "' OR 1=1 --" 2. Nhấn đăng nhập | Đăng nhập thất bại, không bị injection | Nghiêm trọng |
| TC-020 | Tấn công SQL Injection qua trường mật khẩu | Không có | 1. Nhập mật khẩu = "' OR 1=1 --" 2. Nhấn đăng nhập | Đăng nhập thất bại, không bị injection | Nghiêm trọng |

---

### Module 2: Quản lý Nhân viên (TC-021 đến TC-032)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-021 | Hiển thị danh sách nhân viên | Có bản ghi nhân viên trong CSDL | 1. Truy cập trang quản lý nhân viên | Danh sách nhân viên (role=false) được hiển thị | Cao |
| TC-022 | Tạo nhân viên mới với dữ liệu hợp lệ | Quản lý đã đăng nhập | 1. Điền đầy đủ thông tin: họ tên, email, mật khẩu, SĐT 2. Nhấn lưu | Nhân viên mới được tạo với role=false, active=true | Nghiêm trọng |
| TC-023 | Tạo nhân viên với email đã tồn tại | Có user với email trùng | 1. Nhập email đã tồn tại 2. Nhấn lưu | Hiển thị lỗi "Email already exists!", không tạo mới | Nghiêm trọng |
| TC-024 | Tạo nhân viên với trường bắt buộc trống | Quản lý đã đăng nhập | 1. Để trống trường email 2. Nhấn lưu | Lỗi validation hoặc lỗi ràng buộc CSDL | Cao |
| TC-025 | Cập nhật tên và SĐT nhân viên | Nhân viên đã tồn tại | 1. Sửa tên và SĐT 2. Nhấn lưu | Thông tin được cập nhật, mật khẩu không đổi | Cao |
| TC-026 | Vô hiệu hóa tài khoản nhân viên | Nhân viên đang hoạt động | 1. Nhấn nút vô hiệu hóa (active=0) | Nhân viên chuyển sang active=false | Cao |
| TC-027 | Kích hoạt lại tài khoản nhân viên | Nhân viên bị vô hiệu hóa | 1. Nhấn nút kích hoạt (active=1) | Nhân viên chuyển sang active=true | Cao |
| TC-028 | Form nhân viên tại chỗ thêm mới (không có id) | Quản lý đã đăng nhập | 1. Truy cập /manager/staff/form | Hiển thị form trống, không có dữ liệu nhân viên | Trung bình |
| TC-029 | Form nhân viên tại chỗ chỉnh sửa (có id) | Nhân viên id=1 tồn tại | 1. Truy cập /manager/staff/form?id=1 | Hiển thị form với dữ liệu nhân viên đã điền sẵn | Trung bình |
| TC-030 | Nhân viên không thể truy cập quản lý nhân viên | Nhân viên đã đăng nhập | 1. Truy cập /manager/staff | Trả về lỗi 403 Forbidden | Nghiêm trọng |
| TC-031 | Cập nhật nhân viên giữ nguyên mật khẩu | Nhân viên tồn tại | 1. Cập nhật thông tin (không thay đổi mật khẩu) 2. Nhấn lưu | Mật khẩu giữ nguyên giá trị cũ | Cao |
| TC-032 | Tạo nhân viên - hệ thống ép role=false | Quản lý gửi role=true | 1. Tạo nhân viên với role=true | StaffService.createStaff tự động đặt role=false | Cao |

---

### Module 3: Quản lý Danh mục (TC-033 đến TC-042)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-033 | Hiển thị danh sách danh mục | Có danh mục trong CSDL | 1. Truy cập trang quản lý danh mục | Danh sách tất cả danh mục được hiển thị | Cao |
| TC-034 | Tạo danh mục với tên hợp lệ | Quản lý đã đăng nhập | 1. Nhập tên danh mục "Trà" 2. Nhấn lưu | Danh mục mới được tạo, active=true | Nghiêm trọng |
| TC-035 | Tạo danh mục với tên trống | Quản lý đã đăng nhập | 1. Để trống tên danh mục 2. Nhấn lưu | Lỗi ràng buộc CSDL hoặc tạo danh mục trống | Cao |
| TC-036 | Cập nhật tên danh mục | Danh mục id=1 tồn tại | 1. Sửa tên danh mục 2. Nhấn lưu | Tên danh mục được cập nhật | Cao |
| TC-037 | Xóa danh mục không có thức uống (xóa cứng) | Danh mục không chứa thức uống | 1. Nhấn xóa danh mục | Danh mục bị xóa hoàn toàn khỏi CSDL | Cao |
| TC-038 | Xóa danh mục có thức uống (xóa mềm) | Danh mục có thức uống liên kết | 1. Nhấn xóa danh mục | Danh mục chuyển active=false, vẫn còn trong CSDL | Nghiêm trọng |
| TC-039 | Lấy danh mục theo ID hợp lệ | Danh mục id=1 tồn tại | 1. Gọi getCategoryById(1) | Trả về đối tượng Category đúng | Trung bình |
| TC-040 | Lấy danh mục theo ID không tồn tại | Không có danh mục id=999 | 1. Gọi getCategoryById(999) | Trả về null | Trung bình |
| TC-041 | Tải chi tiết danh mục khi có tham số id | Danh mục id=1 tồn tại | 1. Truy cập /manager/categories?id=1 | Cả danh sách và chi tiết danh mục đều được hiển thị | Trung bình |
| TC-042 | Quản lý danh mục yêu cầu quyền quản lý | Nhân viên đăng nhập | 1. Truy cập /manager/categories | Trả về lỗi 403 Forbidden | Nghiêm trọng |

---

### Module 4: Quản lý Thức uống (TC-043 đến TC-054)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-043 | Hiển thị tất cả thức uống (cả ngừng hoạt động) | Có thức uống trong CSDL | 1. Truy cập trang quản lý thức uống | Tất cả thức uống được hiển thị | Cao |
| TC-044 | Chỉ lấy thức uống đang hoạt động | Có thức uống active và inactive | 1. Gọi getActiveDrinks() | Chỉ trả về thức uống có active=true | Nghiêm trọng |
| TC-045 | Tạo thức uống với dữ liệu hợp lệ | Quản lý đăng nhập, có danh mục | 1. Điền tên, giá, danh mục 2. Nhấn lưu | Thức uống mới được tạo, chuyển hướng về danh sách | Nghiêm trọng |
| TC-046 | Tạo thức uống với hình ảnh | Quản lý đăng nhập | 1. Điền thông tin và tải lên hình ảnh 2. Nhấn lưu | Thức uống được tạo, hình ảnh lưu vào MinIO | Cao |
| TC-047 | Cập nhật thức uống không thay đổi hình ảnh | Thức uống đã có hình ảnh | 1. Sửa thông tin, không chọn hình mới 2. Nhấn lưu | Thông tin cập nhật, hình ảnh cũ được giữ lại | Cao |
| TC-048 | Cập nhật thức uống với hình ảnh mới (xóa hình cũ) | Thức uống đã có hình ảnh cũ | 1. Chọn hình ảnh mới 2. Nhấn lưu | Hình cũ bị xóa khỏi MinIO, hình mới được lưu | Cao |
| TC-049 | Xóa thức uống (xóa mềm qua cờ active) | Thức uống tồn tại | 1. Nhấn xóa thức uống | Thức uống chuyển active=false hoặc bị xóa | Cao |
| TC-050 | Lấy thức uống theo ID hợp lệ | Thức uống id=1 tồn tại | 1. Gọi getDrinkById(1) | Trả về đối tượng Drink đúng | Trung bình |
| TC-051 | Lấy thức uống theo ID không tồn tại | Không có thức uống id=999 | 1. Gọi getDrinkById(999) | Trả về null | Trung bình |
| TC-052 | Tạo thức uống với giá = 0 | Quản lý đăng nhập | 1. Nhập giá = 0 2. Nhấn lưu | Thức uống được tạo với giá = 0 (miễn phí) | Trung bình |
| TC-053 | Tạo thức uống với giá âm | Quản lý đăng nhập | 1. Nhập giá = -100 2. Nhấn lưu | Hệ thống từ chối hoặc xử lý lỗi | Cao |
| TC-054 | Form thức uống tải danh mục cho dropdown | Có danh mục trong CSDL | 1. Truy cập form thêm thức uống | Dropdown danh mục được hiển thị | Trung bình |

---

### Module 5: Quản lý Bàn (TC-055 đến TC-062)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-055 | Hiển thị danh sách bàn | Có bàn trong CSDL | 1. Truy cập trang quản lý bàn | Danh sách tất cả bàn được hiển thị | Cao |
| TC-056 | Tạo bàn với tên và mã hợp lệ | Quản lý đăng nhập | 1. Nhập tên="Bàn 1", mã="t1" 2. Nhấn lưu | Bàn mới được tạo, mã được chuyển thành chữ hoa "T1" | Nghiêm trọng |
| TC-057 | Tạo bàn với mã trùng | Có bàn với cùng mã | 1. Nhập mã bàn đã tồn tại 2. Nhấn lưu | Lỗi ràng buộc unique của CSDL | Cao |
| TC-058 | Cập nhật tên và mã bàn | Bàn id=1 tồn tại | 1. Sửa tên và mã 2. Nhấn lưu | Bàn được cập nhật, mã chuyển thành chữ hoa | Cao |
| TC-059 | Xóa bàn | Bàn id=1 tồn tại, không có hóa đơn | 1. Nhấn xóa bàn | Bàn bị xóa khỏi CSDL | Cao |
| TC-060 | Mã bàn luôn được chuyển thành chữ hoa | Không có | 1. Tạo bàn với mã "abc" | Mã được lưu là "ABC" | Trung bình |
| TC-061 | Tìm bàn theo mã | Bàn với mã="T1" tồn tại | 1. Gọi getTableByCode("T1") | Trả về bàn đúng | Trung bình |
| TC-062 | Quản lý bàn yêu cầu quyền quản lý | Nhân viên đăng nhập | 1. Truy cập /manager/tables | Trả về lỗi 403 Forbidden | Nghiêm trọng |

---

### Module 6: POS - Quy trình Hóa đơn (TC-063 đến TC-087)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-063 | Thêm thức uống tạo hóa đơn mới khi billId=0 | Nhân viên đăng nhập, thức uống tồn tại | 1. Nhấn thêm thức uống khi chưa có hóa đơn | Hóa đơn mới được tạo với status=WAITING, 1 chi tiết, total=giá thức uống | Nghiêm trọng |
| TC-064 | Thêm thức uống vào hóa đơn đang chờ | Hóa đơn id=1, status=WAITING | 1. Chọn thức uống mới và thêm vào hóa đơn | Chi tiết mới được thêm, tổng tiền được tính lại | Nghiêm trọng |
| TC-065 | Thêm thức uống đã có tăng số lượng | Hóa đơn có drinkId=1 qty=1 | 1. Thêm lại thức uống đã có | Số lượng tăng lên 2, không tạo chi tiết trùng | Nghiêm trọng |
| TC-066 | Thêm thức uống vào hóa đơn không phải WAITING bị từ chối | Hóa đơn status=FINISHED | 1. Thử thêm thức uống vào hóa đơn đã hoàn thành | Trả về 0, không có thay đổi | Nghiêm trọng |
| TC-067 | Thêm thức uống với drinkId không hợp lệ | Không có thức uống id=999 | 1. Thêm thức uống với ID không tồn tại | NullPointerException hoặc xử lý lỗi | Cao |
| TC-068 | Thêm thức uống với billId=null | Nhân viên đăng nhập | 1. Thêm thức uống mà không truyền billId | Tạo hóa đơn mới (billId xử lý như 0) | Cao |
| TC-069 | Cập nhật số lượng lên 3 | Chi tiết hóa đơn có qty=1 | 1. Thay đổi số lượng thành 3 | Số lượng=3, tổng tiền được tính lại | Nghiêm trọng |
| TC-070 | Cập nhật số lượng về 0 xóa chi tiết | Chi tiết hóa đơn tồn tại | 1. Thay đổi số lượng thành 0 | Chi tiết bị xóa, tổng tiền được tính lại | Nghiêm trọng |
| TC-071 | Cập nhật số lượng trên hóa đơn không phải WAITING | Hóa đơn status=FINISHED | 1. Thử cập nhật số lượng | Không có thay đổi, hàm trả về sớm | Cao |
| TC-072 | Cập nhật số lượng cho thức uống không có trong hóa đơn | Thức uống không nằm trong hóa đơn | 1. Cập nhật số lượng cho drinkId không có | Không có thay đổi (chi tiết là null) | Trung bình |
| TC-073 | Cập nhật ghi chú trên chi tiết hóa đơn | Chi tiết hóa đơn tồn tại | 1. Nhập ghi chú "không đường" 2. Lưu | Ghi chú được cập nhật trên chi tiết | Cao |
| TC-074 | Cập nhật ghi chú trên hóa đơn không phải WAITING | Hóa đơn status=FINISHED | 1. Thử cập nhật ghi chú | Không có thay đổi | Trung bình |
| TC-075 | Thanh toán hóa đơn WAITING -> FINISHED | Hóa đơn status=WAITING | 1. Nhấn thanh toán | Trạng thái hóa đơn chuyển sang FINISHED | Nghiêm trọng |
| TC-076 | Thanh toán hóa đơn đã FINISHED | Hóa đơn status=FINISHED | 1. Nhấn thanh toán | Không có thay đổi (điều kiện chặn) | Cao |
| TC-077 | Thanh toán hóa đơn đã CANCELLED | Hóa đơn status=CANCELLED | 1. Nhấn thanh toán | Không có thay đổi | Trung bình |
| TC-078 | Hủy hóa đơn WAITING -> CANCELLED | Hóa đơn status=WAITING | 1. Nhấn hủy hóa đơn | Trạng thái chuyển sang CANCELLED | Nghiêm trọng |
| TC-079 | Hủy hóa đơn đã CANCELLED | Hóa đơn status=CANCELLED | 1. Nhấn hủy | Không có thay đổi | Trung bình |
| TC-080 | Tổng hóa đơn = tổng(giá x số lượng) của tất cả chi tiết | Hóa đơn có 3 chi tiết | 1. Thêm nhiều thức uống, cập nhật số lượng | bill.total = tổng của (detail.price * detail.quantity) | Nghiêm trọng |
| TC-081 | Định dạng mã hóa đơn "BILL-{timestamp}" | Không có | 1. Tạo hóa đơn mới qua POS | Mã hóa đơn khớp mẫu "BILL-\\d+" | Trung bình |
| TC-082 | Lấy hóa đơn theo ID | Hóa đơn tồn tại | 1. Gọi getBillById(1) | Trả về hóa đơn với dữ liệu đúng | Cao |
| TC-083 | Lấy hóa đơn theo ID không tồn tại | Không có hóa đơn id=999 | 1. Gọi getBillById(999) | Trả về null | Trung bình |
| TC-084 | Lấy hóa đơn theo ID và userId (quyền sở hữu) | Hóa đơn thuộc userId=1 | 1. Gọi getBill(1, 1) | Trả về hóa đơn | Cao |
| TC-085 | Lấy hóa đơn theo ID và userId sai | Hóa đơn thuộc userId=1 | 1. Gọi getBill(1, 2) | Trả về null (không phải chủ sở hữu) | Nghiêm trọng |
| TC-086 | Tìm kiếm hóa đơn theo mã | Hóa đơn có mã="BILL-123" | 1. Gọi searchBills("123", null) | Trả về hóa đơn khớp | Cao |
| TC-087 | Tìm kiếm hóa đơn theo trạng thái | Hóa đơn có nhiều trạng thái | 1. Gọi searchBills(null, "FINISHED") | Chỉ trả về hóa đơn có trạng thái FINISHED | Cao |

---

### Module 7: Khách Đặt hàng Tự phục vụ & Thanh toán (TC-088 đến TC-105)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-088 | Khách thanh toán với giỏ hàng hợp lệ | Thức uống tồn tại | 1. Gửi POST /guest/pos/checkout với JSON giỏ hàng | Hóa đơn được tạo, trả về {success:true, billId, billCode, total} | Nghiêm trọng |
| TC-089 | Khách thanh toán với danh sách món trống | Không có | 1. Gửi thanh toán với items=[] | Hóa đơn tạo với total=0 hoặc trả về lỗi | Cao |
| TC-090 | Khách thanh toán với ID thức uống không hợp lệ | Không có thức uống id=999 | 1. Gửi thanh toán với drinkId=999 | Thức uống bị bỏ qua (kiểm tra null), tổng tiền không tính món này | Cao |
| TC-091 | Khách thanh toán với bàn từ body request | Bàn id=1 tồn tại | 1. Gửi thanh toán với tableId=1 trong body | Bill.table được gán là CoffeeTable id=1 | Cao |
| TC-092 | Khách thanh toán với bàn từ session | tableId=1 trong session | 1. Gửi thanh toán không có tableId trong body | Bill.table được lấy từ session | Cao |
| TC-093 | Khách thanh toán với voucher giảm giá | Khách có voucher chưa sử dụng, discountAmount=10000 | 1. Gửi thanh toán với guestVoucherId | Bill.discountAmount=10000, tổng giảm, voucher đánh dấu đã dùng | Nghiêm trọng |
| TC-094 | Tổng thanh toán không thể âm | Giảm giá voucher > tổng món | 1. Gửi thanh toán | Bill.total = 0 (Math.max(0, ...)) | Nghiêm trọng |
| TC-095 | Tích điểm cho khách | Khách tồn tại, total=50000 | 1. Hoàn thành thanh toán | Khách nhận 50 điểm (50000/1000) | Nghiêm trọng |
| TC-096 | Khách thanh toán với voucher đã sử dụng | Voucher có isUsed=true | 1. Gửi thanh toán với voucher đã dùng | Voucher không được áp dụng (kiểm tra isUsed) | Nghiêm trọng |
| TC-097 | Khách thanh toán với voucher của người khác | Voucher thuộc khách B | 1. Khách A gửi thanh toán với voucherId của khách B | Voucher không được áp dụng (ID khách không khớp) | Nghiêm trọng |
| TC-098 | Định dạng mã hóa đơn khách "GUEST-{timestamp}" | Không có | 1. Khách thanh toán | Mã hóa đơn khớp mẫu "GUEST-\\d+" | Trung bình |
| TC-099 | Khách thanh toán với tên trống | Không có | 1. Gửi thanh toán không có guestName | Hóa đơn tạo với guestName là null | Trung bình |
| TC-100 | Lỗi server trả về JSON 500 | Dữ liệu không hợp lệ gây exception | 1. Gửi thanh toán với dữ liệu sai | Status 500, {success:false, message:"..."} | Cao |
| TC-101 | Chấp nhận hóa đơn khách WAITING -> FINISHED | Hóa đơn khách status=WAITING | 1. Nhấn chấp nhận hóa đơn | Trạng thái chuyển sang FINISHED, chuyển hướng về POS | Cao |
| TC-102 | Chấp nhận hóa đơn không phải WAITING | Hóa đơn status=FINISHED | 1. Nhấn chấp nhận | Không có thay đổi trạng thái | Trung bình |
| TC-103 | Trang POS khách hiển thị danh mục và thức uống | Có dữ liệu | 1. Truy cập /guest/pos | Danh mục và thức uống được hiển thị | Cao |
| TC-104 | Trang POS khách lưu tableId vào session | Không có | 1. Truy cập /guest/pos?tableId=5 | Session attribute tableId="5" | Trung bình |
| TC-105 | Thức uống lọc theo danh mục (JSON) | Thức uống thuộc nhiều danh mục | 1. Gọi /guest/pos/drinks?catId=1 | Trả về JSON chỉ chứa thức uống danh mục 1 | Cao |

---

### Module 8: Khách hàng & Hệ thống Tích điểm (TC-106 đến TC-117)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-106 | Tìm khách theo SĐT - tồn tại | Khách SĐT="0901234567" tồn tại | 1. Gọi findByPhoneNumber | Trả về đối tượng Guest đúng | Cao |
| TC-107 | Tìm khách theo SĐT - không tìm thấy | Không có khách với SĐT | 1. Gọi findByPhoneNumber("0000000000") | Trả về null | Cao |
| TC-108 | Tạo khách khi đặt hàng lần đầu (findOrCreate) | Không có khách với SĐT | 1. Gọi findOrCreateGuest("Tên", "0901234567") | Khách mới được tạo với point=0 | Nghiêm trọng |
| TC-109 | findOrCreate cập nhật tên nếu thay đổi | Khách tồn tại với tên khác | 1. Gọi findOrCreateGuest("Tên Mới", SĐT cũ) | Tên khách được cập nhật | Cao |
| TC-110 | findOrCreate trả về khách cũ nếu cùng tên | Khách tồn tại với cùng tên | 1. Gọi findOrCreateGuest(cùngTên, cùngSĐT) | Không cập nhật, trả về khách hiện tại | Trung bình |
| TC-111 | Cửa hàng điểm - hiển thị danh sách voucher | Voucher tồn tại | 1. Gọi GET /guest/pointshop/vouchers | Trả về JSON mảng {id, name, requiredPoints, discountAmount} | Cao |
| TC-112 | Cửa hàng điểm - lấy trạng thái khách theo SĐT | Khách có điểm và voucher | 1. Gọi GET /guest/pointshop/status?phone=0901234567 | Trả về JSON {success:true, points:N, vouchers:[...]} | Cao |
| TC-113 | Cửa hàng điểm - SĐT không tìm thấy | Không có khách | 1. Gọi GET /guest/pointshop/status?phone=0000000000 | Trả về JSON {success:false, message:"..."} | Cao |
| TC-114 | Đổi voucher với đủ điểm | Khách có 100 điểm, voucher cần 50 điểm | 1. Gửi POST /guest/pointshop/redeem {phone, voucherId, quantity:1} | Trừ 50 điểm, tạo GuestVoucher, trả về {success:true} | Nghiêm trọng |
| TC-115 | Đổi voucher với không đủ điểm | Khách có 10 điểm, voucher cần 50 điểm | 1. Gửi POST đổi voucher | Trả về {success:false, message:"Not enough points."} | Nghiêm trọng |
| TC-116 | Đổi voucher - khách không tồn tại | SĐT không hợp lệ | 1. Gửi POST đổi voucher | Trả về {success:false, message:"Guest not found..."} | Cao |
| TC-117 | Đổi voucher - số lượng <= 0 | Khách và voucher hợp lệ | 1. Gửi đổi voucher với quantity=0 | Trả về {success:false, message:"Quantity must be greater than zero."} | Cao |

---

### Module 9: Quản lý Hóa đơn (Admin) (TC-118 đến TC-124)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-118 | Quản lý xem tất cả hóa đơn | Quản lý đăng nhập, có hóa đơn | 1. Truy cập /manager/bills | Hiển thị tất cả hóa đơn bất kể người tạo | Cao |
| TC-119 | Nhân viên chỉ xem hóa đơn của mình | Nhân viên đăng nhập | 1. Truy cập /manager/bills | Chỉ hiển thị hóa đơn có user_id trùng khớp | Nghiêm trọng |
| TC-120 | Quản lý xem chi tiết hóa đơn | Hóa đơn id=1 tồn tại | 1. Truy cập /manager/bills?id=1 với quyền quản lý | Chi tiết hóa đơn được hiển thị đầy đủ | Cao |
| TC-121 | Nhân viên xem chi tiết hóa đơn của mình | Hóa đơn thuộc nhân viên | 1. Truy cập /manager/bills?id=1 (là chủ sở hữu) | Chi tiết hóa đơn được hiển thị | Cao |
| TC-122 | Nhân viên không xem được hóa đơn người khác | Hóa đơn thuộc người khác | 1. Truy cập /manager/bills?id=1 (không phải chủ sở hữu) | Không hiển thị hóa đơn (null) | Nghiêm trọng |
| TC-123 | Quản lý cập nhật trạng thái hóa đơn qua POST | Quản lý đăng nhập | 1. Gửi POST /manager/bills với billId=1, status=PAID | Trạng thái hóa đơn được cập nhật, chuyển hướng | Cao |
| TC-124 | Nhân viên không thể cập nhật trạng thái hóa đơn | Nhân viên đăng nhập | 1. Gửi POST /manager/bills | Trả về lỗi 403 Forbidden | Nghiêm trọng |

---

### Module 10: Thống kê & Bảng điều khiển (TC-125 đến TC-132)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-125 | Tính doanh thu hôm nay | Có hóa đơn FINISHED trong ngày | 1. Gọi getDashboardData() | todayRevenue = tổng doanh thu các hóa đơn hôm nay | Cao |
| TC-126 | Đếm số đơn hàng hôm nay | Có hóa đơn FINISHED hôm nay | 1. Gọi getDashboardData() | todayOrders = số hóa đơn hoàn thành hôm nay | Cao |
| TC-127 | Doanh thu tuần này | Có hóa đơn FINISHED trong tuần | 1. Gọi getDashboardData() | weekRevenue tính từ thứ Hai | Cao |
| TC-128 | Tổng số hóa đơn (toàn bộ thời gian) | Có hóa đơn trong CSDL | 1. Gọi getDashboardData() | totalBills = tổng tất cả hóa đơn FINISHED | Cao |
| TC-129 | Top 5 thức uống bán chạy nhất | Có chi tiết hóa đơn | 1. Gọi getTopSellingDrinks(null, null) | Trả về top 5 sắp xếp theo tổng số lượng | Cao |
| TC-130 | Báo cáo doanh thu theo ngày | Có hóa đơn nhiều ngày | 1. Gọi getRevenueReport(from, to) | Tổng doanh thu theo ngày trong khoảng thời gian | Cao |
| TC-131 | Thống kê với khoảng ngày null (toàn thời gian) | Có hóa đơn | 1. Truy cập /manager/statistics (không truyền from/to) | Trả về dữ liệu toàn thời gian | Trung bình |
| TC-132 | API thống kê yêu cầu quyền quản lý | Nhân viên đăng nhập | 1. Gọi GET /api/stats | Trả về lỗi 403 Forbidden | Nghiêm trọng |

---

### Module 11: Xử lý Hình ảnh & File (TC-133 đến TC-137)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-133 | ImageServlet phục vụ hình từ MinIO | Hình tồn tại trong MinIO | 1. Gọi GET /uploads/image.jpg | Hình ảnh được trả về với content type đúng | Cao |
| TC-134 | ImageServlet dự phòng từ tài nguyên local | Hình không có trong MinIO nhưng có trong webapp/uploads/ | 1. Gọi GET /uploads/legacy.jpg | Hình ảnh được phục vụ từ tài nguyên local | Cao |
| TC-135 | ImageServlet trả về 404 cho hình không tồn tại | Hình không tồn tại | 1. Gọi GET /uploads/nonexistent.jpg | Trả về 404 Not Found | Cao |
| TC-136 | ImageServlet với pathInfo null | Không có | 1. Gọi GET /uploads/ (không có tên file) | Trả về 404 Not Found | Trung bình |
| TC-137 | Upload file lên MinIO khi tạo thức uống | Quản lý tải lên hình ảnh | 1. Gửi POST multipart với hình ảnh | Hình ảnh được lưu vào MinIO, trả về tên file | Cao |

---

### Module 12: Bộ lọc & Tiện ích (TC-138 đến TC-144)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-138 | EncodingFilter đặt UTF-8 cho mỗi request | Không có | 1. Gửi bất kỳ HTTP request nào | Request và response encoding được đặt là UTF-8 | Trung bình |
| TC-139 | AuthUtil.setUser lưu user vào session | User hợp lệ | 1. Gọi setUser(req, user) rồi getUser(req) | Trả về cùng user đã lưu | Cao |
| TC-140 | AuthUtil.isAuthenticated trả về false khi không có session | Không có user trong session | 1. Gọi isAuthenticated(req) | Trả về false | Cao |
| TC-141 | AuthUtil.isManager trả về true cho role=true | User quản lý trong session | 1. Gọi isManager(req) | Trả về true | Cao |
| TC-142 | AuthUtil.isManager trả về false cho nhân viên | User nhân viên trong session | 1. Gọi isManager(req) | Trả về false | Cao |
| TC-143 | ParamUtil.getInt trả về 0 cho null/không phải số | Không có | 1. Gọi getInt(req, "missing") | Trả về 0 (giá trị mặc định) | Trung bình |
| TC-144 | ParamUtil.getString trả về chuỗi rỗng cho param null | Không có | 1. Gọi getString(req, "missing") | Trả về "" | Trung bình |

---

### Module 13: Kiểm thử Bảo mật (TC-145 đến TC-150)

| Mã | Mô tả | Điều kiện tiên quyết | Các bước thực hiện | Kết quả mong đợi | Mức độ |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-145 | Leo thang đặc quyền - nhân viên truy cập URL quản lý | Nhân viên đăng nhập | 1. Truy cập /manager/staff, /manager/categories, /manager/statistics | Tất cả trả về 403 Forbidden | Nghiêm trọng |
| TC-146 | IDOR - nhân viên truy cập hóa đơn người khác qua billId | Nhân viên A đăng nhập, hóa đơn thuộc nhân viên B | 1. Truy cập /manager/bills?id=<billId của B> với quyền A | Hóa đơn không được trả về (null) - quyền sở hữu được kiểm tra | Nghiêm trọng |
| TC-147 | XSS trong tên khách khi thanh toán | Không có | 1. Gửi thanh toán với guestName="<script>alert(1)</script>" | Thẻ script bị escape khi hiển thị | Nghiêm trọng |
| TC-148 | Duyệt thư mục (Path Traversal) trong ImageServlet | Không có | 1. Gọi GET /uploads/../../WEB-INF/web.xml | Trả về 404 hoặc bị chặn, KHÔNG phục vụ web.xml | Nghiêm trọng |
| TC-149 | Enum BillStatus không hợp lệ khi cập nhật trạng thái | Quản lý đăng nhập | 1. Gửi POST với status="INVALID_STATUS" | IllegalArgumentException được bắt, hệ thống không bị crash | Cao |
| TC-150 | Race condition khi sửa hóa đơn đồng thời | Hóa đơn id=1, status=WAITING | 1. Gửi 2 yêu cầu thanh toán đồng thời cho cùng hóa đơn | Chỉ 1 yêu cầu thành công, dữ liệu không bị hỏng | Cao |

---

## 3. TỔNG HỢP

| Module | Số lượng | Nghiêm trọng | Cao | Trung bình | Thấp |
|--------|---------|-------------|-----|------------|------|
| Xác thực và Phân quyền | 20 | 10 | 3 | 5 | 2 |
| Quản lý Nhân viên | 12 | 4 | 6 | 2 | 0 |
| Quản lý Danh mục | 10 | 3 | 4 | 3 | 0 |
| Quản lý Thức uống | 12 | 2 | 6 | 4 | 0 |
| Quản lý Bàn | 8 | 3 | 3 | 2 | 0 |
| POS - Quy trình Hóa đơn | 25 | 10 | 8 | 7 | 0 |
| Khách Đặt hàng Tự phục vụ | 18 | 6 | 8 | 4 | 0 |
| Khách hàng & Hệ thống Tích điểm | 12 | 3 | 7 | 2 | 0 |
| Quản lý Hóa đơn (Admin) | 7 | 3 | 3 | 1 | 0 |
| Thống kê & Bảng điều khiển | 8 | 1 | 5 | 2 | 0 |
| Xử lý Hình ảnh & File | 5 | 0 | 4 | 1 | 0 |
| Bộ lọc & Tiện ích | 7 | 0 | 3 | 4 | 0 |
| Bảo mật | 6 | 4 | 2 | 0 | 0 |
| **TỔNG CỘNG** | **150** | **49** | **62** | **37** | **2** |

---

## 4. KẾT LUẬN

Kế hoạch kiểm thử này bao gồm 150 trường hợp kiểm thử toàn diện cho hệ thống PolyCoffee, bao phủ tất cả các tầng từ controller, service, repository, filter đến bảo mật. Với 49 test case mức nghiêm trọng và 62 test case mức cao, kế hoạch này đảm bảo kiểm tra kỹ lưỡng các chức năng chính, logic nghiệp vụ và các lỗ hổng bảo mật tiềm ẩn của hệ thống.
