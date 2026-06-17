# PolyCoffee

Hệ thống Quản lý Bán hàng (POS) bằng Java dành cho chuỗi cà phê. Hỗ trợ gọi món tại bàn, quy trình thu ngân, quản trị hệ thống, kiosk tự đặt hàng, chương trình khách hàng thân thiết/voucher và báo cáo thống kê.

## Công nghệ sử dụng

| Tầng | Công nghệ |
|------|-----------|
| Ngôn ngữ | Java 21 |
| Runtime | Apache Tomcat 11 (Jakarta EE 10 / Servlet 6.1) |
| Web | Jakarta Servlet + JSP + JSTL 3.0 |
| ORM | Hibernate 7 (JPA provider) |
| Cơ sở dữ liệu | MySQL 8 (Docker) |
| Lưu trữ ảnh | MinIO (Docker) |
| Build | Apache Maven (đóng gói WAR) |
| JSON | Gson |
| Kiểm thử | JUnit 5, Mockito |
| Frontend | Vanilla JS + CSS (JSP-rendered views) |

## Yêu cầu hệ thống

- Java 21+
- Apache Maven
- Docker & Docker Compose
- Apache Tomcat 11

## Hướng dẫn chạy

```bash
# 1. Khởi động hạ tầng (MySQL + MinIO)
docker-compose up -d

# 2. Build file WAR
./mvnw clean package

# 3. Deploy lên Tomcat 11
cp target/Assignment-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/
```

## Cấu trúc dự án

```
src/
├── main/
│   ├── java/chez1s/assignment/
│   │   ├── controller/     # Jakarta Servlet controllers (MVC front controllers)
│   │   ├── service/        # Tầng xử lý nghiệp vụ
│   │   ├── repository/     # Truy cập dữ liệu qua Hibernate ORM
│   │   ├── entity/         # Các lớp JPA entity
│   │   ├── dto/            # Data Transfer Objects
│   │   ├── filter/         # Servlet filters (xác thực, CORS, v.v.)
│   │   └── util/           # Tiện ích (MinIO, Gson helpers, v.v.)
│   ├── webapp/
│   │   ├── views/          # JSP templates phân nhóm theo tính năng
│   │   ├── static/         # Tài nguyên tĩnh (CSS, JS)
│   │   └── WEB-INF/
│   │       └── web.xml     # Cấu hình Servlet mappings
│   └── resources/
│       └── messages.properties  # Chuỗi i18n (Tiếng Việt + Tiếng Anh)
├── docker-compose.yml      # Dịch vụ MySQL 8 + MinIO
└── init.sql                # Script khởi tạo/seed cơ sở dữ liệu
```

## Quy ước chính

- **Xác thực**: Xác thực dựa trên session với các vai trò — `admin`, `cashier`, `guest`
- **API**: Các endpoint REST nằm trong servlet `*ApiController`; phản hồi JSON sử dụng Gson
- **Ảnh**: Lưu trữ trên MinIO; truy cập qua `ImageServlet`
- **i18n**: Chuỗi tiếng Việt và tiếng Anh trong `messages.properties`
- **Lombok**: Dùng xuyên suốt dự án — bật annotation processing trong IDE
