<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách đồ uống</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<style>
    .thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; }
</style>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Danh sách đồ uống</h3>
        <a href="${pageContext.request.contextPath}/drink/create" class="btn btn-success">Thêm mới</a>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width:60px">ID</th>
                            <th>Tên</th>
                            <th>Mô tả</th>
                            <th style="width:100px">Ảnh</th>
                            <th style="width:120px">Giá (VNĐ)</th>
                            <th style="width:100px">Hiển thị</th>
                            <th style="width:140px">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 5 dữ liệu mẫu hardcoded -->
                        <tr>
                            <td>1</td>
                            <td>Cà phê sữa</td>
                            <td>Đậm vị, thơm mùi sữa</td>
                            <td><img src="http://kingroti.com/uploads/plugin/news/157/1711097076-159736173-h-ng-d-n-chi-ti-t-pha-ca-phe-s-a-a-sieu-ngon-t-i-nha.jpg" alt="Ca phe" class="thumb"/></td>
                            <td>45.000</td>
                            <td><span class="badge bg-success">Có</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/drink/edit?id=1" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="${pageContext.request.contextPath}/drink/delete?id=1" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa món này không?');">Xóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>2</td>
                            <td>Trà đào</td>
                            <td>Hương đào tươi, mát dịu</td>
                            <td><img src="https://toongcenter.vn/storage/photos/shares/meo%20pha%20che/tra%20dao%20cam%20sả/1.jpg" alt="Tra dao" class="thumb"/></td>
                            <td>50.000</td>
                            <td><span class="badge bg-success">Có</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/drink/edit?id=2" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="${pageContext.request.contextPath}/drink/delete?id=2" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa món này không?');">Xóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>3</td>
                            <td>Bạc xỉu</td>
                            <td>Ngọt dịu, nhẹ nhàng</td>
                            <td><img src="https://lypham.vn/wp-content/uploads/2024/10/cach-lam-bac-xiu.jpg" alt="Bac xiu" class="thumb"/></td>
                            <td>40.000</td>
                            <td><span class="badge bg-secondary">Không</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/drink/edit?id=3" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="${pageContext.request.contextPath}/drink/delete?id=3" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa món này không?');">Xóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>4</td>
                            <td>Sinh tố bơ</td>
                            <td>Béo mịn, giàu dinh dưỡng</td>
                            <td><img src="https://hasuka.com.vn/storage/uploads/v4ojgTcmGzX0bmRzgIdBHjIErtbCKL8eqZ9GKSc6.jpg" alt="Sinh to bo" class="thumb"/></td>
                            <td>55.000</td>
                            <td><span class="badge bg-success">Có</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/drink/edit?id=4" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="${pageContext.request.contextPath}/drink/delete?id=4" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa món này không?');">Xóa</a>
                            </td>
                        </tr>

                        <tr>
                            <td>5</td>
                            <td>Matcha Latte</td>
                            <td>Vị matcha nguyên chất, thơm trọn vị</td>
                            <td><img src="https://www.modernfarmhouseeats.com/wp-content/uploads/2022/02/starbucks-iced-matcha-latte-8.jpg" alt="Matcha" class="thumb"/></td>
                            <td>60.000</td>
                            <td><span class="badge bg-success">Có</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/drink/edit?id=5" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="${pageContext.request.contextPath}/drink/delete?id=5" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa món này không?');">Xóa</a>
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