# KE HOACH KIEM THU - HE THONG POLYCOFFEE

**Du an**: PolyCoffee - He thong quan ly ban hang (POS) quan ca phe  
**Phien ban**: 1.0  
**Ngay lap**: 11/04/2026  
**Nguoi thuc hien**: [Sinh vien]  
**Mon hoc**: JAV202 - Lap trinh Java  
**Pham vi**: Kiem thu toan dien (Controller / Service / Repository / Filter / Bao mat)  

---

## 1. GIOI THIEU

### 1.1. Muc dich
Tai lieu nay mo ta ke hoach kiem thu cho he thong PolyCoffee - ung dung POS (Point of Sale) danh cho chuoi quan ca phe. Ke hoach bao gom 150 test case kiem thu chuc nang, phi chuc nang va bao mat tren toan bo cac tang cua he thong.

### 1.2. Pham vi kiem thu
- Xac thuc va phan quyen nguoi dung
- Quan ly nhan vien
- Quan ly danh muc san pham
- Quan ly do uong
- Quan ly ban
- Quy trinh ban hang (POS)
- Dat hang tu phuc vu (Guest Self-Order)
- He thong tich diem va voucher
- Quan ly hoa don
- Thong ke va bao cao
- Xu ly hinh anh va file
- Bo loc va tien ich
- Bao mat he thong

### 1.3. Moi truong kiem thu
- **Ngon ngu**: Java 21
- **Server**: Apache Tomcat 11 (Jakarta EE 10 / Servlet 6.1)
- **Co so du lieu**: MySQL 8 (Docker)
- **Luu tru file**: MinIO (Docker)
- **ORM**: Hibernate 7
- **Build**: Apache Maven
- **Framework kiem thu**: JUnit 5, Mockito

### 1.4. Phan loai muc do uu tien
- **Nghiem trong (Critical)**: Loi gay anh huong den chuc nang chinh, bao mat, hoac mat du lieu
- **Cao (High)**: Loi anh huong den trai nghiem nguoi dung hoac logic nghiep vu quan trong
- **Trung binh (Medium)**: Loi nho, khong anh huong den luong chinh
- **Thap (Low)**: Loi tham my, hien thi

---

## 2. CAC TRUONG HOP KIEM THU

---

### Module 1: Xac thuc va Phan quyen (TC-001 den TC-020)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-001 | Dang nhap voi tai khoan quan ly hop le | Ton tai user quan ly (email=admin@test.com, active=true) | 1. Truy cap trang dang nhap 2. Nhap email va mat khau hop le 3. Nhan nut dang nhap | Chuyen huong den /employee/pos?tab=stats, session chua thong tin User | Nghiem trong |
| TC-002 | Dang nhap voi tai khoan nhan vien hop le | Ton tai user nhan vien (role=false, active=true) | 1. Truy cap trang dang nhap 2. Nhap email va mat khau hop le 3. Nhan nut dang nhap | Chuyen huong den /employee/pos, session chua thong tin User | Nghiem trong |
| TC-003 | Dang nhap voi mat khau sai | Ton tai user trong he thong | 1. Nhap email dung, mat khau sai 2. Nhan dang nhap | Hien thi thong bao loi "login.error" tren trang dang nhap | Nghiem trong |
| TC-004 | Dang nhap voi email khong ton tai | Khong co user voi email da nhap | 1. Nhap email khong ton tai 2. Nhan dang nhap | Hien thi thong bao loi tren trang dang nhap | Cao |
| TC-005 | Dang nhap voi tai khoan bi vo hieu hoa | Ton tai user nhung active=false | 1. Nhap thong tin dang nhap cua tai khoan bi khoa 2. Nhan dang nhap | Dang nhap that bai, hien thi loi | Nghiem trong |
| TC-006 | Dang nhap voi email trong | Khong co | 1. De trong truong email 2. Nhan dang nhap | Dang nhap that bai, hien thi loi | Trung binh |
| TC-007 | Dang nhap voi mat khau trong | Khong co | 1. Nhap email, de trong mat khau 2. Nhan dang nhap | Dang nhap that bai, hien thi loi | Trung binh |
| TC-008 | Dang xuat xoa session | Nguoi dung da dang nhap | 1. Nhan nut dang xuat | Session bi xoa, chuyen huong ve trang dang nhap | Nghiem trong |
| TC-009 | Bo loc chan truy cap /employee/* khi chua xac thuc | Chua dang nhap | 1. Truy cap /employee/pos khi chua dang nhap | Chuyen huong den /auth/login, luu REDIRECT_URL vao session | Nghiem trong |
| TC-010 | Bo loc chan truy cap /manager/* khi chua xac thuc | Chua dang nhap | 1. Truy cap /manager/bills khi chua dang nhap | Chuyen huong den /auth/login | Nghiem trong |
| TC-011 | Bo loc cho phep nhan vien truy cap /employee/* | Nhan vien da dang nhap | 1. Truy cap /employee/pos | Yeu cau di qua bo loc, trang hien thi binh thuong | Nghiem trong |
| TC-012 | Bo loc chan nhan vien truy cap /manager/* | Nhan vien dang nhap (role=false) | 1. Truy cap /manager/staff | Tra ve loi 403 Forbidden | Nghiem trong |
| TC-013 | Bo loc cho phep quan ly truy cap /manager/* | Quan ly da dang nhap | 1. Truy cap /manager/staff | Yeu cau di qua bo loc, trang hien thi binh thuong | Nghiem trong |
| TC-014 | Bo loc luu URL chuyen huong kem query string | Chua dang nhap | 1. Truy cap /employee/pos?billId=5 khi chua dang nhap | REDIRECT_URL = "/employee/pos?billId=5" duoc luu trong session | Cao |
| TC-015 | Chuyen huong sau dang nhap den URL da luu | Co REDIRECT_URL trong session | 1. Dang nhap thanh cong | Chuyen huong den URL da luu, REDIRECT_URL bi xoa khoi session | Cao |
| TC-016 | Trang ho so yeu cau xac thuc | Chua dang nhap | 1. Truy cap /auth/profile khi chua dang nhap | Chuyen huong den trang dang nhap | Trung binh |
| TC-017 | Trang ho so hien thi khi da xac thuc | Nguoi dung da dang nhap | 1. Truy cap /auth/profile | Hien thi trang profile.jsp | Trung binh |
| TC-018 | Trang dang nhap hien thi thong ke tong quan | Co hoa don trong CSDL | 1. Truy cap trang dang nhap | Hien thi tong so hoa don va tong doanh thu | Thap |
| TC-019 | Tan cong SQL Injection qua truong email | Khong co | 1. Nhap email = "' OR 1=1 --" 2. Nhan dang nhap | Dang nhap that bai, khong bi injection | Nghiem trong |
| TC-020 | Tan cong SQL Injection qua truong mat khau | Khong co | 1. Nhap mat khau = "' OR 1=1 --" 2. Nhan dang nhap | Dang nhap that bai, khong bi injection | Nghiem trong |

---

### Module 2: Quan ly Nhan vien (TC-021 den TC-032)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-021 | Hien thi danh sach nhan vien | Co ban ghi nhan vien trong CSDL | 1. Truy cap trang quan ly nhan vien | Danh sach nhan vien (role=false) duoc hien thi | Cao |
| TC-022 | Tao nhan vien moi voi du lieu hop le | Quan ly da dang nhap | 1. Dien day du thong tin: ho ten, email, mat khau, SDT 2. Nhan luu | Nhan vien moi duoc tao voi role=false, active=true | Nghiem trong |
| TC-023 | Tao nhan vien voi email da ton tai | Co user voi email trung | 1. Nhap email da ton tai 2. Nhan luu | Hien thi loi "Email already exists!", khong tao moi | Nghiem trong |
| TC-024 | Tao nhan vien voi truong bat buoc trong | Quan ly da dang nhap | 1. De trong truong email 2. Nhan luu | Loi validation hoac loi rang buoc CSDL | Cao |
| TC-025 | Cap nhat ten va SDT nhan vien | Nhan vien da ton tai | 1. Sua ten va SDT 2. Nhan luu | Thong tin duoc cap nhat, mat khau khong doi | Cao |
| TC-026 | Vo hieu hoa tai khoan nhan vien | Nhan vien dang hoat dong | 1. Nhan nut vo hieu hoa (active=0) | Nhan vien chuyen sang active=false | Cao |
| TC-027 | Kich hoat lai tai khoan nhan vien | Nhan vien bi vo hieu hoa | 1. Nhan nut kich hoat (active=1) | Nhan vien chuyen sang active=true | Cao |
| TC-028 | Form nhan vien tai cho them moi (khong co id) | Quan ly da dang nhap | 1. Truy cap /manager/staff/form | Hien thi form trong, khong co du lieu nhan vien | Trung binh |
| TC-029 | Form nhan vien tai cho chinh sua (co id) | Nhan vien id=1 ton tai | 1. Truy cap /manager/staff/form?id=1 | Hien thi form voi du lieu nhan vien da dien san | Trung binh |
| TC-030 | Nhan vien khong the truy cap quan ly nhan vien | Nhan vien da dang nhap | 1. Truy cap /manager/staff | Tra ve loi 403 Forbidden | Nghiem trong |
| TC-031 | Cap nhat nhan vien giu nguyen mat khau | Nhan vien ton tai | 1. Cap nhat thong tin (khong thay doi mat khau) 2. Nhan luu | Mat khau giu nguyen gia tri cu | Cao |
| TC-032 | Tao nhan vien - he thong ep role=false | Quan ly gui role=true | 1. Tao nhan vien voi role=true | StaffService.createStaff tu dong dat role=false | Cao |

---

### Module 3: Quan ly Danh muc (TC-033 den TC-042)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-033 | Hien thi danh sach danh muc | Co danh muc trong CSDL | 1. Truy cap trang quan ly danh muc | Danh sach tat ca danh muc duoc hien thi | Cao |
| TC-034 | Tao danh muc voi ten hop le | Quan ly da dang nhap | 1. Nhap ten danh muc "Tra" 2. Nhan luu | Danh muc moi duoc tao, active=true | Nghiem trong |
| TC-035 | Tao danh muc voi ten trong | Quan ly da dang nhap | 1. De trong ten danh muc 2. Nhan luu | Loi rang buoc CSDL hoac tao danh muc trong | Cao |
| TC-036 | Cap nhat ten danh muc | Danh muc id=1 ton tai | 1. Sua ten danh muc 2. Nhan luu | Ten danh muc duoc cap nhat | Cao |
| TC-037 | Xoa danh muc khong co do uong (xoa cung) | Danh muc khong chua do uong | 1. Nhan xoa danh muc | Danh muc bi xoa hoan toan khoi CSDL | Cao |
| TC-038 | Xoa danh muc co do uong (xoa mem) | Danh muc co do uong lien ket | 1. Nhan xoa danh muc | Danh muc chuyen active=false, van con trong CSDL | Nghiem trong |
| TC-039 | Lay danh muc theo ID hop le | Danh muc id=1 ton tai | 1. Goi getCategoryById(1) | Tra ve doi tuong Category dung | Trung binh |
| TC-040 | Lay danh muc theo ID khong ton tai | Khong co danh muc id=999 | 1. Goi getCategoryById(999) | Tra ve null | Trung binh |
| TC-041 | Tai chi tiet danh muc khi co tham so id | Danh muc id=1 ton tai | 1. Truy cap /manager/categories?id=1 | Ca danh sach va chi tiet danh muc deu duoc hien thi | Trung binh |
| TC-042 | Quan ly danh muc yeu cau quyen quan ly | Nhan vien dang nhap | 1. Truy cap /manager/categories | Tra ve loi 403 Forbidden | Nghiem trong |

---

### Module 4: Quan ly Do uong (TC-043 den TC-054)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-043 | Hien thi tat ca do uong (ca ngung hoat dong) | Co do uong trong CSDL | 1. Truy cap trang quan ly do uong | Tat ca do uong duoc hien thi | Cao |
| TC-044 | Chi lay do uong dang hoat dong | Co do uong active va inactive | 1. Goi getActiveDrinks() | Chi tra ve do uong co active=true | Nghiem trong |
| TC-045 | Tao do uong voi du lieu hop le | Quan ly dang nhap, co danh muc | 1. Dien ten, gia, danh muc 2. Nhan luu | Do uong moi duoc tao, chuyen huong ve danh sach | Nghiem trong |
| TC-046 | Tao do uong voi hinh anh | Quan ly dang nhap | 1. Dien thong tin va tai len hinh anh 2. Nhan luu | Do uong duoc tao, hinh anh luu vao MinIO | Cao |
| TC-047 | Cap nhat do uong khong thay doi hinh anh | Do uong da co hinh anh | 1. Sua thong tin, khong chon hinh moi 2. Nhan luu | Thong tin cap nhat, hinh anh cu duoc giu lai | Cao |
| TC-048 | Cap nhat do uong voi hinh anh moi (xoa hinh cu) | Do uong da co hinh anh cu | 1. Chon hinh anh moi 2. Nhan luu | Hinh cu bi xoa khoi MinIO, hinh moi duoc luu | Cao |
| TC-049 | Xoa do uong (xoa mem qua co active) | Do uong ton tai | 1. Nhan xoa do uong | Do uong chuyen active=false hoac bi xoa | Cao |
| TC-050 | Lay do uong theo ID hop le | Do uong id=1 ton tai | 1. Goi getDrinkById(1) | Tra ve doi tuong Drink dung | Trung binh |
| TC-051 | Lay do uong theo ID khong ton tai | Khong co do uong id=999 | 1. Goi getDrinkById(999) | Tra ve null | Trung binh |
| TC-052 | Tao do uong voi gia = 0 | Quan ly dang nhap | 1. Nhap gia = 0 2. Nhan luu | Do uong duoc tao voi gia = 0 (mien phi) | Trung binh |
| TC-053 | Tao do uong voi gia am | Quan ly dang nhap | 1. Nhap gia = -100 2. Nhan luu | He thong tu choi hoac xu ly loi | Cao |
| TC-054 | Form do uong tai danh muc cho dropdown | Co danh muc trong CSDL | 1. Truy cap form them do uong | Dropdown danh muc duoc hien thi | Trung binh |

---

### Module 5: Quan ly Ban (TC-055 den TC-062)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-055 | Hien thi danh sach ban | Co ban trong CSDL | 1. Truy cap trang quan ly ban | Danh sach tat ca ban duoc hien thi | Cao |
| TC-056 | Tao ban voi ten va ma hop le | Quan ly dang nhap | 1. Nhap ten="Ban 1", ma="t1" 2. Nhan luu | Ban moi duoc tao, ma duoc chuyen thanh chu hoa "T1" | Nghiem trong |
| TC-057 | Tao ban voi ma trung | Co ban voi cung ma | 1. Nhap ma ban da ton tai 2. Nhan luu | Loi rang buoc unique cua CSDL | Cao |
| TC-058 | Cap nhat ten va ma ban | Ban id=1 ton tai | 1. Sua ten va ma 2. Nhan luu | Ban duoc cap nhat, ma chuyen thanh chu hoa | Cao |
| TC-059 | Xoa ban | Ban id=1 ton tai, khong co hoa don | 1. Nhan xoa ban | Ban bi xoa khoi CSDL | Cao |
| TC-060 | Ma ban luon duoc chuyen thanh chu hoa | Khong co | 1. Tao ban voi ma "abc" | Ma duoc luu la "ABC" | Trung binh |
| TC-061 | Tim ban theo ma | Ban voi ma="T1" ton tai | 1. Goi getTableByCode("T1") | Tra ve ban dung | Trung binh |
| TC-062 | Quan ly ban yeu cau quyen quan ly | Nhan vien dang nhap | 1. Truy cap /manager/tables | Tra ve loi 403 Forbidden | Nghiem trong |

---

### Module 6: POS - Quy trinh Hoa don (TC-063 den TC-087)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-063 | Them do uong tao hoa don moi khi billId=0 | Nhan vien dang nhap, do uong ton tai | 1. Nhan them do uong khi chua co hoa don | Hoa don moi duoc tao voi status=WAITING, 1 chi tiet, total=gia do uong | Nghiem trong |
| TC-064 | Them do uong vao hoa don dang cho | Hoa don id=1, status=WAITING | 1. Chon do uong moi va them vao hoa don | Chi tiet moi duoc them, tong tien duoc tinh lai | Nghiem trong |
| TC-065 | Them do uong da co tang so luong | Hoa don co drinkId=1 qty=1 | 1. Them lai do uong da co | So luong tang len 2, khong tao chi tiet trung | Nghiem trong |
| TC-066 | Them do uong vao hoa don khong phai WAITING bi tu choi | Hoa don status=FINISHED | 1. Thu them do uong vao hoa don da hoan thanh | Tra ve 0, khong co thay doi | Nghiem trong |
| TC-067 | Them do uong voi drinkId khong hop le | Khong co do uong id=999 | 1. Them do uong voi ID khong ton tai | NullPointerException hoac xu ly loi | Cao |
| TC-068 | Them do uong voi billId=null | Nhan vien dang nhap | 1. Them do uong ma khong truyen billId | Tao hoa don moi (billId xu ly nhu 0) | Cao |
| TC-069 | Cap nhat so luong len 3 | Chi tiet hoa don co qty=1 | 1. Thay doi so luong thanh 3 | So luong=3, tong tien duoc tinh lai | Nghiem trong |
| TC-070 | Cap nhat so luong ve 0 xoa chi tiet | Chi tiet hoa don ton tai | 1. Thay doi so luong thanh 0 | Chi tiet bi xoa, tong tien duoc tinh lai | Nghiem trong |
| TC-071 | Cap nhat so luong tren hoa don khong phai WAITING | Hoa don status=FINISHED | 1. Thu cap nhat so luong | Khong co thay doi, ham tra ve som | Cao |
| TC-072 | Cap nhat so luong cho do uong khong co trong hoa don | Do uong khong nam trong hoa don | 1. Cap nhat so luong cho drinkId khong co | Khong co thay doi (chi tiet la null) | Trung binh |
| TC-073 | Cap nhat ghi chu tren chi tiet hoa don | Chi tiet hoa don ton tai | 1. Nhap ghi chu "khong duong" 2. Luu | Ghi chu duoc cap nhat tren chi tiet | Cao |
| TC-074 | Cap nhat ghi chu tren hoa don khong phai WAITING | Hoa don status=FINISHED | 1. Thu cap nhat ghi chu | Khong co thay doi | Trung binh |
| TC-075 | Thanh toan hoa don WAITING -> FINISHED | Hoa don status=WAITING | 1. Nhan thanh toan | Trang thai hoa don chuyen sang FINISHED | Nghiem trong |
| TC-076 | Thanh toan hoa don da FINISHED | Hoa don status=FINISHED | 1. Nhan thanh toan | Khong co thay doi (dieu kien chan) | Cao |
| TC-077 | Thanh toan hoa don da CANCELLED | Hoa don status=CANCELLED | 1. Nhan thanh toan | Khong co thay doi | Trung binh |
| TC-078 | Huy hoa don WAITING -> CANCELLED | Hoa don status=WAITING | 1. Nhan huy hoa don | Trang thai chuyen sang CANCELLED | Nghiem trong |
| TC-079 | Huy hoa don da CANCELLED | Hoa don status=CANCELLED | 1. Nhan huy | Khong co thay doi | Trung binh |
| TC-080 | Tong hoa don = tong(gia x so luong) cua tat ca chi tiet | Hoa don co 3 chi tiet | 1. Them nhieu do uong, cap nhat so luong | bill.total = tong cua (detail.price * detail.quantity) | Nghiem trong |
| TC-081 | Dinh dang ma hoa don "BILL-{timestamp}" | Khong co | 1. Tao hoa don moi qua POS | Ma hoa don khop mau "BILL-\\d+" | Trung binh |
| TC-082 | Lay hoa don theo ID | Hoa don ton tai | 1. Goi getBillById(1) | Tra ve hoa don voi du lieu dung | Cao |
| TC-083 | Lay hoa don theo ID khong ton tai | Khong co hoa don id=999 | 1. Goi getBillById(999) | Tra ve null | Trung binh |
| TC-084 | Lay hoa don theo ID va userId (quyen so huu) | Hoa don thuoc userId=1 | 1. Goi getBill(1, 1) | Tra ve hoa don | Cao |
| TC-085 | Lay hoa don theo ID va userId sai | Hoa don thuoc userId=1 | 1. Goi getBill(1, 2) | Tra ve null (khong phai chu so huu) | Nghiem trong |
| TC-086 | Tim kiem hoa don theo ma | Hoa don co ma="BILL-123" | 1. Goi searchBills("123", null) | Tra ve hoa don khop | Cao |
| TC-087 | Tim kiem hoa don theo trang thai | Hoa don co nhieu trang thai | 1. Goi searchBills(null, "FINISHED") | Chi tra ve hoa don co trang thai FINISHED | Cao |

---

### Module 7: Khach Dat hang Tu phuc vu & Thanh toan (TC-088 den TC-105)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-088 | Khach thanh toan voi gio hang hop le | Do uong ton tai | 1. Gui POST /guest/pos/checkout voi JSON gio hang | Hoa don duoc tao, tra ve {success:true, billId, billCode, total} | Nghiem trong |
| TC-089 | Khach thanh toan voi danh sach mon trong | Khong co | 1. Gui thanh toan voi items=[] | Hoa don tao voi total=0 hoac tra ve loi | Cao |
| TC-090 | Khach thanh toan voi ID do uong khong hop le | Khong co do uong id=999 | 1. Gui thanh toan voi drinkId=999 | Do uong bi bo qua (kiem tra null), tong tien khong tinh mon nay | Cao |
| TC-091 | Khach thanh toan voi ban tu body request | Ban id=1 ton tai | 1. Gui thanh toan voi tableId=1 trong body | Bill.table duoc gan la CoffeeTable id=1 | Cao |
| TC-092 | Khach thanh toan voi ban tu session | tableId=1 trong session | 1. Gui thanh toan khong co tableId trong body | Bill.table duoc lay tu session | Cao |
| TC-093 | Khach thanh toan voi voucher giam gia | Khach co voucher chua su dung, discountAmount=10000 | 1. Gui thanh toan voi guestVoucherId | Bill.discountAmount=10000, tong giam, voucher danh dau da dung | Nghiem trong |
| TC-094 | Tong thanh toan khong the am | Giam gia voucher > tong mon | 1. Gui thanh toan | Bill.total = 0 (Math.max(0, ...)) | Nghiem trong |
| TC-095 | Tich diem cho khach | Khach ton tai, total=50000 | 1. Hoan thanh thanh toan | Khach nhan 50 diem (50000/1000) | Nghiem trong |
| TC-096 | Khach thanh toan voi voucher da su dung | Voucher co isUsed=true | 1. Gui thanh toan voi voucher da dung | Voucher khong duoc ap dung (kiem tra isUsed) | Nghiem trong |
| TC-097 | Khach thanh toan voi voucher cua nguoi khac | Voucher thuoc khach B | 1. Khach A gui thanh toan voi voucherId cua khach B | Voucher khong duoc ap dung (ID khach khong khop) | Nghiem trong |
| TC-098 | Dinh dang ma hoa don khach "GUEST-{timestamp}" | Khong co | 1. Khach thanh toan | Ma hoa don khop mau "GUEST-\\d+" | Trung binh |
| TC-099 | Khach thanh toan voi ten trong | Khong co | 1. Gui thanh toan khong co guestName | Hoa don tao voi guestName la null | Trung binh |
| TC-100 | Loi server tra ve JSON 500 | Du lieu khong hop le gay exception | 1. Gui thanh toan voi du lieu sai | Status 500, {success:false, message:"..."} | Cao |
| TC-101 | Chap nhan hoa don khach WAITING -> FINISHED | Hoa don khach status=WAITING | 1. Nhan chap nhan hoa don | Trang thai chuyen sang FINISHED, chuyen huong ve POS | Cao |
| TC-102 | Chap nhan hoa don khong phai WAITING | Hoa don status=FINISHED | 1. Nhan chap nhan | Khong co thay doi trang thai | Trung binh |
| TC-103 | Trang POS khach hien thi danh muc va do uong | Co du lieu | 1. Truy cap /guest/pos | Danh muc va do uong duoc hien thi | Cao |
| TC-104 | Trang POS khach luu tableId vao session | Khong co | 1. Truy cap /guest/pos?tableId=5 | Session attribute tableId="5" | Trung binh |
| TC-105 | Do uong loc theo danh muc (JSON) | Do uong thuoc nhieu danh muc | 1. Goi /guest/pos/drinks?catId=1 | Tra ve JSON chi chua do uong danh muc 1 | Cao |

---

### Module 8: Khach hang & He thong Tich diem (TC-106 den TC-117)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-106 | Tim khach theo SDT - ton tai | Khach SDT="0901234567" ton tai | 1. Goi findByPhoneNumber | Tra ve doi tuong Guest dung | Cao |
| TC-107 | Tim khach theo SDT - khong tim thay | Khong co khach voi SDT | 1. Goi findByPhoneNumber("0000000000") | Tra ve null | Cao |
| TC-108 | Tao khach khi dat hang lan dau (findOrCreate) | Khong co khach voi SDT | 1. Goi findOrCreateGuest("Ten", "0901234567") | Khach moi duoc tao voi point=0 | Nghiem trong |
| TC-109 | findOrCreate cap nhat ten neu thay doi | Khach ton tai voi ten khac | 1. Goi findOrCreateGuest("Ten Moi", SDT cu) | Ten khach duoc cap nhat | Cao |
| TC-110 | findOrCreate tra ve khach cu neu cung ten | Khach ton tai voi cung ten | 1. Goi findOrCreateGuest(cungTen, cungSDT) | Khong cap nhat, tra ve khach hien tai | Trung binh |
| TC-111 | Cua hang diem - hien thi danh sach voucher | Voucher ton tai | 1. Goi GET /guest/pointshop/vouchers | Tra ve JSON mang {id, name, requiredPoints, discountAmount} | Cao |
| TC-112 | Cua hang diem - lay trang thai khach theo SDT | Khach co diem va voucher | 1. Goi GET /guest/pointshop/status?phone=0901234567 | Tra ve JSON {success:true, points:N, vouchers:[...]} | Cao |
| TC-113 | Cua hang diem - SDT khong tim thay | Khong co khach | 1. Goi GET /guest/pointshop/status?phone=0000000000 | Tra ve JSON {success:false, message:"..."} | Cao |
| TC-114 | Doi voucher voi du diem | Khach co 100 diem, voucher can 50 diem | 1. Gui POST /guest/pointshop/redeem {phone, voucherId, quantity:1} | Tru 50 diem, tao GuestVoucher, tra ve {success:true} | Nghiem trong |
| TC-115 | Doi voucher voi khong du diem | Khach co 10 diem, voucher can 50 diem | 1. Gui POST doi voucher | Tra ve {success:false, message:"Not enough points."} | Nghiem trong |
| TC-116 | Doi voucher - khach khong ton tai | SDT khong hop le | 1. Gui POST doi voucher | Tra ve {success:false, message:"Guest not found..."} | Cao |
| TC-117 | Doi voucher - so luong <= 0 | Khach va voucher hop le | 1. Gui doi voucher voi quantity=0 | Tra ve {success:false, message:"Quantity must be greater than zero."} | Cao |

---

### Module 9: Quan ly Hoa don (Admin) (TC-118 den TC-124)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-118 | Quan ly xem tat ca hoa don | Quan ly dang nhap, co hoa don | 1. Truy cap /manager/bills | Hien thi tat ca hoa don bat ke nguoi tao | Cao |
| TC-119 | Nhan vien chi xem hoa don cua minh | Nhan vien dang nhap | 1. Truy cap /manager/bills | Chi hien thi hoa don co user_id trung khop | Nghiem trong |
| TC-120 | Quan ly xem chi tiet hoa don | Hoa don id=1 ton tai | 1. Truy cap /manager/bills?id=1 voi quyen quan ly | Chi tiet hoa don duoc hien thi day du | Cao |
| TC-121 | Nhan vien xem chi tiet hoa don cua minh | Hoa don thuoc nhan vien | 1. Truy cap /manager/bills?id=1 (la chu so huu) | Chi tiet hoa don duoc hien thi | Cao |
| TC-122 | Nhan vien khong xem duoc hoa don nguoi khac | Hoa don thuoc nguoi khac | 1. Truy cap /manager/bills?id=1 (khong phai chu so huu) | Khong hien thi hoa don (null) | Nghiem trong |
| TC-123 | Quan ly cap nhat trang thai hoa don qua POST | Quan ly dang nhap | 1. Gui POST /manager/bills voi billId=1, status=PAID | Trang thai hoa don duoc cap nhat, chuyen huong | Cao |
| TC-124 | Nhan vien khong the cap nhat trang thai hoa don | Nhan vien dang nhap | 1. Gui POST /manager/bills | Tra ve loi 403 Forbidden | Nghiem trong |

---

### Module 10: Thong ke & Bang dieu khien (TC-125 den TC-132)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-125 | Tinh doanh thu hom nay | Co hoa don FINISHED trong ngay | 1. Goi getDashboardData() | todayRevenue = tong doanh thu cac hoa don hom nay | Cao |
| TC-126 | Dem so don hang hom nay | Co hoa don FINISHED hom nay | 1. Goi getDashboardData() | todayOrders = so hoa don hoan thanh hom nay | Cao |
| TC-127 | Doanh thu tuan nay | Co hoa don FINISHED trong tuan | 1. Goi getDashboardData() | weekRevenue tinh tu thu Hai | Cao |
| TC-128 | Tong so hoa don (toan bo thoi gian) | Co hoa don trong CSDL | 1. Goi getDashboardData() | totalBills = tong tat ca hoa don FINISHED | Cao |
| TC-129 | Top 5 do uong ban chay nhat | Co chi tiet hoa don | 1. Goi getTopSellingDrinks(null, null) | Tra ve top 5 sap xep theo tong so luong | Cao |
| TC-130 | Bao cao doanh thu theo ngay | Co hoa don nhieu ngay | 1. Goi getRevenueReport(from, to) | Tong doanh thu theo ngay trong khoang thoi gian | Cao |
| TC-131 | Thong ke voi khoang ngay null (toan thoi gian) | Co hoa don | 1. Truy cap /manager/statistics (khong truyen from/to) | Tra ve du lieu toan thoi gian | Trung binh |
| TC-132 | API thong ke yeu cau quyen quan ly | Nhan vien dang nhap | 1. Goi GET /api/stats | Tra ve loi 403 Forbidden | Nghiem trong |

---

### Module 11: Xu ly Hinh anh & File (TC-133 den TC-137)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-133 | ImageServlet phuc vu hinh tu MinIO | Hinh ton tai trong MinIO | 1. Goi GET /uploads/image.jpg | Hinh anh duoc tra ve voi content type dung | Cao |
| TC-134 | ImageServlet du phong tu tai nguyen local | Hinh khong co trong MinIO nhung co trong webapp/uploads/ | 1. Goi GET /uploads/legacy.jpg | Hinh anh duoc phuc vu tu tai nguyen local | Cao |
| TC-135 | ImageServlet tra ve 404 cho hinh khong ton tai | Hinh khong ton tai | 1. Goi GET /uploads/nonexistent.jpg | Tra ve 404 Not Found | Cao |
| TC-136 | ImageServlet voi pathInfo null | Khong co | 1. Goi GET /uploads/ (khong co ten file) | Tra ve 404 Not Found | Trung binh |
| TC-137 | Upload file len MinIO khi tao do uong | Quan ly tai len hinh anh | 1. Gui POST multipart voi hinh anh | Hinh anh duoc luu vao MinIO, tra ve ten file | Cao |

---

### Module 12: Bo loc & Tien ich (TC-138 den TC-144)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-138 | EncodingFilter dat UTF-8 cho moi request | Khong co | 1. Gui bat ky HTTP request nao | Request va response encoding duoc dat la UTF-8 | Trung binh |
| TC-139 | AuthUtil.setUser luu user vao session | User hop le | 1. Goi setUser(req, user) roi getUser(req) | Tra ve cung user da luu | Cao |
| TC-140 | AuthUtil.isAuthenticated tra ve false khi khong co session | Khong co user trong session | 1. Goi isAuthenticated(req) | Tra ve false | Cao |
| TC-141 | AuthUtil.isManager tra ve true cho role=true | User quan ly trong session | 1. Goi isManager(req) | Tra ve true | Cao |
| TC-142 | AuthUtil.isManager tra ve false cho nhan vien | User nhan vien trong session | 1. Goi isManager(req) | Tra ve false | Cao |
| TC-143 | ParamUtil.getInt tra ve 0 cho null/khong phai so | Khong co | 1. Goi getInt(req, "missing") | Tra ve 0 (gia tri mac dinh) | Trung binh |
| TC-144 | ParamUtil.getString tra ve chuoi rong cho param null | Khong co | 1. Goi getString(req, "missing") | Tra ve "" | Trung binh |

---

### Module 13: Kiem thu Bao mat (TC-145 den TC-150)

| Ma | Mo ta | Dieu kien tien quyet | Cac buoc thuc hien | Ket qua mong doi | Muc do |
|----|-------|---------------------|---------------------|------------------|--------|
| TC-145 | Leo thang dac quyen - nhan vien truy cap URL quan ly | Nhan vien dang nhap | 1. Truy cap /manager/staff, /manager/categories, /manager/statistics | Tat ca tra ve 403 Forbidden | Nghiem trong |
| TC-146 | IDOR - nhan vien truy cap hoa don nguoi khac qua billId | Nhan vien A dang nhap, hoa don thuoc nhan vien B | 1. Truy cap /manager/bills?id=<billId cua B> voi quyen A | Hoa don khong duoc tra ve (null) - quyen so huu duoc kiem tra | Nghiem trong |
| TC-147 | XSS trong ten khach khi thanh toan | Khong co | 1. Gui thanh toan voi guestName="<script>alert(1)</script>" | The script bi escape khi hien thi | Nghiem trong |
| TC-148 | Duyet thu muc (Path Traversal) trong ImageServlet | Khong co | 1. Goi GET /uploads/../../WEB-INF/web.xml | Tra ve 404 hoac bi chan, KHONG phuc vu web.xml | Nghiem trong |
| TC-149 | Enum BillStatus khong hop le khi cap nhat trang thai | Quan ly dang nhap | 1. Gui POST voi status="INVALID_STATUS" | IllegalArgumentException duoc bat, he thong khong bi crash | Cao |
| TC-150 | Race condition khi sua hoa don dong thoi | Hoa don id=1, status=WAITING | 1. Gui 2 yeu cau thanh toan dong thoi cho cung hoa don | Chi 1 yeu cau thanh cong, du lieu khong bi hong | Cao |

---

## 3. TONG HOP

| Module | So luong | Nghiem trong | Cao | Trung binh | Thap |
|--------|---------|-------------|-----|------------|------|
| Xac thuc va Phan quyen | 20 | 10 | 3 | 5 | 2 |
| Quan ly Nhan vien | 12 | 4 | 6 | 2 | 0 |
| Quan ly Danh muc | 10 | 3 | 4 | 3 | 0 |
| Quan ly Do uong | 12 | 2 | 6 | 4 | 0 |
| Quan ly Ban | 8 | 3 | 3 | 2 | 0 |
| POS - Quy trinh Hoa don | 25 | 10 | 8 | 7 | 0 |
| Khach Dat hang Tu phuc vu | 18 | 6 | 8 | 4 | 0 |
| Khach hang & He thong Tich diem | 12 | 3 | 7 | 2 | 0 |
| Quan ly Hoa don (Admin) | 7 | 3 | 3 | 1 | 0 |
| Thong ke & Bang dieu khien | 8 | 1 | 5 | 2 | 0 |
| Xu ly Hinh anh & File | 5 | 0 | 4 | 1 | 0 |
| Bo loc & Tien ich | 7 | 0 | 3 | 4 | 0 |
| Bao mat | 6 | 4 | 2 | 0 | 0 |
| **TONG CONG** | **150** | **49** | **62** | **37** | **2** |

---

## 4. KET LUAN

Ke hoach kiem thu nay bao gom 150 truong hop kiem thu toan dien cho he thong PolyCoffee, bao phu tat ca cac tang tu controller, service, repository, filter den bao mat. Voi 49 test case muc nghiem trong va 62 test case muc cao, ke hoach nay dam bao kiem tra ky luong cac chuc nang chinh, logic nghiep vu va cac lo hong bao mat tiem an cua he thong.
