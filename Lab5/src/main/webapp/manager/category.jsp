<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.poly.lab4.entity.Category" %>
<%
    Category category = (Category) request.getAttribute("category");
%>

<html>
<head>
    <title>Category Manager</title>
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
            padding: 24px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            max-width: 520px;
            margin-bottom: 40px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #444;
        }

        input[type="text"],
        input[type="hidden"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #d1d9e0;
            border-radius: 6px;
            font-size: 15px;
            margin-bottom: 16px;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #5c8aff;
            box-shadow: 0 0 0 3px rgba(92, 138, 255, 0.15);
        }

        button {
            background-color: #5c8aff;
            color: white;
            border: none;
            padding: 10px 24px;
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
            margin: 32px 0;
        }

        table {
            width: 100%;
            max-width: 720px;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
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

        td a {
            color: #5c8aff;
            text-decoration: none;
            font-weight: 500;
            margin-right: 4px;
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

<h2>Quản lý danh mục</h2>

<form action="category" method="post">
    <input type="hidden" name="id" value="<%= category != null ? category.getId() : "" %>">
    <input type="hidden" name="action" value="<%= category != null ? "update" : "add" %>">

    <label for="name">Tên danh mục:</label>
    <input type="text" name="name" id="name"
           value="<%= category != null ? category.getName() : "" %>"
           placeholder="Nhập tên danh mục..."
           required>

    <button type="submit">
        <%= category != null ? "Cập nhật" : "Thêm mới" %>
    </button>
</form>

<hr>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên danh mục</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Category> list = (List<Category>) request.getAttribute("list");
        if (list != null) {
            for(Category c : list){
    %>
    <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getName() %></td>
        <td>
            <a href="category?action=edit&id=<%= c.getId() %>">Sửa</a>
            |
            <a href="category?action=delete&id=<%= c.getId() %>"
               class="delete"
               onclick="return confirm('Bạn chắc chắn muốn xóa danh mục này?')">Xóa</a>
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