<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách nhân viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<style>
    .thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; }
</style>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Danh sách nhân viên</h3>
        <a href="${pageContext.request.contextPath}/staff/create" class="btn btn-success">Thêm mới</a>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width:60px">Mã</th>
                            <th>Email</th>
                            <th>Họ và tên</th>
                            <th style="width:140px">Số điện thoại</th>
                            <th style="width:100px">Trạng thái</th>
                            <th style="width:220px">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 5 dữ liệu mẫu hardcoded -->
                        <tr>
                            <td>1</td>
                            <td>nguyenvana@example.com</td>
                            <td>Nguyễn Văn A</td>
                            <td>0909123456</td>
                            <td><span class="badge bg-success">Hoạt động</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/staff/edit?id=1" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/staff/lock?id=1" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn khóa tài khoản này không?');">Khóa tài khoản</a>
                            </td>
                        </tr>

                        <tr>
                            <td>2</td>
                            <td>lethib@example.com</td>
                            <td>Lê Thị B</td>
                            <td>0912345678</td>
                            <td><span class="badge bg-secondary">Không hoạt động</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/staff/edit?id=2" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/staff/unlock?id=2" class="btn btn-sm btn-success" onclick="return confirm('Bạn có chắc muốn mở khóa tài khoản này không?');">Mở khóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>3</td>
                            <td>tranvan@example.com</td>
                            <td>Trần Văn C</td>
                            <td>0987654321</td>
                            <td><span class="badge bg-success">Hoạt động</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/staff/edit?id=3" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/staff/lock?id=3" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn khóa tài khoản này không?');">Khóa tài khoản</a>
                            </td>
                        </tr>

                        <tr>
                            <td>4</td>
                            <td>phamth@example.com</td>
                            <td>Phạm Thị D</td>
                            <td>0933222111</td>
                            <td><span class="badge bg-secondary">Không hoạt động</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/staff/edit?id=4" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/staff/unlock?id=4" class="btn btn-sm btn-success" onclick="return confirm('Bạn có chắc muốn mở khóa tài khoản này không?');">Mở khóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>5</td>
                            <td>ngocanh@example.com</td>
                            <td>Ngọc Ánh</td>
                            <td>0977001122</td>
                            <td><span class="badge bg-success">Hoạt động</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/staff/edit?id=5" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/staff/lock?id=5" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn khóa tài khoản này không?');">Khóa tài khoản</a>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>