<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.poly.lab4.entity.User" %>

<%
    User user = (User) request.getAttribute("user");
%>

<html>
<head>
    <title>User Manager</title>
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
        input[type="email"],
        input[type="password"],
        input[type="hidden"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #d1d9e0;
            border-radius: 6px;
            font-size: 15px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
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

        .role-admin {
            color: #e67e22;
            font-weight: 600;
        }

        .role-user {
            color: #27ae60;
            font-weight: 500;
        }
    </style>
</head>
<body>

<h2>Quản lý người dùng</h2>

<form action="user" method="post">
    <input type="hidden" name="id"    value="<%= user != null ? user.getId() : "" %>">
    <input type="hidden" name="action" value="<%= user != null ? "update" : "add" %>">

    <div class="form-group">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" name="username" id="username"
               value="<%= user != null ? user.getUsername() : "" %>"
               placeholder="Nhập username..." required>
    </div>

    <div class="form-group">
        <label for="password">Mật khẩu:</label>
        <input type="password" name="password" id="password"
               value="<%= user != null ? user.getPassword() : "" %>"
               placeholder="Nhập mật khẩu mới (nếu thay đổi)">
    </div>

    <div class="form-group">
        <label for="fullname">Họ và tên:</label>
        <input type="text" name="fullname" id="fullname"
               value="<%= user != null ? user.getFullname() : "" %>"
               placeholder="Ví dụ: Nguyễn Văn Hậu" required>
    </div>

    <div class="form-group">
        <label for="role">Vai trò:</label>
        <input type="text" name="role" id="role"
               value="<%= user != null ? user.getRole() : "" %>"
               placeholder="Ví dụ: ADMIN hoặc USER" required>
    </div>

    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" name="email" id="email"
               value="<%= user != null ? user.getEmail() : "" %>"
               placeholder="example@gmail.com" required>
    </div>

    <button type="submit">
        <%= user != null ? "Cập nhật" : "Thêm mới" %>
    </button>
</form>

<hr>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên đăng nhập</th>
        <th>Họ và tên</th>
        <th>Vai trò</th>
        <th>Email</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<User> list = (List<User>) request.getAttribute("list");
        if (list != null) {
            for(User u : list){
    %>
    <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getUsername() %></td>
        <td><%= u.getFullname() %></td>
        <td>
                <span class="<%= "ADMIN".equalsIgnoreCase(u.getRole()) ? "role-admin" : "role-user" %>">
                    <%= u.getRole() %>
                </span>
        </td>
        <td><%= u.getEmail() %></td>
        <td>
            <a href="user?action=edit&id=<%= u.getId() %>">Sửa</a> |
            <a href="user?action=delete&id=<%= u.getId() %>"
               class="delete"
               onclick="return confirm('Bạn chắc chắn muốn xóa người dùng <%= u.getUsername() %>?')">Xóa</a>
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