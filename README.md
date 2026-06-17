# PolyCoffee

A Java-based Point of Sale (POS) system for a coffee shop chain. Supports table-side ordering, cashier workflows, admin management, self-order kiosks, a guest loyalty/voucher system, and statistical reporting.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 21 |
| Runtime | Apache Tomcat 11 (Jakarta EE 10 / Servlet 6.1) |
| Web | Jakarta Servlet + JSP + JSTL 3.0 |
| ORM | Hibernate 7 (JPA provider) |
| Database | MySQL 8 (Docker) |
| Object Storage | MinIO (Docker) |
| Build | Apache Maven (WAR packaging) |
| JSON | Gson |
| Testing | JUnit 5, Mockito |
| Frontend | Vanilla JS + CSS (JSP-rendered views) |

## Prerequisites

- Java 21+
- Apache Maven
- Docker & Docker Compose
- Apache Tomcat 11

## Getting Started

```bash
# 1. Start infrastructure (MySQL + MinIO)
docker-compose up -d

# 2. Build the WAR
./mvnw clean package

# 3. Deploy to Tomcat 11
cp target/Assignment-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/
```

## Project Structure

```
src/
├── main/
│   ├── java/chez1s/assignment/
│   │   ├── controller/     # Jakarta Servlet controllers (MVC front controllers)
│   │   ├── service/        # Business logic layer
│   │   ├── repository/     # Hibernate ORM data access
│   │   ├── entity/         # JPA entity classes
│   │   ├── dto/            # Data Transfer Objects
│   │   ├── filter/         # Servlet filters (auth, CORS, etc.)
│   │   └── util/           # Utilities (MinIO, Gson helpers, etc.)
│   ├── webapp/
│   │   ├── views/          # JSP view templates grouped by feature
│   │   ├── static/         # Static assets (CSS, JS)
│   │   └── WEB-INF/
│   │       └── web.xml     # Servlet mappings
│   └── resources/
│       └── messages.properties  # i18n strings (Vietnamese + English)
├── docker-compose.yml      # MySQL 8 + MinIO services
└── init.sql                # Database seed/schema
```

## Key Conventions

- **Auth**: Session-based authentication with roles — `admin`, `cashier`, `guest`
- **API**: REST-style endpoints live in `*ApiController` servlets; all JSON responses use Gson
- **Images**: Stored in MinIO; proxied through `ImageServlet`
- **i18n**: Vietnamese and English strings in `messages.properties`
- **Lombok**: Used project-wide — enable annotation processing in your IDE
