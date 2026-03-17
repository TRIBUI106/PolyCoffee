<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Thống kê</title>

    <style>
        body {
            font-family: 'Segoe UI';
            background: #f5f7fb;
            padding: 20px;
        }

        .box {
            width: 70%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
        }

        input {
            padding: 8px;
            margin: 5px;
        }

        button {
            padding: 8px 12px;
            background: #4a6cf7;
            color: white;
            border: none;
            border-radius: 6px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th {
            background: #4a6cf7;
            color: white;
            padding: 10px;
        }

        td {
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Top 5 thức uống bán chạy</h2>

    <form>
        Từ: <input type="date" name="from" value="${from}">
        Đến: <input type="date" name="to" value="${to}">
        <button type="submit">Lọc</button>
    </form>

    <table>
        <tr>
            <th>Tên nước</th>
            <th>Số lượng bán</th>
        </tr>

        <c:forEach var="d" items="${list}">
            <tr>
                <td>${d[0]}</td>
                <td>${d[1]}</td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>