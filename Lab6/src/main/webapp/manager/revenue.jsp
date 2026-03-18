<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Thống kê doanh thu</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: Arial;
            background: #f5f6fa;
            padding: 30px;
        }

        .card {
            width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
        }
    </style>
</head>

<body>

<div class="card">
    <h2>📊 Thống kê doanh thu</h2>

    <form method="get" action="revenue">
        Từ: <input type="date" name="from">
        Đến: <input type="date" name="to">
        <button>Lọc</button>
    </form>

    <canvas id="myChart"></canvas>
</div>

<script>
    const labels = [
        <c:forEach var="r" items="${list}">
            "${r.date}",
        </c:forEach>
    ];

    const data = [
        <c:forEach var="r" items="${list}">
            ${r.revenue},
        </c:forEach>
    ];

    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Doanh thu',
                data: data
            }]
        }
    });
</script>

</body>
</html>