<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Danh sách hóa đơn</title>
    <meta charset="UTF-8">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fb;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .table-container {
            width: 90%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: #4a6cf7;
            color: white;
            padding: 12px;
            text-align: center;
        }

        td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f1f5ff;
        }

        a {
            text-decoration: none;
            padding: 6px 10px;
            border-radius: 6px;
            font-size: 13px;
        }

        a[href*="detail"] {
            background: #28a745;
            color: white;
        }

        a[href*="cancel"] {
            background: #dc3545;
            color: white;
        }

        a:hover {
            opacity: 0.8;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            background: #4a6cf7;
            color: white;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 6px;
        }

        .pagination span {
            margin: 0 10px;
            font-weight: bold;
        }
    </style>
</head>

<body>

<h2>Danh sách hóa đơn</h2>

<div class="table-container">
    <table>
        <tr>
            <th>ID</th>
            <th>Nhân viên</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
            <th>Action</th>
        </tr>

        <c:forEach var="b" items="${list}">
            <tr>
                <td>${b.id}</td>
                <td>${b.userName}</td>
                <td>${b.total}</td>
                <td>${b.status}</td>
                <td>${b.createdDate}</td>
                <td>
                    <a href="bill?action=detail&id=${b.id}">Xem</a> |
                    <a href="bill?action=cancel&id=${b.id}"
                       onclick="return confirm('Bạn có chắc muốn huỷ?')">Huỷ</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <div class="pagination">
        <a href="?action=list&page=${page-1}">Prev</a>
        <span>Page ${page}</span>
        <a href="?action=list&page=${page+1}">Next</a>
    </div>
</div>

</body>
</html>