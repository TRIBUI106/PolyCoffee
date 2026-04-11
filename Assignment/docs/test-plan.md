# PolyCoffee - Test Plan (150 Test Cases)

**Project**: PolyCoffee POS System  
**Version**: 1.0  
**Date**: 2026-04-11  
**Coverage**: Full-stack (Controller / Service / Repository / Filter / Security)  

---

## Module 1: Authentication & Authorization (TC-001 to TC-020)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-001 | Login with valid manager credentials | Manager user exists (email=admin@test.com, active=true) | POST /auth/login with valid email & password | Redirect to /employee/pos?tab=stats, session contains User | Critical |
| TC-002 | Login with valid staff credentials | Staff user exists (role=false, active=true) | POST /auth/login with valid email & password | Redirect to /employee/pos, session contains User | Critical |
| TC-003 | Login with wrong password | User exists | POST /auth/login with correct email, wrong password | Forward to login.jsp with errorKey="login.error" | Critical |
| TC-004 | Login with non-existent email | No user with given email | POST /auth/login with unknown email | Forward to login.jsp with errorKey="login.error" | High |
| TC-005 | Login with inactive user account | User exists but active=false | POST /auth/login with valid credentials | Login fails, forward to login.jsp with error | Critical |
| TC-006 | Login with empty email | None | POST /auth/login with email="" | Login fails, error shown | Medium |
| TC-007 | Login with empty password | None | POST /auth/login with password="" | Login fails, error shown | Medium |
| TC-008 | Logout clears session | User is logged in | GET /auth/logout | Session cleared, redirect to /auth/login | Critical |
| TC-009 | AuthFilter blocks unauthenticated /employee/* | No session | GET /employee/pos without session | Redirect to /auth/login, REDIRECT_URL stored in session | Critical |
| TC-010 | AuthFilter blocks unauthenticated /manager/* | No session | GET /manager/bills without session | Redirect to /auth/login | Critical |
| TC-011 | AuthFilter allows authenticated staff to /employee/* | Staff logged in | GET /employee/pos | Request passes through filter, page renders | Critical |
| TC-012 | AuthFilter blocks staff from /manager/* | Staff logged in (role=false) | GET /manager/staff | 403 Forbidden response | Critical |
| TC-013 | AuthFilter allows manager to /manager/* | Manager logged in | GET /manager/staff | Request passes through, page renders | Critical |
| TC-014 | AuthFilter stores redirect URL with query string | No session | GET /employee/pos?billId=5 without session | REDIRECT_URL = "/employee/pos?billId=5" stored in session | High |
| TC-015 | Post-login redirect to stored URL | REDIRECT_URL in session | Login successfully | Redirect to stored URL, REDIRECT_URL removed from session | High |
| TC-016 | Profile page requires authentication | No session | GET /auth/profile without session | Redirect to /auth/login | Medium |
| TC-017 | Profile page loads for authenticated user | User logged in | GET /auth/profile | Forward to profile.jsp | Medium |
| TC-018 | Login page shows total bills and revenue stats | Bills exist in DB | GET /auth/login | totalBills and totalRevenue attributes set | Low |
| TC-019 | SQL injection in email login field | None | POST /auth/login with email="' OR 1=1 --" | Login fails (no injection), error shown | Critical |
| TC-020 | SQL injection in password login field | None | POST /auth/login with password="' OR 1=1 --" | Login fails, error shown | Critical |

---

## Module 2: Staff/User Management (TC-021 to TC-032)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-021 | List all staff accounts | Staff records exist | GET /manager/staff | staffList attribute contains all staff (role=false) | High |
| TC-022 | Create new staff with valid data | Manager logged in | POST /manager/staff/save with fullName, email, password, phone | New user created with role=false, active=true, redirect to /employee/pos?tab=users | Critical |
| TC-023 | Create staff with duplicate email | User with same email exists | POST /manager/staff/save with existing email | Session error "Email already exists!", redirect without creating | Critical |
| TC-024 | Create staff with empty required fields | Manager logged in | POST /manager/staff/save with email="" | Validation error or DB constraint violation | High |
| TC-025 | Update staff name and phone | Staff exists | POST /manager/staff/save with id=existing, new fullName & phone | Staff updated, password unchanged | High |
| TC-026 | Toggle staff to inactive | Active staff exists | GET /manager/staff/status?id=1&active=0 | Staff active=false, redirect | High |
| TC-027 | Toggle staff to active | Inactive staff exists | GET /manager/staff/status?id=1&active=1 | Staff active=true, redirect | High |
| TC-028 | Staff form loads for new user (no id) | Manager logged in | GET /manager/staff/form | Forward to staff-form.jsp, no staff attribute | Medium |
| TC-029 | Staff form loads for existing user | Staff id=1 exists | GET /manager/staff/form?id=1 | Forward to staff-form.jsp, staff attribute populated | Medium |
| TC-030 | Staff cannot access staff management | Staff logged in | GET /manager/staff | 403 Forbidden (AuthFilter) | Critical |
| TC-031 | Update staff preserves password (no password field in update) | Staff exists | POST /manager/staff/save with id=existing | Password remains unchanged | High |
| TC-032 | Create staff - role forced to false by StaffService | Manager submits role=true | POST /manager/staff/save with role=true, id=0 | StaffService.createStaff sets role=false | High |

---

## Module 3: Category Management (TC-033 to TC-042)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-033 | List all categories | Categories exist | GET /manager/categories | categories attribute populated | High |
| TC-034 | Create category with valid name | Manager logged in | POST /manager/categories with name="Tea" | New category created, active=true, redirect | Critical |
| TC-035 | Create category with empty name | Manager logged in | POST /manager/categories with name="" | DB constraint violation or empty category created | High |
| TC-036 | Update category name | Category id=1 exists | POST /manager/categories with id=1, name="New Name" | Category name updated | High |
| TC-037 | Delete empty category (hard delete) | Category exists with 0 drinks | GET /manager/categories/delete?id=1 | Category removed from DB entirely | High |
| TC-038 | Delete category with drinks (soft delete) | Category has associated drinks | GET /manager/categories/delete?id=1 | Category active=false, still in DB | Critical |
| TC-039 | Get category by valid ID | Category id=1 exists | CategoryService.getCategoryById(1) | Returns correct Category object | Medium |
| TC-040 | Get category by non-existent ID | No category id=999 | CategoryService.getCategoryById(999) | Returns null | Medium |
| TC-041 | Category detail loaded when id param present | Category id=1 exists | GET /manager/categories?id=1 | Both categories list and single category attribute set | Medium |
| TC-042 | Category management requires manager role | Staff logged in | GET /manager/categories | 403 Forbidden | Critical |

---

## Module 4: Drink Management (TC-043 to TC-054)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-043 | List all drinks (including inactive) | Drinks exist | GET /manager/drinks | All drinks listed | High |
| TC-044 | Get active drinks only | Mix of active/inactive drinks | DrinkService.getActiveDrinks() | Only active=true drinks returned | Critical |
| TC-045 | Create drink with valid data | Manager logged in, category exists | POST /manager/drinks/save with name, price, categoryId | New drink created, redirect to ?tab=drinks | Critical |
| TC-046 | Create drink with image upload | Manager logged in | POST (multipart) /manager/drinks/save with image file | Drink created, image stored in MinIO, image field set | High |
| TC-047 | Update drink without changing image | Drink exists with image | POST /manager/drinks/save with id, no new image | Drink updated, original image preserved | High |
| TC-048 | Update drink with new image deletes old | Drink exists with old image | POST /manager/drinks/save with id, new image | Old image deleted from MinIO, new image stored | High |
| TC-049 | Delete drink (soft delete via active flag) | Drink exists | GET /manager/drinks/delete?id=1 | Drink active=false or deleted | High |
| TC-050 | Get drink by valid ID | Drink id=1 exists | DrinkService.getDrinkById(1) | Returns correct Drink | Medium |
| TC-051 | Get drink by non-existent ID | No drink id=999 | DrinkService.getDrinkById(999) | Returns null | Medium |
| TC-052 | Create drink with price=0 | Manager logged in | POST /manager/drinks/save with price=0 | Drink created with price=0 (free item) | Medium |
| TC-053 | Create drink with negative price | Manager logged in | POST /manager/drinks/save with price=-100 | Should be rejected or handled gracefully | High |
| TC-054 | Drink form loads with categories for dropdown | Categories exist | GET /manager/drinks/form | categories attribute set for dropdown | Medium |

---

## Module 5: Table Management (TC-055 to TC-062)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-055 | List all tables | Tables exist | GET /manager/tables | tables attribute populated | High |
| TC-056 | Create table with valid name and code | Manager logged in | POST /manager/tables/save with name="Table 1", code="t1" | Table created, code uppercased to "T1" | Critical |
| TC-057 | Create table with duplicate code | Table with same code exists | POST /manager/tables/save with duplicate code | DB unique constraint violation | High |
| TC-058 | Update table name and code | Table id=1 exists | POST /manager/tables/save with id=1, new name & code | Table updated, code uppercased | High |
| TC-059 | Delete table | Table id=1 exists, no bills | GET /manager/tables/delete?id=1 | Table removed | High |
| TC-060 | Table code always uppercased | None | TableService.createTable("name", "abc") | Code stored as "ABC" | Medium |
| TC-061 | Get table by code | Table with code="T1" exists | TableService.getTableByCode("T1") | Returns correct table | Medium |
| TC-062 | Table management requires manager role | Staff logged in | GET /manager/tables | 403 Forbidden | Critical |

---

## Module 6: POS - Bill Lifecycle (TC-063 to TC-087)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-063 | Add drink creates new bill when billId=0 | Staff logged in, drink exists | GET /employee/pos/add?drinkId=1 | New bill created with status=WAITING, 1 detail, total=drink.price | Critical |
| TC-064 | Add drink to existing waiting bill | Bill id=1 status=WAITING | GET /employee/pos/add?billId=1&drinkId=2 | New BillDetail added, total recalculated | Critical |
| TC-065 | Add same drink again increments quantity | Bill has drinkId=1 qty=1 | GET /employee/pos/add?billId=1&drinkId=1 | Existing detail qty=2, no duplicate detail | Critical |
| TC-066 | Add drink to non-WAITING bill rejected | Bill status=FINISHED | GET /employee/pos/add?billId=1&drinkId=1 | Returns 0, no changes made | Critical |
| TC-067 | Add drink with invalid drinkId | No drink id=999 | GET /employee/pos/add?drinkId=999 | NullPointerException or handled gracefully | High |
| TC-068 | Add drink with billId=null | Staff logged in | GET /employee/pos/add?drinkId=1 (no billId) | Creates new bill (billId treated as 0) | High |
| TC-069 | Update quantity to 3 | Bill detail exists with qty=1 | GET /employee/pos/update?billId=1&drinkId=1&quantity=3 | Detail quantity=3, total recalculated | Critical |
| TC-070 | Update quantity to 0 removes detail | Bill detail exists | GET /employee/pos/update?billId=1&drinkId=1&quantity=0 | Detail removed from bill, total recalculated | Critical |
| TC-071 | Update quantity on non-WAITING bill | Bill status=FINISHED | GET /employee/pos/update?billId=1&drinkId=1&quantity=5 | No changes, early return | High |
| TC-072 | Update quantity for non-existent drink in bill | Drink not in bill | GET /employee/pos/update?billId=1&drinkId=999&quantity=2 | No changes (detail is null) | Medium |
| TC-073 | Update note on bill detail | Bill detail exists | GET /employee/pos/note?billId=1&drinkId=1&note=no+sugar | Note updated on detail | High |
| TC-074 | Update note on non-WAITING bill | Bill status=FINISHED | GET /employee/pos/note?billId=1&drinkId=1&note=test | No changes | Medium |
| TC-075 | Checkout bill WAITING -> FINISHED | Bill status=WAITING | GET /employee/pos/checkout?billId=1 | Bill status=FINISHED | Critical |
| TC-076 | Checkout already FINISHED bill | Bill status=FINISHED | GET /employee/pos/checkout?billId=1 | No change (guard clause) | High |
| TC-077 | Checkout CANCELLED bill | Bill status=CANCELLED | GET /employee/pos/checkout?billId=1 | No change | Medium |
| TC-078 | Cancel bill WAITING -> CANCELLED | Bill status=WAITING | GET /employee/pos/cancel?billId=1 | Bill status=CANCELLED | Critical |
| TC-079 | Cancel already CANCELLED bill | Bill status=CANCELLED | GET /employee/pos/cancel?billId=1 | No change | Medium |
| TC-080 | Bill total = sum(price * quantity) for all details | Bill with 3 details | Add multiple drinks, update quantities | bill.total equals sum of (detail.price * detail.quantity) | Critical |
| TC-081 | Bill code format is "BILL-{timestamp}" | None | Create new bill via POS | bill.code matches pattern "BILL-\\d+" | Medium |
| TC-082 | Get bill by ID | Bill exists | BillService.getBillById(1) | Returns bill with correct data | High |
| TC-083 | Get bill by ID returns null for missing | No bill id=999 | BillService.getBillById(999) | Returns null | Medium |
| TC-084 | Get bill by ID and userId (ownership) | Bill belongs to userId=1 | BillService.getBill(1, 1) | Returns bill | High |
| TC-085 | Get bill by ID and wrong userId | Bill belongs to userId=1 | BillService.getBill(1, 2) | Returns null (not owner) | Critical |
| TC-086 | Search bills by query matches code | Bill with code="BILL-123" | BillService.searchBills("123", null) | Returns matching bills | High |
| TC-087 | Search bills by status filter | Bills with mixed statuses | BillService.searchBills(null, "FINISHED") | Returns only FINISHED bills | High |

---

## Module 7: Guest Self-Order & Checkout (TC-088 to TC-105)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-088 | Guest checkout with valid cart | Drinks exist | POST /guest/pos/checkout with JSON cart | Bill created, returns {success:true, billId, billCode, total} | Critical |
| TC-089 | Guest checkout with empty items list | None | POST /guest/pos/checkout with items=[] | Bill created with total=0 or error | High |
| TC-090 | Guest checkout with invalid drink ID | No drink id=999 | POST /guest/pos/checkout with drinkId=999 in items | Drink skipped (null check), total excludes it | High |
| TC-091 | Guest checkout with table from request body | Table id=1 exists | POST /guest/pos/checkout with tableId=1 | Bill.table set to CoffeeTable id=1 | High |
| TC-092 | Guest checkout with table from session | tableId=1 in session | POST /guest/pos/checkout without tableId in body | Bill.table set from session tableId | High |
| TC-093 | Guest checkout with voucher discount | Guest has unused voucher, discountAmount=10000 | POST /guest/pos/checkout with guestVoucherId | Bill.discountAmount=10000, total reduced, voucher marked used | Critical |
| TC-094 | Guest checkout total cannot go below 0 | Voucher discount > items total | POST /guest/pos/checkout | Bill.total = 0 (Math.max(0, ...)) | Critical |
| TC-095 | Guest checkout point accumulation | Guest exists, total=50000 | POST /guest/pos/checkout | Guest earns 50 points (50000/1000) | Critical |
| TC-096 | Guest checkout with already-used voucher | Voucher isUsed=true | POST /guest/pos/checkout with used voucherId | Voucher not applied (isUsed check) | Critical |
| TC-097 | Guest checkout with voucher belonging to other guest | Voucher belongs to guest B | POST /guest/pos/checkout as guest A with voucherId | Voucher not applied (guest ID mismatch) | Critical |
| TC-098 | Guest bill code format "GUEST-{timestamp}" | None | Guest checkout | bill.code matches "GUEST-\\d+" | Medium |
| TC-099 | Guest checkout with null guestName | None | POST /guest/pos/checkout without guestName | Bill created with null guestName | Medium |
| TC-100 | Guest checkout server error returns 500 JSON | Invalid data causing exception | POST /guest/pos/checkout with bad data | Status 500, {success:false, message:"..."} | High |
| TC-101 | Accept guest bill WAITING -> FINISHED | Guest bill status=WAITING | POST /guest/pos/accept?billId=1 | Bill status=FINISHED, redirect to /employee/pos?billId=1 | High |
| TC-102 | Accept non-WAITING bill no-op | Bill status=FINISHED | POST /guest/pos/accept?billId=1 | No status change | Medium |
| TC-103 | Guest POS renders categories and drinks | Data exists | GET /guest/pos | categories and drinks attributes set, forward to pos.jsp | High |
| TC-104 | Guest POS stores tableId in session | None | GET /guest/pos?tableId=5 | Session attribute tableId="5" | Medium |
| TC-105 | Guest POS drinks filtered by category (JSON) | Drinks in multiple categories | GET /guest/pos/drinks?catId=1 | JSON response with only drinks in category 1 | High |

---

## Module 8: Guest & Loyalty/Points System (TC-106 to TC-117)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-106 | Find guest by phone - exists | Guest phone="0901234567" exists | GuestService or GuestRepository.findByPhoneNumber | Returns correct Guest | High |
| TC-107 | Find guest by phone - not found | No guest with phone | GuestRepository.findByPhoneNumber("0000000000") | Returns null | High |
| TC-108 | Create guest on first order (findOrCreate) | No guest with phone | GuestService.findOrCreateGuest("Name", "0901234567") | New Guest created with point=0 | Critical |
| TC-109 | findOrCreate updates name if changed | Guest exists with different name | GuestService.findOrCreateGuest("New Name", existingPhone) | Guest name updated | High |
| TC-110 | findOrCreate returns existing if same name | Guest exists with same name | GuestService.findOrCreateGuest(sameName, samePhone) | No update, returns existing | Medium |
| TC-111 | Point shop - list available vouchers | Vouchers exist | GET /guest/pointshop/vouchers | JSON array of {id, name, requiredPoints, discountAmount} | High |
| TC-112 | Point shop - get guest status by phone | Guest exists with points and vouchers | GET /guest/pointshop/status?phone=0901234567 | JSON {success:true, points:N, vouchers:[...]} | High |
| TC-113 | Point shop - guest status phone not found | No guest | GET /guest/pointshop/status?phone=0000000000 | JSON {success:false, message:"..."} | High |
| TC-114 | Redeem voucher with sufficient points | Guest has 100 points, voucher costs 50 | POST /guest/pointshop/redeem {phone, voucherId, quantity:1} | Points deducted to 50, GuestVoucher created, {success:true} | Critical |
| TC-115 | Redeem voucher with insufficient points | Guest has 10 points, voucher costs 50 | POST /guest/pointshop/redeem | {success:false, message:"Not enough points."} | Critical |
| TC-116 | Redeem voucher - guest not found | Invalid phone | POST /guest/pointshop/redeem | {success:false, message:"Guest not found..."} | High |
| TC-117 | Redeem voucher - quantity <= 0 | Valid guest & voucher | POST /guest/pointshop/redeem with quantity=0 | {success:false, message:"Quantity must be greater than zero."} | High |

---

## Module 9: Bill Management (Admin) (TC-118 to TC-124)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-118 | Manager sees all bills | Manager logged in, bills exist | GET /manager/bills | All bills returned regardless of userId | High |
| TC-119 | Staff sees own bills only | Staff logged in | GET /manager/bills | Only bills where user_id matches | Critical |
| TC-120 | Manager views bill detail | Bill id=1 exists | GET /manager/bills?id=1 as manager | bill attribute set with full details | High |
| TC-121 | Staff views own bill detail | Bill belongs to staff | GET /manager/bills?id=1 as staff (owner) | bill attribute set | High |
| TC-122 | Staff cannot view other's bill detail | Bill belongs to different user | GET /manager/bills?id=1 as non-owner staff | bill attribute null | Critical |
| TC-123 | Manager updates bill status via POST | Manager logged in | POST /manager/bills with billId=1, status=PAID | Bill status updated, redirect | High |
| TC-124 | Staff cannot update bill status | Staff logged in | POST /manager/bills | 403 Forbidden | Critical |

---

## Module 10: Statistics & Dashboard (TC-125 to TC-132)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-125 | Dashboard today revenue calculation | Finished bills exist today | StatisticService.getDashboardData() | todayRevenue = sum of today's finished bill totals | High |
| TC-126 | Dashboard today orders count | Finished bills today | StatisticService.getDashboardData() | todayOrders = count of today's finished bills | High |
| TC-127 | Dashboard week revenue | Finished bills this week | StatisticService.getDashboardData() | weekRevenue calculated from Monday | High |
| TC-128 | Dashboard total bills (all time) | Bills exist | StatisticService.getDashboardData() | totalBills = count of all FINISHED bills | High |
| TC-129 | Top 5 best selling drinks | Bill details exist | StatisticService.getTopSellingDrinks(null, null) | Returns top 5 ordered by total quantity | High |
| TC-130 | Revenue by day report | Finished bills on multiple days | StatisticService.getRevenueReport(from, to) | Grouped daily totals within range | High |
| TC-131 | Statistics with null date range (all time) | Bills exist | GET /manager/statistics (no from/to) | All-time data returned | Medium |
| TC-132 | Statistics API requires manager role | Staff logged in | GET /api/stats | 403 Forbidden | Critical |

---

## Module 11: Image & File Handling (TC-133 to TC-137)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-133 | ImageServlet serves from MinIO | Image exists in MinIO | GET /uploads/image.jpg | Image bytes streamed with correct content type | High |
| TC-134 | ImageServlet falls back to local resources | Image not in MinIO but in webapp/uploads/ | GET /uploads/legacy.jpg | Image served from local resource | High |
| TC-135 | ImageServlet returns 404 for missing image | Image doesn't exist anywhere | GET /uploads/nonexistent.jpg | 404 Not Found | High |
| TC-136 | ImageServlet with null pathInfo | None | GET /uploads/ (no filename) | 404 Not Found | Medium |
| TC-137 | File upload to MinIO on drink create | Manager uploads image | POST multipart /manager/drinks/save with image | Image stored in MinIO, filename returned | High |

---

## Module 12: Filters & Utilities (TC-138 to TC-144)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-138 | EncodingFilter sets UTF-8 on all requests | None | Any HTTP request | Request and response encoding set to UTF-8 | Medium |
| TC-139 | AuthUtil.setUser stores user in session | Valid user | AuthUtil.setUser(req, user) then AuthUtil.getUser(req) | Same user returned | High |
| TC-140 | AuthUtil.isAuthenticated returns false for no session | No user in session | AuthUtil.isAuthenticated(req) | Returns false | High |
| TC-141 | AuthUtil.isManager returns true for role=true | Manager user in session | AuthUtil.isManager(req) | Returns true | High |
| TC-142 | AuthUtil.isManager returns false for staff | Staff user in session | AuthUtil.isManager(req) | Returns false | High |
| TC-143 | ParamUtil.getInt returns 0 for null/non-numeric | None | ParamUtil.getInt(req, "missing") | Returns 0 (or default) | Medium |
| TC-144 | ParamUtil.getString returns empty for null param | None | ParamUtil.getString(req, "missing") | Returns "" | Medium |

---

## Module 13: Security Tests (TC-145 to TC-150)

| ID | Description | Precondition | Steps | Expected Result | Priority |
|----|-------------|-------------|-------|-----------------|----------|
| TC-145 | Privilege escalation - staff accesses manager URL directly | Staff logged in | GET /manager/staff, /manager/categories, /manager/statistics | All return 403 Forbidden | Critical |
| TC-146 | IDOR - staff accesses another staff's bill via billId | Staff A logged in, bill belongs to Staff B | GET /manager/bills?id=<staffB_billId> as Staff A | Bill not returned (null) - ownership enforced | Critical |
| TC-147 | XSS in guest name on checkout | None | POST /guest/pos/checkout with guestName="<script>alert(1)</script>" | Script tags escaped in any rendered output | Critical |
| TC-148 | Path traversal in ImageServlet | None | GET /uploads/../../WEB-INF/web.xml | 404 or blocked, does NOT serve web.xml | Critical |
| TC-149 | Invalid BillStatus enum in status update | Manager logged in | POST /manager/bills with status="INVALID_STATUS" | IllegalArgumentException caught, no crash | High |
| TC-150 | Concurrent bill modification race condition | Bill id=1 status=WAITING | Two simultaneous checkout requests for same bill | Only one succeeds, no data corruption, bill ends FINISHED | High |

---

## Summary

| Module | Count | Critical | High | Medium | Low |
|--------|-------|----------|------|--------|-----|
| Authentication & Authorization | 20 | 10 | 3 | 5 | 2 |
| Staff/User Management | 12 | 4 | 6 | 2 | 0 |
| Category Management | 10 | 3 | 4 | 3 | 0 |
| Drink Management | 12 | 2 | 6 | 4 | 0 |
| Table Management | 8 | 3 | 3 | 2 | 0 |
| POS - Bill Lifecycle | 25 | 10 | 8 | 7 | 0 |
| Guest Self-Order & Checkout | 18 | 6 | 8 | 4 | 0 |
| Guest & Loyalty System | 12 | 3 | 7 | 2 | 0 |
| Bill Management (Admin) | 7 | 3 | 3 | 1 | 0 |
| Statistics & Dashboard | 8 | 1 | 5 | 2 | 0 |
| Image & File Handling | 5 | 0 | 4 | 1 | 0 |
| Filters & Utilities | 7 | 0 | 3 | 4 | 0 |
| Security | 6 | 4 | 2 | 0 | 0 |
| **TOTAL** | **150** | **49** | **62** | **37** | **2** |
