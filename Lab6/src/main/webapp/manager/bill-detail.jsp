<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Category Manager</title>
    <meta charset="UTF-8">

</head>
<body>

<h2>Chi tiết hóa đơn</h2>

<table border="1">
<tr>
    <th>Tên nước</th>
    <th>Số lượng</th>
    <th>Đơn giá</th>
    <th>Thành tiền</th>
</tr>

<c:forEach var="d" items="${details}">
<tr>
    <td>${d.drinkId}</td>
    <td>${d.quantity}</td>
    <td>${d.price}</td>
    <td>${d.quantity * d.price}</td>
</tr>
</c:forEach>
</table>
</body>
</html>