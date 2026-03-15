<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>

    <title>Coffee Shop System</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
            text-align:center;
        }

        h1{
            color:#5a2d0c;
        }

        .container{
            margin-top:80px;
        }

        .menu-box{
            display:inline-block;
            width:220px;
            height:140px;
            margin:20px;
            background:white;
            border-radius:10px;
            box-shadow:0 0 10px rgba(0,0,0,0.2);
            padding-top:30px;
        }

        .menu-box a{
            text-decoration:none;
            font-size:20px;
            color:#333;
            font-weight:bold;
        }

        .menu-box:hover{
            background:#ffe6cc;
        }

    </style>

</head>

<body>

<h1>☕ Coffee Shop Management</h1>

<div class="container">

    <div class="menu-box">
        <a href="order">
            🛒 Order Drink
        </a>
    </div>

    <div class="menu-box">
        <a href="drink">
            🍹 Manage Drinks
        </a>
    </div>

    <div class="menu-box">
        <a href="category">
            📂 Manage Category
        </a>
    </div>

    <div class="menu-box">
        <a href="user">
            👤 Manage Users
        </a>
    </div>

</div>

</body>
</html>
