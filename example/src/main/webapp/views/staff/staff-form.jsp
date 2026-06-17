<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Nhân viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">${user != null && user.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên'}</h5>
                </div>
                <div class="card-body">
                    <form id="staffForm" action="${pageContext.request.contextPath}/staff/save" method="post">

                        <c:if test="${user != null && user.id != null}">
                            <input type="hidden" name="id" value="${user.id}" />
                        </c:if>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email <strong class="text-danger">*</strong></label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu ${user != null && user.id != null ? '(Để trống nếu không đổi)' : '<strong class="text-danger">*</strong>'}</label>
                            <input type="password" class="form-control" id="password" name="password" ${user == null || user.id == null ? 'required minlength="6"' : ''}>
                        </div>

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Họ và tên <strong class="text-danger">*</strong></label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại <strong class="text-danger">*</strong></label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" pattern="[0-9]{9,12}">
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="active" name="active" value="1" ${user != null && user.active ? 'checked' : ''}>
                            <label class="form-check-label" for="active">Kích hoạt tài khoản</label>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">${user != null && user.id != null ? 'Lưu' : 'Thêm'}</button>
                            <a href="${pageContext.request.contextPath}/staff/list" class="btn btn-secondary">Hủy</a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>