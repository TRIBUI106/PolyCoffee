<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Đồ Uống</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
    .img-preview {
        max-width: 200px;
        max-height: 200px;
        object-fit: contain;
        border: 1px solid #ddd;
        padding: 4px;
        background: #fff;
    }
</style>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống'}</h5>
                </div>
                <div class="card-body">
                    <form id="drinkForm" action="${pageContext.request.contextPath}/drink/save" 
                    	method="post" 
                    	enctype="multipart/form-data">

                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Danh mục <strong class="text-danger">*</strong></label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${cat.id == drink.categoryId ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="name" class="form-label">Tên <strong class="text-danger">*</strong></label>
                            <input type="text" class="form-control" id="name" name="name" value="${drink.name}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả <strong class="text-danger">*</strong></label>
                            <textarea class="form-control" id="description" name="description" rows="4">${drink.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="imageFile" class="form-label">Tải ảnh lên <strong class="text-danger">*</strong></label>
                            <input class="form-control" type="file" id="imageFile" name="imageFile" accept="image/*">
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Giá <strong class="text-danger">*</strong></label>
                            <input type="number" class="form-control" id="price" name="price" value="${drink.price}" min="0">
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="active" name="active" value="1">
                            <label class="form-check-label" for="active">Hiển thị</label>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">Lưu</button>
                            <a href="${pageContext.request.contextPath}/drink/list" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>