<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.poly.lab4.entity.Drink" %>

<%
    Drink drink = (Drink) request.getAttribute("drink");
%>

<html>
<head>
    <title>Drink Manager</title>
    <meta charset="UTF-8">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 30px 40px;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 24px;
            font-weight: 600;
        }

        form {
            background: white;
            padding: 28px;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            max-width: 580px;
            margin-bottom: 40px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #444;
        }

        input[type="text"],
        input[type="number"],
        input[type="hidden"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #d1d9e0;
            border-radius: 6px;
            font-size: 15px;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #5c8aff;
            box-shadow: 0 0 0 3px rgba(92, 138, 255, 0.15);
        }

        button {
            background-color: #5c8aff;
            color: white;
            border: none;
            padding: 11px 28px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        button:hover {
            background-color: #4a75e6;
        }

        hr {
            border: none;
            border-top: 1px solid #e0e7ff;
            margin: 36px 0;
        }

        table {
            width: 100%;
            max-width: 960px;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
        }

        th {
            background-color: #eef2ff;
            color: #2c3e50;
            font-weight: 600;
            border-bottom: 2px solid #d1d9e0;
        }

        tr {
            border-bottom: 1px solid #f0f0f0;
        }

        tr:last-child {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f8fbff;
        }

        .image-cell {
            max-width: 160px;
            word-break: break-all;
            font-size: 0.92em;
            color: #555;
        }

        .image-preview {
            max-width: 80px;
            height: auto;
            border-radius: 6px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            vertical-align: middle;
        }

        td a {
            color: #5c8aff;
            text-decoration: none;
            font-weight: 500;
            margin-right: 6px;
        }

        td a:hover {
            text-decoration: underline;
            color: #4a75e6;
        }

        .delete {
            color: #e74c3c !important;
        }

        .delete:hover {
            color: #c0392b !important;
        }
    </style>
</head>
<body>

<h2>Quản lý đồ uống</h2>

<form action="drink" method="post">
    <input type="hidden" name="id"    value="<%= drink != null ? drink.getId() : "" %>">
    <input type="hidden" name="action" value="<%= drink != null ? "update" : "add" %>">

    <div class="form-group">
        <label for="name">Tên đồ uống:</label>
        <input type="text" name="name" id="name"
               value="<%= drink != null ? drink.getName() : "" %>"
               placeholder="Nhập tên đồ uống..." required>
    </div>

    <div class="form-group">
        <label for="price">Giá (VND):</label>
        <input type="number" name="price" id="price" min="0" step="1000"
               value="<%= drink != null ? drink.getPrice() : "" %>"
               placeholder="Ví dụ: 35000" required>
    </div>

    <div class="form-group">
        <label for="image">Link ảnh:</label>
        <input type="text" name="image" id="image"
               value="<%= drink != null ? drink.getImage() : "" %>"
               placeholder="https://example.com/image.jpg">
        <% if (drink != null && drink.getImage() != null && !drink.getImage().trim().isEmpty()) { %>
        <div style="margin-top: 10px;">
            <img src="<%= drink.getImage() %>" alt="Preview" class="image-preview">
        </div>
        <% } %>
    </div>

    <div class="form-group">
        <label for="category">ID Danh mục:</label>
        <input type="text" name="category" id="category"
               value="<%= drink != null ? drink.getCategoryId() : "" %>"
               placeholder="Ví dụ: 1" required>
    </div>

    <button type="submit">
        <%= drink != null ? "Cập nhật" : "Thêm mới" %>
    </button>
</form>

<hr>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Ảnh</th>
        <th>Danh mục</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Drink> list = (List<Drink>) request.getAttribute("list");
        if (list != null) {
            for(Drink d : list){
    %>
    <tr>
        <td><%= d.getId() %></td>
        <td><%= d.getName() %></td>
        <td style="font-weight: 500;"><%= String.format("%,.0f", d.getPrice()) %> ₫</td>
        <td class="image-cell">
            <% if (d.getImage() != null && !d.getImage().trim().isEmpty()) { %>
            <img src="<%= d.getImage() %>" alt="<%= d.getName() %>" class="image-preview">
            <br><small><%= d.getImage() %></small>
            <% } else { %>
            <small>Chưa có ảnh</small>
            <% } %>
        </td>
        <td><%= d.getCategoryId() %></td>
        <td>
            <a href="drink?action=edit&id=<%= d.getId() %>">Sửa</a> |
            <a href="drink?action=delete&id=<%= d.getId() %>"
               class="delete"
               onclick="return confirm('Bạn chắc chắn muốn xóa <%= d.getName() %>?')">Xóa</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

</body>
</html>