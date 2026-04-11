# PolyCoffee - Project Understanding

## Overview
Java POS system for coffee shop chain. Jakarta EE 10 on Tomcat 11, Hibernate 7 + MySQL 8, MinIO for images.

## Entities (10)
| Entity | Key Fields | Relationships |
|--------|-----------|---------------|
| User | id, email, password (plaintext!), fullName, phone, role (bool: true=Manager), active | has many Bills |
| Bill | id, code, createdAt, total, status (enum), paymentMethod, guestName, guestPhone, discountAmount | belongs to User, Guest, CoffeeTable, GuestVoucher; has many BillDetails |
| BillDetail | id, quantity, price, note | belongs to Bill, Drink |
| BillStatus | PENDING, WAITING, PAID, FINISHED, CANCELLED | enum |
| Drink | id, name, description, image, price, active | belongs to Category |
| Category | id, name, active | has many Drinks |
| CoffeeTable | id, tableNumber, code (unique), active | has many Bills |
| Guest | id, fullname, phoneNumber, point | has many Bills |
| Voucher | id, name, requiredPoints, discountAmount | has many GuestVouchers |
| GuestVoucher | id, isUsed | belongs to Guest, Voucher |

## Roles & Access
- **Manager** (role=true): Full access - CRUD staff/drinks/categories/tables, bill management, statistics
- **Staff/Cashier** (role=false): POS only - create bills, add drinks, checkout
- **Guest** (unauthenticated): Self-order kiosk, point shop, voucher redemption

## Controllers (14)
| Controller | URLs | Purpose |
|-----------|------|--------|
| HomeController | /, /home | Landing page |
| AuthController | /auth/login, /auth/logout, /auth/profile | Login/logout/profile |
| PosController | /employee/pos, /employee/pos/add,update,note,checkout,cancel | Main POS for staff |
| BillController | /manager/bills | Bill list & status update (admin) |
| CategoryController | /manager/categories/* | CRUD categories |
| DrinkController | /manager/drinks/* | CRUD drinks with image upload |
| StaffController | /manager/staff/* | CRUD staff accounts |
| TableController | /manager/tables/* | CRUD coffee tables |
| StatisticController | /manager/statistics | Revenue & top drinks report |
| StatisticApiController | /api/stats | Dashboard JSON API |
| GuestPosController | /guest/pos/* | Guest self-order & checkout |
| SelfOrderController | (self-order kiosk) | Self-order flow |
| PointShopController | /guest/pointshop/* | Voucher catalog & redemption |
| ImageServlet | /uploads/* | Proxies images from MinIO/local |

## Services (9)
AuthService, BillService, CategoryService, DrinkService, GuestService, PointShopService, StaffService, StatisticService, TableService

## Key Business Logic
1. **Bill lifecycle**: WAITING -> FINISHED/CANCELLED (employee) or WAITING -> PAID -> FINISHED (via status update)
2. **Guest checkout**: Creates bill with guest info, applies voucher discount, accumulates loyalty points (1000 VND = 1 point)
3. **Voucher system**: Guests earn points -> redeem for vouchers -> apply voucher discount on checkout
4. **Category delete**: Soft-delete if drinks exist, hard-delete if empty
5. **Auth**: Session-based, plaintext password comparison, AuthFilter on /manager/* and /employee/*
6. **Manager redirect after login**: goes to /employee/pos?tab=stats; Staff goes to /employee/pos

## Security Observations
- Passwords stored/compared in plaintext
- No CSRF protection visible
- AuthFilter only covers /manager/* and /employee/* paths
- /guest/* and /api/* have inline auth checks
